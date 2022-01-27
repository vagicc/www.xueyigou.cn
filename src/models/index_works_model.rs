use crate::db;
use crate::db::PgPooledConnection;
use crate::models::user_model::{find_user, UserData};
use crate::schema::index_works;
use crate::schema::index_works::dsl::*;
use crate::schema::users;
use diesel;
use diesel::prelude::*;
use serde::Serialize;

#[derive(Debug, Clone, Queryable, PartialEq, Eq, Serialize)]
pub struct IndexWorks {
    pub id: i64,
    pub works_title: String,
    pub watch: i32,
    pub like: i32,
    pub image_url: String,
    pub label: Option<String>,
    pub is_enable: bool,
    pub work_type: i16,
    pub user_id: i32,
}

#[derive(Debug, Clone, Serialize)]
pub struct IndexWorksWithUser {
    pub id: i64,
    pub works_title: String,
    pub watch: i32,
    pub like: i32,
    pub image_url: String,
    pub label: Option<String>,
    pub is_enable: bool,
    pub work_type: i16,
    pub user_id: i32,
    pub username: String,
    pub avatar: String,
}

pub fn get_index_works_by_id(t: i16, conn: &PgPooledConnection) -> Option<Vec<IndexWorksWithUser>> {
    let query = index_works
        // .left_join(users::table)
        .filter(is_enable.eq(true))
        .filter(work_type.eq(t))
        .limit(10);

    let results = query.load::<IndexWorks>(conn);

    match results {
        Ok(res) => {
            let mut data = Vec::new();
            for i in &res {
                let uid = i.user_id.clone();
                let user = find_user(uid, conn);
                let mut info = IndexWorksWithUser {
                    id: i.id,
                    works_title: i.works_title.clone(),
                    watch: i.watch,
                    like: i.like,
                    image_url: i.image_url.clone(),
                    label: i.label.clone(),
                    is_enable: i.is_enable,
                    work_type: i.work_type,
                    user_id: i.user_id,
                    username: String::new(),
                    avatar: String::new(),
                };
                if let Some(u) = user {
                    info.username = u.username.clone();
                    if let Some(avatar) = u.avatar {
                        info.avatar = avatar.clone();
                    }
                }
                data.push(info);
            }
            Some(data)
        }
        Err(error) => {
            match error {
                diesel::result::Error::NotFound => {
                    println!("查无数据");
                }
                _ => {
                    println!("查询出错：{:#?}", error);
                    panic!("查找首页作品数据出错");
                }
            }
            None
        }
    }
}
