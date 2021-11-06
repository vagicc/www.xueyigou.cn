function markshow(){
  $(".mark").fadeIn(300);
}
function markhide(){
  $(".mark").fadeOut(300);
}
function imdshow(){
  $(".indexmd").fadeIn(300);
}
function imdhide(){
  $(".indexmd").fadeOut(300);
  markhide()
}
function allhide(){
  imdhide()
}
function modelbox(mes){
  $(".modelbox").stop(true)
  $(".modelbox").text(mes)
  $(".modelbox").fadeIn(300)
  $(".modelbox").delay(1000).fadeOut(300)
}