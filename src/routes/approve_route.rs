use bytes::BufMut;
use crate::handlers::approve_handler;
use futures::TryStreamExt;
use warp::multipart::{FormData, Part};
use warp::{filters::BoxedFilter, Filter};
use warp::{Rejection, Reply};
use crate::session::Session;

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
