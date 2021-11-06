$(".d-header .icon-fav").click(function(){
    if($(this).hasClass("on")){
        $(this).removeClass("on")
        modelbox("已取消收藏！")
    }else{
        $(this).addClass("on");
        modelbox("已收藏！")
    }
});