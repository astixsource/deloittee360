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
            <asp:BoundField DataField="Participant Code" HeaderStyle-ForeColor="#F4F4F4" HeaderText="Participant Code" HeaderStyle-HorizontalAlign="left"
                SortExpression="Participant Code" NullDisplayText="0">
                <HeaderStyle ForeColor="#F4F4F4" HorizontalAlign="left" Width="8%" VerticalAlign="Middle" />
                <ItemStyle HorizontalAlign="left" Width="8%" Font-Size="10" />
            </asp:BoundField>

            <asp:BoundField DataField="Participant Name" HeaderStyle-ForeColor="#F4F4F4" HeaderText="Participant Name" HeaderStyle-HorizontalAlign="left"
                SortExpression="Participant Name" NullDisplayText="0">
                <HeaderStyle ForeColor="#F4F4F4" HorizontalAlign="left" Width="13%" VerticalAlign="Middle" />
                <ItemStyle HorizontalAlign="left" Width="13%" Font-Size="10" />
            </asp:BoundField>

            <asp:BoundField DataField="Participant Email Id" HeaderStyle-ForeColor="#F4F4F4" HeaderText="Participant Email Id" HeaderStyle-HorizontalAlign="left"
                SortExpression="Participant Email Id" NullDisplayText="0">
                <HeaderStyle ForeColor="#F4F4F4" HorizontalAlign="left" Width="10%" VerticalAlign="Middle" />
                <ItemStyle HorizontalAlign="left" Width="5%" Font-Size="10" />
            </asp:BoundField>


            <asp:BoundField DataField="Participant Level" Visible="false" HeaderStyle-ForeColor="#F4F4F4" HeaderText="Participant Level" HeaderStyle-HorizontalAlign="left"
                SortExpression="Participant Level" NullDisplayText="0">
                <HeaderStyle ForeColor="#F4F4F4" Width="13%" HorizontalAlign="left" VerticalAlign="Middle" />
                <ItemStyle HorizontalAlign="left" Width="13%" Font-Size="10" />
            </asp:BoundField>


            <asp:BoundField DataField="Rater Code" HeaderStyle-ForeColor="#F4F4F4" HeaderText="Rater Code" HeaderStyle-HorizontalAlign="left"
                SortExpression="Rater Code" NullDisplayText="0">
                <HeaderStyle ForeColor="#F4F4F4" Width="17%" HorizontalAlign="left" VerticalAlign="Middle" />
                <ItemStyle HorizontalAlign="left" Width="15%" Font-Size="10" />
            </asp:BoundField>

              <asp:BoundField DataField="Rater Name" HeaderStyle-ForeColor="#F4F4F4" HeaderText="Rater Name" HeaderStyle-HorizontalAlign="left"
                SortExpression="Rater Name" NullDisplayText="0">
                <HeaderStyle ForeColor="#F4F4F4" Width="17%" HorizontalAlign="left" VerticalAlign="Middle" />
                <ItemStyle HorizontalAlign="left" Width="15%" Font-Size="10" />
            </asp:BoundField>

              <asp:BoundField DataField="Rater Email Id" HeaderStyle-ForeColor="#F4F4F4" HeaderText="Rater Email Id" HeaderStyle-HorizontalAlign="left"
                SortExpression="Rater Email Id" NullDisplayText="0">
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
