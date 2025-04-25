<%@ Page Title="" Language="C#" MasterPageFile="~/AdminReports/AdminSite.master" AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs" Inherits="AdminReports_AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#home').hide();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="section-title">
        <h3 class="text-center">Admin Dashboard</h3>
        <div class="title-line-center"></div>
    </div>
    <div id="dvLinks" runat="server"></div>
</asp:Content>

