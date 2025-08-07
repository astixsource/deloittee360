using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Azure;
using Azure.Communication.Email;

using System.Net.Mime;

public partial class frmSend_Review_Approve_Email_ToManager : System.Web.UI.Page
{
    SqlConnection objCon = default(SqlConnection);
    SqlCommand objCom = default(SqlCommand);
    DataTable dt;
    string strConOLD = System.Configuration.ConfigurationManager.AppSettings["strConn"];
    string strCon = HttpContext.Current.Application["DbConnectionString"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginID"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                hdnLoginId.Value = Session["LoginID"].ToString();

                ddlCycle.Items.Insert(0, "Select");
                fnFillCycle();
            }
        }
        //Panel panelLogout;
        //panelLogout = (Panel)Page.Master.FindControl("panelLogout");
        //panelLogout.Visible = false;
    }

    public void fnFillCycle()
    {
        SqlConnection con = new SqlConnection(strCon.Split('|')[0]);
        string com = "spFillCycle";
        SqlDataAdapter adpt = new SqlDataAdapter(com, con);

        DataTable dt = new DataTable();
        adpt.Fill(dt);
        ddlCycle.DataSource = dt;
        ddlCycle.DataBind();
        ddlCycle.DataTextField = "Descr";
        ddlCycle.DataValueField = "CycleId";
        ddlCycle.DataBind();
    }


    //Get Scheme And Product Detail Bases on Store
    [System.Web.Services.WebMethod()]
    public static string fngetdata(int CycleId, string UserType)
    {
        //SqlConnection con = null;
        //con = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        string strCon = HttpContext.Current.Application["DbConnectionString"].ToString();
        SqlConnection con = new SqlConnection(strCon.Split('|')[0]);
        DataSet Ds = null;
        string stresponse = "";
        try
        {
            string storedProcName = "";
            if (UserType == "1")
            {
                storedProcName = "spGetListForSendingMails";
            }

            List<SqlParameter> sp = new List<SqlParameter>()
              {
                   new SqlParameter("@CycleId", CycleId),
                   new SqlParameter("@MailType", 7), // Reminder: Review and Approve 360-Degree Feedback Nomination For Mail Type 7
              };
            Ds = clsDbCommand.ExecuteQueryReturnDataSet(storedProcName, con, sp);

            HttpContext.Current.Session["dtRelationshipDetail"] = Ds.Tables[1];


            StringBuilder str = new StringBuilder();
            StringBuilder str1 = new StringBuilder();

            if (Ds.Tables[0].Rows.Count > 0)
            {
                string[] SkipColumn = new string[14];

                SkipColumn[0] = "ParticipantID";
                SkipColumn[1] = "LevelID";
                SkipColumn[2] = "UserType";
                SkipColumn[3] = "ParticipantUserName";
                SkipColumn[4] = "ParticipantPassword";
                SkipColumn[5] = "DeadlineDate";
                SkipColumn[6] = "ParticipantEmpCode";
                SkipColumn[7] = "ManagerId";
                SkipColumn[8] = "ManagerEmpCode";
                SkipColumn[9] = "ManagerUserName";
                SkipColumn[10] = "ManagerPassword";










                int isSubmitted = 0;// int.Parse(Ds.Tables[1].Rows[0]["isSubmitted"].ToString());
                str.Append("<div id='dvtblbody' class='mb-3'><table id='tbldbrlist' width=90% class='table table-bordered table-sm mb-0' isSubmitted=" + isSubmitted + "><thead><tr>");

                string ss = "";

                str.Append("<th style='width:3%' >S.N.</th>");
                for (int j = 0; j < Ds.Tables[0].Columns.Count; j++)
                {
                    if (SkipColumn.Contains(Ds.Tables[0].Columns[j].ColumnName))
                    {
                        continue;
                    }
                    string sColumnName = Ds.Tables[0].Columns[j].ColumnName; ;

                    str.Append("<th " + ss + ">" + sColumnName + "</th>");
                }
                //str.Append("<th>Include</th>");
                str.Append("<th><input type='checkbox' value='0' id='checkAll' onclick='check_uncheck_checkbox(this.checked)' > ALL</th>");
                str.Append("</tr></thead><tbody>");

                for (int i = 0; i < Ds.Tables[0].Rows.Count; i++)
                {

                    // ManagerId	ManagerName	ManagerEmpCode	ManagerEMailID	ManagerUserName	ManagerPassword

                    //string ParticipantID = Ds.Tables[0].Rows[i]["ParticipantID"].ToString();
                    //string ParticipantName = Ds.Tables[0].Rows[i]["ParticipantName"].ToString();
                    //string ParticipantEmpCode = Ds.Tables[0].Rows[i]["ParticipantEmpCode"].ToString();
                    //string ParticipantEMailID = Ds.Tables[0].Rows[i]["ParticipantEMailID"].ToString();
                    //string ParticipantLevelID = Ds.Tables[0].Rows[i]["LevelID"].ToString();
                    //string ParticipantUserType = Ds.Tables[0].Rows[i]["UserType"].ToString();



                    string ManagerId = Ds.Tables[0].Rows[i]["ManagerId"].ToString();
                    string ManagerName = Ds.Tables[0].Rows[i]["ManagerName"].ToString();
                    string ManagerEmpCode = Ds.Tables[0].Rows[i]["ManagerEmpCode"].ToString();
                    string ManagerEMailID = Ds.Tables[0].Rows[i]["ManagerEMailID"].ToString();
                    string ManagerUserName = Ds.Tables[0].Rows[i]["ManagerUserName"].ToString();
                    string ManagerPassword = Ds.Tables[0].Rows[i]["ManagerPassword"].ToString();


                    string DeadlineDate = Ds.Tables[0].Rows[i]["DeadlineDate"].ToString();



                    str.Append("<tr  ManagerId = '" + ManagerId + "' ManagerName = '" + ManagerName + "' ManagerEmpCode = '" + ManagerEmpCode + "' ManagerEMailID = '" + ManagerEMailID + "' ManagerUserName = '" + ManagerUserName + "' ManagerPassword = '" + ManagerPassword + "' DeadlineDate = '" + DeadlineDate + "'   > ");
                    str.Append("<td style='text-align:center'>" + (i + 1) + "</td>");
                    for (int j = 0; j < Ds.Tables[0].Columns.Count; j++)
                    {
                        string sColumnName = Ds.Tables[0].Columns[j].ColumnName;
                        if (SkipColumn.Contains(sColumnName))
                        {
                            continue;
                        }

                        var sData = Ds.Tables[0].Rows[i][j];

                        str.Append("<td>" + sData + "</td>");

                    }

                    str.Append("<td style='text-align:center'><input type='checkbox' flg='1' value='1'></td>");

                }

                str.Append("</tr>");
            }

            str.Append("</tbody></table></div>");



            stresponse = str.ToString();
        }
        catch (Exception ex)
        {
            stresponse = "2|" + ex.Message;
        }
        finally
        {
            con.Dispose();
        }

        return stresponse;
    }

    [System.Web.Services.WebMethod()]
    public static string fnSave(object udt_DataSaving)
    {
        string strResponse = "";
        try
        {

            string strDataSaving = JsonConvert.SerializeObject(udt_DataSaving, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            DataTable dtDataSaving = JsonConvert.DeserializeObject<DataTable>(strDataSaving);
            dtDataSaving.TableName = "tblMeetingData";
            if (dtDataSaving.Rows[0][0].ToString() == "0")
            {
                dtDataSaving.Rows[0].Delete();
            }
            //  SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);

            string strCon = HttpContext.Current.Application["DbConnectionString"].ToString();
            SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]);


            Scon.Open();
            foreach (DataRow drow in dtDataSaving.Rows)
            {
                try
                {

                    string ManagerId = drow["ManagerId"].ToString();
                    string ManagerName = drow["ManagerName"].ToString();
                    string ManagerEmpCode = drow["ManagerEmpCode"].ToString();
                    string ManagerEMailID = drow["ManagerEMailID"].ToString();
                    string ManagerUserName = drow["ManagerUserName"].ToString();
                    string ManagerPassword = drow["ManagerPassword"].ToString();


                    string DeadlineDate = drow["DeadlineDate"].ToString();




                    string strStatus = fnSendICSFIleToUsers(ManagerId, ManagerName, ManagerEmpCode, ManagerEMailID, ManagerUserName, ManagerPassword, DeadlineDate);
                    drow["MailStatus"] = strStatus == "1" ? "Mail Sent" : strStatus;

                    if (strStatus == "1")
                    {
                        fnUpdateMailSp("spMailUpdateLog", ManagerId, "1", "2", "1", Scon);
                    }


                }
                catch (Exception ex)
                {
                    drow["MailStatus"] = "Error-" + ex.Message;
                }
            }

            strResponse = "0|" + JsonConvert.SerializeObject(dtDataSaving, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            Scon.Dispose();
        }
        catch (Exception ex)
        {
            strResponse = "1|" + ex.Message;
        }
        return strResponse;
    }


    //ParticipantID, ParticipantName, ParticipantEmpCode, ParticipantEMailID, ParticipantLevelID, ParticipantUserType, ManagerId, ManagerName, ManagerEmpCode, ManagerEMailID, ManagerUserName, ManagerPassword, DeadlineDate
    public static string fnSendICSFIleToUsers(string ManagerId, string ManagerName, string ManagerEmpCode, string ManagerEMailID, string ManagerUserName, string ManagerPassword, string DeadlineDate)
    {
        string strRespoonse = "1";
        try
        {
            string MailTo = ManagerEMailID;
            //string MailTo = "abhishek@astix.in";

            string WebSitePath = ConfigurationManager.AppSettings["PhysicalPath"].ToString();
            string flgActualUser = ConfigurationManager.AppSettings["flgActualUser"].ToString();
            string fromMail = ConfigurationManager.AppSettings["FromAddress"].ToString();
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("VAC Manager<" + fromMail + ">");

            var connectionString = "endpoint=https://astixemailcommunication.india.communication.azure.com/;accesskey=" + Convert.ToString(HttpContext.Current.Application["AzureMailconnectionString"]);
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


            msg.Subject = "Reminder: Review and Approve 360-Degree Feedback Nomination";



            StringBuilder strBody = new StringBuilder();
            strBody.Append("<font  style='COLOR: #000000; FONT-FAMILY: Arial'  size=2>");



            DataTable dt = (DataTable)HttpContext.Current.Session["dtRelationshipDetail"];
            DataRow[] dr_FilterData = dt.Select("ManagerId= " + ManagerId);
            DataTable dtRelationshipDetail_FilterData = dr_FilterData.CopyToDataTable();

            strBody.Append("<p>Dear " + ManagerName + ",</p>");
            strBody.Append("<p>We request your attention to review and approve the 360-Degree Feedback nominations selected by below list of professionals. The deadline for approval is " + DeadlineDate + ".</p>");


            //Table List Will Come Start  Participant Name will come under the Table


            strBody.Append("<table cellpadding='0' cellspacing='0' style='width:60%;border: 1px solid #020202;'>");
            strBody.Append("<tr><td style='text-align:center; border: 1px solid #020202; background: #020202; width: 20%;color:white;'>Participant Name</td></tr>");

            foreach (DataRow dr in dtRelationshipDetail_FilterData.Rows)
            {
                strBody.Append("<tr>");
                string ParticipantName = dr["ParticipantName"].ToString();
                //string Relationship = dr["Relationship"].ToString();


                strBody.Append("<td style='text-align:center; border: 1px solid #020202; background: white; width: 20%;color:black;'>" + ParticipantName + "</td>");
                //strBody.Append("<td style='text-align:center; border: 1px solid #020202; background: White; width: 20%;color:black;'>" + Relationship + "</td>");
                strBody.Append("</tr>");

            }

            strBody.Append("</table>");


            //Table List Will Come End



            strBody.Append("<p>If not approved by this date, the nominee list will be auto-approved and proceed to the next step. To view and approve the list, you can login to the platform via Single Sign On (SSO) using your Deloitte credentials through this URL: <a href = " + WebSitePath + " > " + WebSitePath + "</a></p>");

            //strBody.Append("<p><b>Login ID: " + ManagerName + "</b></p>");
            //strBody.Append("<p><b>Password: " + ManagerPassword + "</b></p>");

            strBody.Append("<p>In case of any query kindly connect with your talent advisor or raise a ticket on <a href='https://inhelpd.deloitte.com/MDLIncidentMgmt/IM_LogTicket.aspx'>HelpD</a>.</p>");


            strBody.Append("<p>Note: This is a system-generated email. Please do not reply to this ID.</p>");



            strBody.Append("</font>");




            var emailContent = new EmailContent(msg.Subject) { PlainText = null, Html = strBody.ToString() };
            var emailMessage = new EmailMessage(
                senderAddress: ConfigurationManager.AppSettings["MailSender"],      //The email address of the domain registered with the Communication Services resource
                recipients: emailRecipients,
                content: emailContent);


            ////StartSent File Attcachment Code Here
            //string ReportFileNameDB = "Aarohan_UserGuide_for_360_Survey.pdf";
            //string file = HttpContext.Current.Server.MapPath("~/Attatchment/Aarohan_UserGuide_for_360_Survey.pdf");

            //var filePath = file;
            //var attachmentName = ReportFileNameDB;
            //var contentType = "";

            //var content = new BinaryData(System.IO.File.ReadAllBytes(filePath));
            //var emailAttachment = new EmailAttachment(attachmentName, contentType, content);
            //emailMessage.Attachments.Add(emailAttachment);
            ////END Sent File Attcachment Code Here



            var emailSendOperation = emailClient.Send(wait: WaitUntil.Completed, message: emailMessage);
        }
        catch (Exception ex)
        {
            strRespoonse = ex.Message;
        }
        return strRespoonse;
    }




    public static void fnUpdateMailSp(string SPName, string EmpNodeID, string FlgMailState, string flgUpdate, string UserType, SqlConnection Scon1)
    {
        //  SqlConnection Scon1 = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon1;
        Scmd.CommandText = SPName;
        Scmd.Parameters.AddWithValue("@UserID", EmpNodeID);
        Scmd.Parameters.AddWithValue("@MailType", 7);
        Scmd.Parameters.AddWithValue("@CycApseAssmntTypeMapID", 1);

        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;

        Scmd.ExecuteNonQuery();
    }


}