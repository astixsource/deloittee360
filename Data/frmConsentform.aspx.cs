using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Xml;
using System.IO;
using Azure.Core;

public partial class frmConsentform : System.Web.UI.Page
{
   
    SqlConnection objCon = default(SqlConnection);
    SqlCommand objCom = default(SqlCommand);
    DataTable dt;
    SqlCommand cmd = null;
    DataSet ds = null;
    SqlDataAdapter da = null;
    SqlDataReader drdr = null;

    static string strCon = HttpContext.Current.Application["DbConnectionString"].ToString();

    int intlogin = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
       
            btnback.Visible = false;
            dvbtncontainer.Visible = true;
            if (Session["LoginID"] == null)
            {
                Response.Redirect("../Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                hdnLoginId.Value = Session["LoginId"].ToString();
                // hdnLevelId.Value = Session["LevelId"].ToString();
            }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string strReturn = "";
        // int strReturnFlgfromDb =0;
        SqlConnection con = new SqlConnection(strCon.Split('|')[0]);
        cmd = new SqlCommand("SpManageConsentInfo", con);
        cmd.Parameters.AddWithValue("@EmpNodeID", Session["NodeId"].ToString());
        cmd.Parameters.AddWithValue("@LoginID", Session["LoginID"].ToString());
        cmd.Parameters.AddWithValue("@flgAgree", hdnAgree.Value);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandTimeout = 0;

        //int strReturnFlgfromDb = 0;
        try
        {
            con.Open();
            // SqlDataReader dr;
             cmd.ExecuteNonQuery();
            strReturn = "1^";
            cmd.Dispose();
			Response.Redirect("../"+Request.QueryString["str"].ToString());
        }
        catch (Exception ex)
        {
            dvMsg.InnerHtml = ex.Message;
			strReturn = ("2^" + ex.Message);
        }
        finally
        {
            //cmd.Dispose();
            con.Close();
            //cmd.Dispose();
        }

        
    }

    protected void btnback_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Login.aspx");
    }
}