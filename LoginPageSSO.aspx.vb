Imports System.Web.Security
Imports System.Data.SqlClient
Imports Microsoft.Owin.Security.OpenIdConnect
Imports Microsoft.Owin.Security
Imports System.Data
Imports System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel
Imports Azure.Communication
Imports System.IO

Partial Class LoginPageSSO
    Inherits System.Web.UI.Page
    Dim arrPara(0, 1) As String
    Dim objdr As SqlDataReader
    Dim redirectURL As String = System.Configuration.ConfigurationManager.AppSettings("PostRedirectUri")
    Dim Logpath As String = ""

    'Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
    'If (Request.IsSecureConnection = False Or Request.Url.Port <> 443) Then
    'Response.Redirect("https://www.ruralvistaar.com/frmLogin.aspx")
    'End If
    'End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Logpath = AppDomain.CurrentDomain.BaseDirectory & "\\Logs\\DailyLogs_" & HttpContext.Current.Session.SessionID + "_" & DateTime.Now.ToString("yyyyMMdd") & ".txt"
        If (Request.IsAuthenticated = False) Then
            HttpContext.Current.GetOwinContext().Authentication.Challenge(New AuthenticationProperties With {
            .RedirectUri = redirectURL
            }, OpenIdConnectAuthenticationDefaults.AuthenticationType)
            Return
        Else
            Try


                Dim obj As New clsADUserInfo()
                Dim token As String = obj.fnGetToken().Result
                Dim emailId = HttpContext.Current.GetOwinContext().Authentication.User.FindAll("email").FirstOrDefault.Value
                Using logfile As New StreamWriter(Logpath, True)
                    logfile.WriteLine("Date- " & DateTime.Now.ToString())
                    logfile.WriteLine("Token:" & token)
                End Using
                Dim userEmail As String = obj.fnGetUserDetail().Result
                dvMessage.InnerHtml = emailId & ":" & userEmail
            Catch ex As Exception
                dvMessage.InnerHtml = ex.Message
                Using logfile As New StreamWriter(Logpath, True)
                    logfile.WriteLine("Date- " & DateTime.Now.ToString())
                    logfile.WriteLine("Token:" & ex.Message)
                End Using
            End Try
            'fnSignIn(emailId, "")
        End If
    End Sub
    Private Sub fnSignIn(ByVal emailId As String, ByVal gpId As String)
        Dim strTicket As String
        Dim roleID As String
        Dim PassExpired As String = "0"
        Dim chkRoleID As String = "0"
        Dim PassChangeFirst As String = "0"
        Dim flgAgreementsigned As String = "0"
        Dim varAuthenticate As Boolean = False
        Dim NodeID As Integer = 1
        Dim flgAgreement As String = "0"
        Dim objCon As New SqlConnection
        Dim objCom As New SqlCommand

        objCom.CommandTimeout = 0
        Dim strConn As String = Convert.ToString(HttpContext.Current.Application("DbConnectionString"))
        objCon = New SqlConnection(strConn.Split("|")(0))
        objCom = New SqlCommand("spSecUserLogin", objCon)
        objCom.Parameters.AddWithValue("@UserName", ReplaceQuotes(Trim(HttpUtility.HtmlEncode(emailId))))
        objCom.Parameters.AddWithValue("@Password", ReplaceQuotes(Trim(HttpUtility.HtmlEncode(emailId))))
        objCom.Parameters.AddWithValue("@SessionID", HttpContext.Current.Session.SessionID)
        objCom.Parameters.AddWithValue("@IPAddress", HttpContext.Current.Request.ServerVariables("REMOTE_ADDR"))
        objCom.Parameters.AddWithValue("@BrowserVersion", HttpContext.Current.Request.Browser.Type)
        objCom.Parameters.AddWithValue("@Resolution", "")
        objCom.CommandType = CommandType.StoredProcedure
        objCom.CommandTimeout = 0
        objCon.Open()
        objdr = objCom.ExecuteReader
        If objdr.HasRows Then
            objdr.Read()
            If (objdr("LoginID") = 0) Then
                dvMessage.InnerText = "Invalid Login-Id or Password. Try Again !!"
            Else
                HttpContext.Current.Session("RId") = objdr.Item("RoleID")
                HttpContext.Current.Session("LoginId") = objdr.Item("LoginID")
                HttpContext.Current.Session("FullName") = objdr.Item("FullName")
                HttpContext.Current.Session("NodeId") = objdr.Item("NodeId")
                HttpContext.Current.Session("flgIsManager") = objdr.Item("flgIsManager")
                HttpContext.Current.Session("flgParticipant") = objdr.Item("flgParticipant")
                HttpContext.Current.Session("emailid") = objdr.Item("EmailID")
                HttpContext.Current.Session("function") = Convert.ToString(objdr.Item("Function"))
                HttpContext.Current.Session("Department") = Convert.ToString(objdr.Item("Department"))
                HttpContext.Current.Session("Desgination") = Convert.ToString(objdr.Item("Desgination"))
                HttpContext.Current.Session("RM") = Convert.ToString(objdr.Item("ReportingManager"))
                HttpContext.Current.Session("LevelId") = Convert.ToString(objdr.Item("LevelId"))
                flgAgreement = Convert.ToString(objdr.Item("flgAgreement"))
                If Not IsDBNull(objdr.Item("CycleID")) Then
                    HttpContext.Current.Session("CycleID") = objdr.Item("CycleID")
                Else
                    HttpContext.Current.Session("CycleID") = 1
                End If
                If Not IsDBNull(objdr.Item("AssmntTypeID")) Then
                    HttpContext.Current.Session("AssmntTypeID") = objdr.Item("AssmntTypeID")
                Else
                    HttpContext.Current.Session("AssmntTypeID") = 1
                End If
                If Not IsDBNull(objdr.Item("EndDate")) Then
                    HttpContext.Current.Session("EndDate") = objdr.Item("EndDate")
                Else
                    HttpContext.Current.Session("EndDate") = Format(DateTime.Now.Date, "dd-MM-yyyy")
                End If

                ' makeTicket(strTicket, emailId)
                varAuthenticate = True
            End If
        End If
        objdr.Close()
        objCon.Close()
        objCon.Dispose()
        NodeID = 1 'drdr.item("NodeID")
        HttpContext.Current.Session("Flag") = 1
        Dim strResponse As String = "Data/Instruction.aspx?NodeID=|"
        If Session("flgParticipant").ToString() = 1 Then
            strResponse = "Data/InstructionPage.aspx?NodeID=|"
            'strResponse = "1|Data/frmNominateRater.aspx"  'Response.Redirect("Data/frmMain.aspx")
        ElseIf Session("flgIsManager").ToString() = 1 Then
            strResponse = "Data/InstructionPage.aspx?NodeID=|"
            '  strResponse = "1|Data/frmNominateApproveNomination.aspx"  'Response.Redirect("Data/frmMain.aspx")
        Else
            strResponse = "Data/Instruction.aspx?NodeID=|"

        End If

        Response.Redirect(strResponse)
        If flgAgreement = 1 Then
            Response.Redirect(strResponse)
        Else
            Response.Redirect("Data/frmUndertakingPage.aspx?str=" & strResponse)
        End If


    End Sub


    Private Sub makeTicket(ByVal strTicket As String, ByVal UserName As String)
        Dim objTicket As FormsAuthenticationTicket
        Dim authCookie As HttpCookie
        Dim sessionLength As Integer = System.Configuration.ConfigurationManager.AppSettings("sessionDuration")

        objTicket = New FormsAuthenticationTicket(1, UserName, Date.Now, Date.Now.AddMinutes(sessionLength), False, strTicket)

        authCookie = New HttpCookie(".aspxauth")
        authCookie.Value = FormsAuthentication.Encrypt(objTicket)

        Response.Cookies.Add(authCookie)


    End Sub
    Public Function MakeDate(ByVal DateText As Date) As String
        Return Format(DateText, "dd-MMM-yyyy")
    End Function
    Public Function ReplaceQuotes(ByVal str As String) As String
        Return Replace(str, "'", "''")
    End Function

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)
        Response.Redirect("Login.aspx")
    End Sub
End Class
