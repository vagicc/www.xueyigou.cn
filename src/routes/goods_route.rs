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

pub fn do_virtual(
    s: BoxedFilter<(Session,)>,
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let sfn = move || s.clone();

    warp::post()
        .and(warp::path!("goods" / "create" / "virtual"))
        .and(warp::path::end())
        .and(sfn())
        .and(warp::multipart::form())
        .and_then(goods_handler::do_virtual)
}

#[macro_export]
macro_rules! vec{
    ($($x:expr),*)=> {
        {
            let mut temp_vec=Vec::new();
            $(
                temp_vec.push($x);
            )*
            temp_vec
        }
    };
}
