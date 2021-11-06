use crate::session::Session;
use crate::template::to_html;
use handlebars::to_json;
use serde_json::value::Map;
use warp::{Rejection, Reply};

type ResultWarp<T> = std::result::Result<T, Rejection>;

/* 输出首页 */
pub async fn index(mut session: Session) -> ResultWarp<impl Reply> {
    // let html = "模板返回html".to_string();
    // let html = register_model::register_html();

    let mut data = Map::new();
    let user = session.user();
    if let Some(u) = user {
        let mut username = u.username.clone();
        if let Some(mobile) = &u.mobile {
            username = mobile.clone();
        }
        data.insert("username".to_string(), to_json(username));
    }
    data.insert("title".to_string(), to_json("title传过来的值"));
    let html = to_html("index.html", data);

    let id = 32;
    if id != 0 {
        Ok(warp::reply::html(html))
    } else {
        Err(warp::reject::not_found())
    }
}
