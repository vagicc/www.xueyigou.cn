use crate::session::Session;
use crate::template::to_html_ad;
use handlebars::to_json;
use serde_json::value::Map;
use warp::{Rejection, Reply};

type ResultWarp<T> = std::result::Result<T, Rejection>;

/* 输出首页 */
pub async fn index(mut session: Session) -> ResultWarp<impl Reply> {
    // let html = "模板返回html".to_string();
    // let html = register_model::register_html();

    let mut data = Map::new();
    let user = session.user();
    if let Some(u) = user {
        let mut username = u.username.clone();
        if let Some(mobile) = &u.mobile {
            username = mobile.clone();
        }
        data.insert("username".to_string(), to_json(username));
    }
    data.insert("title".to_string(), to_json("title传过来的值"));

    // 获取轮播图片
    use crate::models::banners_model::get_enable_banners;

    let banners = get_enable_banners(session.db());
    if let Some(b) = banners {
        data.insert("banners".to_string(), to_json(b));
    }

    // 加载定制服务
    use crate::models::customized_services::get_enable_csInfo;

    let csinfos = get_enable_csInfo(session.db());
    if let Some(ci) = csinfos {
        data.insert("csinfos".to_string(), to_json(ci));
    }


    // 公益资讯
    use crate::models::public_welfare_model::get_public_welfare_by_id;

    let public_welfare_info = get_public_welfare_by_id(1, session.db());

    if let Some(pwi) = public_welfare_info {
        data.insert("public_welfare_info".to_string(), to_json(pwi));
    }

    // 爱心捐资对象
    let public_welfare_object = get_public_welfare_by_id(2, session.db());

    if let Some(pwo) = public_welfare_object {
        data.insert("public_welfare_object".to_string(), to_json(pwo));
    }

    // 募捐活动
    let public_welfare_active = get_public_welfare_by_id(3, session.db());

    if let Some(pwa) = public_welfare_active {
        data.insert("public_welfare_active".to_string(), to_json(pwa));
    }

    // 最新发布
    use crate::models::index_works_model::get_index_works_by_id;

    let works_new = get_index_works_by_id(1, session.db());

    if let Some(wn) = works_new {
        data.insert("works_new".to_string(), to_json(wn));
    }

    // 最热作品
    let works_hot = get_index_works_by_id(2, session.db());

    if let Some(wh) = works_hot {
        data.insert("works_hot".to_string(), to_json(wh));
    }

    // 官方甄选
    let works_official = get_index_works_by_id(3, session.db());

    if let Some(wo) = works_official {
        data.insert("works_official".to_string(), to_json(wo));
    }

    // 加载荣誉展台服务
    use crate::models::honor_model::get_enable_honorInfo;

    let honorinfos = get_enable_honorInfo(session.db());
    if let Some(hi) = honorinfos {
        data.insert("honorinfos".to_string(), to_json(hi));
    }

    let html = to_html_ad("index.html", data);
    let id = 64;
    if id != 0 {
        Ok(warp::reply::html(html))
    } else {
        Err(warp::reject::not_found())
    }


}
