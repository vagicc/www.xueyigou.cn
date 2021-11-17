use crate::db::PgPooledConnection;
use crate::schema::to_approve;
use crate::schema::to_approve::dsl::*;
use bigdecimal::BigDecimal;
use chrono::NaiveDateTime;
use diesel::data_types::Cents;
use diesel::prelude::*;
use diesel::QueryDsl;

#[derive(Debug, Insertable, Clone, Queryable, PartialEq, Eq)]
#[table_name = "to_approve"]
pub struct ToApprove {
    pub id: i32,
    pub mobile: String,
    pub real_name: String,
    pub is_student: Option<bool>,
    pub student_certificate: Option<String>,
    pub identity_card: String,
    pub identity_card_frontage: Option<String>,
    pub identity_card_verso: Option<String>,
    pub alipay: Option<String>,
    pub figure: Option<Cents>,
    pub credit_code: Option<String>,
    pub business_license: Option<String>,
    pub status: i16,
    pub user_id: i32,
    pub user_type: i16,
    pub modify_id: Option<i32>,
    pub modify_time: Option<NaiveDateTime>,
    pub add_time: Option<NaiveDateTime>,
}

pub fn get_user_approve(userid: i32, conn: &PgPooledConnection) -> Option<ToApprove> {
    let query = to_approve.filter(user_id.eq(userid));
    // let sql = diesel::debug_query::<diesel::pg::Pg, _>(&query).to_string();
    // println!("查询SQL：{:?}", sql);
    let result = query.first::<ToApprove>(conn);
    match result {
        Ok(approve_data) => Some(approve_data),
        Err(error) => {
            match error {
                diesel::result::Error::NotFound => {
                    println!("查无数据");
                }
                _ => {
                    println!("查询出错：{:#?}", error);
                    panic!("查找用户质次申请数据出错");
                }
            }
            None
        }
    }
}

#[derive(Debug, Clone, Insertable)]
#[table_name = "to_approve"]
pub struct NewToApprove {
    pub mobile: String,
    pub real_name: String,
    pub is_student: Option<bool>,
    pub student_certificate: Option<String>,
    pub identity_card: String,
    pub identity_card_frontage: Option<String>,
    pub identity_card_verso: Option<String>,
    pub alipay: Option<String>,
    pub figure: Option<Cents>,
    pub credit_code: Option<String>,
    pub business_license: Option<String>,
    pub status: i16,
    pub user_id: i32,
    pub user_type: i16,
    pub modify_id: Option<i32>,
    pub modify_time: Option<NaiveDateTime>,
    pub add_time: Option<NaiveDateTime>,
}
impl NewToApprove {
    pub fn insert(&self, connection: &PgPooledConnection) -> i32 {
        let insert_id = diesel::insert_into(to_approve)
            .values(self)
            .returning(id)
            .get_result(connection)
            .unwrap_or(0);
        insert_id
    }
}
