/*editor*/
var testEditor;
$(function() {
    testEditor = editormd("editormd", {
        toolbarAutoFixed: false,
        width   : "100%",
        height  : 500,
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