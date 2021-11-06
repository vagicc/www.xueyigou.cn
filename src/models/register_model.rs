// 这个只是输出handlebars模板，不是真的模型
use handlebars::{to_json, Handlebars};
use serde_derive::Serialize;
use serde_json;
use serde_json::value::{Map, Value as Json};

/* 可参考 /home/elapse/Language/Rust/demo-handlebars */
pub fn register_html() -> String {
    let mut handlebars = Handlebars::new();

    /* 注册html模板 */
    handlebars
        .register_template_file("register.html", "src/views/register.html")
        .unwrap_or_else(|e| println!("handlebars注册模板出错:{}", e));
    handlebars
        .register_template_file("frame.html", "src/views/frame.html")
        .unwrap_or_else(|e| println!("handlebars注册模板出错:{}", e));

    /* 传输数据给模板 */
    let mut data = Map::new();
    data.insert("parent".to_string(), to_json("frame.html")); //必传,这个是插入父级的html
    data.insert("title".to_string(), to_json("src"));

    let html = handlebars.render("register.html", &data).unwrap();
    html
}

pub fn register_template(name: &str, mut data: Map<String, Json>) -> String {
    let mut handlebars = Handlebars::new();

    /* 注册html模板 */
    handlebars
        .register_template_file(name, "src/views/".to_owned() + name)
        .unwrap_or_else(|e| println!("handlebars注册模板出错:{}", e));
    handlebars
        .register_template_file("frame.html", "src/views/frame.html")
        .unwrap_or_else(|e| println!("handlebars注册模板出错:{}", e));

    /* 传输数据给模板 */
    // let mut data = Map::new();
    data.insert("parent".to_string(), to_json("frame.html")); //必传,这个是插入父级的html
                                                              // data.insert("title".to_string(), to_json("src"));

    let html = handlebars.render(name, &data).unwrap();
    html
}

// 定义一些数据,示例
#[derive(Serialize)]
pub struct Team {
    name: String,
    pts: u16,
}
static TYPES: &'static str = "serde_json";

pub fn make_data() -> Map<String, Json> {
    let mut data = Map::new();

    data.insert("year".to_string(), to_json("2015"));

    let teams = vec![
        Team {
            name: "Jiangsu Suning".to_string(),
            pts: 43u16,
        },
        Team {
            name: "Shanghai SIPG".to_string(),
            pts: 39u16,
        },
        Team {
            name: "Hebei CFFC".to_string(),
            pts: 27u16,
        },
        Team {
            name: "Guangzhou Evergrand".to_string(),
            pts: 22u16,
        },
        Team {
            name: "Shandong Luneng".to_string(),
            pts: 12u16,
        },
        Team {
            name: "Beijing Guoan".to_string(),
            pts: 7u16,
        },
        Team {
            name: "Hangzhou Greentown".to_string(),
            pts: 7u16,
        },
        Team {
            name: "Shanghai Shenhua".to_string(),
            pts: 4u16,
        },
    ];
    data.insert("teams".to_string(), to_json(&teams));
    data.insert("engine".to_string(), to_json(TYPES));
    data
}
