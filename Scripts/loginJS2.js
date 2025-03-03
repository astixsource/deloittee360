$(window).on("load resize", function () {
    $("img.bg-img").hide();
    var $url = $("img.bg-img").attr("src");
    $('.full-background').css('backgroundImage', 'url(' + $url + ')');

    $(".loginfrm").css({
        'margin-top': ($(window).height() - ($(".loginfrm").outerHeight() + 56)) / 2 + "px",
        'margin-left': ($(window).width() - $('.loginfrm').outerWidth()) * 1 / 8 + "px"
    });
});
$(document).ready(function () {

    $("#dvFadeForProcessing").hide();
    
    $("#btnLogin").click(function () {
        fnSendLogin();
    })

    document.addEventListener("keydown", function (event) {
        if (event.key === "Enter") {
            event.preventDefault(); // Prevent form submission
            fnSendLogin();
        }
    });
})

function fnReset() {
    document.getElementById("txtLoginID").value = "";
    document.getElementById("txtPassword").value = "";
    document.getElementById("dvMessage").innerText = "";
}

function fnHideError() {
    document.getElementById("tblProgress").style.display = "none";
}

function fnValidate() {
    document.getElementById("hdnResolution").value = screen.availWidth + "*" + screen.availHeight;
    if (document.getElementById("txtLoginID").value == "") {
        document.getElementById("dvMessage").innerText = "Email ID can't be left blank";
        document.getElementById("txtLoginID").focus();
        return false;
    }
    //if (document.getElementById("txtPassword").value == "") {
    //    document.getElementById("dvMessage").innerText = "Password can't be left blank";
    //    document.getElementById("txtPassword").focus();
    //    return false;
    //}
}

function fnKeyPress() {
    document.getElementById("dvMessage").innerText = "";
}

function fnSendLogin() {
    if (document.getElementById("txtLoginID").value == "") {
        alert("User name can't be left blank");
        document.getElementById("txtLoginID").focus();
        return false;
    }
    //else if (document.getElementById("txtPassword").value == "") {
    //    alert("Password can't be left blank");
    //    document.getElementById("txtPassword").focus();
    //    return false;
    //}
    var UserName = document.getElementById("txtLoginID").value;
    var csrfToken = document.getElementById("hiddenCSRFToken").value;
    $("#dvFadeForProcessing").show();
    $.ajax({
        url: "Login.aspx/fnLoginFromDB",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        headers: {
            "X-CSRF-Token": csrfToken
        },
        data: '{UserName:' + JSON.stringify(UserName) + '}',
        success: function (response) {
            $("#dvFadeForProcessing").css("display", "none");
            var strRep = response.d;

            $("#dvFadeForProcessing").hide();
            if (strRep.split("|")[0] == 1) {
                window.location.href = strRep.split("|")[1];
            }
            else {
                $("#dvMessage").html(strRep.split("|")[1]);
            }
        },
        error: function (msg) {
            $("#dvFadeForProcessing").css("display", "none");
            alert(msg.responseText);
        }
    });
}