use crate::db;
use crate::db::PgPooledConnection;
use crate::schema::honor;
use crate::schema::honor::dsl::*;
use diesel;
use diesel::prelude::*;
use serde::Serialize;

#[derive(Debug, Clone, Queryable, PartialEq, PartialOrd, Serialize)]
pub struct honorInfo {
    pub id: i64,
    pub honor_name: String,
    pub detail: Option<String>,
    pub image_url: String,
    pub hyper_url: Option<String>,
    pub is_enabled: bool,
}

pub fn get_enable_honorInfo(conn: &PgPooledConnection) -> Option<Vec<honorInfo>> {
    let query = honor.filter(is_enabled.eq(true));

    let results = query.load::<honorInfo>(conn);

    match results {
        Ok(res) => Some(res),
        Err(error) => {
            match error {
                diesel::result::Error::NotFound => {
                    println!("查无数据");
                }
                _ => {
                    println!("查询出错：{:#?}", error);
                    panic!("未能成功查找数据");
                }
            }
            None
        }
    }
}
