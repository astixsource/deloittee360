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

public partial class Data_frmNominateRater : System.Web.UI.Page
{
    SqlConnection objCon = default(SqlConnection);
    SqlCommand objCom = default(SqlCommand);
    DataTable dt;
    string strCon = HttpContext.Current.Application["DbConnectionString"].ToString();
 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlRelatioShip.Items.Insert(0, "Select");
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
        ddlRelatioShip.DataSource = dt;
        ddlRelatioShip.DataBind();
        ddlRelatioShip.DataTextField = "Descr";
        ddlRelatioShip.DataValueField = "RltshpID";
        ddlRelatioShip.DataBind();
    }
}