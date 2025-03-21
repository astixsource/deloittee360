<%@ Page Title="" Language="VB" MasterPageFile="~/Data/SiteNominate.master" AutoEventWireup="true" CodeFile="frmNominateApproveNomination.aspx.vb" Inherits="_Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../Scripts/progressbarJS.js"></script>

    <script type="text/javascript">
        function fnOPenPage(flg) {
            window.location.href = flg == 1 ? "frmNominateRater.aspx" : flg == 2 ? "frmNominateRaterApprove.aspx" : "Instruction.aspx";
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="section-title">
        <h4 class="text-center">360-Degree Feedback Dashboard</h4>
        <div class="title-line-center"></div>
    </div>

    <div class="row absolute-center mt-4">
        <div class="col-4" id="div1" runat="server">
            <h6 class="text-center">For Participants: Click on ‘Nominate’ to <br /> select raters:</h6>

            <div class="btn-img" onclick="fnOPenPage(1)">
                <img src="../Images/1-nom.svg" alt="" class="" />
            </div>
        </div>
        <div class="col-4" id="div2" runat="server">
            <h6 class="text-center" id="dvRMCoach" runat="server">For RM/Coach: Click on below icon to review your team members’ rater selections:</h6>
            <div class="btn-img" onclick="fnOPenPage(2)">
                <img src="../Images/2-nom.svg" alt="" class="" />
            </div>
        </div>
        <div class="col-4" id="div3" runat="server">
            <h6 class="text-center">For Participants and Raters: Click on ‘Start Survey’ to submit feedback:</h6>
            <div class="btn-img" onclick="fnOPenPage(3)">
                <img src="../Images/3-nom.svg" alt="" class="" />
            </div>
        </div>
    </div>
</asp:Content>
