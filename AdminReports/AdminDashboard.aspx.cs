﻿using System;
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
        Panel panelLogout;
        panelLogout = (Panel)Page.Master.FindControl("panelLogout");
        panelLogout.Visible = false;
    }
    private string CreateLinks()
    {
        StringBuilder sb = new StringBuilder();
        dvLinks.Style.Add("font-size", "15px");
        sb.Append("<table class='table table-bordered border-left-0 border-right-0'>");
        sb.Append("<tr>");
        sb.Append("<td rowspan='9' style='width:170px; color:#044d91; text-align:center; font-weight: 500;text-transform: uppercase;'>Manage Process</td>");


        sb.Append("<tr>");
        sb.Append("<td><a href='../AdminReports/frmSendEmailInvite_ToParticipants.aspx' class='btn-one col-12'>Launch Notification</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class='mb-0 pl-3'><li>Launch Notification : To Participants</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");
   

        sb.Append("<tr>");
        sb.Append("<td><a href='../AdminReports/frmSend_Review_Approve_Email_ToManager.aspx' class='btn-one col-12'>Review and Approve 360-Degree Feedback raters for your team members </a></td>");
        sb.Append("<td>");
        sb.Append("<ul class='mb-0 pl-3'><li>Review and Approve 360-Degree Feedback raters for your team members : To Manager </li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");
   

        sb.Append("<tr>");
        sb.Append("<td><a href='../AdminReports/frmSendEmail_KickOffNotice_Mail3.aspx' class='btn-one col-12'>360 Degree Feedback for <Emp Name>: Kickoff Notice </a></td>");
        sb.Append("<td>");
        sb.Append("<ul class='mb-0 pl-3'><li>360 Degree Feedback for <Emp Name>: Kickoff Notice </li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");


        sb.Append("<tr>");
        sb.Append("<td><a href='../AdminReports/frmSendEmail_Feedbackforyourstakeholders_Mail4.aspx' class='btn-one col-12'>360 Degree Feedback for your stakeholders: Survey Launch </a></td>");
        sb.Append("<td>");
        sb.Append("<ul class='mb-0 pl-3'><li>360 Degree Feedback for your stakeholders: Survey Launch </li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");

       
        sb.Append("</tr>");
        return sb.ToString();
    }

}