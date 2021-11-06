function confirmbox (sevid){
    $(".confirmyes").attr("onclick","confirmok("+sevid+")")
    $(".mark2").fadeIn(300);
    $(".confirmbox").fadeIn(300);
}
function confirmhide (){
    $(".confirmbox").fadeOut(300);
    $(".mark2").fadeOut(300);
}
function confirmok (sevid){
    //执行删除服务...
    confirmhide();
    modelbox("服务已删除！");
    //window.location.reload()//刷新当前页面
}