$('.hleft .cleft li a').on('click' , function(e){
    $('.hleft .cleft li').removeClass('on');
    $(this).parent('li').addClass('on');
    var target = $('[section-scroll='+$(this).attr('href')+']');
    e.preventDefault();
    var targetHeight = target.offset().top;
    $('html, body').animate({
     scrollTop: targetHeight
    }, 500);
});