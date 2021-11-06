function confirmbox (wkid){
    $(".confirmyes").attr("onclick","confirmok("+wkid+")")
    $(".mark2").fadeIn(300);
    $(".confirmbox").fadeIn(300);
}
function confirmhide (){
    $(".confirmbox").fadeOut(300);
    $(".mark2").fadeOut(300);
}
function confirmok (wkid){
    //执行删除产品...
    confirmhide();
    modelbox("产品已删除！");
    //window.location.reload()//刷新当前页面
}