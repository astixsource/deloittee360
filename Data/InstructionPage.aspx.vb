Imports System.Data.SqlClient
Imports System.Web.Security
Imports System.Text.RegularExpressions
Imports System.Data

Partial Class InstructionPage
    Inherits Page

    Dim strLocalIP As String
    Dim drdr As SqlDataReader
    Dim objCon As SqlConnection
    Dim objCom As SqlCommand

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Dim panelLogout As Panel
        'panelLogout = DirectCast(Page.Master.FindControl("panelLogout"), Panel)
        'panelLogout.Visible = False

    End Sub
    Protected Sub btnContiue_Click(sender As Object, e As EventArgs) Handles btnContiue.Click
        If Convert.ToString(Session("flgParticipant")) = 1 Then
            Response.Redirect("frmNominateRater.aspx")  'Response.Redirect("Data/frmMain.aspx")
        ElseIf Convert.ToString(Session("flgIsManager")) = 1 Then
            Response.Redirect("frmNominateApproveNomination.aspx")  'Response.Redirect("Data/frmMain.aspx")
        Else
            Response.Redirect("Instruction.aspx?NodeID=")
            'strResponse = "1|Data/Dashboard.aspx?NodeID="

        End If
    End Sub
    'Protected Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
    '    'Response.Redirect("frmMain.aspx")
    '    Response.Redirect("http://23.102.103.18/deloitteVac_Demo/Set2/Main/frmExerciseMain.aspx?LoginId=" + Convert.ToString(Session("logid")) & "&CycleId=" & Convert.ToString(Session("cyclid")))
    'End Sub
End Class