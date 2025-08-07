using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.IO;
using ClosedXML.Excel;
using System.Drawing;


public partial class frmNominationApprovalStatusReport : System.Web.UI.Page
{
    int j = 0;
    SqlConnection objCon = default(SqlConnection);
    SqlCommand objCom = default(SqlCommand);
    DataTable dt;
    string strConOLD = System.Configuration.ConfigurationManager.AppSettings["strConn"];
    // string strCon = HttpContext.Current.Application["DbConnectionString"].ToString();
    static string strCon = HttpContext.Current.Application["DbConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdnLoginId.Value = Session["LoginId"].ToString();
            ddlCycle.Items.Insert(0, "Select");
            fnFillCycle();
            fnFillStatus();
        }
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

    public void fnFillStatus()
    {
        SqlConnection con = new SqlConnection(strCon.Split('|')[0]);
        string com = "spGetStatusListForNominationApproval";
        SqlDataAdapter adpt = new SqlDataAdapter(com, con);

        DataTable dt = new DataTable();
        adpt.Fill(dt);
        ddlStatus.DataSource = dt;
        ddlStatus.DataBind();
        ddlStatus.DataTextField = "Status";
        ddlStatus.DataValueField = "StatusID";
        ddlStatus.DataBind();
    }


    [System.Web.Services.WebMethod()]
    public static string GetDetails(string CycleId, string StatusID)
    {
        try
        {
            SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]);
            //  SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spRptGetNominationApprovalStatus]";
            Scmd.Parameters.AddWithValue("@CycleId", CycleId);
            Scmd.Parameters.AddWithValue("@StatusId", StatusID);
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.CommandTimeout = 0;
            SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
            DataSet ds = new DataSet();
            Sdap.Fill(ds);
            Sdap.Dispose();
            Scmd.Dispose();
            Scon.Dispose();

