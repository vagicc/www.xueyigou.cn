use crate::multipart_form::*;
use crate::session::Session;
use crate::template::*;
use bytes::{Buf, BufMut};
use futures::TryStreamExt;
use handlebars::to_json;
use serde_json::value::Map;
use std::fmt::Debug;
use warp::multipart::{FormData, Part};
use warp::{Rejection, Reply};

type ResultWarp<T> = std::result::Result<T, Rejection>;

pub async fn multipart_form() -> ResultWarp<impl Reply> {
    let html_name = "approve_test.html";
    let mut data = Map::new();
    // data.insert("mobile".to_string(), to_json(form.mobile.clone()));
    // data.insert("username".to_string(), to_json(username));
    // data.insert("user_id".to_string(), to_json(user_id));
    // data.insert("user_type".to_string(), to_json(user_type));
    data.insert("msg".to_string(), to_json("恭喜！！！注册成功"));
    let html = to_html_single(html_name, data);
    Ok(warp::reply::html(html))
}

#[derive(Debug)]
struct ServerError {
    message: String,
}
impl warp::reject::Reject for ServerError {}

pub async fn do_multipart_form(form: FormData) -> Result<impl Reply, Rejection> {
    /* 处理文件上传表单（method="post" enctype="multipart/form-data"） */
    let parts: Vec<Part> = form.try_collect().await.map_err(|e| {
        eprintln!("上传文件表单出错form error: {}", e);
        warp::reject::custom(ServerError {
            message: e.to_string(),
        })
    })?;

    for mut part in parts {
        let input_name = part.name();
        if input_name == "identity_card_frontage" {
            //文件上传处理
            let (name, filename) = upload_file(part).await;
            println!("表单{}上传的文件{}", name, filename);
        } else {
            //普通表单处理
            println!("普通表单处理");
            let (name, value) = get_input(&mut part).await;
            println!("表单{} => {}", name, value);
        }
    }
    Ok("文件上传成功！！")
}

pub async fn _old_do_multipart_form(form: FormData) -> Result<impl Reply, Rejection> {
    //非文件的值如何获取等
    println!("开始处理文件上传：{:#?}", form);

    let parts: Vec<Part> = form.try_collect().await.map_err(|e| {
        eprintln!("上传文件表单出错form error: {}", e);
        warp::reject::custom(ServerError {
            message: e.to_string(),
        })
    })?;

    /* 多个文件上传处理 */
    for mut p in parts {
        // println!("p=--=>{:#?}", p);
        // 示例只处理“身份证正面照片”上传的图片 <input type="file" name="identity_card_frontage">
        if p.name() == "identity_card_frontage" {
            let value = p
                .stream()
                .try_fold(Vec::new(), |mut vec, data| {
                    vec.put(data);
                    async move { Ok(vec) }
                })
                .await
                .map_err(|e| {
                    eprintln!("读取文件出错=>reading file error: {}", e);
                    warp::reject::custom(ServerError {
                        message: e.to_string(),
                    })
                })?;

            let new_file_name = "kdd123"; //新文件名，还要处理还要加上后缀才行
            let fname2 = format!("./static/files/{}", new_file_name);
            tokio::fs::write(&fname2, value).await.map_err(|e| {
                eprint!("写文件或移动文件出错=>error writing file: {}", e);
                warp::reject::custom(ServerError {
                    message: e.to_string(),
                })
            })?;
            #[cfg(debug_assertions)]
            println!("创建上传文件成功=>created file: {}", new_file_name);
        } else {
            let name = p.name().to_string();
            let data = p.data().await;
            if let Some(d) = data {
                match d {
                    Ok(td) => {
                        let k = td.chunk();
                        let k = String::from_utf8(k.to_vec()).expect("Invalid chunk");
                        println!("表单{}:{}", name, k);
                    }
                    Err(e) => {}
                }
            }
            println!("=={:#?}", p);
        }
    }

    Ok("文件上传成功！！")
}

pub async fn is_login(mut session: Session) -> ResultWarp<impl Reply> {
    println!("检查是否登录");

    let user = session.user();

    let mut data = Map::new();
    data.insert("title".to_string(), to_json("测试查看用户是否登录"));
    data.insert("user".to_string(), to_json(user));
    if let Some(u) = user {
        let mut username = u.username.clone();
        if let Some(mobile) = &u.mobile {
            username = mobile.clone();
        }
        data.insert("username".to_string(), to_json(username));
    }
    match user {
        Some(u) => {}
        None => {}
    }

    let html = to_html_single("is_login.html", data);

    let id = 32;
    if id != 0 {
        Ok(warp::reply::html(html))
    } else {
        Err(warp::reject::not_found())
    }
}

fn _test() {
    let integer = 1024;
    let interger_with_integer = 1_000_000_000u32;

    //整数可以使用不同进制表示
    let bing = 0b10_000_000_000; //二进制
    let oct = 0o2_000; //八进制
    let dec = 1024; //十进制
    let hex = 0x400; //十六进制

    // 打印出来默认都是十进制，如果希望有不同的打印方法，则可以查看文档![formatting](https://doc.rust-lang.org/rust-by-example/hello/print/fmt.html)
    println!("four integers: oct: {}, dec: {}, hex: {}", oct, dec, hex);

    let float = 1.0; // 浮点数，默认为 f64
    let float_with_underscore = 0.000_1f32; // 浮点数，可以使用下划线分开。可以通过标注不使用默认类型
    let characters: char = 'a'; // 字符char，使用单引号表示
    let boolean: bool = false; // bool 类型，只有 true 和 false 两个值

    // #2
    // !注：下面这一行没有错误，但是它会阻止程序继续运行
    // 这个语句代表在程序运行中的某个要求，这里要求两个数值相等
    // 这不是一个错误，而是一个运行时的判断
    assert_eq!(true, boolean); // 判断是否相同
    let unit = (); // unit 类型，不占空间，也没有什么意义
    let another_unit = ();
    assert_eq!(unit, another_unit); // 两者是相同的

    let string: &str = "Hello World"; // 字符串 str，可以认为是一个 Unicode的序列。使用双引号表示
    println!("{}!", string);

    // 运算符
    // Rust 的运算符和类 C 语言的运算符基本一致
    // 算术运算符
    println!("1 + 1 = {}", 1i32 + 1i32);
    println!("1 - 2 = {}", 1i32 - 2i32);
    println!("2 * 2 = {}", 2 * 2);
    println!("3 / 2 = {}", 3 / 2);
    println!("10 % 3 = {}", 10 % 3);
}
