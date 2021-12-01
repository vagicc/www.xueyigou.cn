use crate::routes::admin_route;
use crate::routes::approve_route;
use crate::routes::home_route;
use crate::routes::link_route;
use crate::routes::login_route;
use crate::routes::logout_route;
use crate::routes::settings_route;
use crate::routes::signup_route;
use crate::routes::test_route;
use crate::session::create_session_filter;
use warp::Filter;

pub fn all_routes() -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let pgsession = create_session_filter();
    // let s = move || pgsession.clone();

    let dir = warp::path("static").and(warp::fs::dir("./static"));
    let home = home_route::index(pgsession.clone());

    let login = login_route::login().or(login_route::do_login_new(pgsession.clone()));
    let logout = logout_route::logout(pgsession.clone());
    let signup = signup_route::signup().or(signup_route::do_signup(pgsession.clone()));

    let settings = settings_route::security(pgsession.clone())
        .or(settings_route::change_passwd(pgsession.clone()));
    //资质申请
    let approve = approve_route::qualification(pgsession.clone())
        .or(approve_route::do_approve(pgsession.clone()));

    let admin = admin_route::add_admin();
    let link = link_route::test();
    let test = test_route::is_login(pgsession.clone())
        .or(test_route::multipart_form())
        .or(test_route::do_multipart_form());

    let routes = home
        .or(dir)
        .or(login)
        .or(logout)
        .or(signup)
        .or(settings)
        .or(approve)
        .or(admin)
        .or(link)
        .or(test);
    routes
}
