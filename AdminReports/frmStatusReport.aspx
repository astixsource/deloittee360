<%@ Page Title="" Language="C#" MasterPageFile="~/Data/Site.master" AutoEventWireup="true" CodeFile="frmStatusReport.aspx.cs" Inherits="AdminReports_frmStatusReportNew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div align="center">
        <table >
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
            </tr>
        </table>
    </div>
    <br />
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

