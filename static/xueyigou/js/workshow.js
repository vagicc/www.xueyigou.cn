$(".wrp .icon-like").click(function(){
    if($(this).hasClass("on")){
        $(this).removeClass("on")
        modelbox("已取消点赞！")
    }else{
        $(this).addClass("on");
        modelbox("已点赞！")
    }
});
$(".bybtn .icon-fav").click(function(){
    if($(this).hasClass("on")){
        $(this).removeClass("on")
        modelbox("已取消收藏！")
    }else{
        $(this).addClass("on");
        modelbox("已收藏！")
    }
});
$(".bybtn .addtocart").click(function(){
      modelbox("已加入购物车！")
});
/*viewer*/
$(function () {
    'use strict';
  
    var console = window.console || { log: function () {} };
    var $images = $('.docs-pictures');
    var $toggles = $('.docs-toggles');
    var $buttons = $('.docs-buttons');
    var options = {
      // inline: true,
      url: 'data-original',
      ready: function (e) {
        console.log(e.type);
      },
      show: function (e) {
        console.log(e.type);
      },
      shown: function (e) {
        console.log(e.type);
      },
      hide: function (e) {
        console.log(e.type);
      },
      hidden: function (e) {
        console.log(e.type);
      },
      view: function (e) {
        console.log(e.type);
      },
      viewed: function (e) {
        console.log(e.type);
      }
    };
  
    function toggleButtons(mode) {
      if (/modal|inline|none/.test(mode)) {
        $buttons
          .find('button[data-enable]')
            .prop('disabled', true)
          .filter('[data-enable*="' + mode + '"]')
            .prop('disabled', false);
      }
    }
  
    $images.on({
      ready:  function (e) {
        console.log(e.type);
      },
      show:  function (e) {
        console.log(e.type);
      },
      shown:  function (e) {
        console.log(e.type);
      },
      hide:  function (e) {
        console.log(e.type);
      },
      hidden: function (e) {
        console.log(e.type);
      },
      view:  function (e) {
        console.log(e.type);
      },
      viewed: function (e) {
        console.log(e.type);
      }
    }).viewer(options);
  
    toggleButtons(options.inline ? 'inline' : 'modal');
  
    $toggles.on('change', 'input', function () {
      var $input = $(this);
      var name = $input.attr('name');
  
      options[name] = name === 'inline' ? $input.data('value') : $input.prop('checked');
      $images.viewer('destroy').viewer(options);
      toggleButtons(options.inline ? 'inline' : 'modal');
    });
  
    $buttons.on('click', 'button', function () {
      var data = $(this).data();
      var args = data.arguments || [];
  
      if (data.method) {
        if (data.target) {
          $images.viewer(data.method, $(data.target).val());
        } else {
          $images.viewer(data.method, args[0], args[1]);
        }
  
        switch (data.method) {
          case 'scaleX':
          case 'scaleY':
            args[0] = -args[0];
            break;
  
          case 'destroy':
            toggleButtons('none');
            break;
        }
      }
    });
  });
  /*scroll*/
  $(window).on('scroll', function () {
		var windowpos = $(window).scrollTop();
    var H = $(".wleft").height()+350-windowpos;
    var H2 = $(".wright").height()+40;
		if (windowpos>330) {
			$(".wright").addClass("fixed");
		} else {
			$(".wright").removeClass("fixed");
		}
    if (H<H2){
      $(".wright").addClass("fixedx");
    }else{
      $(".wright").removeClass("fixedx");
    }
	  });
    /*disgre*/
    function disgre ($this){
      var disgname = $($this).parent().parent().children(".disg-u").find(".disg-un").text();
      $(".disgtext").focus().val("回复 "+disgname+" ");
      console.log($("#disg-title").offset().top)
      $('html, body').animate({
        scrollTop: $("#disg-title").offset().top
       }, 300);
    }