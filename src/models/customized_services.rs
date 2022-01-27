use crate::db;
use crate::db::PgPooledConnection;
use crate::schema::customized_services;
use crate::schema::customized_services::dsl::*;
use diesel;
use diesel::prelude::*;
use serde::Serialize;

#[derive(Debug, Clone, Queryable, PartialEq, PartialOrd, Serialize)]
pub struct csInfo {
    pub id: i64,
    pub cs_name: String,
    pub hour_wage: f32,
    pub day_wage: f32,
    pub month_wage: f32,
    pub label: Option<String>,
    pub image_url: String,
    pub is_enabled: bool,
}

pub fn get_enable_csInfo(conn: &PgPooledConnection) -> Option<Vec<csInfo>> {
    let query = customized_services.filter(is_enabled.eq(true));

    let results = query.load::<csInfo>(conn);

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
