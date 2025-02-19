<%@ Page Title="" Language="VB" MasterPageFile="~/Data/Site.master" AutoEventWireup="true" CodeFile="Instruction.aspx.vb" Inherits="_Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../Scripts/instructionJS.js"></script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="section-title">
        <h4 class="text-center">360 Degree Feedback Survey FY25</h4>
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
                <h3 class="heading-3">About the Survey</h3>
                <p>As part of Deloitte&rsquo;s commitment to fostering growth and development, we are excited to introduce the 360-Degree Feedback Program for FY25. This initiative is designed to provide a well-rounded perspective on leadership capabilities and personal attributes, aligned with the Deloitte Future Leaders Framework. By gathering feedback from multiple sources&mdash;including peers, direct reports, managers, coaches, and stakeholders&mdash;this program offers valuable insights into individual strengths and areas for growth.</p>
                <h3 class="heading-3">How it works</h3>
                <p>You will see a list of stakeholders who have nominated you as a rater across different categories, including your <strong>self-rating</strong>.</p>
                <div style="font-size: 10pt">
                    <ul>
                        <li>Click on the <strong>hyperlink</strong> for the relevant category to begin the survey for that stakeholder.</li>
                        <li>You will be presented with a series of behaviours specific to your stakeholder&rsquo;s role.</li>
                        <li>Rate each behaviour on a <strong>5-point scale</strong> from <strong>&ldquo;5 - Always&rdquo;</strong> to <strong>&ldquo;1 - Rarely&rdquo;</strong>.</li>
                        <li>If you have not observed a particular behaviour, select <strong>"Have Not Observed"</strong>.</li>
                        <li>Provide comments in the designated space if applicable.</li>
                    </ul>
                    <p>The survey takes approximately <strong>10 minutes</strong> and should be completed in  <strong>one sitting</strong>.</p>
                    <p><strong>Note:</strong> Read each question carefully, as descriptions may vary based on the stakeholder&rsquo;s designation. The survey will conclude with <strong>two open-ended questions </strong>where you can add your comments.</p>
                </div>

                <h3 class="heading-3">Rating Scale</h3>
                <table class="table table-bordered table-sm" style="font-size: 10pt">
                    <tbody>
                        <tr>
                            <td>
                                <strong>Always</strong>
                            </td>
                            <td>Individual consistently and continuously demonstrates the competency at a high level. They display exceptional proficiency in this competency, setting consistently high standards for themselves and others.</td>
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
                                <strong>No Rating</strong>
                            </td>
                            <td>In case this behaviour is not observed by you in the person.
                            </td>
                        </tr>

                    </tbody>
                </table>
                
                <div class="text-center">
                    <asp:Button ID="btnContiue" runat="server" Text="Start Survey" CssClass="btns btn-submit" />
                </div>
            </div>
        </div>

    </div>
</asp:Content>
