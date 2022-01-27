use crate::db;
use crate::db::PgPooledConnection;
use crate::schema::banners;
use crate::schema::banners::dsl::*;
use diesel;
use diesel::prelude::*;
use serde::Serialize;

#[derive(Debug, Clone, Queryable, PartialEq, Eq, Serialize)]
pub struct Banner {
    pub id: i32,
    pub banner_name: Option<String>,
    pub image_url: String,
    pub hyperlink: Option<String>,
    pub is_enabled: bool,
}

pub fn get_enable_banners(conn: &PgPooledConnection) -> Option<Vec<Banner>> {
    let query = banners.filter(is_enabled.eq(true));

    let results = query.load::<Banner>(conn);

    match results {
        Ok(res) => Some(res),
        Err(error) => {
            match error {
                diesel::result::Error::NotFound => {
                    println!("查无数据");
                }
                _ => {
                    println!("查询出错：{:#?}", error);
                    panic!("查找首页图片轮播数据出错");
                }
            }
            None
        }
    }
}
