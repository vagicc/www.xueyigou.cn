/*common*/
function markshow (){
    $(".mark").fadeIn(300);
}
function markhide (){
    $(".mark").fadeOut(300);
}
function regshow (){
    $(".regbox").fadeIn(300);
}
function reghide (){
    $(".regbox").fadeOut(300);
}
function wxregshow (){
    $(".wxregbox").fadeIn(300);
}
function wxreghide (){
    $(".wxregbox").fadeOut(300);
}
function wxlogshow (){
    $(".wxlogbox").fadeIn(300);
}
function wxloghide (){
    $(".wxlogbox").fadeOut(300);
}
function logshow (){
    $(".logbox").fadeIn(300);
}
function loghide (){
    $(".logbox").fadeOut(300);
}
function forshow (){
    $(".forbox").fadeIn(300);
}
function forhide (){
    $(".forbox").fadeOut(300);
}
function searchshow (){
    $(".searchbox").fadeIn(300);
}
function searchhide (){
    $(".searchbox").fadeOut(300);
}
function addshow (){
    $(".addbox").fadeIn(300);
}
function addhide (){
    $(".addbox").fadeOut(300);
}
function wxpayshow (){
    $(".wxpaybox").fadeIn(300);
}
function wxpayhide (){
    $(".wxpaybox").fadeOut(300);
}
function ramshow (){
    markshow();
    regshow();
}
function ramhide (){
    markhide();
    reghide();
}
function lamshow (){
    markshow();
    logshow();
}
function lamhide (){
    markhide();
    loghide();
}
function wxgoto (){
    reghide();
    wxregshow();
}
function wxgoback (){
    wxreghide();
    regshow();
}
function wxlgoto (){
    loghide();
    wxlogshow();
}
function wxlgoback (){
    wxloghide();
    logshow();
}
function wxamhide (){
    markhide();
    wxreghide();
}
function wxlamhide (){
    markhide();
    wxloghide();
}
function foramhide (){
    markhide();
    forhide();
}
function rtol (){
    reghide();
    logshow();
}
function ltor (){
    loghide();
    regshow();
}
function ltof (){
    loghide();
    forshow();
}
function samshow (){
    markshow();
    searchshow();
}function samhide (){
    markhide();
    searchhide();
}
function aamshow (){
    $(".addbox form").attr("action","添加收货地址接口");
    $(".addbox form").find("#shname").attr("value","");
    $(".addbox form").find("#shtel").attr("value","");
    $(".addbox form").find("#shenfen p").text("选择省份");
    $(".addbox form").find("#chengshi p").text("选择城市");
    $(".addbox form").find("#quyu p").text("选择地区");
    $(".addbox form").find(".addtext").text("");
    $(".addbox form").find("#sfdq_num").attr("value","");
    $(".addbox form").find("#csdq_num").attr("value","");
    $(".addbox form").find("#qydq_num").attr("value","");
    markshow();
    addshow();
}
function aamhide (){
    markhide();
    addhide();
}
function pamshow (){
    markshow();
    wxpayshow();
}
function pamhide (){
    markhide();
    wxpayhide();
}
function allhide (){
    markhide();
    reghide();
    wxreghide();
    loghide();
    wxloghide();
    forhide();
    searchhide();
    addhide();
    wxpayhide();
}
function modelbox(mes){
    $(".modelbox").stop(true)
    $(".modelbox").text(mes)
    $(".modelbox").fadeIn(300)
    $(".modelbox").delay(1000).fadeOut(300)
}
$(document).ready(function(){
    $(".sel-type").mouseenter(function(){
        $(this).children("ul").stop().fadeIn()
    })
    $(".sel-type").mouseleave(function(){
        $(this).children("ul").stop().fadeOut()
    })
    $(".sel-type ul li").click(function(){
        var type=$(this).data("type");
        var content=$(this).text();
        $(".reg-type").val(type);
        $(".sel-type p").text(content);
        $(".sel-type ul").fadeOut();
    });
    $(".search-type").mouseenter(function(){
        $(this).children("ul").stop().fadeIn()
    })
    $(".search-type").mouseleave(function(){
        $(this).children("ul").stop().fadeOut()
    })
    $(".search-type ul li").click(function(){
        var type=$(this).data("type");
        var content=$(this).text();
        $(".searchs-type").val(type);
        $(".search-type p").text(content);
        $(".search-type ul").fadeOut();
    });
    $(".kjkey span").click(function(){
        var content=$(this).text();
        $(".searchkey").val(content);
    });
  });
/*settime*/
var clock = '';
var nums = 30;
var btn;
function sendCode(thisBtn){
    var phone = $("#r-telnumber").val();
    var flag = false;
    var message = "";
    var myreg = /^(((13[0-9]{1})|(14[0-9]{1})|(17[0]{1})|(15[0-3]{1})|(15[5-9]{1})|(18[0-9]{1}))+\d{8})$/;       
    if(phone == ''){
        message="手机号码不能为空！";
    }else if(phone.length !=11){
        message="请输入11位手机号！";
    }else if(!myreg.test(phone)){
        message="请输入有效手机号！";
    }else{
        flag = true;
    }
    if(!flag){
        modelbox(message);
    }else{
        modelbox("验证码已发送，5分钟内有效!");
        btn = thisBtn;
        btn.disabled = true; //将按钮置为不可点击
        //somecode...执行验证码发送
        $(btn).text(nums+'S');
        clock = setInterval(doLoop, 1000); //一秒执行一次
    }
    return flag;
};
function doLoop(){
    nums--;
    if(nums > 0){
    $(btn).text(nums+'S');
    }else{
        clearInterval(clock); //清除js定时器
        btn.disabled = false;
        $(btn).text('获取验证码');
        nums = 30; //重置时间
    }
};