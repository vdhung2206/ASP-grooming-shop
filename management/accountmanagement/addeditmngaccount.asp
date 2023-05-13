<!-- #include file="../share/connect.asp" -->
<%
dim add
add = true
On Error Resume Next
' handle Error
Sub handleError(message)
    Session("Error") = message
    'send an email to the admin
    'Write the error message in an application error log file
End Sub
    function checkInput(tk,mk,ten,sdt,diachi)
        dim check
        check = false
        for i = 1 to 9 
            if(inStr(mk,cstr(i))) then
            check = true
            exit for
            end if
        next
        errmsg = ""
        if (isnull(tk) or tk="" or isnull(mk) or mk="" or isnull(ten) or ten="" or  isnull(sdt) or sdt="" or isnull(diachi) or diachi="") then
            errmsg = "Hãy nhập đầy đủ thông tin!"
        elseif((len(tk)<6 or len(tk)>25)) then
            errmsg = "Tài khoản phải từ 6 đến 25 kí tự"
        elseif(len(mk)<6) then
            errmsg = "Mật khẩu phải từ 6 kí tự trở lên"
        elseif(check = false) then
            errmsg = "Mật khẩu phải chứa kí tự số"
        elseif(not IsNumeric(sdt) or len(sdt)<>10) then
            errmsg = "Số điện thoại không đúng định dạng"
        else
            errmsg = ""
        end if
        checkInput = errmsg
    end function
    If (isnull(Session("tkmanager")) OR TRIM(Session("tkmanager")) = "") Then
        Response.redirect("login.asp")
    End If
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        tk = Request.QueryString("tk")
        If (isnull(tk) OR trim(tk) = "") then 
            tk="" 
        End if
        If (tk<>"") Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM TaiKhoan WHERE TK=?"
            ' cmdPrep.parameters.Append cmdPrep.createParameter("MaNV",3,1, ,tk)
            cmdPrep.Parameters(0)=tk
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                tk = Result("TK")
                mk = Result("MK")
                ten = Result("Ten")
                sdt = Result("SDT")
                diachi = Result("DiaChi")
            End If

            ' Set Result = Nothing
            Result.Close()
        End If
    Else
        tk = Request.QueryString("tk")
        if (isnull (tk) OR trim(tk) = "") then tk="" end if
        mk = Request.form("mk")
        ten = Request.form("ten")
        sdt = Request.form("sdt")
        diachi = Request.form("diachi")
        if (tk="") then
            tk = request.form("tk")
            dim checkmsg
            checkmsg =checkInput(tk,mk,ten,sdt,diachi)
            if (checkmsg = "") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO TaiKhoan values (?,?,?,?,1,1,null,?)"
                cmdPrep.Parameters(0)=tk
                cmdPrep.Parameters(1)=mk
                cmdPrep.Parameters(2)=ten
                cmdPrep.Parameters(3)=sdt
                cmdPrep.Parameters(4)=diachi
                cmdPrep.execute               
                If Err.Number = 0 Then 
                ' Set rs = connDB.execute("SELECT @@tkENTITY AS Newtk")
                '     Response.write(rs("Newtk"))  
                    Session("Success") = "Tạo tài khoản thành công!"                    
                    Response.redirect("mngaccount.asp")
                Else
                    Err.Description = "Tên tài khoản đã tồn tại!"
                    handleError(Err.Description)
                End If
                On Error GoTo 0
            else
                Session("Error") = checkmsg
            end if
        else
            if (NOT isnull(mk) and mk<>"" and NOT isnull(ten) and ten<>"" and NOT isnull(sdt) and sdt<>""and NOT isnull(diachi) and diachi<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE TaiKhoan SET MK=?,Ten=?,SDT=?,DiaChi=? WHERE TK=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("mk",202,1,255,mk)
                cmdPrep.parameters.Append cmdPrep.createParameter("ten",202,1,255,ten)
                cmdPrep.parameters.Append cmdPrep.createParameter("sdt",202,1,255,sdt)
                cmdPrep.parameters.Append cmdPrep.createParameter("diachi",202,1,255,diachi)
                cmdPrep.parameters.Append cmdPrep.createParameter("tk",202,1,255,tk)
                cmdPrep.execute
                If Err.Number=0 Then
                    Session("Success") = "Chỉnh sửa thông tin thành công!"
                    Response.redirect("mngaccount.asp")
                Else
                    handleError(Err.Description)
                End If
                On Error Goto 0
            else
                Session("Error") = "Hãy nhập đầy đủ các thông tin!"
            end if
        end if
    End If    
%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="wtkth=device-wtkth,initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <title>CRUD Example</title>
    </head>
    <body>
        <!-- #include file="../share/header.asp"-->
        <div class="container">
            <form method="post">
                <div class="mb-3">
                    <label for="name" class="form-label">Tài khoản</label>
                    <input type="text" class="form-control" id="tk" name="tk" value="<%=tk%>">
                </div>
                <div class="mb-3">
                    <label for="hometown" class="form-label">Mật khẩu</label>
                    <input type="text" class="form-control" id="mk" name="mk" value="<%=mk%>">
                </div>
                <div class="mb-3">
                    <label for="hometown" class="form-label">Tên người dùng</label>
                    <input type="text" class="form-control" id="ten" name="ten" value="<%=ten%>">
                </div>
                <div class="mb-3">
                    <label for="hometown" class="form-label">Số điện thoại</label>
                    <input type="text" class="form-control" id="sdt" name="sdt" value="<%=sdt%>">
                </div>
                <div class="mb-3">
                    <label for="hometown" class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" id="diachi" name="diachi" value="<%=diachi%>">
                </div>            
                <button type="submit" class="btn btn-primary">
                    <%
                        if (Request.QueryString("tk")="") then
                            Response.write("Add")
                        else
                            Response.write("Edit")
                        end if
                    %>
                </button>
                <a href="mngaccount.asp" class="btn btn-info">Cancel</a>           
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    </body>
</html>