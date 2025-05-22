<%@ Page Title="" Language="C#" MasterPageFile="~/AdminReports/AdminSite.master" AutoEventWireup="true" CodeFile="frmNominationStatusReport.aspx.cs" Inherits="AdminReports_frmNominationStatusReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            fnGetDetails();
        });

        function fnGetDetails() {
            var CycleID = $("#MainContent_ddlCycle").val();
            var StatusID = $("#MainContent_ddlStatus").val();

            $("#loader").css("display", "block");
            $("#fade").css("display", "inline");
            PageMethods.GetDetails(CycleID, StatusID, GetDetails_pass, GetDetails_fail);
        }
        function GetDetails_pass(res) {
            $("#loader").css("display", "none");
            $("#fade").css("display", "none");

            $("#txtTypeSearch").val("");
            if (res.split("|^|")[0] == "0") {

                $("#dvContainer").html("<div id='divRptHeader'>" + res.split("|^|")[1] + "</div><div id='divRptBody' style='overflow-y: auto;'>" + res.split("|^|")[1] + "</div>");
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
    </script>
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
                <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control">
                    <asp:ListItem Value="0" Selected="True">- ALL - </asp:ListItem>
                    <asp:ListItem Value="1">Not Submitted</asp:ListItem>
                    <asp:ListItem Value="2">Pending Final Submission</asp:ListItem>
                    <asp:ListItem Value="3">Submitted</asp:ListItem>
                </asp:DropDownList>
            </td>

            <td>
                <a href="###" class="btns btn-submit w-100" onclick="fnGetDetails();" style="margin-left: 20px;">Get Report</a>
                <a href="###" class="btns btn-submit w-100" onclick="fnDownload();" style="margin-left: 10px;">Download</a>


                <asp:Button runat="server" ID="btnDownload" Text="." OnClick="btnDownload_Click" Style="visibility: hidden;" />
            </td>

            <td>
                <div style="width:250px; display: inline-block" class="search-container">
                    <input typ="text" id="txtTypeSearch" style="width: 100%" class="form-control" placeholder="Type atleast 3 charcters to Search" onkeyup="TypeSearch();" />
                </div>
            </td>
        </tr>
    </table>
    <div class="clear"></div>

    <div id="dvContainer" style="width: 96%; margin: 0 auto;"></div>


    <div id="divPopup" style="display: none;"></div>


</asp:Content>

