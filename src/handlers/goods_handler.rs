use crate::multipart_form::*;
use crate::session::Session;
use crate::template::*;
use bytes::{Buf, BufMut};
use chrono::prelude::{Local, NaiveDateTime};
use futures::TryStreamExt;
use handlebars::to_json;
use serde_json::value::Map;
use serde_json::Value;
use std::collections::HashMap;
use std::fmt::Debug;
use warp::multipart::{FormData, Part};
use warp::{Rejection, Reply};

/* 输出发布服务HTML */
pub async fn virtual_html(session: Session) -> Result<impl Reply, Rejection> {
    let mut data: Map<String, Value> = Map::new();
    let mut html = String::new();
    if let Some(user) = session.user() {
        println!("输出发布服务HTML");
        data.insert("title".to_string(), to_json("title传过来的值"));
        data.insert("user_id".to_string(), to_json(user.id));
        data.insert("user_type".to_string(), to_json(user.user_type));
        data.insert("username".to_string(), to_json(&user.username));
        let mobile = &user.mobile;
        if let Some(mobile) = &user.mobile {
            data.insert("mobile".to_string(), to_json(mobile));
        }
        html = to_html_base("goods_virtual.html", data);
    } else {
        // println!("没登录提示登录并跳转到登录页");
        data.insert("title".to_string(), to_json("title传过来的值"));
        data.insert("path".to_string(), to_json("login"));
        data.insert("message".to_string(), to_json("请登录后再进行发布服务"));
        html = to_html_ad("refresh.html", data);
    }
    Ok(warp::reply::html(html))
}

#[derive(Debug)]
struct ServerError {
    message: String,
}
impl warp::reject::Reject for ServerError {}

/* 处理服务上传（虚拟商品） */
pub async fn do_virtual(session: Session, form: FormData) -> Result<impl Reply, Rejection> {
    let mut data: Map<String, Value> = Map::new();
    let mut html = String::new();

    let parts: Vec<Part> = form.try_collect().await.map_err(|e| {
        eprintln!("虚拟商品上传表单出错：{}", e);
        warp::reject::custom(ServerError {
            message: e.to_string(),
        })
    })?;
    /* 取得表单post数据 */
    let mut post: HashMap<String, String> = HashMap::new();
    for mut part in parts {
        let input_name = part.name();
        if input_name == "goods_img" || input_name == "goods_photo" {
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

    if let Some(user) = session.user() {
        // println!("处理非实体商品上传");

        let goods_img=post.get("goods_img").unwrap().clone();

        data.insert("title".to_string(), to_json("title传过来的值"));
        data.insert("path".to_string(), to_json("login"));
        data.insert("message".to_string(), to_json("请登录后再进行发布服务"));
        html = to_html_ad("refresh.html", data);
    } else {
        // println!("没登录提示登录并跳转到登录页");
        data.insert("title".to_string(), to_json("title传过来的值"));
        data.insert("path".to_string(), to_json("login"));
        data.insert("message".to_string(), to_json("请登录后再进行发布服务"));
        html = to_html_ad("refresh.html", data);
    }
    Ok(warp::reply::html(html))
}
