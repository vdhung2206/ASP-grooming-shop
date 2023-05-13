<!--#include file="./models/taiKhoan.asp" -->
<%  
    'status code 1: dang nhap thanh cong
    'status code 2: sai mat khau
    'status code 3: sai loai tai khoan
    'status code 4: tai khoan khong ton tai
    'status code 5: tai khoan dang bi khoa
    loai = request.Form("loai")
    dim page 
    Set danhsachtaikhoan = Server.CreateObject("Scripting.Dictionary")
    limit = 10
    
    if(loai = "phantrangtaikhoan") then
        page = request.form("page")
        set danhsachtaikhoan = tk.phanTrangTaiKhoan(offset,limit,page)
    end if

    if(loai = "phantrangtaikhoanquanly") then
        Set danhsachtaikhoan = Server.CreateObject("Scripting.Dictionary")
        page = request.form("page")
        set danhsachtaikhoan = tk.phanTrangTaiKhoanQuanLy(offset,limit,page)
    end if

    if(loai = "unban") then
        set tk = new TaiKhoan
        set tentk= Request.Form("tk")
        tk.moKhoaTaiKhoan(tentk)       
    end if

    if(loai = "ban") then
        set tk = new TaiKhoan
        set tentk= Request.Form("tk")
        tk.khoaTaiKhoan(tentk)       
    end if

    If (loai = "admindangnhap") Then
    Set classtk = New TaiKhoan
    dim tk
    tk = Request.Form("tk")
    dim mk
    mk = Request.Form("mk")
    Response.Write("{")
    If (classtk.checkTonTai(tk)) Then
        If (classtk.getLoaiTK(tk) <> "0") Then
            If(classtk.getTinhTrang(tk) = True) Then
                If(classtk.checkMK(tk,mk)) Then
                    Response.Write("""status code"": ""1"",")
                    Response.Write("""message"": ""Đăng nhập thành công!"",")
                    Response.Write("""data"":{ ""checkLogin"": true}")
                Else
                    Response.Write("""status code"": ""2"",")
                    Response.Write("""message"": ""Sai mật khẩu!"",")
                    Response.Write("""data"":{ ""checkLogin"": false}")
                End If
            Else
                Response.Write("""status code"": ""3"",")
                Response.Write("""message"": ""Tài khoản của bạn đang bị khóa!"",")
                Response.Write("""data"":{ ""checkLogin"": false}")
            End if
        Else
            Response.Write("""status code"": ""4"",")
            Response.Write("""message"": ""Sai loại tài khoản!"",")
            Response.Write("""data"":{ ""checkLogin"": false}")
        End If
    Else
        Response.Write("""status code"": ""5"",")
        Response.Write("""message"": ""Tài khoản không tồn tại!"",")
        Response.Write("""data"":{ ""checkLogin"": false}")
    End If
    Response.Write("}")
    End If

%>  