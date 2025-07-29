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



    Dim Email As String
    Dim strLocalIP As String
    Dim drdr As SqlDataReader
    Dim objCon As SqlConnection
    Dim objCom As SqlCommand
    Dim _tenantId As String = ConfigurationManager.AppSettings("_tenantId")
    Dim _clientId As String = ConfigurationManager.AppSettings("_clientId")

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load, Me.Load
        'btnLogin.Attributes.Add("onclick", "javascript:return fnValidate()")
        If Page.IsPostBack = False Then
            Session("LoginID") = DBNull.Value
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1))
            Response.Cache.SetNoStore()

            Email = Request.QueryString("Email")
            hdnEmailId.Value = Email.ToString()

            hiddenCSRFToken.Value = Guid.NewGuid().ToString()
            Session("CSRFToken") = hiddenCSRFToken.Value
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

    Public Shared Function HashData(ByVal input As String) As String
        Using sha256 As System.Security.Cryptography.SHA256 = sha256.Create()
            Dim bytes As Byte() = sha256.ComputeHash(Encoding.UTF8.GetBytes(input))
            Return BitConverter.ToString(bytes).Replace("-", "").ToLower()
        End Using
    End Function
    Public Shared Function DecodeBase64(ByVal base64Encoded As String) As String
        Dim base64Bytes As Byte() = Convert.FromBase64String(base64Encoded)
        Return Encoding.UTF8.GetString(base64Bytes)
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function fnLoginFromDB(ByVal UserName As String, ByVal Password As String) As String
        Dim Objcon2 As SqlConnection
        Dim objCom2 As SqlCommand
        Dim strResponse As String = ""
        Try

            Dim csrfTokenFromHeader = HttpContext.Current.Request.Headers("X-CSRF-Token")
            Dim csrfTokenFromSession = Convert.ToString(HttpContext.Current.Session("CsrfToken"))
            If (String.IsNullOrEmpty(csrfTokenFromHeader) Or csrfTokenFromHeader <> csrfTokenFromSession) Then
                strResponse = "2|Error : Invalid CSRF Token !!!"
                Return strResponse
            End If

            UserName = DecodeBase64(UserName)
            Password = DecodeBase64(Password)
            'Dim strTokens = mydivant.InnerHtml
            'AntiForgery.Validate(strTokens.Split(":")(0), strTokens.Split(":")(1))
            'AntiForgery.Validate()

            Dim PassChangeFirst As String = "0"
                Dim flgAgreementsigned As String = "0"
                Dim chkRoleID As String = "0"
                Dim varAuthenticate As Boolean = False
                Dim NodeID As Integer = 1
                Dim flgAgreement As String = "0"
                Dim strConn As String = Convert.ToString(HttpContext.Current.Application("DbConnectionString"))
                Objcon2 = New SqlConnection(strConn.Split("|")(0))
                objCom2 = New SqlCommand("spSecUserLogin", Objcon2)
                objCom2.Parameters.AddWithValue("@UserName", ReplaceQuotes(Trim(HttpUtility.HtmlEncode(UserName))))
                objCom2.Parameters.AddWithValue("@Password", ReplaceQuotes(Trim(HttpUtility.HtmlEncode(Password))))
                objCom2.Parameters.AddWithValue("@SessionID", HttpContext.Current.Session.SessionID)
                objCom2.Parameters.AddWithValue("@IPAddress", HttpContext.Current.Request.ServerVariables("REMOTE_ADDR"))
                objCom2.Parameters.AddWithValue("@BrowserVersion", HttpContext.Current.Request.Browser.Type)
                objCom2.Parameters.AddWithValue("@Resolution", "")
                objCom2.CommandType = CommandType.StoredProcedure
                objCom2.CommandTimeout = 0
                Dim drdr As SqlDataReader
                Dim cycleName As String = ""

                'Objcon2.AccessToken = clsAccesstoken.getazureAccessToken()
                Objcon2.Open()
                drdr = objCom2.ExecuteReader
                drdr.Read()
                If (drdr.Item("LoginID") = 0) Then
                    strResponse = "2|Invalid Login-Id or Password. Try Again !!"
                Else
                    HttpContext.Current.Session("RId") = drdr.Item("RoleID")
                    HttpContext.Current.Session("LoginId") = drdr.Item("LoginID")
                    HttpContext.Current.Session("FullName") = drdr.Item("FullName")
                    HttpContext.Current.Session("NodeId") = drdr.Item("NodeId")
                    HttpContext.Current.Session("flgIsManager") = drdr.Item("flgIsManager")
                    HttpContext.Current.Session("flgParticipant") = drdr.Item("flgParticipant")
                    HttpContext.Current.Session("emailid") = drdr.Item("EmailID")
                'HttpContext.Current.Session("function") = Convert.ToString(drdr.Item("Function"))
                HttpContext.Current.Session("function") = Convert.ToString(drdr.Item("Business"))

                HttpContext.Current.Session("Department") = Convert.ToString(drdr.Item("Department"))

                'HttpContext.Current.Session("Desgination") = Convert.ToString(drdr.Item("Desgination"))
                HttpContext.Current.Session("Desgination") = Convert.ToString(drdr.Item("Grade"))



                HttpContext.Current.Session("RM") = Convert.ToString(drdr.Item("ReportingManager"))
                HttpContext.Current.Session("LevelId") = Convert.ToString(drdr.Item("LevelId"))
                HttpContext.Current.Session("IsNominationSubmissionEnable") = Convert.ToString(drdr.Item("IsNominationSubmissionEnable"))
                HttpContext.Current.Session("IsApprovalEnable") = Convert.ToString(drdr.Item("IsApprovalEnable"))
                HttpContext.Current.Session("flgDisable360Process") = drdr.Item("flgDisable360Process").ToString()
                HttpContext.Current.Session("NominationRatersDate") = drdr.Item("NominationRatersDate").ToString()
                HttpContext.Current.Session("ApproverRatersDate") = drdr.Item("ApproverRatersDate").ToString()
                HttpContext.Current.Session("SurveyCompletionDate") = drdr.Item("SurveyCompletionDate").ToString()
                flgAgreement = Convert.ToString(drdr.Item("flgAgreement"))
                    If Not IsDBNull(drdr.Item("CycleID")) Then
                        HttpContext.Current.Session("CycleID") = drdr.Item("CycleID")
                    Else
                        HttpContext.Current.Session("CycleID") = 1
                    End If
                    If Not IsDBNull(drdr.Item("AssmntTypeID")) Then
                        HttpContext.Current.Session("AssmntTypeID") = drdr.Item("AssmntTypeID")
                    Else
                        HttpContext.Current.Session("AssmntTypeID") = 1
                    End If
                    If Not IsDBNull(drdr.Item("EndDate")) Then
                        HttpContext.Current.Session("EndDate") = drdr.Item("EndDate")
                    Else
                        HttpContext.Current.Session("EndDate") = Format(DateTime.Now.Date, "dd-MM-yyyy")
                    End If
                    NodeID = 1 'drdr.item("NodeID")
                    HttpContext.Current.Session("Flag") = 1
                    strResponse = drdr.Item("RoleID").ToString()

                    If drdr.Item("flgParticipant").ToString() = 1 Then
                        strResponse = "1|Data/InstructionPage.aspx?NodeID=|" + flgAgreement
                        'strResponse = "1|Data/frmNominateRater.aspx"  'Response.Redirect("Data/frmMain.aspx")
                    ElseIf drdr.Item("flgIsManager").ToString() = 1 Then
                        strResponse = "1|Data/InstructionPage.aspx?NodeID=|" + flgAgreement
                        '  strResponse = "1|Data/frmNominateApproveNomination.aspx"  'Response.Redirect("Data/frmMain.aspx")
                    ElseIf drdr.Item("flgIsAdmin").ToString() = 1 Then
                        strResponse = "1|AdminReports/AdminDashboard.aspx?NodeID=|" + flgAgreement
                        '  strResponse = "1|Data/frmNominateApproveNomination.aspx"  'Response.Redirect("Data/frmMain.aspx")
                    Else
                        strResponse = "1|Data/Instruction.aspx?NodeID=|" + flgAgreement
                        'strResponse = "1|Data/Dashboard.aspx?NodeID="

                    End If

                End If
                drdr = Nothing
                objCom2.Dispose()
                Objcon2.Close()
                Objcon2.Dispose()

        Catch ex As Exception
            strResponse = "2|Error : " & ex.Message
        Finally


        End Try

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


