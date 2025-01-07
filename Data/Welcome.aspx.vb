
Partial Class _Welcome
    Inherits Page

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim panelLogout As Panel
        panelLogout = DirectCast(Page.Master.FindControl("panelLogout"), Panel)
        panelLogout.Visible = False
    End Sub
    Protected Sub btnContiue_Click(sender As Object, e As EventArgs) Handles btnContiue.Click
        Response.Redirect("Instruction.aspx")
    End Sub
End Class