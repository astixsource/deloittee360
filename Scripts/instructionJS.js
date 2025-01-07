$(document).ready(function () {
    $("img.info-bg").hide();
    var $url = $("img.info-bg").attr("src");
    $('.grid-welcome-bg').css('backgroundImage', 'url(' + $url + ')');
    $('aside.left-panel, section.content').hide();
});