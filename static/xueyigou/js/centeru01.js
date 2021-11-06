$(function() {
    var tabsSwiper;
    tabsSwiper = new Swiper('.centerbds', {
        autoHeight: true,
        speed : 500,
        onSlideChangeStart : function() {
            $(".centertabs .active").removeClass('active');
            $(".centertabs li").eq(tabsSwiper.activeIndex).addClass('active');
        }
    });
    $(".centertabs li").on('touchstart mousedown', function(e) {
        e.preventDefault()
        $(".centertabs .active").removeClass('active');
        $(this).addClass('active');
        tabsSwiper.slideTo($(this).index());
    });
    $(".centertabs li").click(function(e) {
        e.preventDefault();
    });
});