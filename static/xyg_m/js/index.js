if(!$.session.get('showadd')){
    $.session.set('showadd', 'yes')
    markshow()
    imdshow()
    var swiper = new Swiper('.indexsw',{
        autoHeight:true,
        pagination: {
          el:'.swiper-pagination',
          clickable:true,
        }
    });
}
var swiper = new Swiper('.banner',{
  autoHeight:true,
  loop:true,
  pagination: {
      el:'.swiper-pagination',
      clickable:true,
    }
});
var swiper = new Swiper('.iworkc',{
  autoHeight:true,
  slidesPerView:2,
  freeMode:true
});