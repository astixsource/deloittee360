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

public partial class frmSendEmailInvite : System.Web.UI.Page
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
                   new SqlParameter("@MailType", 5), //  360 Degree Feedback for your stakeholders: Survey completion // Mail Type 5
              };
            Ds = clsDbCommand.ExecuteQueryReturnDataSet(storedProcName, con, sp);


            HttpContext.Current.Session["dtRelationshipDetail"] = Ds.Tables[0];

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
                    string ParticipantID = Ds.Tables[0].Rows[i]["ParticipantID"].ToString();
                    string ParticipantName = Ds.Tables[0].Rows[i]["ParticipantName"].ToString();
                    string ParticipantEMailID = Ds.Tables[0].Rows[i]["ParticipantEMailID"].ToString();
                    string ParticipantUserName = Ds.Tables[0].Rows[i]["ParticipantUserName"].ToString();
                    string ParticipantPassword = Ds.Tables[0].Rows[i]["ParticipantPassword"].ToString();
                    string DeadlineDate = Ds.Tables[0].Rows[i]["DeadlineDate"].ToString();
                    string ReportFileName = Ds.Tables[0].Rows[i]["ReportFileName"].ToString(); 
                        string ManagerMailId = Ds.Tables[0].Rows[i]["ManagerMailId"].ToString();


                    
                    
                    str.Append("<tr ParticipantID = '" + ParticipantID + "' ParticipantName = '" + ParticipantName + "'   ParticipantEMailID = '" + ParticipantEMailID + "'  ParticipantUserName = '" + ParticipantUserName + "' ParticipantPassword = '" + ParticipantPassword + "' DeadlineDate = '" + DeadlineDate + "' ReportFileName = '" + ReportFileName + "' ManagerMailId = '" + ManagerMailId + "'   > ");
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
                    string ParticipantID = drow["ParticipantID"].ToString();
                    string ParticipantName = drow["ParticipantName"].ToString();
                    string ParticipantEMailID = drow["ParticipantEMailID"].ToString();
                    string ParticipantUserName = drow["ParticipantUserName"].ToString();
                    string ParticipantPassword = drow["ParticipantPassword"].ToString();
                    string DeadlineDate = drow["DeadlineDate"].ToString();
                    string ReportFileName = drow["ReportFileName"].ToString();
                    string ManagerMailId = drow["ManagerMailId"].ToString();
                    


                    string strStatus = fnSendICSFIleToUsers(ParticipantID, ParticipantName, ParticipantEMailID, ParticipantUserName, ParticipantPassword, DeadlineDate, ReportFileName, ManagerMailId);
                    drow["MailStatus"] = strStatus == "1" ? "Mail Sent" : strStatus;

                    if (strStatus == "1")
                    {
                        fnUpdateMailSp("spMailUpdateLog", ParticipantID, "1", "2", "1", Scon);
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

    //RaterId, RaterName, RaterEMailId, RaterUserName, RaterPassword, DeadlineDate
    public static string fnSendICSFIleToUsers(string ParticipantID, string ParticipantName, string ParticipantEMailID, string ParticipantUserName, string ParticipantPassword, string DeadlineDate, string ReportFileName, string ManagerMailId)
    {


        string strRespoonse = "1";
        try
        {
            string MailTo = ParticipantEMailID;
            string MailCC = ManagerMailId;
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

                //for CC

                if (MailCC != "")
                {
                    for (int i = 0; i < MailCC.Split(',').Length; i++)
                    {
                        emailRecipients.CC.Add(new EmailAddress(MailCC.Split(',')[i].Trim()));
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


            msg.Subject = "360 Feedback survey closure & Report";



            StringBuilder strBody = new StringBuilder();
            strBody.Append("<font  style='COLOR: #000000; FONT-FAMILY: Arial'  size=2>");



        


            strBody.Append("<p>Dear " + ParticipantName + ",</p>");
            strBody.Append("<p>The is to inform you that your 360-Degree Feedback survey has been successfully completed.</p>");


            strBody.Append("<p><b>Next steps:</b></p>");

            strBody.Append("<p><b>Review and self-reflection:</b> We encourage you to review the feedback received, identify personal strengths and growth areas, and consider how these insights align with your professional development goals.</p>");
            strBody.Append("<p><b>Feedback session:</b> Look out for a group debrief session invite from the Partner Matters Team, Consider scheduling a debrief session with your team and review your Team Pulse report (from iRPM) to discuss the results, address any concerns, and plan for future development.</p>");
            strBody.Append("<p><b>Access to the report:</b></p>");
            strBody.Append("<p>The comprehensive feedback report is now available for your review. Please find the same attached.</p>");
            strBody.Append("<p>We appreciate your active participation in the 360-Degree Feedback process and in enhancing our firm's vision of fostering a culture of continuous improvement.</p>");


            strBody.Append("<p>Note: This is a system-generated email. Please do not reply to this ID.</p>");



            strBody.Append("</font>");




            var emailContent = new EmailContent(msg.Subject) { PlainText = null, Html = strBody.ToString() };
            var emailMessage = new EmailMessage(
                senderAddress: ConfigurationManager.AppSettings["MailSender"],      //The email address of the domain registered with the Communication Services resource
                recipients: emailRecipients,
                content: emailContent);


            //StartSent File Attcachment Code Here
            string ReportFileNameDB = ReportFileName;
            string file = HttpContext.Current.Server.MapPath("~/Reports/"+ ReportFileNameDB);

            var filePath = file;
            var attachmentName = ReportFileNameDB;
            var contentType = "";

            var content = new BinaryData(System.IO.File.ReadAllBytes(filePath));
            var emailAttachment = new EmailAttachment(attachmentName, contentType, content);
            emailMessage.Attachments.Add(emailAttachment);
            //END Sent File Attcachment Code Here



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
        Scmd.Parameters.AddWithValue("@MailType", 5);
        Scmd.Parameters.AddWithValue("@CycApseAssmntTypeMapID", 1);

        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;

        Scmd.ExecuteNonQuery();
    }


}