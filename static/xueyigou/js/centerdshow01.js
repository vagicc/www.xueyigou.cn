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
    //执行确认发货...
    confirmhide();
    modelbox("已确认发货！");
    //window.location.replace("example.com")//跳转至订单列表页
}
$('input[type=radio][name=state]').change(function() {
    if (this.value == '2') {
       $(".fhinfo").hide()
       $(".fhinfo input").val("")
    }
    else {
        $(".fhinfo").show()
    }
});