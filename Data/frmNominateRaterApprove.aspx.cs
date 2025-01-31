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
            fnGetApseListForManager();
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
                            sb.Append("<div class='clscoacheelist' onclick=\"fnGetNomineeDetails(this," + dr["EmpNodeId"].ToString() + ")\">"+ dr["FullName"].ToString() + "</div>");
                            i++;
                        }
                        dvcoacheelist.InnerHtml = sb.ToString();
                    }
                }
            }
        }
    }

    [System.Web.Services.WebMethod()]
    public static string fnGetNomineeDetails(int loginId,int EmpNodeId)
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
                    command.Parameters.AddWithValue("@EmpNodeId", EmpNodeId);
                    command.Parameters.AddWithValue("@flgSubmittedForApproval", 1);
                    
                    using (SqlDataAdapter da = new SqlDataAdapter(command))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            StringBuilder sb = new StringBuilder();
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                int flgSubmittedForApproval = Convert.ToInt32(dt.Rows[i]["flgSubmittedForApproval"]);
                                sb.Append("<tr flg='1' flgvalid='1' CycleApseApsrMapID='"+ dt.Rows[i]["CycleApseApsrMapID"].ToString() + "' nomineid='" + dt.Rows[i]["NodeId"].ToString() + "' rpid='" + dt.Rows[i]["RltshpID"].ToString() + "'>");
                               if(flgSubmittedForApproval == 1 && Convert.ToInt32(dt.Rows[i]["flgApproved"]) == 0)
                                {
                                    sb.Append("<td class='text-center'><input type='checkbox' /></td>");
                                }
                                else
                                {
                                    sb.Append("<td class='text-center'></td>");
                                }
                                
                                sb.Append("<td>" + dt.Rows[i]["Relationship"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["FullName"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["EMailID"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Function"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Department"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Designation"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Status"].ToString() + "</td>");
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
    public static string fnSaveandDeleteNomineeData(int LoginID, object arrData, string RejectionComment)
    {
        string jsonData = "";
        try
        {
            string strOrderDetail = JsonConvert.SerializeObject(arrData, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            System.Data.DataTable tblOrderDetail = JsonConvert.DeserializeObject<System.Data.DataTable>(strOrderDetail);
            tblOrderDetail.TableName = "tblOrderDetail";

            using (SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]))
            {
                using (SqlCommand command = new SqlCommand("spSaveNominationsAprovalFromManager", Scon))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 0;
                    command.Parameters.AddWithValue("@LoginId", LoginID);
                    command.Parameters.AddWithValue("@tmpApproveNominationsFromManager", tblOrderDetail);
                    command.Parameters.AddWithValue("@RejectionComment", RejectionComment);
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
}