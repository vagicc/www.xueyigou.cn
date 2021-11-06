function confirmbox (pyqid){
    $(".confirmyes").attr("onclick","confirmok("+pyqid+")")
    $(".mark2").fadeIn(300);
    $(".confirmbox").fadeIn(300);
}
function confirmhide (){
    $(".confirmbox").fadeOut(300);
    $(".mark2").fadeOut(300);
}
function confirmok (pyqid){
    //执行删除圈子...
    confirmhide();
    modelbox("圈子已删除！");
    //window.location.reload()//刷新当前页面
}