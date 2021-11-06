//微信支付
function onBridgeReady() {
var req = localStorage.getItem("payParams");
if (!req) return;
else req = JSON.parse(req);
WeixinJSBridge.invoke(
'getBrandWCPayRequest', req,
function(res) {
if (res.err_msg == "get_brand_wcpay_request:ok") {
// alert("支付成功");
} // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回 ok，但并不保证它绝对可靠。
else {
console.log(res.err_msg);
//支付失败后的操作
window.location.href = "pay.html?ticketPrice="+$tickprice+"&actid="+$actid+"&ticketId="+$ticketId+"&sellerid="+$sellerid;
}
}
);
}
if (typeof WeixinJSBridge == "undefined") {
if (document.addEventListener) {
document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
} else if (document.attachEvent) {
document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
}
} else {
onBridgeReady();
}
//支付宝支付
_wechatPay(type, vid, token, point) {
    wechatPay(type, vid, token, point).then(res => {
       const form = res.data
       const div = document.createElement('div')
       div.id = 'alipay'
       div.innerHTML = form
       document.body.appendChild(div)
       document.querySelector('#alipay').children[0].submit() // 执行后会唤起支付宝
    })
}