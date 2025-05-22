using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminReports_AdminDashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Session["LoginId"] == null)
        //{
        //    Response.Redirect("../../Login.aspx");
        //}
        //else
        //{
        //    dvLinks.InnerHtml = CreateLinks();
        //}
        dvLinks.InnerHtml = CreateLinks();
        //Panel panelLogout;
        //panelLogout = (Panel)Page.Master.FindControl("panelLogout");
        //panelLogout.Visible = false;
    }
    private string CreateLinks()
    {
        StringBuilder sb = new StringBuilder();
        //dvLinks.Style.Add("font-size", "15px");
        sb.Append("<table class='table-style'>");

        sb.Append("<thead><tr><th>Process Management</th><th>Title</th><th>Audience</th></tr></thead>");

        sb.Append("<tbody>");
        //sb.Append("<tr><td rowspan='11'>Manage Process</td></tr>");

        sb.Append("<tr>");
        sb.Append("<td>Survey Status</td>");
        sb.Append("<td><a href='../AdminReports/frmStatusReport.aspx' class='btn-one w-100'>E360 Status Report</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class=''><li>E360 Status Report</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");



        sb.Append("<tr>");
        sb.Append("<td>Nomination Status Report</td>");
        sb.Append("<td><a href='../AdminReports/frmNominationStatusReport.aspx' class='btn-one w-100'>Nomination Status Report</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class=''><li>Nomination Status Report</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");

        sb.Append("<tr>");
        sb.Append("<td>Nomination Approval Status Report</td>");
        sb.Append("<td><a href='../AdminReports/frmNominationApprovalStatusReport.aspx' class='btn-one w-100'>Nomination Approval Status Report</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class=''><li>Nomination Approval Status Report</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");


        sb.Append("<tr>");
        sb.Append("<td>Email Notification: Invite</td>");
        sb.Append("<td><a href='../AdminReports/frmSendEmailInvite_ToParticipants.aspx' class='btn-one w-100'>Launch Notification</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class=''><li>Launch Notification : To Participants</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");


        sb.Append("<tr>");
        sb.Append("<td>Email Notification: Invite</td>");
        sb.Append("<td><a href='../AdminReports/frmSend_Review_Approve_Email_ToManager.aspx' class='btn-one w-100'>Review and Approve 360-Degree Feedback raters for your team members </a></td>");
        sb.Append("<td>");
        sb.Append("<ul class=''><li>Review and Approve 360-Degree Feedback raters for your team members : To Manager </li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");


        sb.Append("<tr>");
        sb.Append("<td>Email Notification: Invite</td>");
        sb.Append("<td><a href='../AdminReports/frmSendEmail_KickOffNotice_Mail3.aspx' class='btn-one w-100'>360 Degree Feedback for <Emp Name>: Kickoff Notice </a></td>");
        sb.Append("<td>");
        sb.Append("<ul class=''><li>360 Degree Feedback for <Emp Name>: Kickoff Notice </li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");


        sb.Append("<tr>");
        sb.Append("<td>Email Notification: Invite</td>");
        sb.Append("<td><a href='../AdminReports/frmSendEmail_Feedbackforyourstakeholders_Mail4.aspx' class='btn-one w-100'>360 Degree Feedback for your stakeholders: Survey Launch </a></td>");
        sb.Append("<td>");
        sb.Append("<ul class=''><li>360 Degree Feedback for your stakeholders: Survey Launch </li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");


        sb.Append("<tr>");
        sb.Append("<td>Email Notification: Reminder</td>");
        sb.Append("<td><a href='../AdminReports/frmSendEmail_Reminder_InitiateYour360Degree_FeedbackForm_Mail6.aspx' class='btn-one w-100'>Reminder: Initiate Your 360-Degree Feedback Form</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class=''><li>Reminder: Initiate Your 360-Degree Feedback Form</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");


        sb.Append("<tr>");
        sb.Append("<td>Email Notification: Reminder</td>");
        sb.Append("<td><a href='../AdminReports/frmSendEmail_Reminder_Review_and_Approve360Degree_FeedbackNomination_Mail7.aspx' class='btn-one w-100'>Reminder: Review and Approve 360-Degree Feedback Nomination</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class=''><li>Reminder: Review and Approve 360-Degree Feedback Nomination</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");


        sb.Append("<tr>");
        sb.Append("<td>Email Notification: Reminder</td>");
        sb.Append("<td><a href='../AdminReports/frmSendEmail_Urgent_InitiateYour360Degree_FeedbackForm_Mail8.aspx' class='btn-one w-100'>Urgent: Initiate Your 360-Degree Feedback Form</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class=''><li>Urgent: Initiate Your 360-Degree Feedback Form</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");


        sb.Append("<tr>");
        sb.Append("<td>Email Notification: Reminder</td>");
        sb.Append("<td><a href='../AdminReports/frmSendEmail_Reminder_PendingNotificationof360Degree_FeedbackForm_Mail9.aspx' class='btn-one w-100'>Reminder: Pending Notification of 360-Degree Feedback Form- Receipent</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class=''><li>Reminder: Pending Notification of 360-Degree Feedback Form - Receipent</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");


        sb.Append("<tr>");
        sb.Append("<td>Email Notification: Reminder</td>");
        sb.Append("<td><a href='../AdminReports/frmSendEmail_Reminder_PendingNotificationof360Degree_FeedbackForm_Mail10.aspx' class='btn-one w-100'>Reminder: Pending Notification of 360-Degree Feedback Form- Participants</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class=''><li>Reminder: Pending Notification of 360-Degree Feedback Form - Participants</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");


        sb.Append("</tr></tbody>");
        // sb.Append("</table>");
        return sb.ToString();
    }

}