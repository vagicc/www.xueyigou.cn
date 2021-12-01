use crate::handlers::settings_handler;
use crate::session::Session;
use warp::{filters::BoxedFilter, Filter};

/* 账户安全：修改密码 */
pub fn security(
    s: BoxedFilter<(Session,)>,
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let sfn = move || s.clone();
    warp::get()
        .and(warp::path!("settings" / "security"))
        .and(warp::path::end())
        .and(sfn())
        .and_then(settings_handler::security)
}

pub fn change_passwd(
    s: BoxedFilter<(Session,)>,
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let sfn = move || s.clone();
    warp::post()
        .and(warp::path!("settings" / "change_passwd"))
        .and(warp::path::end())
        .and(sfn())
        .and(warp::body::form())
        .and_then(settings_handler::change_passwd)
}
