<%@ Page Title="" Language="VB" MasterPageFile="~/Data/Site.master" AutoEventWireup="true" CodeFile="Instruction.aspx.vb" Inherits="_Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../Scripts/instructionJS.js"></script>

    <%--<style>
        table.bordered, table.bordered > tbody > tr td, table.bordered > tbody > tr th  {
            border: 1px solid #88bd26;
        }

        table.bordered {
            width: 100%;
            border-collapse: collapse;
        }
    </style>--%>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="section-title">
        <h3 class="text-center">HCAS | 360 Degree Feedback Survey</h3>
        <div class="title-line-center"></div>
    </div>
    <div class="row g-0">
        <div class="col-md-4">
            <div class="grid-welcome-bg">
                <img src="../Images/welcome.jpg" class="info-bg" />
            </div>
        </div>
        <div class="col-md-8">
            <div class="grid bg_two">
                <h3 class="heading-3">ABOUT THE SURVEY</h3>
                <p>This newly launched platform is our in-house tool to consolidate our assessment offerings and simplify the reporting process.&nbsp;&nbsp; We are excited to invite you to be the first users of this assessment tool! While the HCAS survey is currently open only to AD&rsquo;s and above, we hope to scale this across all levels internally, as well as a robust client offering. The HCAS 360 Survey is an assessment tool anchored on the competencies aligned with our the &ldquo;Deloitte Future Leaders Framework&rdquo;. The initiative spotlights transformative insights by analysing inputs by the individual as well as reporting managers, coaches, peers, direct reports, and others for a well-rounded perspective into strengths and areas for growth. Please be assured, all responses in this survey will be strictly confidential.</p>
                <h3 class="heading-3">HOW IT WORKS</h3>
                <p><strong>Survey Instructions</strong></p>
                <ul>
                    <li>Click on &ldquo;<strong>Your Name</strong>&rdquo; under the relevant category to start the survey.</li>
                    <li>You will be presented with a series of behaviors associated with your stakeholder&rsquo;s role. The survey will take ~15 minutes to complete and should be completed in one sitting.</li>
                    <li>Rate each behavior on a 5-point scale, ranging from &ldquo;5-Always" to &ldquo;1-Rarely&ldquo;. Provide comments in the designated space if applicable.</li>
                    <li>If you haven't observed the behavior, simply select the "Have Not Observed" option</li>
                </ul>
                <p><em>Note: Please read each item carefully as descriptions may change depending on your </em><em>appraisee&rsquo;s</em><em> designation.</em></p>
                <ul>
                    <li>There will also be two open-ended questions at the end of the survey.</li>
                </ul>
                <h3 class="heading-3">RATING SCALE</h3>
                <table class="table table-bordered table-sm">
                    <tbody>
                        <tr>
                            <td>
                                <strong>Always</strong>
                            </td>
                            <td>Individual consistently and continuously demonstrates the competency at a high level. They display exceptional proficiency in this competency, setting consistently high standards for themselves and others.
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <strong>Often</strong>
                            </td>
                            <td>Individual demonstrates the competency most of the time, and it is a strong aspect of their performance. They frequently exhibit proficiency in this competency, meeting or exceeding expectations.
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Sometimes</strong>
                            </td>
                            <td>Individual demonstrates the competency regularly, but there is room for improvement. They show competence, but there are areas where their performance can be enhanced.
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Occasionally</strong>
                            </td>
                            <td>Individual demonstrates the competency on occasion, but it is not consistent. There are noticeable gaps in their proficiency, and it is not a regular occurrence.
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Rarely</strong>
                            </td>
                            <td>Competency is rarely demonstrated by the individual, and there is a significant need for improvement. It is seldom seen in their performance.
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <strong>Have Not Observed</strong>
                            </td>
                            <td>In case this behaviour is not applicable to this person.
                            </td>
                        </tr>

                    </tbody>
                </table>
                <p>If you have any technical queries, please contact  <a href="mailto:demer@deloitte.com.">demer@deloitte.com.</a></p>
            </div>
        </div>
        <div class="text-center">
            <asp:Button ID="btnContiue" runat="server" Text="Start Survey" CssClass="btns btn-submit" />
        </div>

    </div>
</asp:Content>
