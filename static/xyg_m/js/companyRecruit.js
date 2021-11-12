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


