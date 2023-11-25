<!-- #include file="../share/connect.asp" -->
<%
if(Request.ServerVariables("request_method")="POST") then
if(session("count")<>0) then
dim tkregister, mkregister, mkconfirm, fname, address, sdt
tkregister= request.form("tkregister")
mkregister= request.form("mkregister")
mkconfirm= request.form("mkconfirm")
fname= request.form("fname")  
address= request.form("address")
sdt = request.form("sdt")
dim check
check = false
        for i = 1 to 9 
            if(inStr(mkregister,cstr(i))) then
            check = true
            exit for
            end if
        next
dim checkexist 
checkexist = false
dim sql
sql = "select * from TaiKhoan where TK=?"
dim cmdPrep
    set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType=1
    cmdPrep.Prepared=true
    cmdPrep.CommandText = sql
    cmdPrep.Parameters(0)=tkregister
    Dim result
    set result = cmdPrep.execute()
    If not result.EOF Then
    checkexist = true
    end if
    result.Close()
    connDB.Close()
    if(TRIM(tkregister)="" or trim(mkregister)="" or trim(mkconfirm)="" or trim(fname)= "" or trim(address)="" or trim(sdt)="") then
    session("error")= "Hãy nhập đầy đủ các thông tin"
    elseif((len(tkregister)<6 or len(tkregister)>25)) then
        Session("error") = "Tên đăng nhập phải từ 6 đến 25 kí tự"
    elseif(checkexist) then
        session("error") = "Tên tài khoản đã tồn tại"
    elseif(len(mkregister)<6) then
        Session("error") = "Mật khẩu phải từ 6 kí tự trở lên"
    elseif(check = false) then
        Session("error") ="Mật khẩu phải chứa kí tự số"
    elseif(not strcomp(mkregister,mkconfirm)=0) then
        Session("error") = "Mật khẩu và xác nhận mật khẩu không khớp"
    elseif(not IsNumeric(sdt) or len(sdt)<>10) then
        session("error") = "Số điện thoại không đúng định dạng"
    else
        dim sql1
        sql1 = "insert into TaiKhoan values(?,?,?,?,0,1,0,?)"
        Dim cmdPrep1
        set cmdPrep1 = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep1.ActiveConnection = connDB
        cmdPrep1.CommandType=1
        cmdPrep1.Prepared=true
        cmdPrep1.CommandText = sql1
        cmdPrep1.Parameters(0)=tkregister
        cmdPrep1.Parameters(1)=mkregister
        cmdPrep1.Parameters(2)=fname
        cmdPrep1.Parameters(3)=sdt
        cmdPrep1.Parameters(4)=address
        cmdPrep1.execute()
        session("taikhoan") = tkregister
        session("success") ="Đăng ký thành công"
        response.redirect("loginkhachhang-view.asp")
        connDB.Close()
    end if
end if
end if
session("count") = 1
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
    <!-- #include file="../share/headerkhachhang.html"-->
<div class="container w-50 mt-4">
            <form method="post" action="dangky.asp">
                <input type="hidden" id="role" value="<%=session("error")%>"/>
                <div class="mb-3">
                    <label for="tkregister" class="form-label">Tên đăng nhập</label>
                    <input type="text" class="form-control" id="tkregister" name="tkregister" value="<%=tkregister%>" placeholder="Tên đăng nhập (từ 6-25 kí tự)">
                </div>
                <div class="mb-3">
                    <label for="mkregister" class="form-label">Mật khẩu</label>
                    <input type="password" class="form-control" id="mkregister" name="mkregister" value="<%=mkregister%>" placeholder="Mật khẩu (từ 6 kí tự trở lên, phải có kí tự số)">
                </div>
                <div class="mb-3">
                    <label for="mkconfirm" class="form-label">Xác nhận mật khẩu</label>
                    <input type="password" class="form-control" id="mkconfirm" name="mkconfirm" value="<%=mkconfirm%>" >
                </div>
                <div class="mb-3">
                    <label for="fname" class="form-label">Tên người dùng</label>
                    <input type="text" class="form-control" id="fname" name="fname" value="<%=fname%>">
                </div>     
                <div class="mb-3">
                    <label for="sdt" class="form-label">Số điện thoại</label>
                    <input type="text" class="form-control" id="sdt" name="sdt" placeholder="VD: 0123456789" value="<%=sdt%>">
                </div>     
                <div class="mb-3">
                    <label for="address" class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" id="address" name="address" placeholder="Có thể cập nhật lại sau khi đăng ký" value="<%=address%>">
                </div>            
                <div class="row px-2 mt-4"> 
                <button type="submit" class="btn btn-primary">Đăng ký</button>
                </div>
            </form>
        </div>
        <script>
            var msg= document.getElementById("role").getAttribute("value")
            if(msg !=""){
                addAlertDanger(msg)
            }
             function addAlertDanger(msg) {
                $("#msg").addClass("alert alert-danger mt-2");
                $("#msg").html(msg);
                $(".alert").fadeTo(500, 1).slideDown(500, function () {
                });
                window.setTimeout(function () {
                    $(".alert").fadeTo(500, 0).slideUp(500, function () {
                    });
                }, 2000);
            }
        </script>
</body>
</html>