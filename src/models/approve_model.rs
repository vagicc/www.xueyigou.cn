use crate::db::PgPooledConnection;
use crate::schema::to_approve;
use crate::schema::to_approve::dsl::*;
use bigdecimal::BigDecimal;
use chrono::NaiveDateTime;
use diesel::data_types::Cents;
use diesel::prelude::*;
use diesel::result::Error;

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
