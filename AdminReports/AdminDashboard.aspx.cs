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
        if (Session["LoginId"] == null)
        {
            Response.Redirect("../../Login.aspx");
        }
        else
        {
            dvLinks.InnerHtml = CreateLinks();
        }
    }
    private string CreateLinks()
    {
        StringBuilder sb = new StringBuilder();
        dvLinks.Style.Add("font-size", "15px");
        sb.Append("<table class='table table-bordered border-left-0 border-right-0'>");
        sb.Append("<tr>");
        sb.Append("<td rowspan='9' style='width:170px; color:#044d91; text-align:center; font-weight: 500;text-transform: uppercase;'>Manage Process</td>");

        //sb.Append("<tr>");
        //sb.Append("<td><a href='../MasterForms/frmSendEmailInvite_AzureServices.aspx' class='btn-one col-12'>Users Invitation Mail</a></td>");
        //sb.Append("<td>");
        //sb.Append("<ul class='mb-0 pl-3'><li>Send Invitation Mail to Users</li></ul>");
        //sb.Append("</td>");
        //sb.Append("</tr>");
        //sb.Append("</tr>");

        sb.Append("<tr>");
        sb.Append("<td><a href='../MasterForms/frmSendEmailInvite_APSE_AzureServices.aspx' class='btn-one col-12'>APSE Invitation Mail : Only Self</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class='mb-0 pl-3'><li>Send Invitation Mail to APSE : Only Self</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");
        sb.Append("</tr>");

        sb.Append("<tr>");
        sb.Append("<td><a href='../MasterForms/frmSendEmailInvite_APSR_AzureServices.aspx' class='btn-one col-12'>APSR Invitation Mail : Only Raters</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class='mb-0 pl-3'><li>Send Invitation Mail to APSR : Only Raters</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");
        sb.Append("</tr>");

        sb.Append("<tr>");
        sb.Append("<td><a href='../MasterForms/frmSendEmailInvite_APSE_APSR_AzureServices.aspx' class='btn-one col-12'>APSE & APSR Invitation Mail: Both(Self + Rater)</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class='mb-0 pl-3'><li>Send Invitation Mail to APSE & APSR : Both(Self + Rater)</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");
        sb.Append("</tr>");


        sb.Append("<tr>");
        sb.Append("<td><a href='../MasterForms/frmSendEmailInvite_Reminders_APSE_AzureServices.aspx' class='btn-one col-12'>APSE Reminders Mail : Only Self</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class='mb-0 pl-3'><li>Send Reminders Mail to APSE : Only Self</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");
        sb.Append("</tr>");

        sb.Append("<tr>");
        sb.Append("<td><a href='../MasterForms/frmSendEmailInvite_Reminders_APSR_AzureServices.aspx' class='btn-one col-12'>APSR Reminders Mail: Only Raters</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class='mb-0 pl-3'><li>Send Reminders Mail to APSR : Only Raters</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");
        sb.Append("</tr>");

        sb.Append("<tr>");
        sb.Append("<td><a href='../MasterForms/frmSendEmailInvite_Reminders_APSE__APSR_AzureServices.aspx' class='btn-one col-12'>APSE & APSR Reminders Mail : Both(Self + Rater)</a></td>");
        sb.Append("<td>");
        sb.Append("<ul class='mb-0 pl-3'><li>Send Reminders Mail to APSR & APSR : Both(Self + Rater)</li></ul>");
        sb.Append("</td>");
        sb.Append("</tr>");
        sb.Append("</tr>");
        return sb.ToString();
    }

}