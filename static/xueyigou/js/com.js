
$(".c-header .icon-guanzhu").click(function(){
    if($(this).hasClass("on")){
        $(this).removeClass("on")
        modelbox("已取消关注！")
    }else{
        $(this).addClass("on");
        modelbox("已关注！")
    }
});
var swiper = new Swiper('.c-banner',{
    autoHeight:true,
    loop:true,
    pagination: {
        el: '.swiper-pagination',
        clickable :true,
      }
});
$(".cjlist").click(function(){
    $(".mark2").fadeIn(300);
    $(this).css("z-index",999)
    $(this).find(".jobc").fadeIn(300)
    $(this).find(".closebtn").fadeIn(300)
});
function jobclose (obj){
    $(obj).parent(".cjlist").css("z-index","inherit")
    $(obj).siblings(".jobc").fadeOut(300)
    $(obj).fadeOut(300)
    $(".mark2").fadeOut(300)
    window.event.stopPropagation()
};
function jobchide (){
    $(".cjlist").css("z-index","inherit")
    $(".jobc").fadeOut(300)
    $(".cjlist .closebtn").fadeOut(300)
    $(".mark2").fadeOut(300)
};