<%@ Page Title="" Language="C#" MasterPageFile="~/AdminReports/AdminSite.master" AutoEventWireup="true" CodeFile="frmNominationStatusReport.aspx.cs" Inherits="AdminReports_frmNominationStatusReport" %>

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

                $("#dvContainer").html("<div id='divRptHeader' style='display: none;'>" + res.split("|^|")[1] + "</div><div id='divRptBody' style='overflow-y: auto;'>" + res.split("|^|")[1] + "</div>");
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

        function fnReOpen(ApseNodeId, ctrl) {
            
            var str = "<div>Are you sure you want to Reopen this rater?</div>";
            $("#dvDialog").html(str);
                $("#dvDialog").dialog({
                title: "Confirmation :",
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
                            PageMethods.fnReOpen_Result(ApseNodeId, function (result) {
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
        width: 18% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(8), table#tblRpt > tbody > tr > td:nth-child(8) {
        width: 8% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(9), table#tblRpt > tbody > tr > td:nth-child(9) {
        width: 5% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(10), table#tblRpt > tbody > tr > td:nth-child(10) {
        width: 5% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(11), table#tblRpt > tbody > tr > td:nth-child(11) {
        width: 5% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(12), table#tblRpt > tbody > tr > td:nth-child(12) {
        width: 5% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(13), table#tblRpt > tbody > tr > td:nth-child(13) {
        width: 5% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(14), table#tblRpt > tbody > tr > td:nth-child(14) {
        width: 5% !important;
    }

    table#tblRpt > thead > tr > th:nth-child(15), table#tblRpt > tbody > tr > td:nth-child(15) {
        width: 8% !important;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <%-- <div id="loader" style="position: fixed; height: 100%; width: 100%; left: 0%; top: 0%; display: none;">
        <img src="../Images/blue-loading.gif" alt="loader" style="margin-left: 45%; margin-top: 20%;" />
    </div>--%>
    <table style="margin: 0 auto">
        <tr>
            <td style="font-size: 15px">Select Cycle:</td>
            <td style="padding: 10px">
                <asp:DropDownList ID="ddlCycle" CssClass="form-control" Style="width: auto" runat="server">
                </asp:DropDownList>
            </td>

            <td style="font-size: 15px">Select Status:</td>
            <td style="padding: 10px">
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

    <div id="dvContainer" style="width: 100%; height:570px; overflow-y:scroll;overflow-x:hidden;"></div>


    <div id="divPopup" style="display: none;"></div>
    <div id="dvDialog" style="display: none"></div>
        <div class="loader_bg" style="display: none" id="dvFadeForProcessing">
        <div class="loader"></div>
    </div>


</asp:Content>

