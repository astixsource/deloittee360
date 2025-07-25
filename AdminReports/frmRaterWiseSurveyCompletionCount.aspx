<%@ Page Title="" Language="C#" MasterPageFile="~/AdminReports/AdminSite.master" AutoEventWireup="true" CodeFile="frmRaterWiseSurveyCompletionCount.aspx.cs" Inherits="AdminReports_frmNominationStatusReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../Content/jquery-ui.css" rel="stylesheet" />
    <link href="../JDatatable/dataTables.dataTables.css" rel="stylesheet" />
    <link href="../JDatatable/fixedHeader.dataTables.css" rel="stylesheet" />

    <script src="../Scripts/jquery-ui.js"></script>
    <script src="../JDatatable/dataTables.js"></script>
    <script src="../JDatatable/dataTables.fixedHeader.js"></script>
    <script src="../JDatatable/fixedHeader.dataTables.js"></script>
    <script src="../Scripts/progressbarJS.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            fnGetDetails();
        });

        function fnGetDetails() {
            var CycleID = $("#MainContent_ddlCycle").val();
            var StatusID = $("#MainContent_ddlStatus").val();
            var LoginId = $("#MainContent_hdnLoginId").val();

            $("#dvFadeForProcessing").show();
            $("#loader").css("display", "block");
            $("#fade").css("display", "inline");
            PageMethods.GetDetails(CycleID, StatusID, GetDetails_pass, GetDetails_fail);
        }
        function GetDetails_pass(res) {
            $("#dvFadeForProcessing").hide();
            $("#loader").css("display", "none");
            $("#fade").css("display", "none");

            $("#txtTypeSearch").val("");
            if (res.split("|^|")[0] == "0") {

                $("#dvContainer").html("<div id='divRptHeader' style='display: none;'>" + res.split("|^|")[1] + "</div><div id='divRptBody' style='overflow: auto; height: 590px;'>" + res.split("|^|")[1] + "</div>");
                $("#divRptHeader").find("tbody").remove();

                $("#divRptBody").css("height", ($(window).height() - ($("#dvBanner").height() + $("#dvHeading").height() + $("#dvFilter").height() + $("#divRptHeader").height() + 60) + "px"));

                for (i = 0; i < $("#divRptHeader").find("th").length - 2; i++) {
                    var rt_wid = $("#divRptBody").find("th")[i].clientWidth;
                    $("#divRptBody").find("th").eq(i).css("width", rt_wid);
                    //$("#divRptBody").find("th").eq(i).css("min-width", rt_wid);
                    $("#divRptHeader").find("th").eq(i).css("width", rt_wid);
                    //$("#divRptHeader").find("th").eq(i).css("min-width", rt_wid);
                }

                $("#divRptBody").find("table").css("margin-top", "-" + $("#divRptHeader")[0].offsetHeight + "px");
            }
            else {
                $("#dvContainer").html("<div class='error'>Error :  " + res.split("|^|")[1] + "</div>");
            }
        }
        function GetDetails_fail(res) {
            $("#dvContainer").html("<div class='error'>Error :  " + res.Message + "</div>");
        }



        function fnDownload() {
            $("#MainContent_hdnReportDate").val($("#txtDate").val());
            $("#MainContent_btnDownload").click();

            AlertMsg("Please wait, Your downloading will start shortly .. !", 0);
        }
    </script>

    <script type="text/javascript">
        function TypeSearch() {
            var searchtxt = $("#txtTypeSearch").val().toUpperCase().trim();
            if (searchtxt.length > 2) {
                //alert($("#divRptBody").find("#tblRpt").find("tbody").find("tr").length)
                $("#divRptBody").find("#tblRpt").find("tbody").find("tr").css("display", "none");
                $("#divRptBody").find("#tblRpt").find("tbody").find("tr").each(function () {
                    if ($(this)[0].innerHTML.toUpperCase().indexOf(searchtxt) > -1) {
                        $(this).css("display", "table-row");
                    }
                });
            }
            else {
                $("#divRptBody").find("#tblRpt").find("tbody").find("tr").css("display", "table-row");
            }
        }

        function fnReOpen(ParticipantName, ApseNodeId, flgApproved, flgFeedbackStarted, ctrl) {
            //alert("Hi");
            //alert(flgApproved)

            var LoginId = $("#MainContent_hdnLoginId").val();
            var CycleID = $("#MainContent_ddlCycle").val();
            var str = "";
            if (flgApproved == 1 && flgFeedbackStarted == 1) {
                str = "<div>Nominations are approved already & atleast 1 rater has started providing feedback also. Are you sure for moving the nominations to editable stage?</div>";
            }
            else if (flgApproved == 1 && flgFeedbackStarted == 0) {
                str = "<div>Nominations are approved already. Are you sure for moving the nominations to editable stage?</div>";
            }
            if (flgApproved == 0) {
                str = "<div>Are you sure for moving the nominations to editable stage?</div>";
            }


            $("#dvDialog").html(str);
            $("#dvDialog").dialog({
                title: "Reset Nomination for : " + ParticipantName,
                modal: true,
                width: "300",
                height: "auto",
                close: function () {
                    $(this).dialog('destroy');
                    $("#dvDialog").html("");
                },
                //open: function () {
                //    $(this).next().find("button").removeClass("ui-button ui-corner-all ui-widget");
                //},
                buttons: [
                    {
                        text: "Yes",
                        class: "btns btn-submit",
                        click: function () {

                            $("#dvFadeForProcessing").show();
                            $(this).dialog('close');
                            PageMethods.fnReOpen_Result(ApseNodeId, CycleID, LoginId, function (result) {
                                fnGetDetails();
                                $("#dvFadeForProcessing").hide();
                                if (result.split("|")[0] == 2) {
                                    fnShowmsg("Error:" + result.split("|")[1]);
                                    return false;
                                }

                            }, function (result) {
                                $("#dvFadeForProcessing").hide();
                                fnShowmsg("Error:" + result._message);
                            });
                        }
                    },
                    {
                        text: "No",
                        class: "btns btn-danger",
                        click: function () {
                            $(this).dialog('close');
                        }
                    }
                ]
            })

        }


        function fnShowmsg(msg) {
            $("#dvAlert").html(msg);
            $("#dvAlert").dialog({
                title: "Alert!",
                modal: true,
                width: "auto",
                height: "auto",
                dialogClass: "alertcss",
                close: function () {
                    $(this).dialog('destroy');
                    $("#dvAlert").html("");
                },
                open: function () {
                    $(this).next().find("button").removeClass("ui-button ui-corner-all ui-widget");
                },
                buttons: [
                    {
                        text: "OK",
                        "class": "btns btn-dark",
                        click: function () {
                            $("#dvAlert").dialog('close');
                        }
                    }
                ]
            })
        }

        function fnViewNominationedRater(ParticipantName, ApseNodeId, ctrl) {
            var LoginId = $("#MainContent_hdnLoginId").val();
            var CycleID = $("#MainContent_ddlCycle").val();
            PageMethods.fnViewNominationedRaterDetail(ApseNodeId, CycleID, GetNominationedRaterDetailSuccess, fnFailed, ParticipantName);

        }
        function GetNominationedRaterDetailSuccess(result, ParticipantName) {
            //alert(result);
            //  $("#divtblReport").css("display", "none");
            $("#dvNominationedRaterDetail").css("display", "block");

            $("#dvNominationedRaterDetail").html(result);

            $("#loader").css("display", "none");
            $("#fade").css("display", "none");

            var height = 0; var width = 0;
            var body = window.document.body;
            if (window.innerHeight) {
                height = window.innerHeight;
                width = window.innerWidth;
            } else if (body.parentElement.clientHeight) {
                height = body.parentElement.clientHeight;
                width = body.parentElement.clientWidth;
            } else if (body && body.clientHeight) {
                height = body.clientHeight;
                width = body.clientWidth;
            }

            //$('#tblBasicDetailsInfoDetails').DataTable({
            //    "ordering": false,
            //    "paging": false,
            //    "pagingType": "full_numbers",
            //    "bLengthChange": false,
            //    "iDisplayLength": parseInt((height - 280) / 25),
            //    "searching": true
            //});



            $("#dvNominationedRaterDetail").dialog({
                title: "Nominationed Rater : " + ParticipantName,
                height: "650",
                width: "70%",
                modal: true,
                show: {
                    effect: "blind",
                    duration: 100
                },
                hide: {
                    duration: 100
                },
                beforeClose: function (event, ui) {
                    $("#dvNominationedRaterDetail").html('');
                    $("#loader").css("display", "none");
                    $("#fade_dark").css("display", "none");
                }
            });



        }

        function fnFailed(result) {
            alert(result.get_message());
            $("#loader").css("display", "none");
            $("#fade").css("display", "none");
        }

    </script>
        <style type="text/css">
    table#tblRpt > thead > tr > th:nth-child(1), table#tblRpt > tbody > tr > td:nth-child(1) {
        width: 2% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(2), table#tblRpt > tbody > tr > td:nth-child(2) {
        width: 5% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(3), table#tblRpt > tbody > tr > td:nth-child(3) {
        width: 7% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(4), table#tblRpt > tbody > tr > td:nth-child(4) {
        width: 5% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(5), table#tblRpt > tbody > tr > td:nth-child(5) {
        width: 5% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(6), table#tblRpt > tbody > tr > td:nth-child(6) {
        width: 5% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(7), table#tblRpt > tbody > tr > td:nth-child(7) {
        width: 5% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(8), table#tblRpt > tbody > tr > td:nth-child(8) {
        width: 5% !important;
    }

   
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <%-- <div id="loader" style="position: fixed; height: 100%; width: 100%; left: 0%; top: 0%; display: none;">
        <img src="../Images/blue-loading.gif" alt="loader" style="margin-left: 45%; margin-top: 20%;" />
    </div>--%>
       <div style="text-align: center">
       <h3 class="text-center" style="background-color: #88bd26; color: white;">Rater Wise Survey Completion Count Report </h3>
   </div>
    <table style="margin: 0 auto">
        <tr>
            <td style="font-size: 15px">Select Batch:</td>
            <td style="padding: 10px">
                <asp:DropDownList ID="ddlCycle" CssClass="form-control" Style="width: auto" runat="server">
                </asp:DropDownList>
            </td>

            <td style="font-size: 15px; display:none" >Select Status:</td>
            <td style="padding: 10px;  display:none">
                <asp:DropDownList runat="server" ID="ddlStatus" Style="width: auto" CssClass="form-control">
                    <%--        <asp:ListItem Value="0" Selected="True">- ALL - </asp:ListItem>
                    <asp:ListItem Value="1">Not Submitted</asp:ListItem>
                    <asp:ListItem Value="2">Pending Final Submission</asp:ListItem>
                    <asp:ListItem Value="3">Submitted</asp:ListItem>--%>
                </asp:DropDownList>
            </td>

            <td>
                <a href="###" class="btns btn-submit w-100" onclick="fnGetDetails();" style="margin-left: 20px;">Get Report</a>
                <a href="###" class="btns btn-submit w-100" onclick="fnDownload();" style="margin-left: 10px;">Download</a>


                <asp:Button runat="server" ID="btnDownload" Text="." OnClick="btnDownload_Click" Style="visibility: hidden;" />
            </td>

            <td>
                <div style="width: 250px; display: inline-block" class="search-container">
                    <input typ="text" id="txtTypeSearch" style="width: 100%" class="form-control" placeholder="Type atleast 3 charcters to Search" onkeyup="TypeSearch();" />
                </div>
            </td>
        </tr>
    </table>
    <div class="clear"></div>

    <div id="dvContainer" style="width: 96%; margin: 0 auto;"></div>

    <div id="dvNominationedRaterDetail" style="display: none; font-size: 8.5pt" title="Nominationed Rater">
    </div>
    <div id="divPopup" style="display: none;"></div>
    <asp:HiddenField ID="hdnLoginId" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
    <div class="loader_bg" style="display: none" id="dvFadeForProcessing">
        <div class="loader"></div>
    </div>


</asp:Content>

