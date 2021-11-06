/*banner*/
var swiper = new Swiper('.banner',{
    pagination: {
        el: '.swiper-pagination',
        clickable :true,
      }
  });
  /*indexwork*/
  $(function() {
    var tabsSwiper;
    tabsSwiper = new Swiper('.iwcont', {
        autoHeight: true,
        speed : 500,
        onSlideChangeStart : function() {
            $(".iwtabs .active").removeClass('active');
            $(".iwtabs li").eq(tabsSwiper.activeIndex).addClass('active');
        }
    });
    $(".iwtabs li").on('touchstart mousedown', function(e) {
        e.preventDefault()
        $(".iwtabs .active").removeClass('active');
        $(this).addClass('active');
        tabsSwiper.slideTo($(this).index());
    });
    $(".iwtabs li").click(function(e) {
        e.preventDefault();
    });
});
/*indexgar*/
$(function() {
    var tabsSwiper;
    tabsSwiper = new Swiper('.igcont', {
        autoHeight: true,
        speed : 500,
        onSlideChangeStart : function() {
            $(".igtabs .active").removeClass('active');
            $(".igtabs li").eq(tabsSwiper.activeIndex).addClass('active');
        }
    });
    $(".igtabs li").on('touchstart mousedown', function(e) {
        e.preventDefault()
        $(".igtabs .active").removeClass('active');
        $(this).addClass('active');
        tabsSwiper.slideTo($(this).index());
    });
    $(".igtabs li").click(function(e) {
        e.preventDefault();
    });
});