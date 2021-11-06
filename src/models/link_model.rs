use crate::db::PgPooledConnection;
use crate::schema::linksnap;
use chrono::NaiveDateTime;
use diesel;
use diesel::prelude::*;
use serde_derive::{Deserialize, Serialize};

// #![feature(trait_alias)]
// pub type QueryResult<T> = Result<T, Error>;
pub type LinkId = i32;
   
#[derive(Debug, Serialize, Deserialize, Insertable)]
#[table_name = "linksnap"]
pub struct AddLink {
    pub title: String,
    pub url: String,
}

#[derive(Queryable, Debug)]
pub struct Link {
    pub id: i32,
    pub title: String,
    pub url: String,
    pub added: NaiveDateTime,
}

impl Link {
    pub fn add_link(new_link: AddLink, conn: &PgPooledConnection) -> QueryResult<usize> {
        use crate::schema::linksnap::dsl::*;
        diesel::insert_into(linksnap).values(new_link).execute(conn)
    }
    pub fn get_links(conn: &PgPooledConnection) -> QueryResult<Vec<Link>> {
        use crate::schema::linksnap::dsl::linksnap as getlinksnap;
        getlinksnap.order(linksnap::id.desc()).load::<Link>(conn)
    }
    pub fn rm_links(id: LinkId, conn: &PgPooledConnection) -> QueryResult<usize> {
        use crate::schema::linksnap::dsl::linksnap as getlinksnap;
        diesel::delete(getlinksnap.find(id)).execute(conn)
    }

    //这里还有错误
    // pub fn update_row(conn: &PgPooledConnection) {
    //     use crate::schema::linksnap::dsl::linksnap as getlinksnap;
    //     use crate::schema::linksnap::dsl::*;
    //     let updated_row = diesel::update(getlinksnap.find(id))
    //         .set((title.eq("kasdfk=asdf"), url.eq("kdasd00")))
    //         .get_result(conn);
    // }

    pub fn add_getid(new_link: AddLink, conn: &PgPooledConnection)->QueryResult<Link>  {
        use crate::schema::linksnap::dsl::*;
        
        // diesel::insert_into(linksnap).values(new_link).execute(conn);
        let insert_id=diesel::insert_into(linksnap)
        .values(new_link)
        // .returning(id)
        // .get_result::<(id, String)>(conn);
        .get_result::<Link>(conn);
        
        insert_id
    }
}
