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
    //执行删除订单...
    confirmhide();
    modelbox("订单已删除！");
    //window.location.replace("example.com")//跳转至订单列表页
}