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


public partial class AdminReports_frmStatusReportNew : System.Web.UI.Page
{
    int j = 0;
    SqlConnection objCon = default(SqlConnection);
    SqlCommand objCom = default(SqlCommand);
    DataTable dt;
    string strCon = System.Configuration.ConfigurationManager.AppSettings["strConn"];
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            ddlCycle.Items.Insert(0, "Select");
            fnFillCycle();
        }
    }
    public void fnFillCycle()
    {
        SqlConnection con = new SqlConnection(strCon);
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

    protected void btnShow_Click(object sender, EventArgs e)
    {
        fnBindGrid();
    }

    public void fnBindGrid()
    {
        objCon = new SqlConnection(strCon);
        objCom = new SqlCommand("spGETStatusForALKEM", objCon);
        objCom.CommandType = CommandType.StoredProcedure;
        objCom.Parameters.Add("@CycleID", SqlDbType.Int).Value = ddlCycle.SelectedValue.ToString();

        objCon.Open();
        objCom.CommandTimeout = 0;
        SqlDataAdapter da = new SqlDataAdapter(objCom);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dt = new DataTable();
        dt.Clear();
        da.Fill(dt);
        grdWSMapping.DataSource = ds;
        grdWSMapping.DataBind();

    }

    protected void btnExportReport_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=StatusReport_" + DateTime.Now.ToString("dd-MMM-yy") + ".xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            this.fnBindGrid();
            grdWSMapping.HeaderRow.BackColor = Color.White;
            foreach (TableCell cell in grdWSMapping.HeaderRow.Cells)
            {
                cell.BackColor = grdWSMapping.HeaderStyle.BackColor;
            }

            foreach (GridViewRow row in grdWSMapping.Rows)
            {
                row.BackColor = Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    cell.CssClass = "textmode";
                }
            }

            grdWSMapping.RenderControl(hw);

            //style to format numbers to string
            string style = @"<style> .textmode {border:solid 0.1pt #CCCCCC; } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
   
}