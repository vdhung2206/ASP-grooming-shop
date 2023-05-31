<!--#include file="../models/giamgia.asp" -->
<%
    loai = request.querystring("loai")
    if(loai = "") then
        loai = request.form("loai")
    end if
    Set danhsachgiamgia = Server.CreateObject("Scripting.Dictionary")
    if(loai="taochuongtrinhgiamgiakhachhang") then
        magg = request.form("magg")
        tengg = request.form("tengg")
        tichdiemgg = request.form("tichdiemgg")
        sotiengg = request.form("sotiengg")
        phantramgg= request.form("phantramgg")
        ngaybatdaugg= request.form("ngaybatdaugg")
        ngayketthucgg= request.form("ngayketthucgg")
        response.write("{")
        
        if(magg<>"") then
            if(tengg<>"") then
                if(tichdiemgg<>"" and IsNumeric(tichdiemgg) and tichdiemgg>0) then
                    if not( sotiengg<>"" and phantramgg<>"") then
                        if(sotiengg<>"") then
                            call gg.ggKhachHang(magg,tengg,tichdiemgg,ngaybatdaugg,ngayketthucgg,phantramgg,sotiengg)
                            Response.Write("""status code"": ""101"",")
                            Response.Write("""message"": ""Thành công!"",")
                            Response.Write("""data"":{ ""themGiamGia"": true}")
                        end if
                        if(phantramgg<>"") then
                            call gg.ggKhachHang(magg,tengg,tichdiemgg,ngaybatdaugg,ngayketthucgg,phantramgg,sotiengg)
                            Response.Write("""status code"": ""101"",")
                            Response.Write("""message"": ""Thành công!"",")
                            Response.Write("""data"":{ ""themGiamGia"": true}")
                        end if
                    else
                        Response.Write("""status code"": ""101"",")
                        Response.Write("""message"": ""Chỉ được chọn một trong hai hình thức giảm giá!"",")
                        Response.Write("""data"":{ ""themGiamGia"": false}")
                    end if
                else
                    Response.Write("""status code"": ""101"",")
                    Response.Write("""message"": ""Tích điểm không hợp lệ"",")
                    Response.Write("""data"":{ ""themGiamGia"": false}")
                end if
            else
                Response.Write("""status code"": ""101"",")
                Response.Write("""message"": ""Tên giảm giá không được trống!"",")
                Response.Write("""data"":{ ""themGiamGia"": false}")
            end if
        else
            Response.Write("""status code"": ""101"",")
            Response.Write("""message"": ""Mã giảm giá không được trống!"",")
            Response.Write("""data"":{ ""themGiamGia"": false}")
        end if
        response.write("}")

        set gg = new GiamGia
    end if

    if(loai="taochuongtrinhgiamgiasanpham") then
        magg = request.form("magg")
        tengg = request.form("tengg")
        sotiengg = request.form("sotiengg")
        phantramgg= request.form("phantramgg")
        ngaybatdaugg= request.form("ngaybatdaugg")
        ngayketthucgg= request.form("ngayketthucgg")
        listspgg = request.form("listspgg")
        set gg = new GiamGia
        dim idgiamgia
        idgiamgia = gg.ggKhachHang(magg,tengg,"null",ngaybatdaugg,ngayketthucgg,phantramgg,sotiengg)
        a = Split(listspgg,",")
        for each x in a
           call gg.suaChiTietGiamGia(Cstr(idgiamgia),Cstr(x))
        next
        response.write("{")
        Response.Write("""status code"": ""101"",")
        Response.Write("""message"": ""Thành công!"",")
        Response.Write("""data"":{ ""themGiamGia"": true}")
        response.write("}")
    end if

    if(loai="laydanhsachgiamgia") then
        set gg = new GiamGia
        magg = request.querystring("magg")
        tengg = request.querystring("tengg")
        batdautruoc = request.querystring("batdautruoc")
        batdautu = request.querystring("batdautu")
        ketthuctruoc = request.querystring("ketthuctruoc")
        ketthuctu = request.querystring("ketthuctu")
        tichdiem1 = request.querystring("tichdiem1")
        tichdiem2 = request.querystring("tichdiem2")
        tinhtrang = request.querystring("tinhtrang")
        set danhsachgiamgia = gg.getList(magg,tengg,batdautruoc,batdautu,ketthuctruoc,ketthuctu,tichdiem1,tichdiem2,tinhtrang)
        Response.Write("{")
        Response.Write("""status code"": ""6"",")
        Response.Write("""message"": """",")
        Response.Write("""data"":{ ""danhsachgiamgia"": [")
        dim count 
        count = 0
        for each z in danhsachgiamgia
            count = count + 1
            Response.Write("{")
            Response.Write("")
            response.write("""id"": """)
            response.write(danhsachgiamgia(z).Id)
            response.write(""",")
            response.write("""magg"": """)
            response.write(danhsachgiamgia(z).MaGG)
            response.write("""")
            response.write(",")
            response.write("""tengg"": """)
            response.write(danhsachgiamgia(z).TenGG)
            response.write("""")
            response.write(",")
            response.write("""dkkhachhang"": """)
            response.write(danhsachgiamgia(z).DieuKienKH)
            response.write("""")
            response.write(",")
            response.write("""batdau"": """)
            response.write(danhsachgiamgia(z).BatDau)
            response.write("""")
            response.write(",")
            response.write("""ketthuc"": """)
            response.write(danhsachgiamgia(z).KetThuc)
            response.write("""")
            response.write(",")
            response.write("""phantramgg"": """)
            response.write(danhsachgiamgia(z).PhanTramGG)
            response.write("""")
            response.write(",")
            response.write("""sotiengg"": """)
            response.write(danhsachgiamgia(z).SoTienGG)
            response.write("""")
            Response.Write("}")
            if(count < danhsachgiamgia.count) then
                response.write(",")
            end if
        next
        Response.Write("]")
        Response.Write(",""minTichDiem"":")
        Response.Write(gg.minTichDiem())
        Response.Write("")
        Response.Write(",""maxTichDiem"":")
        Response.Write(gg.maxTichDiem)
        Response.Write("}")
        Response.Write("}")
    end if

%>