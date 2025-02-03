<%@ Page Title="" Language="VB" MasterPageFile="~/Data/Site.master" AutoEventWireup="true" CodeFile="InstructionPage.aspx.vb" Inherits="InstructionPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../Scripts/instructionJS.js"></script>

    <style>
        table.bordered, table.bordered > tbody > tr td, table.bordered > tbody > tr th {
            border: 1px solid #88bd26;
        }

        table.bordered {
            width: 100%;
            border-collapse: collapse;
        }

        .heading3 {
            background-color: #88bd26;
            color: white;
            text-align: center;
            font-size: 1.2rem;
            padding: 6px;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row no-gutters">
        <div class="section-title">
            <h3 class="text-center">HCAS | 360 Degree Feedback Survey</h3>
            <div class="title-line-center"></div>
        </div>
        <div class="col-md-5">
            <div class="grid-welcome-bg">
                <img src="../Images/welcome.jpg" class="info-bg" />
            </div>
        </div>
        <div class="col-md-7">
            <div class="grid bg_two">
                <h3 class="heading3">ABOUT THE SURVEY</h3>
                <p>
                    <p>The HCAS 360 Survey is an assessment tool anchored on the competencies aligned with our the &ldquo;Deloitte Future Leaders Framework&rdquo;, which captures the leadership capabilities and personal attributes that are the building blocks of successful leaders, contextualized for Deloitte through our shared values and purpose. This assessment initiative spotlights transformative insights by analysing inputs by the individual as well as reporting managers, coaches, peers, direct reports, and others for a well-rounded perspective into strengths and areas for growth.</p>
                </p>
                <h3 class="heading3">HOW IT WORKS</h3>
                <p><strong>1A. Rater Selection (FOR PARTICIPANTS ONLY)</strong></p>
                <p>On the next screen, you will see 6 categories of identified appraisers. You are required to submit a minimum of<strong> 3 raters per category </strong>to complete your appraisal. Minimum selection is required to ensure confidentiality of your evaluators.</p>
                <p>Upon submission, your selection will go to your manager/coach for approval.</p>
                <p>Please ensure your selection is confirmed, or take further action as prompted</p>
                <p><strong>1B. Rater Approval (FOR COACHES ONLY)</strong></p>
                <p>On the next page, you will receive a list of appraisers nominated by your coachee, with the option to approve or reject each individual entry, or approve the entire list with no changes.</p>
                <p>In case you reject any nominee, you will be required to provide a <strong>reason for rejection </strong>and a <strong>replacement within the same category.</strong></p>
                <p><strong><em>Categories</em></strong><em>: </em><em>Peers, Direct </em><em>reportees</em><em>, Managers/Coaches, Review partners, others</em></p>
                <ol start="2">
                    <li><strong>Next Steps</strong></li>
                </ol>
                <ul>
                    <li>Keep an eye out for a confirmation on your selected appraisers, and take any action indicated.</li>
                </ul>

            </div>
           
            <div class="text-center">
    
                <asp:Button ID="btnContiue" runat="server" Text="Next" CssClass="btns btn-submit" OnClick="btnContiue_Click" />
            </div>
        </div>

    </div>
</asp:Content>