            string[] SkipColumn = new string[5];
            SkipColumn[0] = "flgGrouping";
            SkipColumn[1] = "ApseNodeId";
            SkipColumn[2] = "StatusId";
            SkipColumn[3] = "flgApproved";
            SkipColumn[4] = "flgFeedbackStarted";
            if (ds.Tables[0].Rows.Count > 0)
            {
                return "0|^|" + dttoHTML(ds.Tables[0], SkipColumn, "Rpt");
            }
            else
            {
                return "0|^|" + "No Record found for this selection..";
            }
            //return "0|^|" + dttoHTML(ds.Tables[0], SkipColumn, "Rpt");
        }
        catch (Exception ex)
        {
            return "1|^|" + ex.Message;
        }
    }
    private static string dttoHTML(DataTable dt, string[] SkipColumn, string lbl)
    {
        StringBuilder sb = new StringBuilder();
        StringBuilder sbAlign = new StringBuilder();
        StringBuilder sbTypeSearch = new StringBuilder();

        sb.Append("<table id='tbl" + lbl + "' class='table table-bordered table-sm tbl-" + lbl + "'>");
        sb.Append("<thead>");
        sb.Append("<tr>");

        sb.Append("<th style='min-width: 30px; width: 30px;background: #88bd26;color: #F4F4F4;'>Sr.No</th>");
        for (int j = 0; j < dt.Columns.Count; j++)
            if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Trim()))
                sb.Append("<th style='min-width: 30px; width: 30px;background: #88bd26;color: #F4F4F4;'>" + dt.Columns[j].ColumnName.ToString() + "</th>");

        //sb.Append("<th style='display: none;'>Search</th>");
        sb.Append("<th style='width:12%; background: #88bd26;color: #F4F4F4;'>Action</th>");
        sb.Append("</tr>");
        sb.Append("</thead>");
        sb.Append("<tbody>");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            sbTypeSearch.Clear();

            sb.Append("<tr>");
            sb.Append("<td style='text-align: center;'>" + (i + 1).ToString() + "</td>");
            for (int j = 0; j < dt.Columns.Count; j++)
                if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Trim()))
                {
                    sbAlign.Clear();
                    //if (dt.Columns[j].ColumnName.ToString().Split('$')[1] == "1")
                    //    sbAlign.Append("left");
                    //if (dt.Columns[j].ColumnName.ToString().Split('$')[1] == "2")
                    //    sbAlign.Append("center");
                    //if (dt.Columns[j].ColumnName.ToString().Split('$')[1] == "3")
                    //    sbAlign.Append("right");

                    sbTypeSearch.Append(dt.Rows[i][j].ToString() + " ");
                    sb.Append("<td style='text-align: " + sbAlign.ToString() + "; '>" + dt.Rows[i][j].ToString() + "</td>");
                    //sb.Append("<td style='text-align: " + sbAlign.ToString() + ";'>" + (dt.Rows[i][j].ToString().Length > 30 ? dt.Rows[i][j].ToString().Substring(0, 28) + ".. <a href='#' header='" + dt.Columns[j].ColumnName.ToString().Trim() + "' lbl='" + dt.Rows[i][j].ToString() + "' onclick='fnShowFullString(this);'>(more)</a>" : dt.Rows[i][j].ToString()) + "</td>");
                }
            if (dt.Rows[i]["StatusId"].ToString() == "2")
            {           
               sb.Append("<td style='text-align: center;'><a href = '###' onclick='fnViewNominationedRater(\"" + dt.Rows[i]["Participant Name"].ToString().Trim() + "\"," + dt.Rows[i]["ApseNodeId"].ToString() + ", this);'>View Nomination</a></td>");
            }
            if (dt.Rows[i]["StatusId"].ToString() == "3")
            {
                sb.Append("<td style='text-align: center;'><a href = '###' onclick='fnReOpen(\"" + dt.Rows[i]["Participant Name"].ToString().Trim() + "\"," + dt.Rows[i]["ApseNodeId"].ToString() + "," + dt.Rows[i]["flgFeedbackStarted"].ToString() + ", this);'>Re-open</a></br><a href = '###'  onclick='fnViewNominationedRater(\"" + dt.Rows[i]["Participant Name"].ToString().Trim() + "\"," + dt.Rows[i]["ApseNodeId"].ToString() + ", this);' style='margin-left: 20px;'>View Nomination</a></td>");
                //sb.Append("<td style='width:12%'><a href = '###' onclick='fnReOpen(\"" + dt.Rows[i]["Participant Name"].ToString().Trim() + "\"," + dt.Rows[i]["ApseNodeId"].ToString() + "," + dt.Rows[i]["flgFeedbackStarted"].ToString() + ", this);' style='margin-left: 20px;'>Re-open</a></td>");
            }
            if (dt.Rows[i]["StatusId"].ToString() == "1")
            {
                sb.Append("<td></td>");
            }


            //sb.Append("<td iden='Search' style='display: none;'>" + sbTypeSearch.ToString() + "</td>");
            sb.Append("</tr>");
        }
        sb.Append("</tbody>");
        sb.Append("</table>");

        sbAlign.Clear();
        sbTypeSearch.Clear();
        return sb.ToString();
    }


    protected void btnDownload_Click(object sender, EventArgs e)
    {
        SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]);
        //SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "[spRptGetNominationApprovalStatus]";
        Scmd.Parameters.AddWithValue("@CycleId", ddlCycle.SelectedValue);
        // Scmd.Parameters.AddWithValue("@ReportDate", hdnReportDate.Value);
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        DataSet ds = new DataSet();
        Sdap.Fill(ds);
        Sdap.Dispose();
        Scmd.Dispose();
        Scon.Dispose();

        XLWorkbook wb = new XLWorkbook();
        string[] SkipColumn = new string[1];
        SkipColumn[0] = "flgGrouping";

        wb = AddWorkSheet(wb, ds.Tables[0], SkipColumn, "Report");

        try
        {
            //Export the Excel file.
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.Buffer = true;
            HttpContext.Current.Response.Charset = "";
            HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=NominationApprovalStatusReport_" + DateTime.Now.ToString("yyyyMMddhhmmss") + ".xlsx");
            using (MemoryStream MyMemoryStream = new MemoryStream())
            {
                wb.SaveAs(MyMemoryStream);
                MyMemoryStream.WriteTo(HttpContext.Current.Response.OutputStream);
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();
            }
        }
        catch (Exception ex)
        {
            //
        }
    }
    private static XLWorkbook AddWorkSheet(XLWorkbook wb, DataTable dt, string[] SkipColumn, string Sheetname)
    {
        IXLCell cellStart;
        IXLCell cellEnd;
        int k = 0, j = 0;
        var ws = wb.Worksheets.Add(Sheetname);

        //-----------Header------------------------
        k++;
        int FreezeRows = k;
        cellStart = ws.Cell(k, j + 1);
        for (int c = 0; c < dt.Columns.Count; c++)
        {
            if (!SkipColumn.Contains(dt.Columns[c].ColumnName.ToString().Trim().Split('$')[0]))
            {
                j++;
                ws.Cell(k, j).Value = dt.Columns[c].ColumnName.ToString().Split('$')[0];
                ws.Cell(k, j).Style.Alignment.WrapText = true;
                ws.Cell(k, j).Style.Fill.BackgroundColor = XLColor.FromHtml("#728cd4");
                ws.Cell(k, j).Style.Font.FontColor = XLColor.FromHtml("#ffffff");
                ws.Cell(k, j).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
            }
        }

        //------------Body---------------------------
        for (int b = 0; b < dt.Rows.Count; b++)
        {
            k++; j = 0;
            for (int c = 0; c < dt.Columns.Count; c++)
            {
                if (!SkipColumn.Contains(dt.Columns[c].ColumnName.ToString().Trim()))
                {
                    j++;
                    ws.Cell(k, j).Style.Alignment.WrapText = true;
                    ws.Cell(k, j).Value = dt.Rows[b][c].ToString();

                    //if (dt.Columns[c].ColumnName.ToString().Trim().Split('$')[1] == "1")
                    //    ws.Cell(k, j).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Left);
                    //else if (dt.Columns[c].ColumnName.ToString().Trim().Split('$')[1] == "2")
                    //    ws.Cell(k, j).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    //else if (dt.Columns[c].ColumnName.ToString().Trim().Split('$')[1] == "3")
                    //    ws.Cell(k, j).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                }
            }
        }
        cellEnd = ws.Cell(k, j);

        ws.Range(cellStart, cellEnd).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Left);
        ws.Range(cellStart, cellEnd).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
        ws.Range(cellStart, cellEnd).Style.Border.SetInsideBorder(XLBorderStyleValues.Thin);
        ws.Range(cellStart, cellEnd).Style.Border.SetOutsideBorder(XLBorderStyleValues.Medium);
        ws.Range(cellStart, cellEnd).Style.Font.SetFontSize(10);
        ws.SheetView.FreezeRows(FreezeRows);
        //ws.Columns().Width = 35;


        ws.Row(1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
        ws.Columns().AdjustToContents();

        return wb;
    }

    [System.Web.Services.WebMethod()]
    public static string fnReOpen_Result(int ApseNodeId, int CycleID, int LoginID)
    {

        string jsonData = "";
        try
        {

            using (SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]))
            {
                using (SqlCommand command = new SqlCommand("spManage_ReOpenNominationApproval", Scon))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandTimeout = 0;
                    command.Parameters.AddWithValue("@ApseNodeId", ApseNodeId);
                    command.Parameters.AddWithValue("@CycleId", CycleID);
                    command.Parameters.AddWithValue("@LoginId", LoginID);
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
    public static string fnViewNominationedRaterDetail(int ApseNodeId, int CycleID)
    {
        string lbl = "Rpt";
        SqlConnection Scon = new SqlConnection(strCon.Split('|')[0]);
        //SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "spGetListOfNominatedRaters";//"[SpVanGetCoveragedetails]";
        Scmd.Parameters.AddWithValue("@ApseNodeId", ApseNodeId);
        Scmd.Parameters.AddWithValue("@CycleId", CycleID);
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        DataSet Ds = new DataSet();
        Sdap.Fill(Ds);

        StringBuilder str = new StringBuilder();
        if (Ds.Tables[0].Rows.Count > 0)
        {
            str.Append("<table id='tbl" + lbl + "' class='table table-bordered table-sm tbl-" + lbl + "'>");
            // str.Append("<table cellpadding='0' cellspacing='0' style='width:100%; border-bottom:1px solid gray;border-collapse:collapse;' id='tblBasicDetailsInfoDetails' class='table-bordered' ><thead>");
            str.Append("<thead>");
            str.Append("<tr>");
            str.Append("<th style='width:2%; background: #88bd26;color: #F4F4F4;'>Sr.No.</th>");
            str.Append("<th style='width:7%; background: #88bd26;color: #F4F4F4;'>Rater Name</th>");
            str.Append("<th style='width:7%; background: #88bd26;color: #F4F4F4;'>Rater Email ID</th>");
            str.Append("<th style='width:7%; background: #88bd26;color: #F4F4F4;'>Relationship</th>");
            str.Append("<th style='width:7%; background: #88bd26;color: #F4F4F4;'>Status</th>");

            str.Append("</tr></thead><tbody>");

            for (int i = 0; i < Ds.Tables[0].Rows.Count; i++)
            {
                str.Append("<tr> ");
                str.Append("<td style='width:2%;text-align:center;'>" + (i + 1) + "</td>");

                str.Append("<td style='width:7%;text-align:left;'>" + Ds.Tables[0].Rows[i]["ApsrName"].ToString() + "</td>");
                str.Append("<td style='width:7%;text-align:left;'>" + Ds.Tables[0].Rows[i]["Email"].ToString() + "</td>");
                str.Append("<td style='width:7%;text-align:left;'>" + Ds.Tables[0].Rows[i]["Relationship"].ToString() + "</td>");
                str.Append("<td style='width:7%;text-align:left;'>" + Ds.Tables[0].Rows[i]["Status"].ToString() + "</td>");


                str.Append("</tr>");
            }
            
        }
        else
        {
            str.Append("<tr> ");
            str.Append("<td style='width:7%;text-align:left;'>No record found for this rater.</td>");
            str.Append("</tr>");
        }
        str.Append("</tbody></table>");
        return str.ToString();
    }
}