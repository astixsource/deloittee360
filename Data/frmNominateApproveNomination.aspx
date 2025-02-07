<%@ Page Title="" Language="VB" MasterPageFile="~/Data/SiteNominate.master" AutoEventWireup="true" CodeFile="frmNominateApproveNomination.aspx.vb" Inherits="_Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../Scripts/progressbarJS.js"></script>
    <style type="text/css">
        .absolute-center {
            display: flex;
            align-items: center;
            /*justify-content: center;*/
            justify-content: space-around !important;
        }

        .btn-img {
            padding: 1rem;
            border: 2px solid transparent;
            cursor: pointer;
        }

            .btn-img > img {
                width: 100%;
                display: block
            }

            .btn-img:hover {
                border-color: #000000;
            }
    </style>

    <script>
        function fnOPenPage(flg) {
            window.location.href = flg == 1 ? "frmNominateRater.aspx" : flg == 2 ? "frmNominateRaterApprove.aspx" :"Instruction.aspx";
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="section-title">
        <h3 class="text-center">360-Degree Feedback Dashboard</h3>
        <div class="title-line-center"></div>
    </div>

    <div class="row absolute-center mt-4">
        <div class="col-4" id="div1" runat="server">
             <h5 class="text-center">For participant, click on nominate to select raters:</h5>
            
            <div class="btn-img" onclick="fnOPenPage(1)">
                <img src="../Images/1-nom.svg" alt="" class="" />
            </div>
        </div>
        <div class="col-4" id="div2" runat="server">
             <h5 class="text-center">For RM/Coach, click on below to review the raters selects by your team member:</h5>
            <div class="btn-img" onclick="fnOPenPage(2)">
                <img src="../Images/2-nom.svg" alt="" class="" />
            </div>
        </div>
        <div class="col-4" id="div3" runat="server">
             <h5 class="text-center">For Survey, click on below to go to survey page:</h5>
            <div class="btn-img" onclick="fnOPenPage(3)">
                <img src="../Images/3-nom.svg" alt="" class="" />
            </div>
        </div>
        <%--  <div class="text-center">
                    <asp:Button ID="btnContiue" runat="server" Text="Start Survey" CssClass="btns btn-submit" />
                </div>--%>
    </div>
</asp:Content>
