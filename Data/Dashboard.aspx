<%@ Page Title="" Language="VB" MasterPageFile="~/Data/Site.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.vb" Inherits="_Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../Scripts/DashboardJS.js"></script>

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


            .btn-block > .btnDashboard {
                text-decoration: none;
                display: block;
                line-height: 2.4rem;
                height: 2.4rem;
                padding: 0 3.5rem 0 55px;
                position: relative;
                border-radius: .25rem;
                color: #FFF;
                background: #86BC25;
                white-space: nowrap;
                transition: all .2s;
                margin: .1rem 0;
                border: none;
                outline: none;
            }

                .btn-block > .btnDashboard > span.circle {
                    border: 15px solid #86BC25;
                    text-align: center;
                    width: 50px;
                    height: 50px;
                    line-height: 50px;
                    position: absolute;
                    left: 0;
                    top: 0;
                    margin: -6px 0 0 -6px;
                    transition: color 300ms;
                    border-radius: 25px;
                    background: #FFF;
                    box-shadow: 0 1px 1px 0 rgba(255, 255, 255, 0.9), 1px 0 1px 1px rgba(255, 255, 255, 0.9);
                }

                .btn-block > .btnDashboard:hover {
                    background: #5e6271;
                    text-decoration: none;
                }

                    .btn-block > .btnDashboard:hover > span.circle {
                        border-color: #5e6271;
                        text-decoration: none;
                    }
    </style>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row no-gutters">
        <div class="col-md-12">
            
                <div class="section-title">
                    <h3 class="text-center">360-Degree Feedback Dashboard</h3>
                    <div class="title-line-center"></div>
                </div>

                <h3 class="text-center">*I am a :</h3>
                <div class="row">
                    <div class="col-4 text-center">
                        <div class="btn-block">
                            <button type="button" id="btnParticipant" class="btnDashboard"  onclick="fnNominateRater()">
                                <span class="circle"></span>
                                Participant                        
                            </button>
                        </div>
                    </div>
                    <div class="col-4 text-center">
                        <div class="btn-block">
                            <button type="button" id="btnCoach"  class="btnDashboard"  onclick="fnOpenWelcomePage()">
                                <span class="circle"></span>
                                Coach                        
                            </button>
                        </div>
                    </div>
                    <div class="col-4 text-center">
                        <div class="btn-block">
                            <button type="button" id="btnAppraiser" class="btnDashboard" onclick="fnOpenWelcomePage()">
                                <span class="circle"></span>
                                Appraiser
                            </button>

                        </div>
                    </div>
                </div>


                <h3 class="text-center">Choose one of the above based on the email you received from [email id]</h3>
                <%--  <div class="text-center">
                    <asp:Button ID="btnContiue" runat="server" Text="Start Survey" CssClass="btns btn-submit" />
                </div>--%>
            </div>
     
    </div>
</asp:Content>
