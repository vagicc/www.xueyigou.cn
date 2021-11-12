use crate::handlers::test_handler;
use crate::session::Session;
use bytes::BufMut;
use futures::TryStreamExt;
// use std::convert::Infallible;
// use warp::http::StatusCode;
use warp::multipart::{FormData, Part};
use warp::{filters::BoxedFilter, Filter};
use warp::{Rejection, Reply};

pub fn is_login(
    s: BoxedFilter<(Session,)>,
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let sfn = move || s.clone();
    let logout = warp::get()
        .and(warp::path!("test" / "is_login"))
        .and(warp::path::end())
        .and(sfn())
        .and_then(test_handler::is_login);
    logout
}

pub fn multipart_form() -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone
{
    let form = warp::get()
        .and(warp::path!("test" / "multipart_form"))
        .and(warp::path::end())
        .and_then(test_handler::multipart_form);
    form
}

pub fn do_multipart_form(
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let do_multipart_form = warp::post()
        .and(warp::path!("test" / "do_multipart_form"))
        .and(warp::path::end())
        .and(warp::multipart::form())
        // .and(warp::multipart::form().max_length(5_000_000))  //这个是带文件上传，并限制上传文件大小
        // .and(warp::body::form())   //这个是没有文件上传的表单
        .and_then(test_handler::do_multipart_form);
    do_multipart_form
}

pub fn _simple() -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let upload_route = warp::path("files")
        .and(warp::path("v1"))
        .and(warp::post())
        .and(warp::path::param())
        .and(warp::multipart::form().max_length(5_000_000))
        .and_then(upload);
    upload_route
}

#[derive(Debug)]
struct ServerError {
    message: String,
}
impl warp::reject::Reject for ServerError {}

async fn upload(param_file_name: String, form: FormData) -> Result<impl Reply, Rejection> {
    let parts: Vec<Part> = form.try_collect().await.map_err(|e| {
        eprintln!("上传文件表单出错form error: {}", e);
        warp::reject::custom(ServerError {
            message: e.to_string(),
        })
    })?;

    /* 多个文件上传处理 */
    for p in parts {
        if p.name() == "file" {
            let value = p
                .stream()
                .try_fold(Vec::new(), |mut vec, data| {
                    vec.put(data);
                    async move { Ok(vec) }
                })
                .await
                .map_err(|e| {
                    eprintln!("读取文件出错=>reading file error: {}", e);
                    warp::reject::custom(ServerError {
                        message: e.to_string(),
                    })
                })?;

            let fname2 = format!("./files/{}", param_file_name);
            tokio::fs::write(&fname2, value).await.map_err(|e| {
                eprint!("写文件或移动文件出错=>error writing file: {}", e);
                warp::reject::custom(ServerError {
                    message: e.to_string(),
                })
            })?;
            #[cfg(debug_assertions)]
            println!("创建上传文件成功=>created file: {}", param_file_name);
        }
    }

    Ok("success")
}
