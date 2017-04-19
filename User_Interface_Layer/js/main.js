(function backToTop() {
    var rand = parseInt((Math.random() * 10) % 3 + 1);
    $('#back').css("background-image", "url(http://kisssub.org/images/back2top/back2top" + rand + ".png");
    (function setBackPosAnimation() {
        var top = document.documentElement.scrollTop || document.body.scrollTop;
        var max = document.documentElement.scrollHeight || document.body.scrollHeight;
        max = max / 2;
        var pos = -135;
        if (top >= max) pos = -5;
        else pos += 130 * (top * 1.0 / max);
        $('#back').animate({ right: pos + 'px' }, 500);
    })();
    $('#back').click(function () {
        $('body').animate({ scrollTop: '0px' }, 300);
    })
})();

(function copyright() {
    var cc = document.getElementById('cc');
    function over() {
        if (cc.innerText.indexOf('150104400108') < 0) return;
        cc.innerText = cc.innerText.replace('150104400108', '\u674e\u5929\u9633');
        var itv = setInterval(function () {
            cc.innerText = cc.innerText.replace('\u674e\u5929\u9633', '150104400108');
            clearInterval(itv);
        }, 3000);
    }
    $('#cc').mouseover(over);
})();

function setBackPos() {
    var top = document.documentElement.scrollTop || document.body.scrollTop;
    var max = document.documentElement.scrollHeight || document.body.scrollHeight;
    max -= document.documentElement.clientHeight;
    var pos = -135;
    if (top >= max) pos = -5;
    else pos += 130 * (top * 1.0 / max);
    $('#back').css('right', pos + 'px');
}
window.onscroll = setBackPos;