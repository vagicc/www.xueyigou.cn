use crate::common::get_env;
use std::net::SocketAddr;

mod common;
mod db;
mod filters;
mod handlers;
mod models;
mod multipart_form;
mod routes;
mod schema;
mod session;
mod template;

#[macro_use]
extern crate diesel;

#[tokio::main]
async fn main() {
    let routes = filters::all_routes();

    let cert_path = get_env("cert_path");
    let key_path = get_env("key_path");
    let ip_addr = get_env("ip_address");
    let socket_addr: SocketAddr = ip_addr.as_str().parse().unwrap();

    println!("站点（https://warp.wiki/）");
    println!("warp https 监听： {:?}", ip_addr);

    warp::serve(routes)
        .tls()
        .cert_path(cert_path)
        .key_path(key_path)
        .run(socket_addr)
        .await;
}
