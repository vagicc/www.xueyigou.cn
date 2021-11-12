$("#photo").change(function () {
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
        $("#photoEcho").attr("src", objUrl);
        $("#uploading-img-icon").hide();
    }
});



function addVideo(e) {
    let file = e.files[0];
    if (!file) {
        return false;
    }
    if (!/(video\/mp4|video\/avi|video\/wmv)$/.test(file.type)) {
        modelbox("您未上传文件，或者您上传文件类型有误！")
        return;
    }
    let objUrl = getObjectURL(file);
    $(e).siblings("#photoEcho").show().attr("src", objUrl);
    $(e).hide();
    $(e).siblings("#uploading-img-icon").hide();
    $(e).siblings(".up-del").show();
}

function delVideo(e) {
    $(e).siblings("#photoEcho").removeAttr("src").hide();
    $(e).siblings("#uploading-img-icon").show();
    $(e).siblings("input").val('');
    $(e).siblings("input").show();
    $(e).hide();
}


function addImage(e) {
    let file = e.files[0];
    if (!file) {
        return false;
    }
    if (!/(image\/gif|image\/jpg|image\/jpeg|image\/png)$/.test(file.type)) {
        modelbox("您未上传文件，或者您上传文件类型有误！")
        return;
    }
    let objUrl = getObjectURL(file);
    if (objUrl) {
        $(e).siblings("#photoEcho").attr("src", objUrl);
        $(e).hide();
        $(e).siblings("#uploading-img-icon").hide();
        $(e).siblings(".up-del").show();
    }
    let template = `
                        <div class="uploading-img" style="margin-top: .2rem;">
                            <span id="uploading-img-icon">+</span>
                            <span onclick="delImg(this)" class="up-del iconfont icon-close"></span>
                            <input class="uploading-img-input" onchange="addImage(this)" type="file"></input>
                            <img id="photoEcho">
                        </div>
                    `;
    let temp = $(template);
    $(e).parent().after(temp);
}


function delImg(e) {
    $(e).parent().remove();
}







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








/*now*/
var myDate = new Date;
var year = myDate.getFullYear();
var mon = myDate.getMonth() + 1;
var date = myDate.getDate();
var h = myDate.getHours();
var m = myDate.getMinutes();
//var s = myDate.getSeconds();
$("#time").attr("value",year+"-"+mon+"-"+date+" "+h+":"+m)
/*time*/
$("#time").flatpickr();