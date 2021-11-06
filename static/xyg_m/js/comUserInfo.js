

$("#up-head").change(function () {
    let file = this.files[0];
    // console.log(file);
    if (!file) {
        return false;
    }
    if (!/(image\/gif|image\/jpg|image\/jpeg|image\/png)$/.test(file.type)) {
        modelbox("您未上传文件，或者您上传文件类型有误！")
        return;
    }

    let objUrl = getObjectURL(file);
    if (objUrl) {
        let img = $("<img >")
        img.attr("src", objUrl);
        $(".head-img").append(img);
    }
});
//建立一個可存取到該file的url
function getObjectURL(file) {
    let url = null;
    if (window.createObjectURL != undefined) { // basic
        url = window.createObjectURL(file);
    } else if (window.URL != undefined) { // mozilla(firefox)
        url = window.URL.createObjectURL(file);
    } else if (window.webkitURL != undefined) { // webkit or chrome
        url = window.webkitURL.createObjectURL(file);
    }
    return url;
}





$(".uploading-img").children("input").change(function () {
    let file = this.files[0];
    console.log(file);
    if (!file) {
        return false;
    }
    if (!/(image\/gif|image\/jpg|image\/jpeg|image\/png)$/.test(file.type)) {
        modelbox("您未上传文件，或者您上传文件类型有误！")
        return;
    }

    let objUrl = getObjectURL(file);
    if (objUrl) {
        $(this).siblings("#photoEcho").attr("src", objUrl);
        $(this).siblings("#uploading-img-icon").hide();
    }
});
//建立一個可存取到該file的url
function getObjectURL(file) {
    let url = null;
    if (window.createObjectURL != undefined) { // basic
        url = window.createObjectURL(file);
    } else if (window.URL != undefined) { // mozilla(firefox)
        url = window.URL.createObjectURL(file);
    } else if (window.webkitURL != undefined) { // webkit or chrome
        url = window.webkitURL.createObjectURL(file);
    }
    return url;
}





$("#ord-city-picker").cityPicker({
    title: "选择省/市/区县",
})








// var map = new BMap.Map("allmap", {
//     minZoom: 5,
//     maxZoom: 19
// });
// map.centerAndZoom(new BMap.Point(121.36564, 31.22611), 19);
// map.enableScrollWheelZoom(true);
// var opts = {type: BMAP_NAVIGATION_CONTROL_SMALL}
// map.addControl(new BMap.NavigationControl(opts));
// map.addEventListener("click", function(e) {
//     document.getElementById('lat').value = e.point.lat;
//     document.getElementById('lng').value = e.point.lng;
// });
// var local = new BMap.LocalSearch(map, {
//     renderOptions: {
//         map: map
//     }
// });
// function theLocation() {
//     var city = document.getElementById("cityName").value;
//     if (city != "") {
//         local.search(city);
//     }
// };


//创建和初始化地图函数：
function initMap(){
    createMap();//创建地图
    setMapEvent();//设置地图事件
}
//创建地图函数：
function createMap(){
    var map = new BMap.Map("allmap");//在百度地图容器中创建一个地图
    var point = new BMap.Point(121.36564, 31.22611);//定义一个中心点坐标
    map.centerAndZoom(point,17);//设定地图的中心点和坐标并将地图显示在地图容器中
    window.map = map;//将map变量存储在全局
    var opts = {type: BMAP_NAVIGATION_CONTROL_SMALL}
    map.addControl(new BMap.NavigationControl(opts));
    map.addEventListener("click", function(e) {
        document.getElementById('lat').value = e.point.lat;
        document.getElementById('lng').value = e.point.lng;
    });
}
//地图事件设置函数：
function setMapEvent(){
    map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
    map.enableScrollWheelZoom();//启用地图滚轮放大缩小
    map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
    map.enableKeyboard();//启用键盘上下左右键移动地图
}

initMap();//创建和初始化地图
var local = new BMap.LocalSearch(map, {
    renderOptions: {
        map: map
    }
});
function theLocation() {
    var city = document.getElementById("cityName").value;
    if (city != "") {
        local.search(city);
    }
};