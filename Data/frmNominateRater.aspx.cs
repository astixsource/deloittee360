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
            hdnLevelId.Value = Session["LevelId"].ToString();


            if (hdnLevelId.Value == "1")
            {
                divContent_2.Style.Add("display", "none");
            }
            else
            {
                divContent_1.Style.Add("display", "none");
            }

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
        string levelid = hdnLevelId.Value;
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
                                if (dr["minNominationperCategory"].ToString() == "0")
                                {
                                    lst.Text = dr["Descr"].ToString() + " (Optional)";
                                }
                                else
                                {
                                    lst.Text = dr["RltshpID"].ToString()=="1"? (levelid == "2" ? "CDA" : dr["Descr"].ToString())+ " (Auto populated)" : dr["Descr"].ToString() + " (Min. " + dr["minNominationperCategory"].ToString() + ")";
                                }
                                lst.Value = dr["RltshpID"].ToString();
                                lst.Attributes.Add("rptxt", dr["Descr"].ToString());
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
                                     fnSendMailToUsers(Convert.ToString(dt.Rows[0][0]), Convert.ToString(dt.Rows[0]["ParticipantName"]) , Convert.ToString(dt.Rows[0][1]));
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
                using (SqlCommand command = new SqlCommand("spSaveIndUser", Scon))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 0;
                    command.Parameters.AddWithValue("@LoginId", LoginID);
                    command.Parameters.AddWithValue("@FullName", st_name);
                    command.Parameters.AddWithValue("@EmailId", st_email);
                    command.Parameters.AddWithValue("@Function", st_function);
                    command.Parameters.AddWithValue("@Department", st_dept);
                    command.Parameters.AddWithValue("@Designation", st_desig);
                    using (SqlDataAdapter da = new SqlDataAdapter(command))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            jsonData = "1|" + dt.Rows[0]["flgUserExist"].ToString() + "|" + Convert.ToString(dt.Rows[0]["EmpNodeId"]);
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

    public static string fnSendMailToUsers(string FName, string PFName, string MailTo)
    {
        string strRespoonse = "1";
        try
        {
           
            string WebSitePath = ConfigurationManager.AppSettings["PhysicalPath"].ToString();
            string flgActualUser = ConfigurationManager.AppSettings["flgActualUser"].ToString();
            string fromMail = ConfigurationManager.AppSettings["FromAddress"].ToString();
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("VAC Manager<" + fromMail + ">");

            //var connectionString = "endpoint=https://astixemailcommunication.india.communication.azure.com/;accesskey=" + Convert.ToString(HttpContext.Current.Application["AzureMailconnectionString"]);
            var connectionString = "endpoint=https://astixemailcommunication.india.communication.azure.com/;accesskey=eY/ca2ZawDDXmJx1KvbW0FXw5CbMmucrsW+mjBqE9urodCYTNJeiBeRq3vjX/s7cVlCymgjphLEPbeF9IJRSuw==";
            var emailClient = new EmailClient(connectionString);
            var emailRecipients = new EmailRecipients();
            if (ConfigurationManager.AppSettings["flgActualUser"].ToString() == "1")
            {
                if (MailTo != "")
                {
                    for (int i = 0; i < MailTo.Split(',').Length; i++)
                    {
                        emailRecipients.To.Add(new EmailAddress(MailTo.Split(',')[i].Trim()));
                    }
                }

                // For BCC
                string[] BCCEmailIDs = ConfigurationManager.AppSettings["MailBcc"].Split(',');
                if (BCCEmailIDs.Length > 1)
                {
                    for (int i = 0; i < BCCEmailIDs.Length; i++)
                    {
                        emailRecipients.BCC.Add(new EmailAddress(BCCEmailIDs[i]));
                    }
                }
                else
                {
                    emailRecipients.BCC.Add(new EmailAddress(ConfigurationManager.AppSettings["MailBcc"]));
                }

            }
            else
            {
                MailTo = ConfigurationManager.AppSettings["MailTo"].ToString();
                if (MailTo != "")
                {
                    for (int i = 0; i < MailTo.Split(',').Length; i++)
                    {
                        emailRecipients.To.Add(new EmailAddress(MailTo.Split(',')[i].Trim()));
                    }
                }

            }

            msg.Subject = "Review and Approve 360-Degree Feedback raters for your team members";



            StringBuilder strBody = new StringBuilder();
            strBody.Append("<font  style='COLOR: #000000; FONT-FAMILY: Arial'  size=2>");

            strBody.Append("<p>Dear " + FName + ",</p>");
            strBody.Append("<p>The 360-Degree Feedback application is designed to enhance overall feedback and development processes within the organisation. This tool focuses on offering a comprehensive view of an individual's competencies core to the Deloitte Future Leaders Framework and provides feedback from various sources.</p>");
           // strBody.Append("<p>We request your attention to review and approve the 360-Degree Feedback raters' list selected by " + PFName + ". The deadline for approval is <strong>20-Feb-2025</strong>.</p>");
            strBody.Append("<p>We request your attention to review and approve the 360-Degree Feedback nominations raised by " + PFName + ". </p>");
            strBody.Append("<p>If not approved by this date, the participant list will be auto-approved and proceed to the next step.</p>");
            strBody.Append("<p>You can login to the platform via Single Sign On (SSO) using your Deloitte credentials through the following URL: (platform URL will come later)</p>");
            //strBody.Append("<p>If not approved by this date, the participant list will be auto-approved and proceed to the next step. You can access and approve this document at the following URL : <a href=" + WebSitePath + ">" + WebSitePath + "</a></p>");
            //strBody.Append("<p><b>Login ID: " + ManagerName + "</b></p>");
            //strBody.Append("<p><b>Password: " + ManagerPassword + "</b></p>");

            strBody.Append("<p>The way forward involves triggering an assessment process, where the selected list of participants will provide feedback through this tool.</p>");
            strBody.Append("<p>If you have any questions, please connect with your <a href='https://apcdeloitte.sharepoint.com/sites/in/psupport/hr/Documents/Forms/AllItems.aspx?id=%2Fsites%2Fin%2Fpsupport%2Fhr%2FDocuments%2Fin%2Dtalent%2Dorganogram%2Dfeb%2D2025%2Epdf&parent=%2Fsites%2Fin%2Fpsupport%2Fhr%2FDocuments'>Talent business advisor</a>, or raise a ticket on <a href='https://inhelpd.deloitte.com/MDLIncidentMgmt/IM_LogTicket.aspx'>HelpD</a>.</p>");

            //strBody.Append("<p>Regards,</p>");
            //strBody.Append("<p>Talent team</p>");

            strBody.Append("<p>Note: This is a system-generated email. Please do not reply to this ID.</p>");
            strBody.Append("</font>");




            var emailContent = new EmailContent(msg.Subject) { PlainText = null, Html = strBody.ToString() };
            var emailMessage = new EmailMessage(
                senderAddress: ConfigurationManager.AppSettings["MailSender"],      //The email address of the domain registered with the Communication Services resource
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
        string levelid = Convert.ToString(HttpContext.Current.Session["LevelId"]);
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
                                sb.Append("<tr flg='1' flgSubmittedForApproval='"+ flgSubmittedForApproval.ToString()+ "' flgvalid='" + (Convert.ToInt32(dt.Rows[i]["flgApproved"]) == 2 ? "0" : "1") + "' nomineid='" + dt.Rows[i]["NodeId"].ToString() + "' rpid='" + dt.Rows[i]["RltshpID"].ToString() + "' newrpid='"+ dt.Rows[i]["RltshpID"].ToString() + "'>");
                                if (levelid == "2" && dt.Rows[i]["RltshpID"].ToString()=="1")
                                {
                                    sb.Append("<td>CDA</td>");
                                }
                                else
                                {
                                    sb.Append("<td>" + dt.Rows[i]["Relationship"].ToString() + "</td>");
                                }
                               
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