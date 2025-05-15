<%@ Page Title="" Language="C#" MasterPageFile="~/AdminReports/AdminSite.master" AutoEventWireup="true" CodeFile="frmStatusReport.aspx.cs" Inherits="AdminReports_frmStatusReportNew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script type="text/javascript">
        function TypeSearch() {
            var searchtxt = $("#txtTypeSearch").val().toUpperCase().trim();
            if (searchtxt.length > 2) {
                $("#MainContent_grdWSMapping").find("tbody").eq(0).find("tr").css("display", "none");
                $("#MainContent_grdWSMapping").find("tbody").eq(0).find("tr").each(function () {
                    if ($(this)[0].innerHTML.toUpperCase().indexOf(searchtxt) > -1) {
                        $(this).css("display", "table-row");
                    }
                });
                $("#MainContent_grdWSMapping").find("tbody").eq(0).find("tr").eq(0).css("display", "table-row");
            }
            else {
                $("#MainContent_grdWSMapping").find("tbody").eq(0).find("tr").css("display", "table-row");
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table style="margin: 0 auto">
        <tr>
            <td style="font-size: 22px">Select Cycle:</td>
            <td style="padding: 10px">
                <asp:DropDownList ID="ddlCycle" CssClass="form-control" Style="width: 195px" runat="server">
                </asp:DropDownList></td>
            <td style="padding: 10px">
                <asp:Button ID="btnShow" runat="server" Text="Show Report" CssClass="btns btn-submit w-100"
                    OnClick="btnShow_Click" /></td>
            <td style="padding: 10px">
                <asp:Button ID="btnExportReport" runat="server" Text="Export To Excel" CssClass="btns btn-submit w-100"
                    OnClick="btnExportReport_Click" /></td>
            <td>
                <div style="width: 284%; display: inline-block" class="search-container">
                    <input typ="text" id="txtTypeSearch" style="width: 100%" class="form-control" placeholder="Type atleast 3 charcters to Search" onkeyup="TypeSearch();" />
                </div>
            </td>
        </tr>
    </table>


    <asp:GridView ID="grdWSMapping" runat="server" BorderWidth="1" align="center" class="table table-bordered table-sm mt-3" Width="80%" EmptyDataText="There is no record found" BorderStyle="Solid"
        ForeColor="#333333" AutoGenerateColumns="False" HeaderStyle-VerticalAlign="Middle">
        <HeaderStyle VerticalAlign="Middle" />
        <FooterStyle BackColor="#507CD1" Font-Bold="false" ForeColor="White" />
        <Columns>
            <asp:BoundField DataField="ApseEmpCode" HeaderStyle-ForeColor="#F4F4F4" HeaderText="ApseEmpCode" HeaderStyle-HorizontalAlign="left"
                SortExpression="ApseEmpCode" NullDisplayText="0">
                <HeaderStyle ForeColor="#F4F4F4" HorizontalAlign="left" Width="8%" VerticalAlign="Middle" />
                <ItemStyle HorizontalAlign="left" Width="8%" Font-Size="10" />
            </asp:BoundField>

            <asp:BoundField DataField="ApseName" HeaderStyle-ForeColor="#F4F4F4" HeaderText="ApseName" HeaderStyle-HorizontalAlign="left"
                SortExpression="ApseName" NullDisplayText="0">
                <HeaderStyle ForeColor="#F4F4F4" HorizontalAlign="left" Width="13%" VerticalAlign="Middle" />
                <ItemStyle HorizontalAlign="left" Width="13%" Font-Size="10" />
            </asp:BoundField>

            <asp:BoundField DataField="ApsemailID" HeaderStyle-ForeColor="#F4F4F4" HeaderText="Apse EmailID" HeaderStyle-HorizontalAlign="left"
                SortExpression="ApsemailID" NullDisplayText="0">
                <HeaderStyle ForeColor="#F4F4F4" HorizontalAlign="left" Width="10%" VerticalAlign="Middle" />
                <ItemStyle HorizontalAlign="left" Width="5%" Font-Size="10" />
            </asp:BoundField>


            <asp:BoundField DataField="ApsrName" Visible="false" HeaderStyle-ForeColor="#F4F4F4" HeaderText="ApsrName" HeaderStyle-HorizontalAlign="left"
                SortExpression="ApsrName" NullDisplayText="0">
                <HeaderStyle ForeColor="#F4F4F4" Width="13%" HorizontalAlign="left" VerticalAlign="Middle" />
                <ItemStyle HorizontalAlign="left" Width="13%" Font-Size="10" />
            </asp:BoundField>


            <asp:BoundField DataField="ApsrEmailID" HeaderStyle-ForeColor="#F4F4F4" HeaderText="ApsrEmailID" HeaderStyle-HorizontalAlign="left"
                SortExpression="ApsrEmailID" NullDisplayText="0">
                <HeaderStyle ForeColor="#F4F4F4" Width="17%" HorizontalAlign="left" VerticalAlign="Middle" />
                <ItemStyle HorizontalAlign="left" Width="15%" Font-Size="10" />
            </asp:BoundField>

            <asp:BoundField DataField="Relationship" HeaderStyle-ForeColor="#F4F4F4" HeaderStyle-HorizontalAlign="left"
                HeaderText="Relationship" SortExpression="Relationship" NullDisplayText="0">
                <HeaderStyle ForeColor="#F4F4F4" Width="13%" HorizontalAlign="left" VerticalAlign="Middle" />
                <ItemStyle HorizontalAlign="left" Width="13%" Font-Size="10" />
            </asp:BoundField>

            <asp:BoundField DataField="Status" HeaderStyle-ForeColor="#F4F4F4" HeaderText="Status" HeaderStyle-HorizontalAlign="left"
                SortExpression="Status" NullDisplayText="0">
                <HeaderStyle ForeColor="#F4F4F4" Width="10%" HorizontalAlign="left" VerticalAlign="Middle" />
                <ItemStyle HorizontalAlign="left" Width="10%" Font-Size="10" />
            </asp:BoundField>

        </Columns>
        <PagerStyle BackColor="#ef4522" ForeColor="White" HorizontalAlign="Left" />

        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle Height="25" Font-Size="10" BackColor="#88bd26" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#ef4522" />
    </asp:GridView>
</asp:Content>

