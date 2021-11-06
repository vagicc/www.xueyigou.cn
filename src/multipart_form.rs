use bytes::{Buf, BufMut};
use chrono::{DateTime, Local};
use chrono::{Datelike, Timelike};
use futures::TryStreamExt;
use warp::multipart::Part;

/* 处理非文件的表单内容 */
pub async fn get_input(part: &mut Part) -> (String, String) {
    let name = part.name().to_string();
    let mut value = String::new();
    if let Some(data) = part.data().await {
        match data {
            Ok(input_buf) => {
                // let value = td.chunk().to_vec();
                let input_string = String::from_utf8(input_buf.chunk().to_vec())
                    .expect("表单中Vec<u8>转字符串出错");
                // println!("表单{}值:{:#?}", name, input_string);
                if !input_string.is_empty() {
                    value = input_string;
                }
            }
            Err(e) => {
                //正常来说都不会走到这个流程
                eprintln!("表单值({})为空？？{:#?}", name, e);
            }
        }
    }
    (name, value)
}

/* 处理文件上传返回（表单名，访问文件的相对路径） */
pub async fn upload_file(part: Part) -> (String, String) {
    // println!("part:{:#?}", part);
    let local: DateTime<Local> = Local::now();
    let year = local.year();
    let month = local.month();
    let day = local.day();
    let hour = local.hour();
    let minute = local.minute();
    let second = local.second();

    let input_name = part.name().to_string();
    let original_name = part
        .filename()
        .expect("原上传文件名为空？？！！")
        .to_string();
    let extension = original_name
        .split(".")
        .last()
        .expect("上传的文件不存在扩展名");
    // println!("原来上传文件名：{},扩展名:{}", original_name, extension);

    let new_file_name = format!(
        "{}{}{}{}{}{}{}.{}",
        year,
        month,
        day,
        hour,
        minute,
        second,
        random_string(5),
        extension
    ); //新的文件名=>年月日时分秒+5个随机字符+原后缀名
       /* 设置上传文件目录 */
    let new_path = format!("static/uploads/{}{}", year, month); //上传目录
    std::fs::create_dir_all(&new_path).expect("创建新的上传文件目录失败"); //如果不存在则创建

    let path_and_name = format!("{}/{}", new_path, new_file_name);

    /*
    处理文件上传
    处理文件上传分目录,目录不存在自动创建(是否按用户ID分文件夹，后期看情况处理)
    处理文件名为“年月日时分秒+随机”
    返回（文件相对路径/文件名)
    再细，就得判断文件类型是否可上传类型，文件大小等
    */
    let value = part
        .stream()
        .try_fold(Vec::new(), |mut vec, data| {
            vec.put(data);
            async move { Ok(vec) }
        })
        .await
        .map_err(|e| {
            // 这里要做错误返回处理
            eprintln!("读取文件出错=>reading file error: {}", e.to_string());
        })
        .expect("kkk");

    // tokio::fs::write(&path_and_name, value)
    //     .await
    //     .map_err(|e| {
    //         //这里要做错误返回处理
    //         eprint!("写文件或移动文件出错=>error writing file: {}", e);
    //     })
    //     .expect("移动临时上传文件出错");
    tokio::fs::write(&path_and_name, &value)
        .await
        .unwrap_or_else(|op| {
            match op.kind() {
                std::io::ErrorKind::NotFound => {
                    // println!("目录还没创建，先创建目录后，再进行一次文件移动");
                    std::fs::create_dir_all(&new_path).expect("创建新的上传文件目录失败");
                    //如果不存在则创建

                    //tokio::fs::write(&fname2, value).await.expect("");
                }
                _ => panic!("移动临时上传文件出错:{:#?}", op),
            }
            // println!("没文件：{:#?}", op);
            // panic!("没===");
        });
    (input_name, path_and_name)
}

/* 产生随机字符串 */
pub fn random_string(len: usize) -> String {
    use rand::distributions::Alphanumeric;
    use rand::thread_rng;
    use rand::Rng;
    thread_rng()
        .sample_iter(&Alphanumeric)
        .map(char::from)
        .take(len)
        .collect()
}
