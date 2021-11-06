use crate::handlers::signup_handler;
use crate::session::Session;
use warp::{filters::BoxedFilter, Filter};

pub fn signup() -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let signup = warp::get()
        .and(warp::path("signup"))
        .and(warp::path::end())
        .and_then(signup_handler::signup_form);
    signup
}

pub fn do_signup(
    s: BoxedFilter<(Session,)>,
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let sfn = move || s.clone();

    let do_signup = warp::post()
        .and(warp::path("signup"))
        .and(warp::path::end())
        .and(sfn())
        .and(warp::body::form())
        .and_then(signup_handler::do_signup);
    do_signup
}
