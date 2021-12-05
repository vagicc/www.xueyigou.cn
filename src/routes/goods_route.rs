use crate::handlers::goods_handler;
use crate::session::Session;
use warp::{filters::BoxedFilter, Filter};

/* 发布服务：goods/create/virtual */
pub fn create_virtual(
    s: BoxedFilter<(Session,)>,
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let sfn = move || s.clone();
    warp::get()
        .and(warp::path!("goods" / "create" / "virtual"))
        .and(warp::path::end())
        .and(sfn())
        .and_then(goods_handler::virtual_html)
}
