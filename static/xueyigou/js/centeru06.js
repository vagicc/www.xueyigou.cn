function uploadpic (){
    var filePath=$(this).val();
    if(filePath.indexOf("jpg")!=-1 || filePath.indexOf("png")!=-1|| filePath.indexOf("gif")!=-1|| filePath.indexOf("jpeg")!=-1){
        var arr=filePath.split('\\');
        var fileName=arr[arr.length-1];
        $(this).siblings("p").html(fileName);
    }else{
        $(this).siblings("p").html("上传发生错误！");
        modelbox("您未上传文件，或者您上传文件类型有误！");
        return false 
    }
}
$(".filestyle").on("change","input[type='file']",uploadpic)


// $(".filestyle").on("change","input[type='file']",function(){
//     var filePath=$(this).val();
//     if(filePath.indexOf("jpg")!=-1 || filePath.indexOf("png")!=-1|| filePath.indexOf("gif")!=-1|| filePath.indexOf("jpeg")!=-1){
//         var arr=filePath.split('\\');
//         var fileName=arr[arr.length-1];
//         $(this).siblings("p").html(fileName);
//     }else{
//         $(this).siblings("p").html("上传发生错误！");
//         modelbox("您未上传文件，或者您上传文件类型有误！");
//         return false 
//     }
// })
$('input[type=radio][name=state]').change(function() {
    if (this.value == '2') {
       $(".xszline").hide()
       $(".xszline .filestyle p").text("学生证照片，不可大于1M（必填）")
       $(".xszline").find("input").val("")
    }
    else {
        $(".xszline").show()
    }
});