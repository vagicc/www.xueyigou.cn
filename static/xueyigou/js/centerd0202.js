$(document).ready(function(){
    $(".work-type").mouseenter(function(){
        $(this).children("ul").stop().fadeIn()
    })
    $(".work-type").mouseleave(function(){
        $(this).children("ul").stop().fadeOut()
    })
    $(".work-type ul li").click(function(){
        var type=$(this).data("type");
        var content=$(this).text();
        $(".works-type").val(type);
        $(".work-type p").text(content);
        $(".work-type ul").fadeOut();
    });
    $(".cat-type").mouseenter(function(){
        $(this).children("ul").stop().fadeIn()
    })
    $(".cat-type").mouseleave(function(){
        $(this).children("ul").stop().fadeOut()
    })
    $(".cat-type ul li").click(function(){
        var type=$(this).data("type");
        var content=$(this).text();
        $(".cats-type").val(type);
        $(".cat-type p").text(content);
        $(".cat-type ul").fadeOut();
    });
    $(".color-type").mouseenter(function(){
        $(this).children("ul").stop().fadeIn()
    })
    $(".color-type").mouseleave(function(){
        $(this).children("ul").stop().fadeOut()
    })
    $(".color-type ul li").click(function(){
        var type=$(this).data("type");
        var content=$(this).text();
        $(".colors-type").val(type);
        $(".color-type p").text(content);
        $(".color-type ul").fadeOut();
    });
    /*editor*/
    var testEditor;
    $(function() {
        testEditor = editormd("editormd", {
            toolbarAutoFixed: false,
            width   : "100%",
            height  : 600,
            syncScrolling : "single",
            path    : "./editormd/lib/",
            imageUpload : true,
            imageFormats : ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
            imageUploadURL : "./php/upload.php?test=dfdf",//单图上传，后台处理图片地址
            toolbarIcons : function() {
                // Or return editormd.toolbarModes[name]; // full, simple, mini
                // Using "||" set icons align right.
                return ["undo", "redo", "|", "bold", "hr", "image","|", "preview", "watch", "|", "fullscreen"]
            }
        });
    });
    /*now*/
    var myDate = new Date;
    var year = myDate.getFullYear();
    var mon = myDate.getMonth() + 1;
    var date = myDate.getDate();
    var h = myDate.getHours();
    var m = myDate.getMinutes();
    //var s = myDate.getSeconds();
    $("#time").attr("value",year+"-"+mon+"-"+date+" "+h+":"+m)
    /*time*/
    $("#time").flatpickr();
    /*addmpic*/
})
function addmpic (){
    $(".m-piccontent").append('<li class="ibline"><div class="ibline-r-670 comm-input filestyle ibline-r-o"><p>请上传详情图片</p><i class="iconfont icon-selfile">浏览</i><input type="file"></div><p class="ibline-l ibline-l-o"><span class="searchclose iconfont icon-close" onclick="deletempic(this)"></span></p></li>');
    $(".filestyle").on("change","input[type='file']",uploadpic)
}
function deletempic ($this){
    $($this).parents(".ibline").remove();
}