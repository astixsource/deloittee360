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
using System.Text;
using Azure;
using Azure.Communication.Email;
using System.Net.Mail;
using System.Runtime.InteropServices;

public partial class frmNominateRaterApprove : System.Web.UI.Page
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
            
            fnFillCycle();
            fnGetApseListForManager();
        }
    }
    [System.Web.Services.WebMethod()]
    public static string fnGetNominateList(int LoginId,int EmpNodeId) {

        using (SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]))
        {
            using (SqlCommand command = new SqlCommand("spGetUserListForNomination", Scon))
            {
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.CommandTimeout = 0;
                command.Parameters.AddWithValue("@LoginId", LoginId);
                command.Parameters.AddWithValue("@EmpNodeId", EmpNodeId);
                using (SqlDataAdapter da = new SqlDataAdapter(command))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                     HttpContext.Current.Session["UserListForNominationForManager"] = dt;
                    }
                }
            }
        }
        return "";
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
                                if (dr["minNominationperCategory"].ToString() == "0")
                                {
                                    lst.Text = dr["Descr"].ToString() + " (Optional)";
                                }
                                else
                                {
                                    lst.Text = dr["RltshpID"].ToString() == "1" ? dr["Descr"].ToString() + " (Auto populated)" : dr["Descr"].ToString() + " (Min. " + dr["minNominationperCategory"].ToString() + ")";
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
    public void fnGetApseListForManager()
    {
        using (SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]))
        {
            using (SqlCommand command = new SqlCommand("spGetApseListForManager", Scon))
            {
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.CommandTimeout = 0;
                command.Parameters.AddWithValue("@LoginId", hdnLoginId.Value);
                using (SqlDataAdapter da = new SqlDataAdapter(command))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        StringBuilder sb = new StringBuilder();
                        int i = 1;
                        foreach (DataRow dr in dt.Rows)
                        {
                            //sb.Append("<div class='clscoacheelist' onclick='fnShowNomineelist(this)'>Coachee " + dr["Descr"].ToString()+"</div>");
                            string strIcon = "";
                            if (dr["StatusID"].ToString() == "1")
                            {
                                strIcon = "<i class=\"fa fa-circle clsiconclass\" aria-hidden=\"true\" style=\"color:#e1ac43;font-size:15pt\"></i>";
                            }
                            else if (dr["StatusID"].ToString() == "2")
                            {
                                strIcon = "<i class=\"fa fa-circle clsiconclass\" aria-hidden=\"true\" style=\"color:#53cd8e;font-size:15pt\"></i>";
                            }
                            else if (dr["StatusID"].ToString() == "3")
                            {
                                strIcon = "<i class=\"fa fa-refresh clsiconclass\" aria-hidden=\"true\" style=\"background-color:#5aadf9;color:#fff;font-size:15pt\"></i>";
                            }
                            else
                            {
                                strIcon = "<i class=\"fa fa-check-square clsiconclass clsnomineeapprove\" aria-hidden=\"true\" style=\"color:#59d68e;font-size:15pt\"></i>";
                            }
                            sb.Append("<div style='display:table-row'><div class='clscoacheelist' EmpNodeId='" + dr["EmpNodeId"].ToString() + "' onclick=\"fnGetNomineeDetails(this," + dr["EmpNodeId"].ToString() + ")\">" + dr["FullName"].ToString()+ "</div><div class='clsiconcontainer'>"+ strIcon+"</div></div>");
                            i++;
                        }
                        dvcoacheelist.InnerHtml = sb.ToString();
                    }
                }
            }
        }
    }

    [System.Web.Services.WebMethod()]
    public static string fnGetNomineeDetails(int loginId, int EmpNodeId)
    {
        string jsonData = "";
        try
        {
            using (SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]))
            {
                using (SqlCommand command = new SqlCommand("spGetUserNominationsForManager", Scon))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 0;
                    command.Parameters.AddWithValue("@LoginId", loginId);
                    command.Parameters.AddWithValue("@EmpNodeId", EmpNodeId);
                    //command.Parameters.AddWithValue("@flgSubmittedForApproval", 1);

                    using (SqlDataAdapter da = new SqlDataAdapter(command))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            StringBuilder sb = new StringBuilder();
                            if (dt.Rows.Count > 0)
                            {
                                for (int i = 0; i < dt.Rows.Count; i++)
                                {
                                    int flgSubmittedForApproval = Convert.ToInt32(dt.Rows[i]["flgSubmittedForApproval"]);
                                    sb.Append("<tr flg='1' flgvalid='1' flgApproved='" + dt.Rows[i]["flgApproved"].ToString() + "' CycleApseApsrMapID='" + dt.Rows[i]["CycleApseApsrMapID"].ToString() + "' nomineid='" + dt.Rows[i]["NodeId"].ToString() + "' rpid='" + dt.Rows[i]["RltshpID"].ToString() + "'  newrpid='" + dt.Rows[i]["RltshpID"].ToString() + "'>");
                                    //if (flgSubmittedForApproval == 1 && Convert.ToInt32(dt.Rows[i]["flgApproved"]) == 0)
                                    //{
                                    //    sb.Append("<td class='text-center'><input type='checkbox' /></td>");
                                    //}
                                    //else
                                    //{
                                    //    sb.Append("<td class='text-center'></td>");
                                    //}

                                    sb.Append("<td>" + dt.Rows[i]["Relationship"].ToString() + "</td>");
                                    sb.Append("<td style='word-break:break-all'>" + dt.Rows[i]["FullName"].ToString() + "</td>");
                                    sb.Append("<td style='word-break:break-all'>" + dt.Rows[i]["EMailID"].ToString() + "</td>");
                                    sb.Append("<td>" + dt.Rows[i]["Function"].ToString() + "</td>");
                                    sb.Append("<td  style='word-break:break-all'>" + dt.Rows[i]["Department"].ToString() + "</td>");
                                    sb.Append("<td  style='word-break:break-all'>" + dt.Rows[i]["Designation"].ToString() + "</td>");
                                    sb.Append("<td>" + dt.Rows[i]["Status"].ToString() + "</td>");
                                    if (dt.Rows[i]["flgApproved"].ToString() == "0" && dt.Rows[i]["RltshpID"].ToString() != "4" && dt.Rows[i]["RltshpID"].ToString() != "1")
                                    {
                                        sb.Append("<td class='text-center'  ><i class='fa fa-pencil' onclick='fnEditCategory(this)' title='click to edit' style='cursor:pointer;display:none'></i> <i class='fa fa-trash-o' onclick='fnRemoveFromDB(this)' style='color:red;cursor:pointer;margin-left:5px;display:none' title='click to delete'></i></td>");
                                    }
                                    else
                                    {
                                        sb.Append("<td class='text-center'  style='color:red;cursor:pointer'></td>");
                                    }
                                    sb.Append("</tr>");
                                }
                            }
                            else
                            {
                                sb.Append("<tr><td colspan='8' class='dt-empty p-2 text-center'>Rater nominations are not available yet</td></tr>");
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

    [System.Web.Services.WebMethod()]
    public static string fnGetUserListForNomination(string searchText, int LoginID)
    {
        string jsonData = "";
        if (HttpContext.Current.Session["UserListForNominationForManager"] != null)
        {
            DataTable dt = (DataTable)HttpContext.Current.Session["UserListForNominationForManager"];
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
            jsonData = "3^No Record Found,Please enter correct text for search!";
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
        int Scenario = 1;
        string jsonData = "";
        try
        {
            string strOrderDetail = JsonConvert.SerializeObject(arrData, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            System.Data.DataTable tblOrderDetail = JsonConvert.DeserializeObject<System.Data.DataTable>(strOrderDetail);
            tblOrderDetail.TableName = "tblOrderDetail";

            using (SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]))
            {
                using (SqlCommand command = new SqlCommand("spSaveNominationsFromManager", Scon))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 0;
                    command.Parameters.AddWithValue("@LoginId", LoginID);
                    command.Parameters.AddWithValue("@tmpSaveNominationsFromUser", tblOrderDetail);
                    command.Parameters.AddWithValue("@flgSubmit", 1);
                    using (SqlDataAdapter da = new SqlDataAdapter(command))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            if (flg == 1)
                            {
                                if (dt.Rows.Count > 0)
                                {
                                    string strStatus = fnSendMailToUsers(Scenario, Convert.ToString(dt.Rows[0]["ParticipantName"]), "", "", Convert.ToString(dt.Rows[0]["ParticipantEMailID"]), "");
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



    public static string fnSendMailToUsers(int Scenario, string FName, string UserName, string Password, string MailTo, string Comment)
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

            StringBuilder strBody = new StringBuilder();
            if (Scenario == 1)
            {
                //msg.Subject = "Your HCAS 360-Degree Feedback FY2025 Rater Approval Update";
                msg.Subject = "360 Degree Feedback for " + FName + ": Kickoff Notice ";

                strBody.Append("<font  style='COLOR: #000000; FONT-FAMILY: Arial'  size=2>");

                strBody.Append("<p>Dear " + FName + ",</p>");
                //// Participants Name WIll Come
                //strBody.Append("<p>Thank you for your nominating your raters for the HCAS 360-Degree Feedback FY2025. Your nominated raters have been reviewed by your manager/coach. Below are the next steps for you:</p>");
                //strBody.Append("<p>All your nominated raters have been approved. No further action is required at this stage. Please await the survey launch to complete your self-rating & provide feedback for others if you have been nominated. </p>");
                //strBody.Append("<p>Should you have any questions or need assistance, please reach out to your talent advisors. </p>");
                ////strBody.Append("<p>Your timely review will help ensure a smooth and effective feedback process. Should you have any questions or need assistance, please reach out to : <a style = 'COLOR: #000000; FONT-weight: bold' href = mailto:demer@deloitte.com> (demer@deloitte.com)</a>.</p>");
                //strBody.Append("<p><b>Best Regards,</b></p>");
                //strBody.Append("<p><b>Team Deloitte</b></p>");

                strBody.Append("<p>We are pleased to inform you that the 360-Degree Feedback process has officially commenced, and the team selection has been approved.</p>");
                strBody.Append("<p>The feedback raters given below, has been strategically selected to provide a comprehensive assessment of your strength and development areas:</p>");

                strBody.Append("<p>Complete your Self Assessment which is designed to evaluate various competencies aligned with your professional development goals.<a href='" + WebSitePath + "'>" + WebSitePath + "</a></p>");
                strBody.Append("<p>Should you have any questions or need assistance, please reach out to your talent advisors. </p>");
                //strBody.Append("<p>Your timely review will help ensure a smooth and effective feedback process. Should you have any questions or need assistance, please reach out to : <a style = 'COLOR: #000000; FONT-weight: bold' href = mailto:demer@deloitte.com> (demer@deloitte.com)</a>.</p>");
                strBody.Append("<p>The deadline for approval is <strong>20-Feb-2025</strong>.</p>");
                strBody.Append("<p>If you have any questions, please connect with your <a href='https://apcdeloitte.sharepoint.com/sites/in/psupport/hr/Pages/Home.aspx'>Talent business advisor</a>, or raise a ticket on : <a href='https://inhelpd.deloitte.com/MDLIncidentMgmt/IM_LogTicket.aspx'>HelpD</a>.</p>");
                strBody.Append("<p><b>Regards,</b></p>");
                strBody.Append("<p><b>Talent team</b></p>");

                strBody.Append("<p>Note: This is a system-generated email. Please do not reply to this ID.</p>");

                strBody.Append("</font>");

            }
            else
            {
                msg.Subject = "Your HCAS 360-Degree Feedback FY2025 Rater Approval Update";

                strBody.Append("<font  style='COLOR: #000000; FONT-FAMILY: Arial'  size=2>");

                strBody.Append("<p>Dear " + FName + ",</p>"); // Participants Name WIll Come
                strBody.Append("<p>Thank you for your nominating your raters for the HCAS 360-Degree Feedback FY2025. Your nominated raters have been reviewed by your manager/coach. </p>");
                strBody.Append("<p>Below are the next steps for you:</p>");
                strBody.Append("<p>Some of your nominated raters were not approved and your manager/coach has shared below feedback:</p>");
                strBody.Append("<p>" + Comment + ",</p>"); // When Comment WIll Come then Code need to uncomment
                strBody.Append("<p>Please log-into the platform once again and update your rater selection accordingly before resubmitting for approval.</p>");
                strBody.Append("<p>URL <a href='" + WebSitePath + "'>" + WebSitePath + "</a>.</p>");
                strBody.Append("<p><b>Login ID: " + UserName + "</b></p>");
                strBody.Append("<p><b>Password: " + Password + "</b></p>");

                strBody.Append("<p>Once you updated your raters, please await the survey launch to complete your self-rating & provide feedback for others if you have been nominated. </p>");
                strBody.Append("<p>Should you have any questions or need assistance, please reach out to your talent advisors.</p>");
                strBody.Append("<p><b>Best Regards,</b></p>");
                strBody.Append("<p><b>Team Deloitte</b></p>");


                strBody.Append("</font>");

            }




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
}