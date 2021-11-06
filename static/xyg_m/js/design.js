$(".d-info-t .icon-guanzhu").click(function(){
    if($(this).hasClass("on")){
        $(this).removeClass("on")
        modelbox("已取消关注！")
    }else{
        $(this).addClass("on");
        modelbox("已关注！")
    }
});