!function() {
    var html = document.documentElement;
    var setFontSize = function() {
        var width = html.offsetWidth;
        if(width <= 750) {
            html.style.fontSize = width / 7.5+ 'px';
        } else {
            html.style.fontSize = 100 + 'px';
        }
    };
    var timer;
    var setDelay = function() {
        return clearTimeout(timer), (timer = setTimeout(setFontSize, 150));
    }
    window.addEventListener('pageshow', function(evt) {
        return evt.persisted && setDelay();
    });
    window.addEventListener('resize', setDelay);
    setFontSize();
}();