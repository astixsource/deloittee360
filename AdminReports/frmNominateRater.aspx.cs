using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Formatting = Newtonsoft.Json.Formatting;
using DataTable = System.Data.DataTable;
using System.Text;
using Azure;
using Azure.Communication.Email;
using System.Net.Mail;


public partial class Data_frmNominateRater : System.Web.UI.Page
{
    //To be checked

    SqlConnection objCon = default(SqlConnection);
    SqlCommand objCom = default(SqlCommand);
    DataTable dt;
    static string strCon = HttpContext.Current.Application["DbConnectionString"].ToString().Split('|')[0];

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

            fnFillCycle();
            BatchMstr();
        }
    }
    public void fnFillCycle()
    {
        using (SqlConnection Scon = new SqlConnection(strCon))
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
                            ListItem lst = new ListItem();
                            lst.Text = dr["Descr"].ToString() + " (Min. " + dr["minNominationperCategory"].ToString() + ")";
                            lst.Value = dr["RltshpID"].ToString();
                            lst.Attributes.Add("rptxt", dr["Descr"].ToString());
                            lst.Attributes.Add("minNominationperCategory", dr["minNominationperCategory"].ToString());
                            ddlRelatioShip.Items.Add(lst);

                            //To be checked
                            //if (dr["RltshpID"].ToString() != "4")
                            //{
                            //    ListItem lst = new ListItem();
                            //    string strText = "";
                            //    if (dr["minNominationperCategory"].ToString() == "0")
                            //    {
                            //        strText = dr["Descr"].ToString() + " (Optional)";
                            //    }
                            //    else
                            //    {
                            //        //strText = dr["RltshpID"].ToString() == "1" ? (levelid == "2" ? "CDA" : dr["Descr"].ToString()) + " (Auto populated)" : dr["Descr"].ToString() + " (Min. " + dr["minNominationperCategory"].ToString() + ")";
                            //        strText = dr["Descr"].ToString() + " (Min. " + dr["minNominationperCategory"].ToString() + ")";
                            //    }
                            //    lst.Text = strText;
                            //    lst.Value = dr["RltshpID"].ToString();
                            //    lst.Attributes.Add("rptxt", strText);
                            //    lst.Attributes.Add("minNominationperCategory", dr["minNominationperCategory"].ToString());
                            //    ddlRelatioShip.Items.Add(lst);
                            //}
                        }
                    }
                }
            }
        }
    }    
    public void BatchMstr()
    {
        SqlConnection Scon = new SqlConnection(strCon);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandTimeout = 0;
        Scmd.CommandText = "[spFillCycle]";
        Scmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        DataTable dt = new DataTable();
        Sdap.Fill(dt);
        Sdap.Dispose();
        Scmd.Dispose();
        Scon.Dispose();

        ddlBatch.DataSource = dt;
        ddlBatch.DataTextField = "Descr";
        ddlBatch.DataValueField = "CycleId";
        ddlBatch.DataBind();

        ddlBatch.Items.Insert(0, new ListItem("-- Select --", "0"));
        dt.Dispose();
    }

    [System.Web.Services.WebMethod()]
    public static string getParticipant(string batchId)
    {
        try
        {
            SqlConnection Scon = new SqlConnection(strCon);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandTimeout = 0;
            Scmd.CommandText = "[spRptGetParticipantList]";
            Scmd.Parameters.AddWithValue("@CycleId", batchId);
            Scmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
            DataTable dt = new DataTable();
            Sdap.Fill(dt);
            Sdap.Dispose();
            Scmd.Dispose();
            Scon.Dispose();

            string[] SkipColumn = new string[2];
            SkipColumn[0] = "ApseNodeID";
            SkipColumn[1] = "flgtoCheckForMinRaterForEachCategory";
            return "0|^|" + dtParticipanttoHTML(dt, SkipColumn, "Participant");
        }
        catch (Exception ex)
        {
            return "1|^|" + ex.Message;
        }
    }
    private static string dtParticipanttoHTML(DataTable dt, string[] SkipColumn, string lbl)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<table id='tbl-" + lbl + "' class='table table-bordered table-sm tbl-" + lbl + "'>");
        sb.Append("<thead>");
        sb.Append("<tr>");
        sb.Append("<th>Sr.No</th>");
        for (int j = 0; j < dt.Columns.Count; j++)
            if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Trim()))
                sb.Append("<th>" + dt.Columns[j].ColumnName.ToString() + "</th>");

        sb.Append("</tr>");
        sb.Append("</thead>");
        sb.Append("<tbody>");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            sb.Append("<tr empid='" + dt.Rows[i]["ApseNodeID"] + "' isrelshpminvalid='" + dt.Rows[i]["flgtoCheckForMinRaterForEachCategory"] + "' onclick='SelectEmp(this);'>");
            sb.Append("<td>" + (i + 1).ToString() + "</td>");
            for (int j = 0; j < dt.Columns.Count; j++)
                if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Trim()))
                    sb.Append("<td>" + dt.Rows[i][j].ToString() + "</td>");

            sb.Append("</tr>");
        }

        sb.Append("</tbody>");
        sb.Append("</table>");

        return sb.ToString();
    }



    [System.Web.Services.WebMethod()]
    public static string fnGetNomineeDetails(int LoginId, string BatchID, string ApseNodeID)
    {
        string jsonData = "";
        string levelid = Convert.ToString(HttpContext.Current.Session["LevelId"]);
        try
        {
            using (SqlConnection Scon = new SqlConnection(strCon))
            {
                using (SqlCommand command = new SqlCommand("spGetNominationListForParicipant", Scon))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 0;
                    command.Parameters.AddWithValue("@CycleId", BatchID);
                    command.Parameters.AddWithValue("@ApseNodeID", ApseNodeID);
                    using (SqlDataAdapter da = new SqlDataAdapter(command))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            StringBuilder sb = new StringBuilder();
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                sb.Append("<tr flg='1' flgvalid='1' statusid='" + dt.Rows[i]["StatusId"].ToString() + "' nomineid='" + dt.Rows[i]["NodeId"].ToString() + "' rpid='" + dt.Rows[i]["RltshpID"].ToString() + "' newrpid='" + dt.Rows[i]["RltshpID"].ToString() + "'>");
                                if (levelid == "2" && dt.Rows[i]["RltshpID"].ToString() == "1")
                                {
                                    sb.Append("<td>CDA</td>");
                                }
                                else
                                {
                                    sb.Append("<td>" + dt.Rows[i]["Relationship"].ToString() + "</td>");
                                }

                                sb.Append("<td>" + dt.Rows[i]["Rater Name"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Rater Email"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Function"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Department"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Designation"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Survey Status"].ToString() + "</td>");
                                sb.Append("<td class='text-center'><i class='fa fa-pencil' onclick='fnEditCategory(this)' title='click to edit' style='cursor:pointer'></i>  <i class='fa fa-trash-o' onclick='fnRemoveFromDB(this)' style='color:red;cursor:pointer;margin-left:5px' title='click to delete'></i></td>");
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

        UserMstr(LoginId, ApseNodeID);
        return jsonData;

    }
    public static void UserMstr(int LoginId, string ApseNodeID)
    {
        using (SqlConnection Scon = new SqlConnection(strCon))
        {
            using (SqlCommand command = new SqlCommand("spGetUserListForNomination", Scon))
            {
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.CommandTimeout = 0;
                command.Parameters.AddWithValue("@LoginId", LoginId);
                command.Parameters.AddWithValue("@EmpNodeId", ApseNodeID);
                using (SqlDataAdapter da = new SqlDataAdapter(command))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        HttpContext.Current.Session["UserListForNomination"] = dt;
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
                // string[] filterArray = searchText.Split(',');
                string[] filterArray = searchText.Split(',').Select(x => x.Trim()).ToArray();
                string strsearchfield = "Searchfield LIKE '%" + filterArray[0] + "%'";
                for (int i = 1; i < filterArray.Length; i++)
                {
                    strsearchfield += " and Searchfield LIKE '%" + filterArray[i] + "%'";
                }
                var rows = dt.AsEnumerable().Where(row =>
            filterArray.All(filter =>
                row.Field<string>("Searchfield").IndexOf(filter, StringComparison.OrdinalIgnoreCase) >= 0));

                var resultRows = rows.Take(40).ToList();
                if (resultRows.Any())
                {
                    DataTable dtMain = resultRows.CopyToDataTable();
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
    public static string fnSaveandDeleteNomineeData(int LoginID, int BatchID, object arrData)
    {
        string jsonData = "";
        try
        {
            string strOrderDetail = JsonConvert.SerializeObject(arrData, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            System.Data.DataTable tblOrderDetail = JsonConvert.DeserializeObject<System.Data.DataTable>(strOrderDetail);
            tblOrderDetail.TableName = "tblOrderDetail";

            using (SqlConnection Scon = new SqlConnection(strCon))
            {
                using (SqlCommand command = new SqlCommand("spSaveNominationsFromAdminAfterEdit", Scon))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 0;
                    command.Parameters.AddWithValue("@CycleId", BatchID);
                    command.Parameters.AddWithValue("@tmpSaveNominationsFromUser", tblOrderDetail);
                    command.Parameters.AddWithValue("@LoginId", LoginID);
                    using (SqlDataAdapter da = new SqlDataAdapter(command))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            //fnSendMailToUsers(Convert.ToString(dt.Rows[0][0]), Convert.ToString(dt.Rows[0]["ParticipantName"]), Convert.ToString(dt.Rows[0][1]), Convert.ToString(dt.Rows[0]["DeadLineDate"]));
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
    public static string fnSaveaNewStakeholder(int LoginID, string st_name, string st_email, string st_function, string st_dept, string st_desig, string IsExternalUser)
    {
        string jsonData = "";
        try
        {
            using (SqlConnection Scon = new SqlConnection(strCon))
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
                    command.Parameters.AddWithValue("@IsExternalUser", IsExternalUser);
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




    //---------------- Not In Use ------------------//
    public static string fnSendMailToUsers(string FName, string PFName, string MailTo, string DeadLineDate)
    {
        string strRespoonse = "1";
        try
        {
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

            msg.Subject = "Review and Approve 360-Degree Feedback Nomination";


            StringBuilder strBody = new StringBuilder();
            strBody.Append("<font  style='COLOR: #000000; FONT-FAMILY: Arial'  size=2>");

            strBody.Append("<p>Dear " + FName + ",</p>");
            strBody.Append("<p>The 360-Degree Feedback application is designed to enhance overall feedback and development processes within the organisation. This tool focuses on offering a comprehensive view of an individual's competencies core to the Deloitte Future Leaders Framework and provides feedback from various sources.</p>");
            // strBody.Append("<p>We request your attention to review and approve the 360-Degree Feedback raters' list selected by " + PFName + ". The deadline for approval is <strong>20-Feb-2025</strong>.</p>");
            strBody.Append("<p>We request your attention to review and approve the 360-Degree Feedback nominations raised by " + PFName + ". The deadline for approval is " + DeadLineDate + ".</p>");
            strBody.Append("<p>If not approved by this date, the participant list will be auto-approved and proceed to the next step.</p>");
            strBody.Append("<p>You can login to the platform via Single Sign On (SSO) using your Deloitte credentials through the following URL: <a href = " + WebSitePath + " > " + WebSitePath + "</a></p>");
            //strBody.Append("<p>If not approved by this date, the participant list will be auto-approved and proceed to the next step. You can access and approve this document at the following URL : <a href=" + WebSitePath + ">" + WebSitePath + "</a></p>");
            //strBody.Append("<p><b>Login ID: " + ManagerName + "</b></p>");
            //strBody.Append("<p><b>Password: " + ManagerPassword + "</b></p>");

            strBody.Append("<p>The way forward involves triggering an assessment process, where the selected list of participants will provide feedback through this tool.</p>");
            //strBody.Append("<p>If you have any questions, please connect with PED Matters team.</p>");
            strBody.Append("<p>If you have any questions, please connect with Partner and ED Matters team, or raise a ticket on <a href='https://inhelpd.deloitte.com/MDLIncidentMgmt/IM_LogTicket.aspx'>HelpD</a>.</p>");
            // strBody.Append("<p>If you have any questions, please connect with your <a href='https://apcdeloitte.sharepoint.com/sites/in/psupport/hr/Documents/Forms/AllItems.aspx?id=%2Fsites%2Fin%2Fpsupport%2Fhr%2FDocuments%2Fin%2Dtalent%2Dorganogram%2Dfeb%2D2025%2Epdf&parent=%2Fsites%2Fin%2Fpsupport%2Fhr%2FDocuments'>Talent business advisor</a>, or raise a ticket on <a href='https://inhelpd.deloitte.com/MDLIncidentMgmt/IM_LogTicket.aspx'>HelpD</a>.</p>");

            //strBody.Append("<p>Regards,</p>");
            //strBody.Append("<p>Talent team</p>");

            strBody.Append("<p>Note: This is a system-generated email. Please do not reply to this ID.</p>");
            strBody.Append("</font>");



            var emailContent = new EmailContent(msg.Subject) { PlainText = null, Html = strBody.ToString() };
            var emailMessage = new EmailMessage(
                senderAddress: ConfigurationManager.AppSettings["MailSender"],      //The email address of the domain registered with the Communication Services resource
                recipients: emailRecipients,
                content: emailContent);


            //var emailSendOperation = emailClient.Send(wait: WaitUntil.Completed, message: emailMessage);
        }
        catch (Exception ex)
        {
            strRespoonse = ex.Message;
        }
        return strRespoonse;
    }
}