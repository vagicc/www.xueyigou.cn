use crate::session::Session;
use crate::template::*;
use handlebars::to_json;
use serde::Deserialize;
use serde_json::value::Map;
use warp::{Rejection, Reply};

type ResultWarp<T> = std::result::Result<T, Rejection>;

/* 输出注册表单 */
pub async fn signup_form() -> ResultWarp<impl Reply> {
    // let html = "模板返回html".to_string();
    // let html = register_model::register_html();

    let mut data = Map::new();
    data.insert("title".to_string(), to_json("新用户注册"));
    let html = to_html_single("signup.html", data);

    let id = 32;
    if id != 0 {
        Ok(warp::reply::html(html))
    } else {
        Err(warp::reject::not_found())
    }
}

#[derive(Debug, Deserialize, Clone)]
pub struct SignupForm {
    pub user_type: i16,
    pub mobile: String,
    pub username: String,
    pub password: String,
    pub passwd: String,
}

impl SignupForm {
    pub fn validate(&self) -> Result<Self, &'static str> {
        if self.mobile.is_empty() {
            Err("手机号不能为空")
        } else if self.mobile.len() != 11 {
            Err("手机必须长度为11位数字")
        } else if self.password.is_empty() {
            Err("密码不能为空")
        } else if self.password.len() < 5 || self.passwd.len() < 5 {
            Err("密码与确认密码的长度不能小于5位")
        } else if self.password != self.passwd {
            Err("密码与确认密码必须一致")
        } else {
            Ok(self.clone())
        }
    }
}

pub async fn do_signup(session: Session, form: SignupForm) -> ResultWarp<impl Reply> {
    println!("开始处理注册表单");
    let mut html = String::new();
    // let mut html = "处理注册表单".to_string();
    let mobile = &form.mobile;
    let username = &form.username;
    let user_type = &form.user_type;

    let result = form.validate().map_err(|op| op.to_string());
    match result {
        Ok(form) => {
            println!("表单验证通过，插入用户表..{:#?}", form);
            use crate::models::user_model::insert_user;
            let insert_id = insert_user(&form, session.db());
            if insert_id == 0 {
                println!("插入用户表失败");
                html = "新增用户失败".to_string();
            } else {
                println!("新插入的用户ID:{:?}", insert_id);
                // html = format!("新增用户成功，用户ID:{}", insert_id);
                /* 判断用户非普通用户，则进一步进行用户资质申请 */
                html = signup_success(&form, insert_id);
            }
        }
        Err(msg) => {
            println!("注册表单认证没通过：{}", msg);
            let mut data = Map::new();
            data.insert("mobile".to_string(), to_json(mobile));
            data.insert("user_type".to_string(), to_json(user_type));
            data.insert("username".to_string(), to_json(username));
            data.insert("msg".to_string(), to_json(&msg));

            html = to_html("signup.html", data);
        }
    }
    Ok(warp::reply::html(html))
}

fn signup_success(form: &SignupForm, user_id: i32) -> String {
    let user_type = form.user_type;
    let mut html_name = "";

    //用户类型：1普通用户；2设计师用户；3企业用户
    if user_type == 1 {
        html_name = "login.html";
    } else if user_type == 2 {
        html_name = "approve_designer.html";
    } else if user_type == 3 {
        html_name = "approve_company.html";
    }

    let mut username = String::new();
    if form.username.is_empty() {
        username = form.mobile.clone();
    } else {
        username = form.username.clone();
    }

    let mut data = Map::new();
    data.insert("mobile".to_string(), to_json(form.mobile.clone()));
    data.insert("username".to_string(), to_json(username));
    data.insert("user_id".to_string(), to_json(user_id));
    data.insert("user_type".to_string(), to_json(user_type));
    data.insert("msg".to_string(), to_json("恭喜！！！注册成功"));
    let html = to_html_single(html_name, data);
    // let luck = string_to_static_str(temp);
    html
}
