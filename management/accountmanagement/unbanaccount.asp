<!-- #include file="../share/connect.asp" -->
<%
    On Error Resume Next
    tk = Request.QueryString("tk")
    if (isnull(tk) OR trim(tk)="" OR isnull(Session("tkmanager")) OR trim(Session("tkmanager"))="") then
        Response.redirect("/management/index.asp")
        Response.End
    end if

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "Update TaiKhoan set TinhTrang = 1 where TK=?"
    cmdPrep.Parameters(0)=tk

    cmdPrep.execute
    connDB.Close()
    If Err.Number = 0 Then
    Session("Success") = "Mở khóa tài khoản thành công"    
    Else
        Session("Error") = Err.Description
    End If
    Response.redirect(session("currentpage"))
    On Error Goto 0    
%>