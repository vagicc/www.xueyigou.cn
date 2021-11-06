function editoradd (obj,addid){
    markshow();
    addshow();
    $(".addbox form").attr("action","修改收货地址接口"+addid);
    $(".addbox form").find("#shname").attr("value",$(obj).parents(".addlist").find("#addname").text())
    $(".addbox form").find("#shtel").attr("value",$(obj).parents(".addlist").find("#addtel").text())
    $(".addbox form").find("#shenfen p").text($(obj).parents(".addlist").find("#addsf").text())
    $(".addbox form").find("#chengshi p").text($(obj).parents(".addlist").find("#addsq").text())
    $(".addbox form").find("#quyu p").text($(obj).parents(".addlist").find("#addqy").text())
    $(".addbox form").find(".addtext").text($(obj).parents(".addlist").find("#addxx").text())
    $(".addbox form").find("#sfdq_num").attr("value",$(obj).parents(".addlist").find("#addsf_id").val())
    $(".addbox form").find("#csdq_num").attr("value",$(obj).parents(".addlist").find("#addsq_id").val())
    $(".addbox form").find("#qydq_num").attr("value",$(obj).parents(".addlist").find("#addqy_id").val())
}
function confirmbox (addid){
    $(".confirmyes").attr("onclick","confirmok("+addid+")")
    $(".mark2").fadeIn(300);
    $(".confirmbox").fadeIn(300);
}
function confirmhide (){
    $(".confirmbox").fadeOut(300);
    $(".mark2").fadeOut(300);
}
function confirmok (addid){
    //执行删除地址...
    confirmhide();
    modelbox("收货地址已删除！");
    //window.location.reload()//刷新当前页面
}