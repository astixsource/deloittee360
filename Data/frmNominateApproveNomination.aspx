<%@ Page Title="" Language="VB" MasterPageFile="~/Data/Site.master" AutoEventWireup="true" CodeFile="frmNominateApproveNomination.aspx.vb" Inherits="_Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">

    <style type="text/css">
        *, ::before, ::after {
            box-sizing: border-box;
        }

        .btn-block {
            margin: 0 0 16px;
            padding: 0;
            position: relative;
            list-style: none;
            font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,"Noto Sans",sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";
        }

        .btn-block {
            display: inline-block;
        }


            .btn-block > img.icon-1 {
                max-width: 75px !important;
                margin-bottom: 10px;
            }

            .btn-block > .btnDashboard-2 {
                text-decoration: none;
                display: block;
                line-height: 2.4rem;
                height: 2.4rem;
                padding: 0 1.2rem 0 5rem;
                position: relative;
                border-radius: .25rem;
                color: #FFF;
                background: #86BC25;
                white-space: nowrap;
                transition: all .2s;
                margin: .65rem 0;
                border: none;
                outline: none;
            }

                .btn-block > .btnDashboard-2 > span.circle {
                    border: 10px solid #86BC25;
                    text-align: center;
                    width: 70px;
                    height: 70px;
                    position: absolute;
                    left: 0;
                    top: 0;
                    margin: -.88em 0 0 -.5rem;
                    transition: color 300ms;
                    border-radius: 50%;
                    background: #FFF;
                    box-shadow: 0 1px 1px 0 rgba(255, 255, 255, 0.9), 1px 0 1px 1px rgba(255, 255, 255, 0.9);
                }

                    .btn-block > .btnDashboard-2 > span.circle > img.icon-2 {
                        max-width: 30px !important;
                        margin-top: 5px;
                    }
    </style>

    <script>
        function fnOPenPage(flg) {
            window.location.href = flg == 1 ? "frmNominateRater.aspx" : "frmNominateRaterApprove.aspx";
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

            <div class="section-title">
                <h3 class="text-center">360-Degree Feedback Dashboard</h3>
                <div class="title-line-center"></div>
            </div>

    <div class="row no-gutters" style="margin-top:75px">
        <div class="col-4 offset-2 text-center">

            <div class="btn-block" onclick="fnOPenPage(1)">
                <img src="../Images/1.svg" alt="" class="icon-1" />
                <a href="#" class="btnDashboard-2"><span class="circle">
                    <img src="../Images/2.svg" alt="" class="icon-2" /></span> Nominate </a>
            </div>
            </div>
             <div class="col-4 text-center">
            <div class="btn-block" onclick="fnOPenPage(2)">
                <img src="../Images/3.svg" alt="" class="icon-1" />
                <a href="#" class="btnDashboard-2"><span class="circle">
                    <img src="../Images/4.svg" alt="" class="icon-2" /></span> Approve Nomination</a>
            </div>

            <%--  <div class="text-center">
                    <asp:Button ID="btnContiue" runat="server" Text="Start Survey" CssClass="btns btn-submit" />
                </div>--%>
        </div>

    </div>
</asp:Content>
