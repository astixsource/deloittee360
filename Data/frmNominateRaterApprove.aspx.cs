﻿using System;
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
           
            //SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]);
            //SqlCommand Scmd = new SqlCommand();
            //Scmd.Connection = Scon;
            //Scmd.CommandText = "[spGetUserListForNomination]";
            //Scmd.CommandType = CommandType.StoredProcedure;
            //Scmd.CommandTimeout = 0;
            //Scmd.Parameters.AddWithValue("@LoginId", hdnLoginId.Value);

            //SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
            //DataTable dt = new DataTable();
            //Sdap.Fill(dt);
            //Session["UserListForNomination"] = dt;
            fnFillCycle();
        }
    }
    public void fnFillCycle()
    {
        SqlConnection con = new SqlConnection(strCon.Split('|')[0]);
        string com = "spFillRltshp";
        SqlDataAdapter adpt = new SqlDataAdapter(com, con);

        DataTable dt = new DataTable();
        adpt.Fill(dt);
        //ddlCoacheeList.DataSource = dt;
        //ddlCoacheeList.DataTextField = "Descr";
        //ddlCoacheeList.DataValueField = "RltshpID";
        //ddlCoacheeList.DataBind();
        StringBuilder sb = new StringBuilder();
        foreach(DataRow dr in dt.Rows)
        {
            sb.Append("<div class='clscoacheelist' onclick='fnShowNomineelist(this)'>" + dr["Descr"].ToString()+"</div>");
        }
        dvcoacheelist.InnerHtml = sb.ToString();
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
                    using (SqlDataAdapter da = new SqlDataAdapter(command))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            StringBuilder sb = new StringBuilder();
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                int flgSubmittedForApproval = Convert.ToInt32(dt.Rows[i]["flgSubmittedForApproval"]);
                                sb.Append("<tr flg='1' flgvalid='1' nomineid='" + dt.Rows[i]["NodeId"].ToString() + "' rpid='" + dt.Rows[i]["RltshpID"].ToString() + "'>");
                                sb.Append("<td>" + dt.Rows[i]["Relationship"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["FullName"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["EMailID"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Function"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Department"].ToString() + "</td>");
                                sb.Append("<td>" + dt.Rows[i]["Designation"].ToString() + "</td>");
                                sb.Append("<td>" + (flgSubmittedForApproval == 0 ? "Save as draft" : flgSubmittedForApproval == 1 ? "Submitted" : flgSubmittedForApproval == 2 ? "Approved" : "Rejected") + "</td>");
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
                using (SqlCommand command = new SqlCommand("", Scon))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 0;
                    command.Parameters.AddWithValue("@LoginId", LoginID);
                    command.Parameters.AddWithValue("@arr", LoginID);
                    command.Parameters.AddWithValue("@statusid", flg);
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