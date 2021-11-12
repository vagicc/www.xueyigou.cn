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

function studentAtt() {
    if($("input[name='state']:checked").val() == 1) {
        $(".check-op-uploading-i").css({"display": "block"})
    }else if($("input[name='state']:checked").val() == 2) {
        $(".check-op-uploading-i").css({"display": "none"})
    }
}

