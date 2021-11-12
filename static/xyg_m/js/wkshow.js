$(document).ready(function(){
    $(".iwlti .icon-like").click(function(){
        if($(this).hasClass("on")){
            $(this).removeClass("on")
            modelbox("已取消点赞！")
        }else{
            $(this).addClass("on");
            modelbox("已点赞！")
        }
    });
    $(".pro-sc").click(function(){
        if($(this).hasClass("on")){
            $(this).removeClass("on")
            modelbox("已取消收藏！")
        }else{
            $(this).addClass("on");
            modelbox("已收藏！")
        }
    });
    $(".add-cart").click(function(){
        modelbox("已加入购物车！")
    });
});


function changeComment(e) {    
    $(".comment-p").text($(e).val())
}

function revertInfo(e) {
    let text = "回复@" + $(e).parent().parent().find(".comment-name").text() + "：";
    $(".comment-box").val(text).focus();
    $("body").animate({
        scrollTop: $(".comment-box").offset().top - 50
    }, 300)
}