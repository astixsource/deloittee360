Imports System.Data.SqlClient
Imports System.Web.Security
Imports System.Text.RegularExpressions
Imports System.Data
Imports System.Web
Imports System.Web.Helpers
Imports Azure.Identity
Imports Azure.Core


Partial Class LoginPageFirst
    Inherits System.Web.UI.Page

    Dim Email As String
    Dim strLocalIP As String
    Dim drdr As SqlDataReader
    Dim objCon As SqlConnection
    Dim objCom As SqlCommand
    Dim _tenantId As String = ConfigurationManager.AppSettings("_tenantId")
    Dim _clientId As String = ConfigurationManager.AppSettings("_clientId")

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load, Me.Load
        'btnLogin.Attributes.Add("onclick", "javascript:return fnValidate()")
        If Session("UserExistEmail") Is Nothing Then
            Response.Redirect("~/Login.aspx")
            Return
        End If

        If Session("UserExistEmail") <> Request.QueryString("Email") Then
            Response.Redirect("~/Login.aspx")
            Return
        End If

        If Page.IsPostBack = False Then
            Email = Request.QueryString("Email")
            hdnEmailId.Value = Email.ToString()
        End If
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function fnLoginFromDB(ByVal UserName As String) As String

        Dim strResponse As String = ""
        strResponse = "1|LoginPage.aspx?Email=" & HttpUtility.HtmlEncode(UserName)


        Return strResponse
    End Function

    Public Shared Function ReplaceQuotes(ByVal str As String) As String
        Return Replace(str, "'", "''")
    End Function
    'Protected Sub btnReset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReset.Click
    '    txtLoginID.Text = ""
    '    txtPassword.Text = ""
    '    dvMessage.InnerText = ""
    'End Sub


    Protected Sub btnLoginSSO_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/LoginPageSSO.aspx")
    End Sub
End Class


