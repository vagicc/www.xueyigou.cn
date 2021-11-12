
$("input[name='state']").on("change", function() {
    if($("input[name='state']:checked").val() == "2") {
        $(".deliver-way-input-box").hide();
    }else if($("input[name='state']:checked").val() == "1") {
        $(".deliver-way-input-box").show();
    }
})