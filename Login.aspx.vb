Imports System.Data.SqlClient
Imports System.Web.Security
Imports System.Text.RegularExpressions
Imports System.Data
Imports System.Web
Imports System.Web.Helpers
Imports Azure.Identity
Imports Azure.Core


Partial Class Login
    Inherits System.Web.UI.Page


    Dim strLocalIP As String
    Dim drdr As SqlDataReader
    Dim objCon As SqlConnection
    Dim objCom As SqlCommand
    Dim _tenantId As String = ConfigurationManager.AppSettings("_tenantId")
    Dim _clientId As String = ConfigurationManager.AppSettings("_clientId")

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load, Me.Load
        'btnLogin.Attributes.Add("onclick", "javascript:return fnValidate()")
        If Page.IsPostBack = False Then

            Session.Abandon()
            Session.Clear()
            Session.RemoveAll()
            Response.Cookies.Add(New HttpCookie("ASP.NET_SessionId", ""))
            'Dim cookietoken As String
            'Dim formtoken As String
            'AntiForgery.GetTokens(Nothing, cookietoken, formtoken)
            'divAntiforgery.InnerHtml = cookietoken & ":" & formtoken

            ' Set the anti-forgery cookie
            'Dim antiForgeryCookie As New HttpCookie("__RequestVerificationToken", cookietoken) With {
            '    .HttpOnly = True,
            '    .Secure = Request.IsSecureConnection
            '}
            'Response.Cookies.Add(antiForgeryCookie)
            ' Dim strConn1 As String = Convert.ToString(HttpContext.Current.Application("DbConnectionString"))
            'hdnaccesstoken.Value = strConn1
        End If
    End Sub

    'Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogin.Click

    '    Dim strTokens = divAntiforgery.InnerHtml
    '    AntiForgery.Validate(strTokens.Split(":")(0), strTokens.Split(":")(1))


    '    Dim drdr As SqlDataReader

    '    If (Request.ServerVariables("REMOTE_ADDR") = "") Then
    '        strLocalIP = "Unknown"  'not able to get the IP.
    '    Else
    '        strLocalIP = Request.ServerVariables("REMOTE_ADDR")
    '    End If

    '    Dim PwdStatus As Integer

    '    Dim NodeID As Integer
    '    Dim strReturn As String = ""

    '    Dim Objcon As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
    '    Dim objCom As New SqlCommand("[spSecUserLogin]", Objcon)
    '    objCom.Parameters.Add("@UserName", SqlDbType.VarChar).Value = HttpUtility.HtmlEncode(txtLoginID.Text)
    '    objCom.Parameters.Add("@Password", SqlDbType.VarChar).Value = HttpUtility.HtmlEncode(txtPassword.Text)
    '    objCom.Parameters.Add("@IPAddress", SqlDbType.VarChar).Value = strLocalIP
    '    objCom.Parameters.Add("@SessionID", SqlDbType.VarChar).Value = Session.SessionID
    '    objCom.Parameters.Add("@BrowserVersion", SqlDbType.VarChar).Value = Request.Browser.Type
    '    objCom.Parameters.Add("@Resolution", SqlDbType.VarChar).Value = ""
    '    objCom.CommandType = CommandType.StoredProcedure
    '    objCom.CommandTimeout = 0
    '    Try
    '        Objcon.Open()
    '        drdr = objCom.ExecuteReader()
    '        drdr.Read()
    '        If (drdr.Item("LoginID") = 0) Then
    '            If HttpUtility.HtmlEncode(txtLoginID.Text) = "astix" And HttpUtility.HtmlEncode(txtPassword.Text) = "admin" Then
    '                Response.Redirect("AdminReports/frmStatusReport.aspx")

    '            Else
    '                dvMessage.InnerText = "Invalid Login-Id or Password. Try Again !!"
    '                txtPassword.Text = ""
    '            End If
    '        Else
    '            Session("RId") = drdr.Item("RoleID")
    '            Session("LoginId") = drdr.Item("LoginID")
    '            Session("FullName") = drdr.Item("FullName")
    '            If Not IsDBNull(drdr.Item("CycleID")) Then
    '                Session("CycleID") = drdr.Item("CycleID")
    '            Else
    '                Session("CycleID") = 1
    '            End If
    '            If Not IsDBNull(drdr.Item("AssmntTypeID")) Then
    '                Session("AssmntTypeID") = drdr.Item("AssmntTypeID")
    '            Else
    '                Session("AssmntTypeID") = 1
    '            End If
    '            If Not IsDBNull(drdr.Item("EndDate")) Then
    '                Session("EndDate") = drdr.Item("EndDate")
    '            Else
    '                Session("EndDate") = Format(DateTime.Now.Date, "dd-MM-yyyy")
    '            End If
    '            PwdStatus = drdr.Item("PwdStatus")
    '            NodeID = 1 'drdr.item("NodeID")
    '            Session("Flag") = 1

    '            'If Session("RId") = 6 Then
    '            '    If (Session("FullName") = "Soumitra Mukherjee ") Then

    '            '        Response.Redirect("Data/frmMain.aspx")
    '            '    Else
    '            '        Response.Redirect("Data/Welcome.aspx?NodeID=" & NodeID)
    '            '        'Response.Redirect("frmThanks.html")
    '            '    End If

    '            'Else
    '            '    If (Session("FullName") = "Soumitra Mukherjee ") Then

    '            '        Response.Redirect("Data/Welcome.aspx?NodeID=" & NodeID)
    '            '    Else
    '            '        Response.Redirect("Data/Welcome.aspx?NodeID=" & NodeID)
    '            '        'Response.Redirect("frmThanks.html")
    '            '    End If
    '            'End If

    '            If Session("RId") = 6 Then
    '                Response.Redirect("Data/frmMain.aspx")
    '            Else
    '                'Response.Redirect("Data/Welcome.aspx?NodeID=" & NodeID)
    '                Response.Redirect("Data/Instruction.aspx?NodeID=" & NodeID)
    '                ' Response.Redirect("frmDownloadStatusReport.aspx")

    '            End If

    '        End If

    '    Catch ex As Exception
    '        strReturn = ex.Message
    '    Finally
    '        objCom.Dispose()
    '        Objcon.Close()
    '        Objcon.Dispose()
    '    End Try

    'End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function fnLoginFromDB(ByVal UserName As String) As String

        Dim strResponse As String = ""
        strResponse = "1|LoginPageFirst.aspx?Email=" & HttpUtility.HtmlEncode(UserName)


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

End Class


