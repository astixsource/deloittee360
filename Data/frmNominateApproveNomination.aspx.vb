Imports System.Data.SqlClient
Imports System.Web.Security
Imports System.Text.RegularExpressions
Imports System.Data

Partial Class _Welcome
    Inherits Page

    Dim strLocalIP As String
    Dim drdr As SqlDataReader
    Dim objCon As SqlConnection
    Dim objCom As SqlCommand

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Dim panelLogout As Panel
        'panelLogout = DirectCast(Page.Master.FindControl("panelLogout"), Panel)
        'panelLogout.Visible = False

        If Convert.ToString(Session("flgParticipant")) = "1" And Convert.ToString(Session("flgIsManager")) = "0" Then
            div2.Style.Add("display", "none")
        ElseIf Convert.ToString(Session("flgParticipant")) = "0" And Convert.ToString(Session("flgIsManager")) = "1" Then
            div1.Style.Add("display", "none")
        End If

        If Convert.ToString(Session("LevelId")) = "1" Then
            dvRMCoach.InnerHtml = "For RM/Coach: Click on below icon to review your team members’ rater selections:"
        Else
            dvRMCoach.InnerHtml = "For CDA: Click on below icon to review your team members’ rater selections:"
        End If

    End Sub
    'Protected Sub btnContiue_Click(sender As Object, e As EventArgs) Handles btnContiue.Click
    '    Response.Redirect("frmMain.aspx")
    'End Sub


    'Protected Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
    '    'Response.Redirect("frmMain.aspx")
    '    Response.Redirect("http://23.102.103.18/deloitteVac_Demo/Set2/Main/frmExerciseMain.aspx?LoginId=" + Convert.ToString(Session("logid")) & "&CycleId=" & Convert.ToString(Session("cyclid")))
    'End Sub
End Class