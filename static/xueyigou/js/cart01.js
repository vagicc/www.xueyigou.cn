$(document).ready(function(){
    var total = 0
    var tcount = 0
    $(".ctlist").each(function(index, value){
        var price = $(this).find(".c-price span").text()
        var count = $(this).find(".c-count input").val()
        var jx = $("#jz").text()
        $(this).find(".c-ltotal span").text(price*count)
        $(this).find(".ctprice-j span").text(jx*count)
        total += price*count
        tcount += 1
    })
    $(".ctfoot .alltotal span strong").text(total)
    $(".ctfoot .allcount strong").text(tcount)
})
/*reduce*/
$(".ctlist .c-count .span-reduce").click(function(){
    var count = Number($(this).next("input").attr("value"))
    if (count>=2){
        count-=1
        var total = Number($(".ctfoot .alltotal span strong").text())
        var price = Number($(this).parents(".ctlist").find(".c-price span").text())
        var jx = Number($("#jz").text())
        $(this).next("input").attr("value",count)
        $(this).parents(".ctlist").find(".c-ltotal span").text(price*count)
        $(this).parents(".ctlist").find(".ctprice-j span").text(jx*count)
        total = total - price
        $(".ctfoot .alltotal span strong").text(total)
    }else{
        modelbox("已到达最小值，不需要的商品可点击右侧删除！")
    }
})
/*add*/
$(".ctlist .c-count .span-add").click(function(){
    var count = Number($(this).prev("input").attr("value"))
    var max = $(this).prev("input").attr("max")
    if (count<max){
        count+=1
        var total = Number($(".ctfoot .alltotal span strong").text())
        var price = Number($(this).parents(".ctlist").find(".c-price span").text())
        var jx = Number($("#jz").text())
        $(this).prev("input").attr("value",count)
        $(this).parents(".ctlist").find(".c-ltotal span").text(price*count)
        $(this).parents(".ctlist").find(".ctprice-j span").text(jx*count)
        total = total + price
        $(".ctfoot .alltotal span strong").text(total)
    }else{
        modelbox("已到达库存最大值！")
    }
})
/*delete*/
$(".ctlist .c-copr span").click(function(){
    $(this).parents(".ctlist").remove()
    var tcount = $(".ctfoot .allcount strong").text()
    var total = $(this).parents(".ctlist").find(".c-ltotal span").text()
    var alltotal = $(".ctfoot .alltotal span strong").text()
    $(".ctfoot .allcount strong").text(tcount-1)
    $(".ctfoot .alltotal span strong").text(alltotal-total)
})