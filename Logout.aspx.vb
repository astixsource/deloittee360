﻿Imports System.Data.SqlClient
Imports System.Web.Security
Imports System.Web
Partial Class frmLogout
    Inherits System.Web.UI.Page
    Dim arrPara(0, 1) As String

    Dim objCon As SqlConnection
    Dim objCom As SqlCommand
    Dim objADO As New clsConnection.clsConnection()
    Public lngID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Try
        '    ReDim arrPara(0, 1)
        '    arrPara(0, 0) = Session("LoginId")
        '    arrPara(0, 1) = 1
        '    objCon = New SqlConnection
        '    objCom = New SqlCommand
        '    objADO.RunSP("SPKillInActiveSessions", arrPara, 1, objCon, objCom)
        'Catch
        'Finally
        '    objADO.CloseConnection(objCon, objCom)
        'End Try
        'FormsAuthentication.SignOut()
        Session("LoginID") = DBNull.Value
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1))
        Response.Cache.SetNoStore()
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "popup", "<script language='javascript'>FnLogOut();</script>")

    End Sub
End Class
