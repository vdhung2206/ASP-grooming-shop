<!-- #include file="share/connect.asp" -->
<%
session("count") =0
dim tk,mk
tk = request.form("tk")
mk = request.form("mk")
If (NOT isnull(tk) AND NOT isnull(mk) AND TRIM(tk)<>"" AND TRIM(mk)<>"") Then
    Dim sql
    sql = "select * from TaiKhoan where TK=? and MK=?"
    Dim cmdPrep
    set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType=1
    cmdPrep.Prepared=true
    cmdPrep.CommandText = sql
    cmdPrep.Parameters(0)=tk
    cmdPrep.Parameters(1)=mk
    Dim result
    set result = cmdPrep.execute()
    If(not result.EOF) Then
        if(result("LoaiTK")=0) then
            if(result("TinhTrang")=true) then
                ' dang nhap thanh cong
                Session("tkcustomer")=result("tk")
                Session("Success")="Đăng nhập thành công"
                Dim carts(2)
                carts(0)=5
                carts(1)=10
                carts(2)=15
                Session("s_Carts") = carts
                Response.redirect("index.asp")
            Else
                Session("Error") = "Tài khoản của bạn đang bị khóa!"
            end if
        else
            Session("Error") = "Loại tài khoản không đúng!"
        end if
    Else
        ' dang nhap ko thanh cong
        Session("Error") = "Sai tên đăng nhập hoặc mật khẩu!"
    End if
    result.Close()
    connDB.Close()
Else
    ' Kiem tra vi co the trung voi truong hop logout
    If (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
        Session("Error")="Hãy nhập tên đăng nhập và mật khẩu."
    End if
End if
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://use.fontawesome.com/releases/v5.0.4/css/all.css" rel="stylesheet">  
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <title>Document</title>
</head>
    <body>        
        <!-- #include file="share/header.asp" -->
        <div class="container w-25 mt-4">
            <form method="post" action="login.asp">
                <div class="mb-3">
                    <label for="tk" class="form-label">Tên đăng nhập</label>
                    <input type="text" class="form-control" id="tk" name="tk" value="<%=tk%>">
                </div>
                <div class="mb-3">
                    <label for="mk" class="form-label">Mật khẩu</label>
                    <input type="password" class="form-control" id="tk" name="mk">
                </div>
                <div class="row px-2 mt-4"> 
                <button type="submit" class="btn btn-primary">Login</button>
                </div>
            </form>
        </div>
        <!-- #include file="share/footer.asp" -->
    </body>
</html>