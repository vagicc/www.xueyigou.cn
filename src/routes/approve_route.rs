use crate::handlers::approve_handler;
use crate::session::Session;
use warp::{filters::BoxedFilter, Filter};

/* 资质申请 */
pub fn qualification(
    s: BoxedFilter<(Session,)>,
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let sfn = move || s.clone();
    warp::get()
        .and(warp::path("qualification"))
        .and(warp::path::end())
        .and(sfn())
        .and_then(approve_handler::qualification)
}

pub fn do_approve(
    s: BoxedFilter<(Session,)>,
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let sfn = move || s.clone();
    let do_approve = warp::post()
        .and(warp::path("do_approve"))
        .and(warp::path::end())
        .and(sfn())
        .and(warp::multipart::form())
        .and_then(approve_handler::do_approve);
    do_approve
}
