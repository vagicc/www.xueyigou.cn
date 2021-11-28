use crate::models::approve_model::*;
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
/*
资质申请问题，每个用户只能有一条记录。这里应该在接收表单时做判断，还没做---------------------
 */
/* 输出首页 */
pub async fn qualification(mut session: Session) -> Result<impl Reply, Rejection> {
    let mut data = Map::new();
    let mut html = String::new();
    if let Some(user) = session.user() {
        println!("已登录，正常流程,user:{:#?}", user);

        // html = "登录了".to_string();

        let mut html_name = "";
        //用户类型：1普通用户；2设计师用户；3企业用户
        if user.user_type == 1 {
            html_name = "qualification.html"; //路到是否从普通用户切换（企业，设计师）
            html = "这里欠一个切换用户资质申请的静态页面".to_string();
        } else {
            html_name = "qualification_designer.html"; //设计师用户
            if user.user_type == 3 {
                html_name = "qualification_company.html";
            }

            data.insert("title".to_string(), to_json("title传过来的值"));
            data.insert("user_id".to_string(), to_json(user.id));
            data.insert("user_type".to_string(), to_json(user.user_type));
            let option_approve = get_user_approve(user.id, session.db());
            if let Some(approve) = option_approve {
                data.insert("status".to_string(), to_json(approve.status));
                data.insert("real_name".to_string(), to_json(approve.real_name));
                data.insert("mobile".to_string(), to_json(approve.mobile));
                data.insert("identity_card".to_string(), to_json(approve.identity_card));

                if let Some(alipay) = approve.alipay {
                    data.insert("alipay".to_string(), to_json(alipay));
                }

                /* 设计师：是否是学生 */
                if let Some(is_student) = approve.is_student {
                    data.insert("is_student".to_string(), to_json(is_student));
                    if is_student {
                        if let Some(student_certificate) = approve.student_certificate {
                            data.insert(
                                "student_certificate".to_string(),
                                to_json(student_certificate),
                            );
                        }
                    }
                }

                /* 企业：credit_code */
                if let Some(credit_code) = approve.credit_code {
                    data.insert("credit_code".to_string(), to_json(credit_code));
                }
            }
            // html = to_html(html_name, data);
            html = to_html_base(html_name, data);
        }
    } else {
        println!("没登录提示登录并跳转到登录页");
        data.insert("title".to_string(), to_json("title传过来的值"));
        data.insert("path".to_string(), to_json("login"));
        data.insert("message".to_string(), to_json("请登录后再进行资质申请"));
        html = to_html("refresh.html", data);
        // Ok(warp::reply::html(html))
    }

    Ok(warp::reply::html(html))

    /* 先区别是企业投资申请还是设计师，如是普通用户，再做 */
    /* 还没开始做 */

    // let id = 32;
    // if id != 0 {
    //     Ok(warp::reply::html(html))
    // } else {
    //     Err(warp::reject::not_found())
    // }
}

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

    let insert_id = to_approve_data.insert(session.db());

    let mut html: String = String::new();

    if insert_id != 0 {
        println!("提着企业设计师申请成功，输出登录");

        let mut data = Map::new();
        data.insert(
            "msg".to_string(),
            to_json("恭喜！！！注册及提交资质申请成功，请你登录查看审批详情"),
        );
        html = to_html_single("login.html", data);
    } else {
        html = "资质提交失败".to_string();
    }

    Ok(warp::reply::html(html))
}
