use crate::handlers::logout_handler;
use crate::session::Session;
use warp::{filters::BoxedFilter, Filter};

pub fn logout(
    s: BoxedFilter<(Session,)>,
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let sfn = move || s.clone();
    let logout = warp::get()
        .and(warp::path("logout"))
        .and(warp::path::end())
        .and(sfn())
        .and_then(logout_handler::logout);
    logout
}
