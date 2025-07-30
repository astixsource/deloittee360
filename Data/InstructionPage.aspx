<%@ Page Title="" Language="VB" MasterPageFile="~/Data/SiteNominate.master" AutoEventWireup="true" CodeFile="InstructionPage.aspx.vb" Inherits="InstructionPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../Scripts/instructionJS.js"></script>
    <script src="../Scripts/progressbarJS.js"></script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="section-title">
        <h3 class="text-center">Welcome to the 360-Degree Feedback Program FY25</h3>
        <div class="title-line-center"></div>
    </div>
    <div class="row g-0">
        <div class="col-md-5">
            <div class="grid-welcome-bg">
                <img src="../Images/welcome2.jpg" class="info-bg" />
            </div>
        </div>
        <div class="col-md-7">
            <div class="grid bg_two" id="divContent_1" runat="server" attr="SMD">
                <h3 class="heading-3">About the Survey</h3>
                <p>As part of Deloitte&rsquo;s commitment to fostering growth and development, the <strong>360-Degree Feedback Program for FY25</strong> provides valuable insights into your leadership capabilities and personal attributes. Aligned with the <strong>Deloitte Future Leaders Framework</strong>, this initiative gathers feedback from multiple sources, including <strong>peers, direct reports, managers, coaches, and stakeholders</strong>, to offer a well-rounded perspective on your strengths and areas for growth.</p>

                <h3 class="heading-3 mt-3">How it works</h3>
                <p><strong>For participants :</strong></p>
                <ul>
                    <li>You will <strong>nominate raters</strong> across five categories:
                        <ul>
                            <li><strong>Direct reports</strong> (minimum-2) &ndash; would include your juniors with whom you have worked directly in last 12-18 months.</li>
                            <li><strong>Peers</strong> (minimum-2) &ndash; Would include the professional at the same career level as yours. These can be people from your work group or other service lines.</li>
                            <li><strong>Review partner</strong> &ndash; can be your reporting partner, or engagement partner. You will have an option to add multiple partners in this category.</li>
                            <li><strong>Reporting manager (RM)/Coach</strong> &ndash; Auto-added, with an option to add more raters</li>
                            <li><strong>Other stakeholders</strong> (minimum-2) &ndash; would include the professionals who cannot be categorised under any other relationship categories available. E.g.- People part of teams beyond your core work area, like M,B&amp;C, Talent, RBP(Risk and Brand Protection), Admin, IT, etc.</li>
                        </ul>
                    </li>
                    <li>A <strong>minimum of two raters per category</strong> ensures confidentiality.</li>
                    <li>Once submitted, your <strong>Coach/RM will review and approve</strong> your nominations.</li>
                </ul>

                <p><strong>For RM/Coaches (Rater Approval)</strong></p>
                <ul>
                    <li>You will review the raters nominated by your Team member.</li>
                    <li>You can <strong>approve, reject, or edit/add </strong>new nominees within the category available.</li>
                    <li>If rejecting, please provide a reason to ensure nominations are raised again correctly considering the reason provided.</li>
                </ul>
                <p>Stay engaged and complete the process within the <strong>specified timelines</strong> to make the most out of this self-developmental journey.</p>
            </div>

            <div class="grid bg_two" id="divContent_2" attr="PED" runat="server">
                <h3 class="heading-3">About the Survey</h3>
                <p>As part of Deloitte&rsquo;s commitment to fostering growth and development, the <strong>360-Degree Feedback Program for FY25</strong> provides valuable insights into your leadership capabilities and personal attributes. Aligned with the <strong>Deloitte Future Leaders Framework</strong>, this initiative gathers feedback from multiple sources, including <strong>peers, direct reports, managers, coaches, and stakeholders</strong>, to offer a well-rounded perspective on your strengths and areas for growth.</p>

                <h3 class="heading-3 mt-3">How it works</h3>
                <p><strong>For participants</strong></p>
                <ul>
                    <li>You will <strong>nominate raters</strong> across five categories:
                    <ul>
                        <li><strong>Direct reports</strong> (minimum-2) &ndash; would include your juniors with whom you have worked directly in last 12-18 months.</li>
                        <li><strong>Peers</strong> (minimum-2) &ndash; Would include the professional at the same career level as yours. These can be people from your work group or other service lines.</li>
                        <li><strong>Career Development Advisor (CDA)</strong> &ndash; Auto-added</li>
                        <li><strong>Review partner</strong> &ndash; can be your reporting partner, or engagement partner. You will have an option to add multiple partners in this category.&nbsp;</li>
                        <li><strong>Other stakeholders</strong> (minimum-2) &ndash; would include the professionals who cannot be categorised under any other relationship categories available. E.g.- People part of teams beyond your core work area, like M, B&C, Talent, RBP(Risk and Brand Protection), Admin, IT, etc.  </li>
                    </ul></li>
                    <li>A <strong>minimum of two raters per category</strong> ensures confidentiality.</li>
                    <li>Once submitted, your <strong>CDA will review and approve</strong> your nominations.</li>
                </ul>
                <p><strong>For CDA (Nomination Approval)</strong></p>
                <ul>
                    <li>You will review the raters nominated by your Team Member.</li>
                    <li>You can <strong>approve, reject, or edit/add </strong>new nominees within the category available.</li>
                    <li>If rejecting, please provide a reason to ensure nominations are raised again correctly considering the reason provided.</li>
                </ul>
                <p>Stay engaged and complete the process within the <strong>specified timelines</strong> to make the most out of this self-developmental journey.</p>
            </div>

            <div class="text-center">
                <asp:Button ID="btnContiue" runat="server" Text="Next" CssClass="btns btn-submit" OnClick="btnContiue_Click" />
            </div>
        </div>
    </div>
</asp:Content>
