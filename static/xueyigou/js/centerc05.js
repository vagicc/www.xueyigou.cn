function confirmbox (scid){
    $(".confirmyes").attr("onclick","confirmok("+scid+")")
    $(".mark2").fadeIn(300);
    $(".confirmbox").fadeIn(300);
}
function confirmhide (){
    $(".confirmbox").fadeOut(300);
    $(".mark2").fadeOut(300);
}
function confirmok (scid){
    //执行删除收藏...
    confirmhide();
    modelbox("收藏已删除！");
    //window.location.reload()//刷新当前页面
}