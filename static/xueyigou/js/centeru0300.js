function confirmbox (userid){
    $(".confirmyes").attr("onclick","confirmok("+userid+")")
    $(".mark2").fadeIn(300);
    $(".confirmbox").fadeIn(300);
}
function confirmhide (){
    $(".confirmbox").fadeOut(300);
    $(".mark2").fadeOut(300);
}
function confirmok (userid){
    //执行取消关注...
    confirmhide();
    modelbox("已取消关注！");
    //window.location.reload()//刷新当前页面
}