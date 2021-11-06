use crate::handlers::login_handler;
use crate::session::Session;
use warp::{filters::BoxedFilter, Filter};

pub fn login() -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let login_form = warp::get()
        .and(warp::path("login"))
        .and(warp::path::end())
        .and_then(login_handler::login_form);
    login_form
}

pub fn _do_login(
    s: BoxedFilter<(Session,)>,
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let sfn = move || s.clone();
    let do_login = warp::post()
        .and(warp::path("login"))
        .and(warp::path::end())
        .and(sfn())
        .and(warp::body::form())   //warp::multipart::form()
        .and_then(login_handler::do_login);
    // .and_then(login_handler::do_login_new);
    do_login
}

pub fn do_login_new(
    s: BoxedFilter<(Session,)>,
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let sfn = move || s.clone();
    let do_login = warp::post()
        .and(warp::path("login"))
        .and(warp::path::end())
        .and(sfn())
        .and(warp::body::form())
        .and_then(login_handler::do_login_new);
    do_login
}
