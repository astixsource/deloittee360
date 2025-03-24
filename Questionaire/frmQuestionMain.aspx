<%@ Page Language="VB" MasterPageFile="~/Data/Site.master" AutoEventWireup="false" CodeFile="frmQuestionMain.aspx.vb" Inherits="Questionaire_frmQuestionMain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../Content/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="../Scripts/Question.js"></script>

    <style type="text/css">
        /*html, body {
            max-width: 100%;
            overflow-x: hidden;
        }

        .table td, .table th {
            border-top: none !important;
        }

        .container {
            margin: 20px auto;
            padding: 10px;
              max-width: 900px;
        }

        .instructions {
            background-color: #88bd26;
            padding: 10px;
            border-left: 5px solid #4caf50;
            margin-bottom: 20px;
        }*/

        table.no-border {
            width: 100%;
            border-collapse: collapse;
        }

            table.no-border,
            table.no-border td,
            table.no-border th {
                border: none;
            }


        input[type="radio"].styled-radio {
            position: relative;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            cursor: pointer;
            -webkit-appearance: none; /* Remove default radio button appearance */
            -moz-appearance: none;
            appearance: none;
            margin: 0;
        }

            /* Create the styled appearance for radio button (using pseudo-element) */
            input[type="radio"].styled-radio::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                border-radius: 50%;
                background-color: #d1d1cf; /* Default gray color for unchecked state */
                border: 2px solid #ccc;
                transition: background-color 0.3s ease, border-color 0.3s ease;
            }

            /* Alternate color for unchecked radio buttons */
            input[type="radio"].styled-radio:nth-of-type(odd)::before {
                background-color: #d1d1cf; /* Light gray */
            }

            input[type="radio"].styled-radio:nth-of-type(even)::before {
                background-color: #e5e57d; /* Yellowish */
            }

            /* Styling for checked radio button */
            input[type="radio"].styled-radio:checked::before {
                background-color: #e5e57d; /* Yellow for checked state */
                border-color: #b3b300; /* Darker yellow for checked border */
            }

            /* Optional: Hover effect for better interaction */
            input[type="radio"].styled-radio:hover::before {
                background-color: #cccc00; /* Light yellow when hovered */
            }




        .instructions h2 {
            margin: 0 0 10px;
        }

        .statements-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

            .statements-table thead th {
                background-color: #4caf50;
                color: white;
                text-align: left;
                padding: 10px;
            }

            .statements-table tbody tr {
                border-bottom: 1px solid #ddd;
            }

        .competency-header {
            background-color: #c8e6c9;
            text-align: left;
            font-weight: bold;
            padding: 10px;
        }

        .subcompetency-header {
            background-color: #f1f8e9;
            text-align: left;
            font-weight: bold;
            padding: 10px;
        }

        .ques-row td {
            padding: 10px;
        }

        .rating-scale label {
            margin-right: 10px;
            display: inline-block;
        }

        /*.text-center {
            text-align: center;
            margin-top: 20px;
        }

        .button-group {
            display: flex;
            justify-content: space-evenly;
            align-items: center;
            gap: 15px;
            margin-left: 15px;
        }

        .btn {
            padding: 12px 30px; 
            font-size: 16px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            text-align: center;
        }

            .btn:hover {
                transform: translateY(-2px);
            }

            .btn:active {
                transform: translateY(0);
            }

        .btn-previous {
            background-color: #6c757d;
            color: white;
        }

            .btn-previous:hover {
                background-color: #5a6268;
            }

            .btn-previous:active {
                background-color: #495057;
            }

        .btn-next {
            background-color: #88bd26 !important;
            color: white;
        }

            .btn-next:hover {
                background-color: #5e6271 !important;
                color: white;
            }

            .btn-next:active {
                background-color: #1e7e34;
            }

        .btn-submit {
            background-color: #88bd26 !important;
            color: white;
        }

            .btn-submit:hover {
                background-color: #5e6271 !important;
                color: white;
            }

            .btn-submit:active {
                background-color: #1e7e34;
            }

        .btn-danger {
            background-color: black !important;
            color: white;
            padding: 12px 25px;
        }

            .btn-danger:hover {
                background-color: black !important;
            }

            .btn-danger:active {
                background-color: #bd2130;
            }*/
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <!--Ques Heading-->
    <div class="section-title">
        <h3 class="text-center">WELCOME TO 360 Feedback Survey FY25</h3>
        <div class="title-line-center"></div>
        <span class="text-center" id="h6">Please respond to each statement on the scale provided alongside from "Always" to "Rarely". You may ‘Save’ your responses to leave and come back later to complete the rest of the Survey.</span>
    </div>

    <!--Ques top header-->
    <div id="tblTopHeader" class="ques-header row">
        <!-- Proper Table Header -->
        <div class="col-md-12" id="h7">
            <table class="table table-bordered table-sm" style="width: 100%; border-collapse: collapse;">
                <tbody>
                    <tr>
                        <td>
                            <strong>Scale</strong>
                        </td>
                        <td><strong>Definition</strong></td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Always</strong>
                        </td>
                        <td>Consistently and continuously demonstrates the competency at a high level. They display exceptional proficiency in this competency, setting consistently high standards.</td>
                    </tr>

                    <tr>
                        <td>
                            <strong>Often</strong>
                        </td>
                        <td>Demonstrates the competency most of the time, and it is a strong aspect of their performance. They frequently exhibit proficiency in this competency, exceeding expectations.</td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Sometimes</strong>
                        </td>
                        <td>Demonstrates the competency regularly, but there is room for improvement. They show competence, but there are areas where their performance can be enhanced.
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Occasionally</strong>
                        </td>
                        <td>Demonstrates the competency on occasion, but it is not consistent. There are noticeable gaps in their proficiency, and it is not a regular occurrence.
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Rarely</strong>
                        </td>
                        <td>Competency is rarely demonstrated, and there is a significant need for improvement. It is seldom seen in their performance.
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>No Rating</strong>
                        </td>
                        <td>In case this behaviour is not applicable to this professional.</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Original Table Content -->
        <div class="col-md-6 ques-header-left">
            <table class="Questable" style="width: 100%; border-collapse: collapse;">
                <tr>

                    <th style="color: white;" id="dvName">
                        <br>
                    </th>
                    <th width="20%" id="dvRespColor">&nbsp;</th>
                    <th>&nbsp;</th>
                </tr>
            </table>
        </div>

        <div class="col-md-6" id="dvQuestions">
            <table class="Questable" style="width: 100%; border-collapse: collapse;">
                <thead>
                    <tr>
                        <!-- Rating Scale Values -->
                        <th style="width: 14.28%; text-align: center; padding: 5px;"><span id="Label0">Always</span></th>
                        <th style="width: 14.28%; text-align: center; padding: 5px;"><span id="Label1">Often</span></th>
                        <th style="width: 14.28%; text-align: center; padding: 5px;"><span id="Label2">Sometimes</span></th>
                        <th style="width: 14.28%; text-align: center; padding: 5px;"><span id="Label3">Occasionally</span></th>
                        <th style="width: 14.28%; text-align: center; padding: 5px;"><span id="Label4">Rarely</span></th>
                        <th style="width: 14.28%; text-align: center; padding: 5px;"><span id="Label5">No Rating</span></th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>

    <!--Ques top header end-->

    <!--Ques Section end-->
    <div id="dvSurvey" class="w-100"></div>

    <!--divComments Section end-->
    <div class="ques-row w-100" id="divComments" style="display: none; overflow-x: hidden; overflow-y: hidden;">

        <div class="row mb-2">
            <div class="col-md-6 align-left-middile" id="tdCmmnt1" runat="server"><strong>Overall strengths consistently demonstrated by the individual.</strong></div>
            <div class="col-md-6">
                <asp:TextBox onkeypress="fnCheckLength(this);" ID="Textbox1" Style="background-color: #fff !important; border: 1px solid #000; border-radius: 0px;" placeholder="Optional" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
            </div>
        </div>

        <div class="row mb-2">
            <div class="col-md-6 align-left-middile" id="tdCmmnt2" runat="server"><strong>Areas of development observed in the individual.</strong></div>
            <div class="col-md-6">
                <asp:TextBox onkeypress="fnCheckLength(this);" ID="Textbox2" Style="background-color: #fff !important; border: 1px solid #000; border-radius: 0px;" placeholder="Optional" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
            </div>
        </div>
    </div>

    <div style="text-align: right" id="tdPageNum1">
    </div>

    <div class="button-group mt-3 mb-3">
        <input type="button" class="btns btn-danger" id="btnSaveExit" onclick="fnSaveExit()" value="Exit">
        <input type="button" class="btns btn-previous" id="btnPrevious" onclick="fnPrevious()" value="Previous" style="display: none;">
        <input type="button" class="btns btn-next" id="btnNext" onclick="fnNext()" value="Save &amp; Continue">
        <input type="button" class="btns btn-submit" id="btnSubmit" onclick="FinalSubmit()" value="Submit" style="display: none;">
    </div>


    <div id="dvinstruction" style="display: none;">
        <div class="section-title">
            <h3 class="text-center">WELCOME TO WMC 360 FEEDBACK SURVEY!</h3>
            <div class="title-line-center"></div>
        </div>
        <ol type="1">
            <li>You are required to respond on the given Statements using the 4-Point scale, where ‘1’ stands for ‘Strongly Disagree’ and ‘4’ indicates ‘Strongly Agree</li>
            <li>While responding, please recollect your experience of working with the individual during the recent few years. </li>
            <li>All statements are mandatory</li>
            <li>You may ‘Save’ your responses and ‘Exit’ to come back later and complete the rest of the Survey.</li>
        </ol>

        <p>The survey will remain open till <strong>Monday, 8<sup>th</sup> Nov 2021 5 P.M.</strong> We request you to adhere to the timelines to ensure that the process is completed successfully on time.</p>
        <p>Please click on the <strong>Provide Feedback</strong> tab on the <strong>Menu</strong> to begin the feedback process</p>
        <p>We look forward to your whole-hearted participation in this developmental initiative.</p>
        <p>For any query or clarification please reach out to – </br> <strong>Shubha Ranjan Nandi</strong> at <a href="mailto:shubho.nandi@gmail.com">shubho.nandi@gmail.com</a> +91 6289066933 OR </br> <strong>Arundhati Bagchi</strong> at <a href="mailto:arundhatibagchi2016@gmail.com">arundhatibagchi2016@gmail.com</a> +91 9051344191</p>
    </div>

    <input type="hidden" id="hdnRspID" runat="server" />
    <input type="hidden" id="hdnPGNmbr" runat="server" />
    <input type="hidden" id="hdnMaxPGNmbr" runat="server" />
    <input type="hidden" id="hdnName" runat="server" />
    <input type="hidden" id="hdnLevelID" runat="server" />
    <input type="hidden" id="hdnCmptncyCmntCntr" runat="server" name="hdnCmptncyCmntCntr">
    <input type="hidden" id="hdnCmptncyCmnt" runat="server" name="hdnCmptncyCmnt">
    <input type="hidden" id="hdnCmptncyCmntValue" runat="server" name="hdnCmptncyCmntValue">
    <input type="hidden" id="hdnCmptncyID" runat="server" name="hdnCmptncyID">
</asp:Content>
