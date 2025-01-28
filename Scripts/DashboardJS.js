$(document).ready(function () {
    $("img.info-bg").hide();
    var $url = $("img.info-bg").attr("src");
    $('.grid-welcome-bg').css('backgroundImage', 'url(' + $url + ')');
    $('aside.left-panel, section.content').hide();
});

function fnOpenWelcomePage() {
    window.location.href = "../Data/Instruction.aspx?NodeID=";
}

function fnNominateRater() {
    window.location.href = "../Data/frmNominateRater.aspx?NodeID=";
}

