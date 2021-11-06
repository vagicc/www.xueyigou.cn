function confirmbox (zpid){
    $(".confirmyes").attr("onclick","confirmok("+zpid+")")
    $(".mark2").fadeIn(300);
    $(".confirmbox").fadeIn(300);
}
function confirmhide (){
    $(".confirmbox").fadeOut(300);
    $(".mark2").fadeOut(300);
}
function confirmok (zpid){
    //执行删除招聘岗位...
    confirmhide();
    modelbox("此招聘岗位已删除！");
    //window.location.reload()//刷新当前页面
}