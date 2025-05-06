<%@ Page Title="" Language="C#" MasterPageFile="~/AdminReports/AdminSite.master" AutoEventWireup="true" CodeFile="frmSendEmail_Reminder_PendingNotificationof360Degree_FeedbackForm_Mail9.aspx.cs" EnableEventValidation="false" Inherits="frmSendEmailInvite" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        tr.clstrgdmapped > td {
            background-color: #f5f5f5;
        }
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            //fnDSEList();

        });

        function fnValidaterUserType() {
            var UserType = $("#MainContent_ddlUserType").val();
            var CycleId = $("#MainContent_ddlCycle").val().split("^")[0];
            if (CycleId == "0") {
                alert("Please select the batch")
                return false;
            }
            if (UserType == "0") {
                alert("Please select the user type")
                return false;
            }

        }
        var MappingStatus = 0;
        function fnUserList() {

            if (fnValidaterUserType() == false) {
                return false;
            }
            var CycleId = $("#MainContent_ddlCycle").val().split("^")[0];
            var MailCreationStatus = $("#MainContent_ddlCycle").val().split("^")[1];
            var LoginId = $("#MainContent_hdnLoginId").val();
            var CycleDate = $("#MainContent_ddlCycle option:selected").attr("CycleDate");

            var UserType = $("#MainContent_ddlUserType").val();
            //alert("CycleId=" + CycleId)
            //alert("MeetingCreationStatus=" + MailCreationStatus)
            $("#anchorbtn_other").hide();
            $("#anchorbtn_gd").hide();
            if (CycleId == 0) {

                $("#MainContent_divdrmmain").show();
                $("#anchorbtn_other").hide();
                $("#MainContent_divdrmmain")[0].innerHTML = "";
                return false;
            }

            //if (MailCreationStatus != 3)
            //{
            //    $("#ConatntMatter_divdrmmain").show();
            //    $("#anchorbtn_other").hide();
            //    $("#ConatntMatter_divdrmmain")[0].innerHTML = "Meeting Links has not been created as yet for this cycle";
            //    return false;
            //}

            $("#dvFadeForProcessing").show();
            PageMethods.fngetdata(CycleId, UserType, function (result) {
                $("#dvFadeForProcessing").hide();
                $("#divBTNS").hide();
                if (result.split("|")[0] == "2") {
                    alert("Error-" + result.split("|")[1]);
                } else if (result == "") {
                    $("#MainContent_divdrmmain")[0].innerHTML = "No Participant Found!!!";
                }
                else {

                    $("#MainContent_divdrmmain").show();
                    $("#anchorbtn_other").show();

                    $("#MainContent_divdrmmain")[0].innerHTML = result.split("|")[0];
                    //---- this code add by satish --- //
                    $("#MainContent_divdrmmain").prepend("<div id='tblheader'></div>");
                    if ($("#tbldbrlist").length > 0) {
                        var wid = $("#tbldbrlist").width(), thead = $("#tbldbrlist").find("thead").eq(0).html();
                        $("#tblheader").html("<table id='tblEmp_header' class='table table-bordered table-sm mb-0' style='width:" + (wid - 1) + "px;'><thead>" + thead + "</thead></table>");
                        $("#tbldbrlist").css({ "width": wid, "min-width": wid });

                        for (i = 0; i < $("#tbldbrlist").find("th").length; i++) {
                            var th_wid = $("#tbldbrlist").find("th")[i].clientWidth;
                            $("#tblEmp_header, #tbldbrlist").find("th").eq(i).css({ "min-width": th_wid, "width": th_wid });
                        }
                        $("#tbldbrlist").css("margin-top", "-" + ($("#tblEmp_header")[0].offsetHeight) + "px");

                        $('#dvtblbody').css({
                            'height': $(window).height() - 380,
                            'overflow-y': 'auto',
                            'overflow-x': 'hidden'
                        });
                        $("#divBTNS").show();
                        $(".mergerow").closest('tr').find('td').css('border-top', '2px solid black');
                    }
                    var activeIndex = parseInt($("#tablist").find("a.active").closest("li").index()) + 1;
                    //  fnShowDataAssigned(activeIndex);
                }
            },
                function (result) {
                    $("#dvFadeForProcessing").hide();
                    alert("Error-" + result._message);
                }
            )
        }

    </script>


    <script>

        //for saving 

        function check_uncheck_checkbox(isChecked) {
            if (isChecked) {
                $('input[type=checkbox]').each(function () {
                    this.checked = true;
                });
            } else {
                $('input[type=checkbox]').each(function () {
                    this.checked = false;
                });
            }
        }



        function fnSave(flg) {

            var flgvalid = true;
            var IsCnt = 0;
            var flgStatus = 1;

            var CycleId = $("#MainContent_ddlCycle").val();
            var CycleDate = $("#MainContent_ddlCycle option:selected").attr("CycleDate");

            var ArrDataSaving = []; var ArrDataMails = [];
            var hdnFlagValue = $("#MainContent_hdnMailFlag").val(1);

            // if (flg == 1) {
            //str.Append("<tr UserType= '" + UserType + "' EmailID = '" + EmailID +"'  EmpNodeID = '" + EmpNodeID +"' Fname ='" + Fname + "'  calenderstarttime='" + Calenderstarttime + "' calenderendtime='" + Calenderendtime + "' OrientationTime='"+ OrientationTime + "'>");

            var cntOneTonOne = 0; var OldParticipantCycleMappingId = 0; var startTime = ""; var timeselected = 0;
            $("#MainContent_divdrmmain").find("#tbldbrlist input[flg=1]:checked").each(function () {



                var RaterId = $(this).closest("tr").attr("RaterId");
                var RaterName = $(this).closest("tr").attr("RaterName");

                var RaterEMailId = $(this).closest("tr").attr("RaterEMailId");
                var RaterUserName = $(this).closest("tr").attr("RaterUserName");
                var RaterPassword = $(this).closest("tr").attr("RaterPassword");
                var DeadlineDate = $(this).closest("tr").attr("DeadlineDate");

                ArrDataSaving.push({ RaterId: RaterId, RaterName: RaterName, RaterEMailId: RaterEMailId, MailStatus: '', RaterUserName: RaterUserName, RaterPassword: RaterPassword, DeadlineDate: DeadlineDate });
            });


            if (ArrDataSaving.length == 0) {
                alert("Kindly Select atleast one checkbox!")
                return false;
            }

            //$.extend(ArrDataSaving, ArrDataSavingGD);
            $("#dvFadeForProcessing").show();
            PageMethods.fnSave(ArrDataSaving, fnSave_Success, fnFailed, flgStatus);
        }

        function fnSave_Success(result, flgStatus) {
            alert("Mail Sent Successfully.");
            $("#dvFadeForProcessing").hide();

            //if (result.split("|")[0] == "0") {
            //    var tbl = $.parseJSON(result.split("|")[1]);
            //    var strHTML = "";
            //    if (tbl.length > 0) {

            //        var style = "border-left: 1px solid #A0A0A0; border-bottom: 1px solid #A0A0A0;font-family:arial narrow;font-size:9pt;";
            //        strHTML += "Kindly find below Mail status for each participant.</br>";
            //        strHTML += ("<table cellpadding='2' cellspacing='0' style='font-family:arial narrow;font-size:8.5pt;border-right: 1px solid #A0A0A0; border-top: 1px solid #A0A0A0;text-align:center;width:100%'><thead>");
            //        strHTML += ("<tr bgcolor='#26a6e7'>");
            //        strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>Sr.No</th>";
            //        strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>Participant Name</th>";
            //        strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>EmailId</th>";
            //        strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>Mail Status</th>";
            //        strHTML += ("</tr></thead><tbody>");
            //        //MeetingStartTime
            //        var flgvalid = true;
            //        var Oldparticipantcyclemappingid = 0;
            //        var cnt = 1;
            //        for (var i in tbl) {
            //            var ParticipantAssessorMappingId = 0;// tbl[i]["ParticipantAssessorMappingId"];
            //            var MailStatus = tbl[i]["MailStatus"];
            //            var ParticipantName = tbl[i]["ParticipantName"];
            //            var EmailId = tbl[i]["ParticipantEMailID"];

            //            var strColor = "";

            //            strHTML += ("<tr " + strColor + ">");
            //            strHTML += "<td  style='" + style + ";text-align:center;padding:3px'>" + cnt + "</td>";
            //            strHTML += "<td  style='" + style + ";text-align:left;padding:3px'>" + ParticipantName + "</td>";
            //            strHTML += "<td  style='" + style + ";text-align:left;padding:3px'>" + EmailId + "</td>";
            //            strHTML += "<td  style='" + style + ";text-align:left;padding:3px'>" + MailStatus + "</td>";
            //            strHTML += ("</tr>");
            //            cnt++;


            //        }

            //        strHTML += ("</tbody></table>");

            //    }
            //    $("#dvAlert")[0].innerHTML = strHTML;
            //    $("#dvAlert").dialog({
            //        title: "Alert!",
            //        modal: true,
            //        width: "750",
            //        height: "450",
            //        close: function () {
            //            $(this).dialog('destroy');

            //        },
            //        buttons: {
            //            "OK": function () {
            //                $(this).dialog('close');
            //            }
            //        }
            //    })

            //    //   $("#tbldbrlist  input[type=checkbox]:checked").closest("tr").attr("flgDisplayRow", "2");
            //    $("#tbldbrlist  input[type=checkbox]:checked").prop("checked", false);
            //    var i = parseInt($("#tablist").find("a.active").closest("li").index()) + 1
            //    $("#hdnChkFlag").val(0);
            //    fnShowDataAssigned(i);
            //    $("#loader").hide();
            //    fnUserList();

            //}
            //else {
            //    $("#dvAlert")[0].innerHTML = "Oops! Something went wrong. Please try again.</br>Error:" + result.split("|")[1];
            //    $("#dvAlert").dialog({
            //        title: "Error:",
            //        modal: true,
            //        width: "auto",
            //        height: "auto",
            //        close: function () {
            //            $(this).dialog('destroy');
            //        },
            //        buttons: {
            //            "OK": function () {
            //                $(this).dialog('close');
            //            }
            //        }
            //    })
            //}
        }

        function fnFailed(result) {
            alert("Oops! Something went wrong. Please try again.");
            $("#dvFadeForProcessing").hide();
        }

    </script>



    <script type="text/javascript">
        var OldActive = 2;
        function fnShowDataAssigned(X) {
            var CycleID = $("#MainContent_ddlCycle").val();

            if (CycleID == 0) {
                alert("Please select the Cycle Name");
                $("#MainContent_ddlCycle").eq(0).focus();
                return false;
            }
            //    alert(CycleID)


            OldActive = X;
            if (X == 1)   ////// For New User mail
            {
                $("#tbldbrlist tbody tr").hide();
                $("#tbldbrlist  tbody tr[flgDisplayRow = 1]").css("display", "table-row")

                $("#MainContent_hdnMailFlag").val(1);
            }
            else if (X == 2)  ///// For updated Scheduler Mail
            {
                $("#tbldbrlist tbody tr").hide();
                $("#tbldbrlist  tbody tr[flgDisplayRow = 3]").css("display", "table-row")
                $("#MainContent_hdnMailFlag").val(2);
            }
            else {
                $("#tbldbrlist tbody tr").hide();    ////// For Resend
                $("#tbldbrlist  tbody tr[flgDisplayRow = 2]").css("display", "table-row")

                //$("#tbldbrlist  tbody tr").css("display", "table-row")
                $("#ConatntMatter_hdnMailFlag").val(1);
            }
            $("#tablist").find("a.active").removeClass("active");
            $("#tablist").find("a").eq(OldActive - 1).addClass("active");
            //PageMethods.fnDisplayParticpantAgCycle(CycleID, X, fnGetDisplaySuccessData, fnGetFailed, X);

        }
    </script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="section-title clearfix">
        <h3 class="text-center">Reminder: Pending Notification of 360-Degree Feedback Form</h3>
        <div class="title-line-center"></div>
    </div>

    <div class="row">
        <div class="col-md-5">
            <div class="form-group row">
                <label for="ac" class="col-sm-4 col-form-label">Select Batch :</label>
                <div class="col-sm-8">
                    <asp:DropDownList runat="server" ID="ddlCycle" CssClass="form-control">
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="col-md-5">
            <div class="form-group row">
                <label for="ac" class="col-sm-5 col-form-label">Select User Type :</label>
                <div class="col-sm-7">
                    <asp:DropDownList runat="server" ID="ddlUserType" CssClass="form-control">
                        <asp:ListItem Value="0">- Select - </asp:ListItem>
                        <asp:ListItem Value="1" Selected="True">Rater</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="col-md-2">
            <input type="button" id="btnShowUsers" value="Show Users" onclick="fnUserList()" class="btns small btn-submit">
        </div>
    </div>

    <div id="divdrmmain" runat="server" style="min-height: 300px; margin-top: 10px;"></div>


    <div class="text-center" id="divBTNS" style="display: none;">
        <a href="###" class="btns btn-submit" onclick="return fnSave(1)" id="anchorbtn_other" style="display: none">Send Mail</a>
    </div>


    <div id="dvDialog" style="display: none"></div>
    <div id="dvAlert" style="display: none;"></div>
    <div id="dvFadeForProcessing" class="loader_bg">
        <div class="loader"></div>
    </div>
    <asp:HiddenField runat="server" ID="hdnLoginId" Value="0" />
    <asp:HiddenField runat="server" ID="hdnMenuId" Value="0" />
    <asp:HiddenField runat="server" ID="hdnMailFlag" Value="0" />
</asp:Content>

