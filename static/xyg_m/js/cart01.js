$(document).ready(function(){
    var total = 0
    var tcount = 0
    $(".ctlist").each(function(index, value){
        var price = $(this).find(".ctprice-s span").text()
        var count = $(this).find(".c-count input").val()
        var jx = $(this).find(".ctprice-j span").text()
        $(this).find(".ctprice-t span").text(price*count)
        $(this).find(".ctprice-t font").text(jx*count)
        total += price*count
        tcount += 1
    })
    $(".allcart strong").text(total)
    $(".allcount").text(tcount)
})
/*reduce*/
$(".ctlist .ctcount .span-reduce").click(function(){
    var count = Number($(this).next("input").attr("value"))
    if (count>=2){
        count-=1
        var total = Number($(".allcart strong").text())
        var price = Number($(this).parents(".ctlist").find(".ctprice-s span").text())
        var jx = Number($(this).parents(".ctlist").find(".ctprice-j span").text())
        $(this).next("input").attr("value",count)
        $(this).parents(".ctlist").find(".ctprice-t span").text(price*count)
        $(this).parents(".ctlist").find(".ctprice-t font").text(jx*count)
        total = total - price
        $(".allcart strong").text(total)
    }else{
        modelbox("已到达最小值，不需要的商品可点击右侧删除！")
    }
})
/*add*/
$(".ctlist .ctcount .span-add").click(function(){
    var count = Number($(this).prev("input").attr("value"))
    var max = $(this).prev("input").attr("max")
    if (count<max){
        count+=1
        var total = Number($(".allcart strong").text())
        var price = Number($(this).parents(".ctlist").find(".ctprice-s span").text())
        var jx = Number($(this).parents(".ctlist").find(".ctprice-j span").text())
        $(this).prev("input").attr("value",count)
        $(this).parents(".ctlist").find(".ctprice-t span").text(price*count)
        $(this).parents(".ctlist").find(".ctprice-t font").text(jx*count)
        total = total + price
        $(".allcart strong").text(total)
    }else{
        modelbox("已到达库存最大值！")
    }
})
/*delete*/
$(".ctlist .ctclose .iconfont").click(function(){
    $(this).parents(".ctlist").remove()
    var tcount = $(".allcart .allcount").text()
    var total = $(this).parents(".ctlist").find(".ctprice-t span").text()
    var alltotal = $(".allcart strong").text()
    $(".allcart .allcount").text(tcount-1)
    $(".allcart strong").text(alltotal-total)
})