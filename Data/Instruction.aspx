<%@ Page  Language="VB" MasterPageFile="~/Data/Site.master" AutoEventWireup="true" CodeFile="Instruction.aspx.vb" Inherits="_Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../Scripts/instructionJS.js"></script>
    

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row no-gutters">
        <div class="col-md-5">
            <div class="grid-welcome-bg">
                <img src="../Images/Instruction2.jpg" class="info-bg" />
            </div>
        </div>
        <div class="col-md-7">
            <div class="grid bg_two">
                <div class="section-title">
                    <h3 class="text-center">HCAS | 360 Degree Feedback Survey</h3>
                    <div class="title-line-center"></div>
                </div>

                <p>Welcome to the HCAS 360-Degree Survey</p>
                <p>The HCAS 360-Degree Survey is designed to support your professional development by providing comprehensive feedback based on our Deloitte Future Leader Framework. This 360 tool enables you to gain valuable insights into your strengths and areas for growth, as perceived by yourself and others.</p>
                <p>How It Works:</p>
                <ul>
                    <li>Click on &ldquo;<strong>Your Name</strong>&rdquo; under the evaluations section to start the survey.</li>
                    <li>You will be presented with a series of behaviors associated with your/ your stakeholder&rsquo;s role.</li>
                    <li>Rate each behavior on a 5-point scale, ranging from "Always" to "Rarely" If you haven't observed the behavior, simply select the "Have Not Observed" option.</li>
                </ul>
                <p>Your responses will remain confidential, and the results will be used to help you and your talent team focus on meaningful developmental opportunities. Thank you for your participation in this important process!</p>
                <p>The rating scale used for the 360-feedback survey is as below</p>

                <table border="1" style="border-spacing: 0; border-collapse: 0; border-color: black;">
                    <tbody>
                        <tr>
                            <th>Rating</th>
                            <th>Interpretation</th>
                            <th>Description</th>
                        </tr>

                        <tr style="height: 25px;">
                            <td style="width: 30px; height: 35px;">
                                <p><strong>5</strong></p>
                            </td>
                            <td style="width: 100px; height: 35px;">
                                <p><strong>Always</strong></p>
                            </td>
                            <td style="width: 363.6px; height: 35px;">
                                <p>Individual consistently and continuously demonstrates the competency at a high level. They display exceptional proficiency in this competency, setting consistently high standards for themselves and others.</p>
                            </td>
                        </tr>

                        <tr style="height: 25px;">
                            <td style="width: 30px; height: 35px;">
                                <p><strong>4</strong></p>
                            </td>
                            <td style="width: 100px; height: 35px;">
                                <p><strong>Often</strong></p>
                            </td>
                            <td style="width: 363.6px; height: 35px;">
                                <p>Individual demonstrates the competency most of the time, and it is a strong aspect of their performance. They frequently exhibit proficiency in this competency, meeting or exceeding expectations.</p>
                            </td>
                        </tr>
                        <tr style="height: 25px;">
                            <td style="width: 30px; height: 35px;">
                                <p><strong>3</strong></p>
                            </td>
                            <td style="width: 100px; height: 35px;">
                                <p><strong>Sometimes</strong></p>
                            </td>
                            <td style="width: 363.6px; height: 35px;">
                                <p>Individual demonstrates the competency regularly, but there is room for improvement. They show competence, but there are areas where their performance can be enhanced.</p>
                            </td>
                        </tr>
                        <tr style="height: 25px;">
                            <td style="width: 30px; height: 35px;">
                                <p><strong>2</strong></p>
                            </td>
                            <td style="width: 100px; height: 49px;">
                                <p><strong>Occasionally</strong></p>
                            </td>
                            <td style="width: 363.6px; height: 49px;">
                                <p>Individual demonstrates the competency on occasion, but it is not consistent. There are noticeable gaps in their proficiency, and it is not a regular occurrence.</p>
                            </td>
                        </tr>
                        <tr style="height: 25px;">
                            <td style="width: 30px; height: 35px;">
                                <p><strong>1</strong></p>
                            </td>
                            <td style="width: 100px; height: 35px;">
                                <p><strong>Rarely</strong></p>
                            </td>
                            <td style="width: 363.6px; height: 35px;">
                                <p>Competency is rarely demonstrated by the individual, and there is a significant need for improvement. It is seldom seen in their performance.</p>
                            </td>
                        </tr>

                            <tr style="height: 25px;">
                            <td style="width: 30px; height: 35px;">
                                <p><strong>0</strong></p>
                            </td>
                            <td style="width: 100px; height: 35px;">
                                <p><strong>Cannot rate</strong></p>
                            </td>
                            <td style="width: 363.6px; height: 35px;">
                                <p>Did not have an opportunity to observe this person in this capacity</p>
                            </td>
                        </tr>

                    </tbody>
                </table>

                 <p>If you have any technical queries, please contact  <a href="mailto:demer@deloitte.com.">demer@deloitte.com.</a></p>

                <br />

                <%-- <p>Dear Respondent,</p>
                <p>Deloitte is administering the <strong>180 Degree Feedback Survey</strong> as a part of its people capability development program. </p>
                <p>This is an established method to gather feedback for an individual (henceforth called an “Appraisee” or “Participant”) from various stakeholders who have observed or worked closely with him/her. The compiled feedback is then used for planning developmental interventions for the Appraisee.</p>
                <p>You have been selected to provide feedback for the Assessees (or Participants) listed in the next page. While responding to the question-statements in the following pages, please recollect your experience of working with the individual (Assessee) during the last few years.</p>
                <p>Your responses will be kept confidential and will be merged with other's feedback and presented in a consolidated manner to the ‘assessee’ and the management. Comments will also be kept anonymous, without any indication to respondents’ name.</p>
                <p>Your feedback is a critical part of the Assessee’s leadership development process. Please provide frank and open feedback. </p>
                <p>For any query or clarification please reach out to – <br /> <strong>Alok Kumar</strong> at <a href="mailto:alok@astix.in">alok@astix.in</a> +91 9810386946 OR </br> <strong>Abhishek Kumar</strong> at <a href="mailto:abhishek@astix.in">abhishek@astix.in</a> +919811190021</p>
                <p>Thank you </p>
                <p>Astix</p>--%>
                <%--  <ol type="1">
                    <li>You are required to respond on the given Statements using the 4-Point scale, where ‘1’ stands for ‘Strongly Disagree’ and ‘4’ indicates ‘Strongly Agree</li>
                    <li>While responding, please recollect your experience of working with the individual during the recent few years. </li>
                    <li>All statements are mandatory</li>
                    <li>You may ‘Save’ your responses and ‘Exit’ to come back later and complete the rest of the Survey.</li>
                </ol>--%>

                <%--   <p>The survey will remain open till <strong>Monday, 8<sup>th</sup> Nov 2021 5 P.M.</strong> We request you to adhere to the timelines to ensure that the process is completed successfully on time.</p>
                <p>We look forward to your whole-hearted participation in this developmental initiative.</p>
                <p>For any query or clarification please reach out to – </br> <strong>Shubha Ranjan Nandi</strong> at <a href="mailto:shubho.nandi@gmail.com">shubho.nandi@gmail.com</a> +91 6289066933 OR </br> <strong>Arundhati Bagchi</strong> at <a href="mailto:arundhatibagchi2016@gmail.com">arundhatibagchi2016@gmail.com</a> +91 9051344191</p>--%>

                <div class="text-center">
                    <%--<asp:Button ID="btnBack" runat="server" Text="Back"  CssClass="btns btn-submit" />--%>
                    <asp:Button ID="btnContiue" runat="server" Text="Start Survey" CssClass="btns btn-submit" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
