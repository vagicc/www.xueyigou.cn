$(function() {
    var hgS1 = new selectSwiper({
        el: '.select_box1',
        data: ['普通用户', '设计师用户', '企业用户'],
        init: function(index) {
            if (index !== -1) {
                $('.reg-type').html(this.data[index]);
            }
        },
        okFunUndefind: function() {
            alert('必须选择一项');
            return false;
        },
        okFun: function(index) {
            console.log(index);
            $('.reg-type').html(this.data[index]);
            $('.reg-type-v').html(index+1)
        },
        closeFun: function() {
            console.log('取消');
        },
    });
    $('.reg-type').on('click', function() {
        hgS1.openSelectSwiper();
    });
});
