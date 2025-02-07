using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Net;
using System.IO;
using System.Threading;
using System.Drawing;
using System.Text.Json.Serialization;
using System.Xml;
using Newtonsoft.Json;
using Formatting = Newtonsoft.Json.Formatting;
using Microsoft.Office.Interop.Excel;
using DataTable = System.Data.DataTable;
using System.Text;
using Azure;
using Azure.Communication.Email;
using System.Net.Mail;
using Excel;


public partial class Data_frmNominateRater : System.Web.UI.Page
{
    SqlConnection objCon = default(SqlConnection);
    SqlCommand objCom = default(SqlCommand);
    DataTable dt;
    static string strCon = HttpContext.Current.Application["DbConnectionString"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["LoginId"] == null)
        {
            Response.Redirect("../Login.aspx");
            return;
        }
        if (!IsPostBack)
        {
            hdnLoginId.Value = Session["LoginId"].ToString();
            hdnNodeId.Value = Session["NodeId"].ToString();
            hdnIsManager.Value = Session["flgIsManager"].ToString();
            using (SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]))
            {
                using (SqlCommand command = new SqlCommand("spGetUserListForNomination", Scon))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 0;
                    command.Parameters.AddWithValue("@LoginId", hdnLoginId.Value);
                    using (SqlDataAdapter da = new SqlDataAdapter(command))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            Session["UserListForNomination"] = dt;
                        }
                    }
                }
            }
            fnFillCycle();
        }
    }
    public void fnFillCycle()
    {
        using (SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]))
        {
            using (SqlCommand command = new SqlCommand("spFillRltshp", Scon))
            {
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.CommandTimeout = 0;
                using (SqlDataAdapter da = new SqlDataAdapter(command))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        foreach (DataRow dr in dt.Rows)
                        {
                            if (dr["RltshpID"].ToString() != "4")
                            {
                                ListItem lst = new ListItem();
                                lst.Text = dr["Descr"].ToString();
                                lst.Value = dr["RltshpID"].ToString();
                                lst.Attributes.Add("minNominationperCategory", dr["minNominationperCategory"].ToString());
                                ddlRelatioShip.Items.Add(lst);
                            }
                        }
                        //ddlRelatioShip.DataSource = dt;
                        //ddlRelatioShip.DataTextField = "Descr";
                        //ddlRelatioShip.DataValueField = "RltshpID";
                        //ddlRelatioShip.DataBind();
                    }
                }
            }
        }
    }

    [System.Web.Services.WebMethod()]
    public static string fnGetUserListForNomination(string searchText, int LoginID)
    {
        string jsonData = "";
        if (HttpContext.Current.Session["UserListForNomination"] != null)
        {
            DataTable dt = (DataTable)HttpContext.Current.Session["UserListForNomination"];
            if (dt.Rows.Count > 0)
            {
                string[] filterArray = searchText.Split(',');

                string strsearchfield = "Searchfield LIKE '%" + filterArray[0] + "%'";
                for (int i = 1; i < filterArray.Length; i++)
                {
                    strsearchfield += " and Searchfield LIKE '%" + filterArray[i] + "%'";
                }
                if (dt.Select(strsearchfield).Length > 0)
                {
                    DataTable dtMain = dt.Select(strsearchfield).Take(40).CopyToDataTable();
                    jsonData = JsonConvert.SerializeObject(dtMain, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
                    jsonData = "1^" + jsonData;
                    dtMain.Dispose();
                }
                else
                {
                    jsonData = "3^No Record Found,Please enter correct text for search!";
                }
            }
            else
            {
                jsonData = "3^No Record Found,Please enter correct text for search!";
            }
        }
        else
        {
            jsonData = "3^Session Expired,Kindly login again!";
        }


        return jsonData;
    }


    [System.Web.Services.WebMethod()]
    public static string fnRemoveNomineeData(int empid, int rpId, int LoginID)
    {
        string jsonData = "";
        try
        {

            using (SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]))
            {
                using (SqlCommand command = new SqlCommand("", Scon))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 0;
                    command.Parameters.AddWithValue("@LoginId", LoginID);
                    command.Parameters.AddWithValue("@arr", LoginID);
                    Scon.Open();
                    command.ExecuteNonQuery();
                    Scon.Close();
                    jsonData = "1|";
                }

            }
        }
        catch (Exception e)
        {
            jsonData = "2|" + e.Message;
        }

        return jsonData;
    }

    [System.Web.Services.WebMethod()]
    public static string fnSaveandDeleteNomineeData(int LoginID, object arrData, int flg)
    {

       
        string jsonData = "";
        try
        {
            string strOrderDetail = JsonConvert.SerializeObject(arrData, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            System.Data.DataTable tblOrderDetail = JsonConvert.DeserializeObject<System.Data.DataTable>(strOrderDetail);
            tblOrderDetail.TableName = "tblOrderDetail";

            using (SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]))
            {
                using (SqlCommand command = new SqlCommand("spSaveNominationsFromUser", Scon))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 0;
                    command.Parameters.AddWithValue("@LoginId", LoginID);
                    command.Parameters.AddWithValue("@tmpSaveNominationsFromUser", tblOrderDetail);
                    command.Parameters.AddWithValue("@flgSubmit", flg);
                    using (SqlDataAdapter da = new SqlDataAdapter(command))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            if (flg == 1)
                            {
                                if (dt.Rows.Count > 0)
                                {
                                    fnSendMailToUsers(Convert.ToString(dt.Rows[0][0]), Convert.ToString(dt.Rows[0][1]));
                                }
                            }
                        }
                    }
                    jsonData = "1|";
                }
            }
        }



        catch (Exception e)
        {
            jsonData = "2|" + e.Message;
        }

        return jsonData;
    }


    [System.Web.Services.WebMethod()]
    public static string fnSaveaNewStakeholder(int LoginID, string st_name, string st_email, string st_function, string st_dept, string st_desig)
    {

       
        string jsonData = "";
        try
        {

            using (SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]))
            {
                using (SqlCommand command = new SqlCommand("spSaveNominationsFromUser", Scon))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 0;
                    command.Parameters.AddWithValue("@LoginId", LoginID);
                    Scon.Open();
                    command.ExecuteNonQuery();
                    Scon.Close();
                    jsonData = "1|";
                    string FName = "";
                    string MailTo = "";
                    string strStatus = fnSendMailToUsers(FName, MailTo);// Sent Mail to Coach/Coaches/Managers 
                }
            }
        }



        catch (Exception e)
        {
            jsonData = "2|" + e.Message;
        }

        return jsonData;
    }


    public static string fnSendMailToUsers(string FName, string MailTo)
    {
        string strRespoonse = "1";
        try
        {
           
            string WebSitePath = ConfigurationManager.AppSettings["PhysicalPath"].ToString();
            string flgActualUser = ConfigurationManager.AppSettings["flgActualUser"].ToString();
            string fromMail = ConfigurationManager.AppSettings["FromAddress"].ToString();
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("VAC Manager<" + fromMail + ">");

            var connectionString = "endpoint=https://astixemailcommunication.india.communication.azure.com/;accesskey=eY/ca2ZawDDXmJx1KvbW0FXw5CbMmucrsW+mjBqE9urodCYTNJeiBeRq3vjX/s7cVlCymgjphLEPbeF9IJRSuw==";
            var emailClient = new EmailClient(connectionString);

            var emailRecipients = new EmailRecipients();
            if (ConfigurationSettings.AppSettings["flgActualUser"].ToString() == "1")
            {
                if (MailTo != "")
                {
                    for (int i = 0; i < MailTo.Split(',').Length; i++)
                    {
                        emailRecipients.To.Add(new EmailAddress(MailTo.Split(',')[i].Trim()));
                    }
                }

                // For BCC
                string[] BCCEmailIDs = ConfigurationSettings.AppSettings["MailBcc"].Split(',');
                if (BCCEmailIDs.Length > 1)
                {
                    for (int i = 0; i < BCCEmailIDs.Length; i++)
                    {
                        emailRecipients.BCC.Add(new EmailAddress(BCCEmailIDs[i]));
                    }
                }
                else
                {
                    emailRecipients.BCC.Add(new EmailAddress(ConfigurationSettings.AppSettings["MailBcc"]));
                }

            }
            else
            {
                MailTo = ConfigurationSettings.AppSettings["MailTo"].ToString();
                if (MailTo != "")
                {
                    for (int i = 0; i < MailTo.Split(',').Length; i++)
                    {
                        emailRecipients.To.Add(new EmailAddress(MailTo.Split(',')[i].Trim()));
                    }
                }

            }

            msg.Subject = "Approve Nomination For Reportee ";



            StringBuilder strBody = new StringBuilder();
            strBody.Append("<font  style='COLOR: #000000; FONT-FAMILY: Arial'  size=2>");

            strBody.Append("<p>Dear " + FName + ",</p>");
            strBody.Append("<p>Your Reportee/s are nominated to be part of the annual HCAS 360-Degree Feedback program. As participants, your reportee/s have identified and submitted their rater nominations for review. Your role in this process is crucial to ensuring that each participant receives well-rounded and constructive feedback from the most relevant stakeholders.</p>");
            strBody.Append("<p><strong>Action Required</strong></p>");
            strBody.Append("<p>Please log in to the platform and review the rater nominations submitted by your reportees. You have the option to:</p>");
            strBody.Append("<ul>");
            strBody.Append("<li>Approve the entire list if all nominations are appropriate.</li>");
            strBody.Append("<li>Request modification to specific nominations, if needed. In such cases, please provide a reason or suggest a suitable replacement within the same category.</li>");
            strBody.Append("</ul>");


            strBody.Append("<p>Next Steps</p>");
            strBody.Append("<ol>");
            strBody.Append("<li>Access the platform using <a href='" + WebSitePath + "'>" + WebSitePath + "</a>.</li>");
            strBody.Append("<li>Review the submitted rater nominations for your reportee/Coachee for relevance, diversity of perspectives, and alignment with feedback objectives.</li>");
            strBody.Append("<li>Approve or suggest modifications as necessary.</li>");
            strBody.Append("<li>Submit your approval/revisions by <strong>20-Feb-2025</strong>.</li>");
            strBody.Append("</ol>");


            strBody.Append("<p>Please complete your assessment by <stromg>20th December 2024, 6:00 PM IST.<stromg></p>");
            strBody.Append("<p>Your timely review will help ensure a smooth and effective feedback process. Should you have any questions or need assistance, please reach out to : <a style = 'COLOR: #000000; FONT-weight: bold' href = mailto:demer@deloitte.com> (demer@deloitte.com)</a>.</p>");
            strBody.Append("<p><b>Best Regards,</b></p>");
            strBody.Append("<p><b>Team Deloitte</b></p>");


            strBody.Append("</font>");




            var emailContent = new EmailContent(msg.Subject) { PlainText = null, Html = strBody.ToString() };
            var emailMessage = new EmailMessage(
                senderAddress: ConfigurationSettings.AppSettings["MailSender"],      //The email address of the domain registered with the Communication Services resource
                recipients: emailRecipients,
                content: emailContent);


            var emailSendOperation = emailClient.Send(wait: WaitUntil.Completed, message: emailMessage);
        }
        catch (Exception ex)
        {
            strRespoonse = ex.Message;
        }
        return strRespoonse;
    }

    [System.Web.Services.WebMethod()]
    public static string fnGetNomineeDetails(int loginId)
    {
        string jsonData = "";
        try
        {
            using (SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]))
            {
                using (SqlCommand command = new SqlCommand("spGetNominationsForUser", Scon))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 0;
                    command.Parameters.AddWithValue("@LoginId", loginId);
                    command.Parameters.AddWithValue("@EmpNodeId", 0);
                    using (SqlDataAdapter da = new SqlDataAdapter(command))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            StringBuilder sb = new StringBuilder();
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                int flgSubmittedForApproval = Convert.ToInt32(dt.Rows[i]["flgSubmittedForApproval"]);
                                sb.Append("<tr flg='1' flgSubmittedForApproval='"+ flgSubmittedForApproval.ToString()+ "' flgvalid='" + (Convert.ToInt32(dt.Rows[i]["flgApproved"]) == 2 ? "0" : "1") + "' nomineid='" + dt.Rows[i]["NodeId"].ToString() + "' rpid='" + dt.Rows[i]["RltshpID"].ToString() + "'>");
                                sb.Append("<td>" + dt.Rows[i]["Relationship"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["FullName"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["EMailID"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Function"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Department"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Designation"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Status"].ToString() + "</td>");
                                if (dt.Rows[i]["flgSubmittedForApproval"].ToString() == "0" && dt.Rows[i]["flgApproved"].ToString() == "0" && dt.Rows[i]["RltshpID"].ToString() != "4" && dt.Rows[i]["RltshpID"].ToString() != "1")
                                {
                                    sb.Append("<td class='text-center'><i class='fa fa-pencil' onclick='fnEditCategory(this)' title='click to edit' style='cursor:pointer'></i>  <i class='fa fa-trash-o' onclick='fnRemoveFromDB(this)' style='color:red;cursor:pointer;margin-left:5px' title='click to delete'></i></td>");
                                }
                                else
                                {
                                    sb.Append("<td class='text-center'  style='color:red;cursor:pointer'></td>");
                                }
                                sb.Append("</tr>");
                            }
                            jsonData = "1|" + sb.ToString();
                        }
                    }
                }
            }
        }
        catch (Exception e)
        {
            jsonData = "2|" + e.Message;
        }

        return jsonData;

    }

}