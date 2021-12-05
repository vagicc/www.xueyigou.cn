use crate::session::Session;
use crate::template::*;
use handlebars::to_json;
use serde_json::value::Map;
use serde_json::Value;
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
