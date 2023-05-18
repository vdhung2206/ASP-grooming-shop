
<!--#include file="./models/taiKhoan.asp" -->
<%  
    'status code 1: dang nhap thanh cong
    'status code 2: sai mat khau
    'status code 3: sai loai tai khoan
    'status code 4: tai khoan khong ton tai
    'status code 5: tai khoan dang bi khoa
    'status code 6: lay danh sach tai khoan phan trang
    'status code 7: tai khoan khong dung dinh dang (tao moi tai khoan quan ly)
    'status code 8: mat khau khong dung dinh dang (tao moi tai khoan quan ly)
    'status code 9: so dien thoai khong dung dinh dang (tao moi tai khoan quan ly)
    'status code 10: tai khoan da ton tai (tao moi tai khoan quan ly)
    'status code 11 : tao tai khoan thanh cong (tao moi tai khoan quan ly)


    loai = request.querystring("loai")
    if(loai = "") then
        loai = request.form("loai")
    end if
    dim page 
    Set danhsachtaikhoan = Server.CreateObject("Scripting.Dictionary")
    limit = 10
    
    if(loai = "phantrangtaikhoan") then
        set tk = new TaiKhoan
        loaitk = request.querystring("loaitk")
        page = request.querystring("page")
        taikhoansearch = request.querystring("taikhoan")
        tennguoidung = request.querystring("tennguoidung")
        diachi = request.querystring("diachi")
        sodienthoai = request.querystring("sodienthoai")
        tichdiem = request.querystring("tichdiem")
        trangthai = request.querystring("trangthai")
        sapxepten = request.querystring("sapxepten")
        sapxeptichdiem = request.querystring("sapxeptichdiem")
        sapxepdiachi = request.querystring("sapxepdiachi")
        set danhsachtaikhoan = tk.phanTrangTaiKhoan(loaitk,limit,page,taikhoansearch,tennguoidung,diachi,sodienthoai,tichdiem,trangthai,sapxepten,sapxepdiachi,sapxeptichdiem)
        Response.Write("{")
        Response.Write("""status code"": ""6"",")
        Response.Write("""message"": """",")
        Response.Write("""data"":{ ""danhsachtaikhoan"": [")
        dim count 
        count = 0
        for each z in danhsachtaikhoan
            count = count + 1
            Response.Write("{")
            Response.Write("")
            response.write("""taikhoan"": """)
            response.write(danhsachtaikhoan(z).Tk)
            response.write(""",")
            response.write("""ten"": """)
            response.write(danhsachtaikhoan(z).Ten)
            response.write("""")
            response.write(",")
            response.write("""sdt"": """)
            response.write(danhsachtaikhoan(z).Sdt)
            response.write("""")
            response.write(",")
            response.write("""tinhtrang"": """)
            response.write(danhsachtaikhoan(z).Tinhtrang)
            response.write("""")
            response.write(",")
            response.write("""tichdiem"": """)
            response.write(danhsachtaikhoan(z).Tichdiem)
            response.write("""")
            response.write(",")
            response.write("""diachi"": """)
            response.write(danhsachtaikhoan(z).Diachi)
            response.write("""")
            Response.Write("}")
            if(count < danhsachtaikhoan.count) then
                response.write(",")
            end if

        next
        Response.Write("]")
        Response.Write(",""totalPages"":")
        Response.Write(tk.Ceil(tk.count(loaitk,taikhoansearch,tennguoidung,diachi,sodienthoai,tichdiem,trangthai)/limit))
        Response.Write("")
        Response.Write("}")
        Response.Write("}")
    end if

    if(loai = "phantrangtaikhoanquanly") then
        set tk = new TaiKhoan
        Set danhsachtaikhoan = Server.CreateObject("Scripting.Dictionary")
        page = request.querystring("page")
        set danhsachtaikhoan = tk.phanTrangTaiKhoanQuanLy(offset,limit,page)
    end if

    if(loai = "unban") then
        set tk = new TaiKhoan
        set tentk= Request.querystring("tk")
        tk.moKhoaTaiKhoan(tentk)       
    end if

    if(loai = "ban") then
        set tk = new TaiKhoan
        set tentk= Request.querystring("tk")
        tk.khoaTaiKhoan(tentk)       
    end if

    If (loai="admindangnhap") Then
    Set classtk = New TaiKhoan
    dim tk
    tk = Request.querystring("tk")
    dim mk
    mk = Request.querystring("mk")
    Response.Write("{")
    If (classtk.checkTonTai(tk)) Then
        If (classtk.getLoaiTK(tk) <> "0") Then
            If(classtk.getTinhTrang(tk) = True) Then
                If(classtk.checkMK(tk,mk)) Then
                    session("loaitk") = classtk.getLoaiTK(tk)
                    Session("uid") = classtk.getUID(tk)
                    Response.Write("""status code"": ""1"",")
                    Response.Write("""message"": """",")
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

    if(loai ="taotaikhoanquanly") then
        Set classtk = New TaiKhoan
        dim tkqldangky
        tkqldangky = Request.form("tkqldangky")
        dim mkqldangky
        mkqldangky = Request.form("mkqldangky")
        dim tenqldangky
        tenqldangky = Request.form("tenqldangky")
        dim sdtqldangky
        sdtqldangky = Request.form("sdtqldangky")
        dim diachiqldangky
        diachiqldangky = Request.form("diachiqldangky")
        Response.Write("{")
        If not (classtk.checkTonTai(tkqldangky)) then 
            If (classtk.kiemTraDinhDangTK(tkqldangky)) Then
                If (classtk.kiemTraDinhDangMK(mkqldangky)) Then
                    If(classtk.kiemTraDinhDangSDT(sdtqldangky)) Then
                        call classtk.taoTaiKhoanQuanLy(tkqldangky, mkqldangky, sdtqldangky, tenqldangky, diachiqldangky)
                        Response.Write("""status code"": ""11"",")
                        Response.Write("""message"": ""Tạo tài khoản thành công!"",")
                        Response.Write("""data"":{ ""checkCreate"": true}")
                    Else
                        Response.Write("""status code"": ""9"",")
                        Response.Write("""message"": ""Số điện thoại không đúng định dạng!"",")
                        Response.Write("""data"":{ ""checkCreate"": false}")
                    End if
                Else
                    Response.Write("""status code"": ""8"",")
                    Response.Write("""message"": ""Mật khẩu sai định dạng!"",")
                    Response.Write("""data"":{ ""checkCreate"": false}")
                End If
            Else
                Response.Write("""status code"": ""7"",")
                Response.Write("""message"": ""Tài khoản không đúng định dạng!"",")
                Response.Write("""data"":{ ""checkCreate"": false}")
            End If
        Else
            Response.Write("""status code"": ""10"",")
            Response.Write("""message"": ""Tài khoản đã tồn tại!"",")
            Response.Write("""data"":{ ""checkCreate"": false}")
        end if
        Response.Write("}")
    end if
%>  