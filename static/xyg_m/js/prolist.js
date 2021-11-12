$(document).ready(function(){
    $(".prosel1").click(function(){
        $(".prosel2").removeClass("on")
        $(".proare").fadeOut(300)
        if($(this).hasClass("on")){
            $(this).removeClass("on")
            $(".procat").fadeOut(300)
        }else{
            $(this).addClass("on")
            $(".procat").fadeIn(300)
        }
    })
    $(".procat li a").click(function(event){
        event.preventDefault();
        var text=$(this).text();
        var sel1=$(this).data("sel1");
        console.log(sel1)//测试打印
        //code执行请求对应分类数据
        $(".prosel1").removeClass("on")
        $(".prosel1").text(text)
        $(".procat").fadeOut(300)
    })
    $("#city-picker").cityPicker({
        title: "选择省市区/县",
        // onChange: function (picker, values, displayValues) {
        //     console.log(values, displayValues);
        // }
    })
    $(".prosel2").click(function(){
        $(".prosel1").removeClass("on")
        $(".procat").fadeOut(300)
        if($(this).hasClass("on")){
            $(this).removeClass("on")
            $(".proare").fadeOut(300)
        }else{
            $(this).addClass("on")
            $(".proare").fadeIn(300)
        }
    })
    $(".qxbtn").click(function(){
        $(".proare").fadeOut(300)
        $(".prosel2").removeClass("on")
    })
    $(".qdbtn").click(function(){
        var codes=$("#city-picker").data("codes");
        console.log(codes)//测试打印
        //code执行请求对应分类数据
        $(".proare").fadeOut(300)
        $(".prosel2").removeClass("on")
    })
});