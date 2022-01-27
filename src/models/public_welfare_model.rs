use crate::db;
use crate::db::PgPooledConnection;
use crate::schema::public_welfare;
use crate::schema::public_welfare::dsl::*;
use diesel;
use diesel::prelude::*;
use serde::Serialize;
use chrono::NaiveDate;


#[derive(Debug, Clone, Queryable, PartialEq, Eq, Serialize)]
pub struct publicWelfare {
    pub id : i64,
    pub info_title : String,
    pub date : chrono::NaiveDate,
    pub watch : i32,
    pub image_url : String,
    pub hyperlink : Option<String>,
    pub is_new : Option<bool>,
    pub is_enable : bool,
    pub welfare_type : i16,
}

pub fn get_public_welfare_by_id(t: i16, conn: &PgPooledConnection) -> Option<Vec<publicWelfare>> {
    let query = public_welfare
        // .left_join(users::table)
        .filter(is_enable.eq(true))
        .filter(welfare_type.eq(t))
        .limit(4);

    let results = query.load::<publicWelfare>(conn);

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
