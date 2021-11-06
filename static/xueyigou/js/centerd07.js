function confirmbox (gcount){
    var txcount = Number($("#txcount").text())
    if(txcount>0){
        modelbox("您已有 "+txcount+" 元在提现中，暂时不可申请提现！");
    }else{
        $(".confirmyes").attr("onclick","confirmok("+gcount+")")
        $(".mark2").fadeIn(300);
        $(".confirmbox").fadeIn(300);
    }
}
function confirmhide (){
    $(".confirmbox").fadeOut(300);
    $(".mark2").fadeOut(300);
}
function confirmok (gcount){
    //执行提现...
    confirmhide();
    modelbox("已成功申请提现！");
    //window.location.reload()//刷新当前页面
}