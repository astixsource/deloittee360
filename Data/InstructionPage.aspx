<%@ Page Title="" Language="VB" MasterPageFile="~/Data/SiteNominate.master" AutoEventWireup="true" CodeFile="InstructionPage.aspx.vb" Inherits="InstructionPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../Scripts/instructionJS.js"></script>
    <script src="../Scripts/progressbarJS.js"></script>

    <%-- <style>
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
    </style>--%>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="section-title">
        <h3 class="text-center">HCAS | 360 Degree Feedback Survey</h3>
        <div class="title-line-center"></div>
    </div>
    <div class="row g-0">
        <div class="col-md-5">
            <div class="grid-welcome-bg">
                <img src="../Images/welcome2.jpg" class="info-bg" />
            </div>
        </div>
        <div class="col-md-7">
            <div class="grid bg_two">
                <h3 class="heading-3">ABOUT THE SURVEY</h3>
                <p>
                    As part of Deloitte&rsquo;s commitment to fostering growth and development, we are excited to introduce the 360-Degree Feedback Program for FY2025. This initiative is designed to provide a well-rounded perspective on leadership capabilities and personal attributes, aligned with the Deloitte Future Leaders Framework. By gathering feedback from multiple sources&mdash;including peers, direct reports, managers, coaches, and stakeholders&mdash;this program offers valuable insights into individual strengths and areas for growth.<br />
                    <strong>Process:</strong><br />
                    Participants will nominate raters, Coaches/Managers will approve nominations, and all stakeholders will complete the survey and follow the outlined guidelines within the specified timelines.
                </p>


                <h3 class="heading-3">HOW IT WORKS</h3>
                <p>
                    <strong>FOR PARTICIPANTS:</strong><br />
                    On the next screen, you will see five categories of identified appraisers. To ensure a comprehensive evaluation, you are required to submit a minimum of three raters per category. This minimum selection helps maintain the confidentiality of your evaluators.<br />
                    <strong>Categories:</strong>
                </p>
                <ul>
                    <li><strong>Direct Reports: </strong>Team members who report to you (Min. 2)</li>
                    <li><strong>Peers: </strong>Colleagues you work with (Min. 2)</li>
                    <li><strong>Other Stakeholders: </strong>Other stakeholders that do not map across the rater categories defined (Min. 2)</li>
                    <li><strong>Reporting Manager (RM)/Coach:</strong> Your supervisory, responsible for your career (Auto-added, more raters can be added)</li>
                    <li><strong>Review Partner: </strong>Your project supervisor (Optional)</li>
                </ul>
                <p>Upon submission, your selection will be sent to your coach/RM for approval. Please ensure your selection is confirmed, or take further action as prompted.<br />
                    <strong>FOR RATER APPROVAL (FOR RM/COACHES)</strong><br />
                    On the next screen, you will be able to see a list of raters nominated by your coachee. You will have the option to approve or reject individual entries or approve the entire list without changes.<br />
                    If you reject any nominee, you must provide a reason or suggest a replacement within the same category. This will help ensure your reportee has the right set of stakeholder providing feedback.</p>
            </div>

            <div class="text-center">
                <asp:Button ID="btnContiue" runat="server" Text="Next" CssClass="btns btn-submit" OnClick="btnContiue_Click" />
            </div>
        </div>
    </div>
</asp:Content>
