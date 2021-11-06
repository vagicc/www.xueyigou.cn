use crate::session::Session;
use crate::template::*;
use handlebars::to_json;
use serde_json::value::Map;
use warp::{Rejection, Reply};

type ResultWarp<T> = std::result::Result<T, Rejection>;

pub async fn logout(
    mut session: Session,
) -> std::result::Result<warp::http::Response<&'static str>, Rejection> {
    session.clear();
    let mut data = Map::new();
    data.insert("msg".to_string(), to_json("退出登录成功"));

    let html = to_html("logout.html", data);
    let html = string_to_static_str(html);
    let temp = warp::http::Response::builder()
        .status(200)
        .header(warp::http::header::LOCATION, "/")
        .header(
            warp::http::header::SET_COOKIE,
            "EXAUTH=; Max-Age=0; SameSite=Strict; HttpOpnly",
        )
        .body(html)
        .unwrap();
    return Ok(temp);
}
