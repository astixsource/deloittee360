
$(document).ready(function () {
    fnUpdateProgressbar();
});

function fnUpdateProgressbar() {
    E360WebService.fnGetOverallStatusForTheUser(function (result) {
        if (result.split("@")[0] == 1) {
            var statusid = result.split("@")[1];
            $("#ulstatusprogress li").removeClass("done").removeClass("active");
            if (statusid == 1) {
                $("#ulstatusprogress li").eq(0).addClass("done");
                $("#ulstatusprogress li").eq(1).addClass("active");
            }
            else if (statusid == 2) {
                $("#ulstatusprogress li").eq(0).addClass("done");
                $("#ulstatusprogress li").eq(1).addClass("done");
                $("#ulstatusprogress li").eq(2).addClass("active");
            }
            else if (statusid == 3) {
                $("#ulstatusprogress li").eq(0).addClass("done");
                $("#ulstatusprogress li").eq(1).addClass("done");
                $("#ulstatusprogress li").eq(2).addClass("done");
                $("#ulstatusprogress li").eq(3).addClass("active");
            }
            else if (statusid == 4) {
                $("#ulstatusprogress li").eq(0).addClass("done");
                $("#ulstatusprogress li").eq(1).addClass("done");
                $("#ulstatusprogress li").eq(2).addClass("done");
                $("#ulstatusprogress li").eq(3).addClass("done");
            }
            else {
                $("#ulstatusprogress li").eq(0).addClass("active");
            }
        }
    }, function (result) {
    });
}