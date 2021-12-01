use crate::models::approve_model::*;
use crate::models::user_model::*;
use crate::multipart_form::*;
use crate::session::Session;
use crate::template::*;
use bytes::{Buf, BufMut};
use chrono::prelude::{Local, NaiveDateTime};
use futures::TryStreamExt;
use handlebars::to_json;
use serde::Deserialize;
use serde_json::value::Map;
use serde_json::Value;
use std::collections::HashMap;
use std::fmt::Debug;
use warp::multipart::{FormData, Part};
use warp::{Rejection, Reply};

/* 输出修改密码HTML */
pub async fn security(session: Session) -> Result<impl Reply, Rejection> {
    let mut data: Map<String, Value> = Map::new();
    let mut html = String::new();
    if let Some(user) = session.user() {
        println!("输出修改密码表单");
        data.insert("title".to_string(), to_json("title传过来的值"));
        data.insert("user_id".to_string(), to_json(user.id));
        data.insert("user_type".to_string(), to_json(user.user_type));
        data.insert("username".to_string(), to_json(&user.username));
        let mobile = &user.mobile;
        if let Some(mobile) = &user.mobile {
            data.insert("mobile".to_string(), to_json(mobile));
        }
        html = to_html_base("security.html", data);
    } else {
        // println!("没登录提示登录并跳转到登录页");
        data.insert("title".to_string(), to_json("title传过来的值"));
        data.insert("path".to_string(), to_json("login"));
        data.insert("message".to_string(), to_json("请登录后再进行密码修改"));
        html = to_html_ad("refresh.html", data);
    }
    Ok(warp::reply::html(html))
}

#[derive(Debug, Clone, Deserialize)]
pub struct ChangePasswd {
    pub mobile: String,
    pub old_passwd: String,
    pub password: String,
    pub passwd: String,
}
impl ChangePasswd {
    pub fn validate(&self) -> Result<Self, &'static str> {
        if self.mobile.is_empty() {
            Err("手机号不能为空")
        } else if self.old_passwd.is_empty() {
            Err("必须输入原来登录密码")
        } else if self.password.len() < 5 || self.passwd.len() < 5 {
            Err("新密码与新确认密码的长度不能小于5位")
        } else if self.password != self.passwd {
            Err("新密码与新确认密码必须一致")
        } else {
            Ok(self.clone())
        }
    }
}

/* 处理修改密码 */
pub async fn change_passwd(session: Session, form: ChangePasswd) -> Result<impl Reply, Rejection> {
    if let Some(user) = session.user() {
        let mut data: Map<String, Value> = Map::new();
        let mut html = String::new();

        data.insert("title".to_string(), to_json("title传过来的值"));

        match form.validate().map_err(|op| op.to_string()) {
            Ok(form) => {
                if let Some(mobile) = &user.mobile {
                    if mobile.ne(&form.mobile) {
                        data.insert("msg".to_string(), to_json("手机号不正确"));
                    }
                }
                /* 判断原密码是否正确 */
                match find_user(user.id, session.db()) {
                    Some(userdata) => {
                        if (verify_password(
                            &form.old_passwd,
                            userdata.salt.clone(),
                            &userdata.password,
                        )) {
                            println!("原密码正确，可以修改密码");
                            let userdata = userdata.change_passwd(&form.password, session.db());
                            // println!("外面:{:#?}", userdata);
                            data.insert(
                                "msg".to_string(),
                                to_json("修改密码成功，下次登录请使用新密码"),
                            );
                        } else {
                            data.insert("msg".to_string(), to_json("原密码错误，密码修改失败"));
                        }
                    }
                    None => {
                        data.insert("msg".to_string(), to_json("查无此用户"));
                    }
                }
            }
            Err(msg) => {
                data.insert("msg".to_string(), to_json(msg));
            }
        }

        html = to_html_base("security.html", data);
        Ok(warp::reply::html(html))
    } else {
        println!("没登录不能修改密码");
        Err(warp::reject::not_found())
    }
}
