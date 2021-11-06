function confirmbox (orderid){
    $(".confirmyes").attr("onclick","confirmok("+orderid+")")
    $(".mark2").fadeIn(300);
    $(".confirmbox").fadeIn(300);
}
function confirmhide (){
    $(".confirmbox").fadeOut(300);
    $(".mark2").fadeOut(300);
}
function confirmok (orderid){
    //执行确认收货...
    confirmhide();
    modelbox("已确认收货！");
    //window.location.replace("example.com")//跳转至订单列表页
}