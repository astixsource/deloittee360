function fnAction(HierId) {
    if (HierId == 7) {
        $("#dvDispPerson").show();
        // $("#dvInstructions, #dvStatus").hide();
        $("aside.left-panel").removeClass('collapsed');
        E360WebService.fnShowDispPerson(fnShowDispPersonSuccess, fnShowDispPersonFail);

    }
    else if (HierId == 22) {
        $("#dvInstructions, #dvDispPerson").hide();
        $("aside.left-panel").removeClass('collapsed');
        E360WebService.fnGetCompletionStation(fnShowCompletionSuccess, fnShowCompletionStatusFail);
    }
    else if (HierId == 14) {
        $("#dvInstructions, #dvDispPerson,#dvStatus").hide();
        $("aside.left-panel").removeClass('collapsed');
        $("#heading").html("Daily Access Report");
        parent.FrmDetails.location.href = "../AdminReports/frmSystemAccessReport.aspx"
    }
    else if (HierId == 15) {
        $("#dvInstructions, #dvDispPerson,#dvStatus").hide();
        $("aside.left-panel").removeClass('collapsed');
        $("#heading").html("Daily Feedback Status");
        parent.FrmDetails.location.href = "../AdminReports/frmDailyFeedbackStatusReport.aspx"
    }
    else if (HierId == 10) {
        $("#dvInstructions, #dvDispPerson,#dvStatus").hide();
        $("aside.left-panel").removeClass('collapsed');
        $("#heading").html("Status By Appraisee");
        parent.FrmDetails.location.href = "../AdminReports/frmAppraiseeStatusReport.aspx"
    }
    else if (HierId == 11) {
        $("#dvInstructions, #dvDispPerson,#dvStatus").hide();
        $("aside.left-panel").removeClass('collapsed');
        $("#heading").html("Status By Appraiser");
        parent.FrmDetails.location.href = "../AdminReports/frmAppraiserStatusReport.aspx"
    }
}

function fnShowDispPersonSuccess(result) {
    if (result.split("@")[0] == "1") {
        $("#dvDispPerson").show();
        $("#heading").html("Provide Feedback")
        $("#dvDispPersonInner")[0].innerHTML = result.split("@")[1];

    }
}
function fnShowDispPersonFail(result) {
    if (result.split("@")[0] == "2") {
        $("#dvDispPersonInner")[0].innerHTML = result.split("@")[1];

    }
}

function fnShowCompletionSuccess(result) {
    if (result.split("@")[0] == "1") {
        $("#dvStatus").show();
        $("#heading").html("My feedback completion Status.")
        var returnRslt = result.split("@")[1];
        $("#tdComplete").html(returnRslt.split("^")[0]);
        $("#tdIncomplete").html(returnRslt.split("^")[1]);
        $("#tdPending").html(returnRslt.split("^")[2]);

    }
}
function fnShowCompletionStatusFail(result) {
    if (result.split("@")[0] == "2") {
        $("#dvStatusInner")[0].innerHTML = result.split("@")[1];

    }
}


var Type;

function fnShowQuestion(sender, hdnRspId, hdnRspStatus, hdnCycApseApsrAssmntTypeMapID, hdnCycleID, hdnAssmntTypeID, hdnLevelID) {
    Type = 1;    //For Pre-Nominated Appraisals
    //var TempName = Name;
    //while (TempName.indexOf("_") != -1) {
    //    TempName = TempName.replace(new RegExp("_"), " ");
    //}
    var Name = $(sender).attr("sname");
    var strName = Name;
    strName = strName.replace(" ", "_");

    if (document.getElementById("hdnRspIdDis").value == "") {
        document.getElementById("hdnRspIdDis").value = hdnRspId
        window.location.href = "../Questionaire/Default.aspx?RspId=" + hdnRspId + "&RspStatus=" + hdnRspStatus + "&CycleApseApsrMapID=" + hdnCycApseApsrAssmntTypeMapID + "&CycleID=" + hdnCycleID + "&AssmntTypeID=" + hdnAssmntTypeID + "&LevelID=" + hdnLevelID + "&Name=" + strName + "&Type=" + Type

    }
    else {
        fnDisabled(strName)
    }
}

function fnDisabled(Name) {
    while (Name.indexOf("_") != -1) {
        Name = Name.replace(new RegExp("_"), " ");
    }

    alert("Feedback for  " + Name + "  has not been opened as yet another popup window is already opened")
    return false;

}



$(document).ready(function () {
    var navbarH = $(".navbar").outerHeight() + "px"
    $(".main-content").css({
        "min-height": $(window).height() - ($(".navbar").outerHeight() + 20),
    });
    $('aside.left-panel, section.content').hide();
    //$("body").css("overflow", "hidden");
    $("#dvDispPerson").show();
    E360WebService.fnShowDispPerson(fnShowDispPersonSuccess, fnShowDispPersonFail);


    var h = $("nav.navbar").outerHeight() + $(".r-head").outerHeight();
    //$("#FrmDetails").css({
    //    height: $(window).height() - (h + 30),
    //    width: "80%",
    //    "overflow-y": "auto",
    //    "border": "none",
    //    "margin": "0 auto"
    //});

    $("#FrmDetails, #dvInstructions, #dvDispPerson, #dvStatus").css({
        /* height: $(window).height() - (h + 35),*/
        width: "80%",
        "overflow-y": "auto",
        "border": "none",
        "margin": "0 auto"
    });

});