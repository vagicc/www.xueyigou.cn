use crate::models::user_model;
use crate::session::Session;
use crate::template::*;
use handlebars::to_json;
use serde::Deserialize;
use serde::Serialize;
use serde_json::value::Map;
use std::primitive;
use warp::{Rejection, Reply};

type ResultWarp<T> = std::result::Result<T, Rejection>;

/* 输出登录表单 */
pub async fn login_form() -> ResultWarp<impl Reply> {
    // let html = "模板返回html".to_string();
    // let html = register_model::register_html();

    let mut data = Map::new();
    // data.insert("title".to_string(), to_json("title传过来的值"));
    let html = to_html_single("login.html", data);

    let id = 32;
    if id != 0 {
        Ok(warp::reply::html(html))
    } else {
        Err(warp::reject::not_found())
    }
}

#[derive(Debug, Clone, Deserialize)]
pub struct LoginForm {
    pub mobile: String,
    pub passwd: String,
}
impl LoginForm {
    pub fn validate(&self) -> Result<Self, &'static str> {
        if self.mobile.is_empty() {
            Err("手机号不能为空")
        } else if self.mobile.len() != 11 {
            Err("手机号长度必须为11位数字")
        } else if self.passwd.is_empty() {
            Err("密码不能为空")
        } else {
            Ok(self.clone())
        }
    }
}

/* 先验证账号密码是否正确，然后插入session，最后把cookie写入返回头返回，完成登录 */
pub async fn do_login_new(
    mut session: Session,
    form: LoginForm,
) -> std::result::Result<warp::http::Response<&'static str>, Rejection> {
    match form.validate() {
        Ok(form) => {
            if let Some(cookie) = session.authenticate(&form.mobile, &form.passwd) {
                println!("密码正确，处理登录成功流程");
                // use warp::http::{header, response::Builder, StatusCode};
                // Ok(warp::reply::html(html))
                let tem = warp::http::Response::builder();
                let tem = tem.status(200);
                let tem = tem.header(warp::http::header::LOCATION, "/");
                let tem = tem.header(
                    warp::http::header::SET_COOKIE,
                    format!("EXAUTH={}; SameSite=Strict; HttpOpnly", cookie),
                );

                /* 登录成功，3秒后自动跳转到别的页面 */
                // let base_url = crate::get_env("BASE_URL");
                let template = "<!DOCTYPE html>
                    <html>
                      <head>
                        <META http-equiv=\"refresh\" CONTENT=\"2;URL=https://127.0.0.1:5898/\" >
                        <meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\">
                        <title>Warp Handlebars template example</title>
                      </head>
                      <body>
                        <h1>登录成功!</h1>
                      </body>
                    </html>";
                let html = tem.body(template);
                println!("登录成功，cookie:{}", cookie);
                return Ok(html.unwrap());
            } else {
                println!("密码错误，失败流程");
                // let temp = "密码错误，失败流程";
                // let html = warp::http::response::Builder::new().body(temp).unwrap();
                // return Ok(html);

                let mut data = Map::new();
                data.insert("mobile".to_string(), to_json(form.mobile));
                data.insert("msg".to_string(), to_json("账号或者密码错误"));
                let temp = to_html("login.html", data);
                let luck = string_to_static_str(temp);
                let html = warp::http::response::Builder::new().body(luck).unwrap();
                return Ok(html);
            }
        }
        Err(msg) => {
            println!("输出提示登录表单：{}", msg);
            let mut data = Map::new();
            data.insert("mobile".to_string(), to_json(form.mobile));
            data.insert("msg".to_string(), to_json(&msg));
            let temp = to_html("login.html", data);
            let luck = string_to_static_str(temp);

            let html = warp::http::response::Builder::new()
                .status(warp::http::StatusCode::OK)
                .body(luck)
                .unwrap();
            // return html;
            return Ok(html);
        }
    }
}

/* 处理登录表单 */
pub async fn do_login(mut session: Session, form: LoginForm) -> ResultWarp<impl Reply> {
    let mut html = String::new();

    let result = form.validate();

    match result {
        Ok(form) => {
            println!("登录表单验证通过，开始校验用户密码是否正确等登录流程");
            match user_model::get_mobie(&form.mobile, session.db()) {
                Some(user_data) => {
                    println!("校验密码是否相等");
                    let verify = user_model::verify_password(
                        &form.passwd,
                        user_data.salt,
                        &user_data.password,
                    );
                    if verify {
                        html = "密码正确，登录成功".to_string();
                    } else {
                        html = "密码错误".to_string();
                    }
                }
                None => {
                    println!("输出提示账号密码错误");
                }
            }
        }
        Err(msg) => {
            println!("输出提示登录表单");
        }
    }
    let asdf = warp::reply::html("k");
    Ok(warp::reply::html(html))
}
