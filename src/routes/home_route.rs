use crate::handlers::home_handler;
use crate::session::Session;
use warp::{filters::BoxedFilter, Filter};

pub fn index(
    s: BoxedFilter<(Session,)>,
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let sfn = move || s.clone();
    let home = warp::get()
        .and(warp::path::end())
        .and(sfn())
        .and_then(home_handler::index);
    home
}
