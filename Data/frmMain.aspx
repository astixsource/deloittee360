<%@ Page Language="VB" MasterPageFile="~/Data/Site.master" AutoEventWireup="false" CodeFile="frmMain.aspx.vb" Inherits="_frmMain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        div.sec-relationship {
            display: inline-block;
            margin: 10px 10px 10px 10px;
            width: 300px;
            vertical-align: top;
        }

        div.sec-relationship-img {
            border-radius: 100px;
            /*    border: 1px solid #444;*/
            /*    margin-left: 50px;*/
        }

        div.sec-relationship-lbl {
            font-weight: 500;
            font-size: 22px;
            text-align: center;
        }

        .full-page-container {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 40px;
            padding: 20px;
        }

        .sec-relationship {
            text-align: left;
            width: 300px;
        }

        .sec-relationship-img img {
            display: block;
            margin: 0 auto;
            width: 150px; /* Fixed size for consistency */
            height: 150px; /* Fixed size for consistency */
            border: 2px solid green;
            border-radius: 50%;
            object-fit: cover; /* Ensures the image fits well */
        }

        .sec-relationship-lbl {
            font-size: 18px;
            font-weight: bold;
            margin: 10px 0; /* Space between the circle and the label */
        }

        .name-list {
            list-style-type: none;
            padding: 0;
            margin: 0;
            text-align: center;
        }

            .name-list li {
                margin: 5px 0;
            }

                .name-list li a {
                    text-decoration: none;
                    color: #007BFF;
                    font-size: 16px;
                    transition: color 0.3s;
                }

                    .name-list li a:hover {
                        color: #0056b3;
                    }
    </style>

    <script src="../Scripts/mainJS.js"></script>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row r-head no-gutters" style="display: none">
        <button type="button" class="btn navbar-toggle col-1">
            <%--<span class="sr-only">Toggle navigation</span>--%>
            <span class="fa fa-bars"></span>
        </button>
        <h3 class="h3 col-11" id="heading">Instructions: </h3>
    </div>
    <div id="dvInstructions" style="display: none">
        <div class="container-fluid">
            <div class="section">
                <ol type="1">
                    <li>You are required to respond on the given Statements using the 4-Point scale, where ‘1’ stands for ‘Strongly Disagree’ and ‘4’ indicates ‘Strongly Agree</li>
                    <li>While responding, please recollect your experience of working with the individual during the recent few years. </li>
                    <li>All statements are mandatory</li>
                    <li>You may ‘Save’ your responses and ‘Exit’ to come back later and complete the rest of the Survey.</li>
                </ol>

                <p>The survey will remain open till <strong>Sunday, 31<sup>th</sup> Oct 2021 5 P.M.</strong> We request you to adhere to the timelines to ensure that the process is completed successfully on time.</p>
                <p>Please click on the <strong>Provide Feedback</strong> tab on the <strong>Menu</strong> to begin the feedback process</p>
                <p>We look forward to your whole-hearted participation in this developmental initiative.</p>
                <p>
                    For any query or clarification please reach out to –
                    <br />
                    <strong>Shubha Ranjan Nandi</strong> at <a href="mailto:shubho.nandi@gmail.com">shubho.nandi@gmail.com</a> +91 6289066933 OR <br /> <strong>Arundhati Bagchi</strong> at <a href="mailto:arundhatibagchi2016@gmail.com">arundhatibagchi2016@gmail.com</a> +91 9051344191
                </p>

            </div>
        </div>
    </div>

    <div id="dvDispPerson" style="display: block">
        <div class="container-fluid" id="dvDispPersonInner"></div>
    </div>

    <div id="dvStatus" style="display: none">
        <div id="dvStatusInner">
            <div class="full-page-container">
                <div class="circle-container">
                    <!-- Section 1 -->
                    <div class="sec-relationship">
                        <div class="sec-relationship-img">
                            <img src="Images/Boss.png" alt="Self" />
                        </div>
                        <h4 class="sec-relationship-lbl">Self</h4>
                        <ul class="name-list">
                            <li><a href="#">Devanshi</a></li>
                        </ul>
                    </div>
                    <!-- Section 2 -->
                    <div class="sec-relationship">
                        <div class="sec-relationship-img">
                            <img src="Images/Boss.png" alt="Peer 1" />
                        </div>
                        <h4 class="sec-relationship-lbl">Peers</h4>
                        <ul class="name-list">
                            <li><a href="#">Timcy</a></li>
                            <li><a href="#">Nikita</a></li>
                            <li><a href="#">Krutika</a></li>
                        </ul>
                    </div>
                    <!-- Section 3 -->
                    <div class="sec-relationship">
                        <div class="sec-relationship-img">
                            <img src="Images/Boss.png" alt="Direct Report 1" />
                        </div>
                        <h4 class="sec-relationship-lbl">Direct Reports</h4>
                        <ul class="name-list">
                            <li><a href="#">Twisha D</a></li>
                            <li><a href="#">Krutika P</a></li>
                            <li><a href="#">Aashna</a></li>
                        </ul>
                    </div>
                    <!-- Section 4 -->
                    <div class="sec-relationship">
                        <div class="sec-relationship-img">
                            <img src="Images/Boss.png" alt="Manager/Coach" />
                        </div>
                        <h4 class="sec-relationship-lbl">Manager/Coach</h4>
                        <ul class="name-list">
                            <li><a href="#">Sankalp</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="hdnRspIdDis" />
    <input type="hidden" id="hdnChkFlg" value="0" runat="server" />
</asp:Content>

