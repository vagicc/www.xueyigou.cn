use crate::db::PgPooledConnection;
use crate::handlers::signup_handler::SignupForm;
use crate::schema::users::dsl::*;
use crate::session::random_key;
use bcrypt::{hash_with_salt, verify, DEFAULT_COST};
use chrono::NaiveDateTime;
use core::str;
use diesel::prelude::*;
use log::error;
use serde::{Deserialize, Serialize};
use sha1::Sha1;

#[derive(Debug, Clone, Queryable)]
pub struct UserData {
    pub id: i32,
    pub email: Option<String>,
    pub mobile: Option<String>,
    pub username: String,
    pub realname: Option<String>,
    pub user_type: i16,
    pub password: String,
    pub salt: Option<String>,
    pub create_time: Option<NaiveDateTime>,
    pub last_login: Option<NaiveDateTime>,
}

impl UserData {
    /* 用户修改密码 */
    pub fn change_passwd(mut self, new_passwd: &String, conn: &PgPooledConnection) -> Self {
        // println!("old-user:{:#?}", self);

        let new_salt = get_new_salt();
        let sha1_passwd = encryption(new_passwd, &new_salt);

        /* 把新密码更新到表 */
        let updated_row = diesel::update(users.find(self.id))
            .set((salt.eq(new_salt.clone()), password.eq(sha1_passwd.clone())))
            .execute(conn)
            .unwrap();

        self.salt = Some(new_salt);
        self.password = sha1_passwd;
        // println!("new-user:{:#?}", self);
        self
    }
}

#[derive(Debug, Clone, Queryable, Deserialize, Serialize)]
pub struct User {
    pub id: i32,
    pub username: String,
    pub mobile: Option<String>,
    pub realname: Option<String>,
    pub user_type: i16,
}

impl User {
    /* 身份认证,原本没用的 */
    pub fn _authenticate_old(db: &PgPooledConnection, user: &str, passwd: &str) -> Option<Self> {
        use crate::schema::users::dsl::*;
        let (user, hash) = match users
            .filter(username.eq(user))
            .select(((id, username, mobile, realname, user_type), password))
            .first::<(User, String)>(db)
        {
            Ok((user, hash)) => (user, hash),
            Err(e) => {
                error!("读取用户 {:?} 信息出错: {:?}", user, e);
                return None;
            }
        };

        // let hashed=hash_with_salt(passwd, DEFAULT_COST, salt);
        /* 判断密码是否正确 */
        match verify(&passwd, &hash) {
            Ok(true) => Some(user),
            Ok(false) => None,
            Err(e) => {
                error!("密码认证失败：{:?}: {:?}", user, e);
                None
            }
        }
    }

    /* 身份认证，自己的 */
    pub fn authenticate(db: &PgPooledConnection, mobile_phone: &str, passwd: &str) -> Option<Self> {
        let query = users.filter(mobile.eq(mobile_phone)).select((
            (id, username, mobile, realname, user_type),
            password,
            salt,
        ));
        let sql = diesel::debug_query::<diesel::pg::Pg, _>(&query).to_string();
        println!("查询SQL：{:?}", sql);

        let result = query.first::<(User, String, Option<String>)>(db);

        let (user, user_sha1, user_salt) = match result {
            Ok((user, user_sha1, user_salt)) => (user, user_sha1, user_salt.clone()),
            Err(e) => {
                error!("查询用户 {:?} 信息出错: {:?}", mobile_phone, e);
                return None;
            }
        };

        /* 判断用户密码是否正确 */
        if verify_password(&passwd.to_string(), user_salt, &user_sha1) {
            return Some(user);
        }

        None
    }
}

/* 插入单个注册的用户，并返回用户ID */
pub fn insert_user(newdata: &SignupForm, conn: &PgPooledConnection) -> i32 {
    let mut user_name = &newdata.username;
    if newdata.username.is_empty() {
        user_name = &newdata.mobile;
    }

    let new_salt = get_new_salt();
    let sha1_passwd = encryption(&newdata.password, &new_salt);
    println!("sha1_passwd的长度:{}", sha1_passwd.len());

    let default = 0;
    let insert_id = diesel::insert_into(users)
        .values((
            mobile.eq(&newdata.mobile),
            username.eq(user_name),
            // realname.eq("888"),
            user_type.eq(&newdata.user_type),
            password.eq(sha1_passwd),
            salt.eq(new_salt),
        ))
        .returning(id)
        .get_result(conn)
        .unwrap_or(default);
    insert_id
}

pub fn get_mobie(mobile_phone: &String, conn: &PgPooledConnection) -> Option<UserData> {
    let query = users.filter(mobile.eq(mobile_phone));

    let sql = diesel::debug_query::<diesel::pg::Pg, _>(&query).to_string();
    // println!("查询SQL：{:?}", sql);

    let result = query.first::<UserData>(conn);
    match result {
        Ok(user) => {
            return Some(user);
        }
        Err(error) => {
            println!("打印出错误，还要排查无数据时是正常的");
            return None;
        }
    }
}

pub fn find_user(user_id: i32, conn: &PgPooledConnection) -> Option<UserData> {
    let query = users.find(user_id);
    let sql = diesel::debug_query::<diesel::pg::Pg, _>(&query).to_string();
    // println!("查询SQL：{:?}", sql);

    let result = query.first::<UserData>(conn);

    match result {
        Ok(user) => Some(user),
        Err(error) => {
            println!("{}", error);
            return None;
        }
    }
}

/* 这里还要改成随机算法 */
pub fn get_new_salt() -> String {
    let new_salt = random_key(10);
    new_salt
}

pub fn get_sha1(passwd: &str) -> String {
    let sha1_string = Sha1::from(passwd).digest().to_string();
    println!("Sha1加密后：{}", sha1_string);
    println!("Sha1加密后长度：{}", sha1_string.len());
    sha1_string
}

pub fn encryption(passwd: &String, new_salt: &String) -> String {
    let new_passwd = format!("{}luck{}", passwd, new_salt).to_owned();
    let sha1_passwd = get_sha1(&new_passwd);
    sha1_passwd
}

/* 检验用户密码，正确返回true,错误返回false */
pub fn verify_password(passwd: &String, user_salt: Option<String>, sha1_passwd: &String) -> bool {
    let mut sha1 = String::new();
    match user_salt {
        Some(user_salt) => {
            sha1 = encryption(passwd, &user_salt);
        }
        None => {
            sha1 = get_sha1(passwd);
        }
    }
    // println!("检验密码");
    // println!("{}", sha1);
    // println!("{}", sha1_passwd);

    if sha1.eq(sha1_passwd) {
        println!("密码正确");
        return true;
    } else {
        println!("密码错误");
        return false;
    }
}
