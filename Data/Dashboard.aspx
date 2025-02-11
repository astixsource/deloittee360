<%@ Page Title="" Language="VB" MasterPageFile="~/Data/Site.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.vb" Inherits="_Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../Scripts/DashboardJS.js"></script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

            <div class="section-title">
                <h3 class="text-center">360-Degree Feedback Dashboard</h3>
                <div class="title-line-center"></div>
            </div>

            <h3 class="text-center mt-5">*I am a :</h3>

            <div class="row absolute-center  mt-4">
                <div class="col-3">
                    <div class="btn-img" id="btnParticipant"  onclick="fnNominateRater()">
                        <img src="../Images/1-dash.svg" alt="" class="" />
                    </div>
                </div>
                <div class="col-3">
                    <div class="btn-img" id="btnCoach" onclick="fnOpenWelcomePage()">
                        <img src="../Images/2-dash.svg" alt="" class="" />
                    </div>
                </div>
                <div class="col-3">
                    <div class="btn-img" id="btnAppraiser" onclick="fnOpenWelcomePage()">
                        <img src="../Images/3-dash.svg" alt="" class="" />
                    </div>
                </div>
            </div>


            <h5 class="text-center mt-5">Choose one of the above based on the email you received from [email id]</h5>
            <%--  <div class="text-center">
                    <asp:Button ID="btnContiue" runat="server" Text="Start Survey" CssClass="btns btn-submit" />
                </div>--%>
</asp:Content>
