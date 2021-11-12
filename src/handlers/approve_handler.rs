use crate::models::approve_model::NewToApprove;
use crate::multipart_form::*;
use crate::session::Session;
use crate::template::*;
use bytes::{Buf, BufMut};
use chrono::prelude::{Local, NaiveDateTime};
use futures::TryStreamExt;
use handlebars::to_json;
use serde_json::value::Map;
use std::collections::HashMap;
use std::fmt::Debug;
use warp::multipart::{FormData, Part};
use warp::{Rejection, Reply};

#[derive(Debug)]
struct ServerError {
    message: String,
}
impl warp::reject::Reject for ServerError {}

/* 这里处理用户注册成功后继续填写的质效申请（企业资质、设计师资质） */
pub async fn do_approve(session: Session, form: FormData) -> Result<impl Reply, Rejection> {
    /* 处理文件上传表单（method="post" enctype="multipart/form-data"） */
    let parts: Vec<Part> = form.try_collect().await.map_err(|e| {
        eprintln!("上传文件表单出错form error: {}", e);
        warp::reject::custom(ServerError {
            message: e.to_string(),
        })
    })?;

    let mut post: HashMap<String, String> = HashMap::new();

    for mut part in parts {
        let input_name = part.name();
        if input_name == "identity_card_frontage"
            || input_name == "identity_card_verso"
            || input_name == "business_license"
            || input_name == "student_certificate"
        {
            //文件上传处理
            let (name, filename) = upload_file(part).await;
            // println!("表单{}上传的文件{}", name, filename);
            post.insert(name, filename);
        } else {
            // println!("普通表单处理");
            let (name, value) = get_input(&mut part).await;
            // println!("表单{} => {}", name, value);
            post.insert(name, value);
        }
    }

    // println!("POST:{:#?}", post);
    // 取得表单内容后处理插入数据库
    let user_id = post.get("user_id").unwrap().clone().parse::<i32>().unwrap();
    let user_type = post
        .get("user_type")
        .unwrap()
        .clone()
        .parse::<i16>()
        .expect("字符串转i16位出错");
    let mobile = post.get("mobile").unwrap().clone();
    let real_name = post.get("real_name").unwrap().clone();
    let identity_card = post.get("identity_card").unwrap().clone();
    let identity_card_frontage = post.get("identity_card_frontage").unwrap().clone();
    let identity_card_verso = post.get("identity_card_verso").unwrap().clone();
    let alipay = post.get("alipay").unwrap().clone();
    // let figure= post.get("figure").unwrap().clone();

    let mut is_student: Option<bool> = None; //是否是学生
    let mut student_certificate: Option<String> = None; //学生证
    let mut credit_code: Option<String> = None; //企业社会信用代码
    let mut business_license: Option<String> = None; //营业执照

    if user_type == 2 {
        /* 设计师 */
        let student = post.get("state").unwrap().clone();
        if student.eq("1") {
            /* 是学生 */
            is_student = Some(true);
            student_certificate = Some(post.get("student_certificate").unwrap().clone());
        } else {
            is_student = Some(false);
            let student_certificate: Option<String> = None;
        }
    } else if user_type == 3 {
        /* 企业 */
        credit_code = Some(post.get("credit_code").unwrap().clone());
        business_license = Some(post.get("business_license").unwrap().clone());
    }

    //创建时间示例
    let fmt = "%Y-%m-%d %H:%M:%S";
    let now = Local::now();
    let dft = now.format(fmt);
    let str_date = dft.to_string();
    // println!("当前时间：{}", str_date);
    let now_date_time = NaiveDateTime::parse_from_str(str_date.as_str(), fmt).unwrap();

    let to_approve_data = NewToApprove {
        mobile,
        real_name,
        is_student,
        student_certificate,
        identity_card: identity_card,
        identity_card_frontage: Some(identity_card_frontage),
        identity_card_verso: Some(identity_card_verso),
        alipay: Some(alipay),
        figure: None, //认证金额
        credit_code,
        business_license,
        status: 0, //状态：0默认待审核，-1审核不通过，1审核通过
        user_id,
        user_type,
        modify_id: None,
        modify_time: None,
        add_time: Some(now_date_time),
    };

    let _insert_id = to_approve_data.insert(session.db());

    Ok("文件上传成功!")
}
