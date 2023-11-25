<!--#include file="../models/donhang.asp" -->
<%
    ' status code 30: Lay danh sach loai san pham thanh cong
    ' status code 30: Lay danh sach danh muc thanh cong
    loai = request.querystring("loai")
    if(loai = "") then
        loai = request.form("loai")
    end if
    madm = request.querystring("madm")
    page = request.querystring("page")
    Set danhsachdonhang = Server.CreateObject("Scripting.Dictionary")
    limit = 6
    
    if(Loai="thaotacdonhang") then
        madh = request.form("madh")
        set classdh = new DonHang
        call classdh.thaotacdonhang(madh)
    end if

    if(Loai="huydonhang") then
        madh = request.form("madh")
        set classdh = new DonHang
        call classdh.huydonhang(madh)
    end if

    if(loai="laythongtindonhang") then
        madh = request.queryString("madh")
        set classdh = new DonHang
        dim dh
        set dh= classdh.layThongTinDonHang(madh)
        Response.Write("{")
        Response.Write("""status code"": ""201"",")
        Response.Write("""message"": """",")
        Response.Write("""data"":")
        response.Write("{")
        response.Write("")
        response.write("""madh"": """)
        response.write(dh.Madh)
        response.write(""",")
        response.Write("")
        response.write("""tk"": """)
        response.write(dh.Tk)
        response.write(""",")
        response.write("""tennguoinhan"": """)
        response.write(dh.Tennguoinhan)
        response.write(""",")
        response.write("""sdtnguoinhan"": """)
        response.write(dh.Sdtnguoinhan)
        response.write("""")
        response.write(",")
        response.write("""diachi"": """)
        response.write(dh.Diachinguoinhan)
        response.write("""")
        response.write(",")
        response.write("""idgg"": """)
        response.write(dh.Idgiamgia)
        response.write("""")
        response.write(",")
        response.write("""magg"": """)
        response.write(dh.Magg)
        response.write("""")
        response.write(",")
        response.write("""ngaydat"": """)
        response.write(dh.Ngaydat)
        response.write("""")
        response.write(",")
        response.write("""ngayhoanthanh"": """)
        response.write(dh.Ngayhoanthanh)
        response.write("""")
        response.write(",")
        response.write("""phigiaohang"": """)
        response.write(dh.Phigiaohang)
        response.write("""")
        response.write(",")
        response.write("""tongtien"": """)
        response.write(dh.Tongtien)
        response.write("""")
        response.write(",")
        response.write("""chietkhau"": """)
        response.write(dh.Chietkhau)
        response.write("""")
        response.write(",")
        response.write("""thanhtoan"": """)
        response.write(dh.Thanhtoan)
        response.write("""")
        response.write(",")
        response.write("""trangthai"": """)
        response.write(dh.Tinhtrang)
        response.write("""")
        response.Write("}")
        Response.Write("}")
    end if
    if(loai = "doanhthuthanghientai") then
        set dh = new DonHang
        thang = request.querystring("thang")
        nam = request.querystring("nam")
        response.write(dh.doanhThuThangHienTai(thang,nam))
    end if

    if(loai = "thongkechoduyet") then
        set dh = new DonHang
        response.write(dh.thongKeTheoTrangThaiDonHang("0"))
    end if

    if(loai = "thongkehoanthanh") then
        thang = request.querystring("thang")
        nam = request.querystring("nam")
        set dh = new DonHang
        response.write(dh.thongKeHoanThanhTrongThang(thang,nam))
    end if
    
    if(loai="doanhthutungthang") then
        Set datalist = Server.CreateObject("Scripting.Dictionary")
        nam = request.querystring("nam")
        set dh = new DonHang
        set datalist = dh.doanhThuTungThangTrongNam(nam)
        response.Write("{")
        response.Write("""status code"": ""20"",")
        response.Write("""message"": ""Doanh thu từng tháng trong năm"",")
        response.Write("""data"":{ ""datalist"": [")
        count = 0
        For Each x In datalist.Keys
            count = count + 1
            response.Write("{")
            response.write(""""&x&""": """)
            response.write(datalist(x))
            response.write("""")
            response.Write("}")
            if(count < datalist.count) then
                response.write(",")
            end if
            
        Next
        response.Write("]")
        response.Write("}")
        response.Write("}")

    end if

    if(loai="sodonhangtungthang") then
        Set datalist = Server.CreateObject("Scripting.Dictionary")
        nam = request.querystring("nam")
        set dh = new DonHang
        set datalist = dh.soDonHangTungThangTrongNam(nam)
        response.Write("{")
        response.Write("""status code"": ""20"",")
        response.Write("""message"": ""Số đơn hàng từng tháng trong năm"",")
        response.Write("""data"":{ ""datalist"": [")
        count = 0
        For Each x In datalist.Keys
            count = count + 1
            response.Write("{")
            response.write(""""&x&""": """)
            response.write(datalist(x))
            response.write("""")
            response.Write("}")
            if(count < datalist.count) then
                response.write(",")
            end if
            
        Next
        response.Write("]")
        response.Write("}")
        response.Write("}")

    end if
    if(loai = "doanhthunamhientai") then
        set dh = new DonHang
        nam = request.querystring("nam")
        response.write(dh.doanhThuNamHienTai(nam))
    end if
    if(loai ="laychitietdonhang") then
        madh = request.queryString("madh")
        set dh = new ChiTietDonHang
        set ctdh = dh.layChiTietDonHang(madh)
        response.Write("{")
        response.Write("""status code"": ""20"",")
        response.Write("""message"": """",")
        response.Write("""data"":{ ""chitietdonhang"": [")
        dim count1 
        count1 = 0
        for each z in ctdh
            count1 = count1 + 1
            response.Write("{")
            response.Write("")
            response.write("""madh"": """)
            response.write(ctdh(z).Madh)
            response.write(""",")
            response.Write("")
            response.write("""tensp"": """)
            response.write(ctdh(z).Tensp)
            response.write(""",")
            response.write("""sl"": """)
            response.write(ctdh(z).Sl)
            response.write(""",")
            response.write("""giasp"": """)
            response.write(ctdh(z).Giasp)
            response.write("""")
            response.Write("}")
            if(count1 < ctdh.count) then
                response.write(",")
            end if

        next
        response.Write("]")
        response.Write("}")
        response.Write("}")
    end if
    if(loai="taodonhang") then
        set classdh = new DonHang
        tk = request.form("tk")
        ten = request.form("ten")
        sdt = request.form("sdt")
        diachi = request.form("diachi")
        idgg = session("idgg")
        tong = session("giagiohang")
        chietkhau = request.form("giamgia")
        thanhtoan = request.form("thanhtoan")
        if(chietkhau ="") then
            chietkhau = 0
        end if
        if(idgg="") then
            idgg="NULL"
        end if
        if(tk="") then
            tk="NULL"
        else
            tk = "'" + tk + "'"
        end if
        ngaydat = request.form("ngaydat")
        madh = classdh.taoDonHang(tk,ten,sdt,diachi,idgg,ngaydat,"30000",tong,chietkhau,thanhtoan,"0") 
        session("madh") = madh
    end if

    if(loai="lichsudathang") then
        set dh = new DonHang
        tk = request.queryString("tk")
        set danhsachdonhang = dh.lichsudathang(limit, page, tk)
        response.Write("{")
        response.Write("""status code"": ""20"",")
        response.Write("""message"": """",")
        response.Write("""data"":{ ""danhsachdonhang"": [")
        count = 0
        for each z in danhsachdonhang
            count = count + 1
            response.Write("{")
            response.Write("")
            response.write("""madh"": """)
            response.write(danhsachdonhang(z).Madh)
            response.write(""",")
            response.Write("")
            response.write("""tk"": """)
            response.write(danhsachdonhang(z).Tk)
            response.write(""",")
            response.write("""tennguoinhan"": """)
            response.write(danhsachdonhang(z).Tennguoinhan)
            response.write(""",")
            response.write("""sdtnguoinhan"": """)
            response.write(danhsachdonhang(z).Sdtnguoinhan)
            response.write("""")
            response.write(",")
            response.write("""diachi"": """)
            response.write(danhsachdonhang(z).Diachinguoinhan)
            response.write("""")
            response.write(",")
            response.write("""idgg"": """)
            response.write(danhsachdonhang(z).Idgiamgia)
            response.write("""")
            response.write(",")
            response.write("""magg"": """)
            response.write(danhsachdonhang(z).Magg)
            response.write("""")
            response.write(",")
            response.write("""ngaydat"": """)
            response.write(danhsachdonhang(z).Ngaydat)
            response.write("""")
            response.write(",")
            response.write("""ngayhoanthanh"": """)
            response.write(danhsachdonhang(z).Ngayhoanthanh)
            response.write("""")
            response.write(",")
            response.write("""phigiaohang"": """)
            response.write(danhsachdonhang(z).Phigiaohang)
            response.write("""")
            response.write(",")
            response.write("""tongtien"": """)
            response.write(danhsachdonhang(z).Tongtien)
            response.write("""")
            response.write(",")
            response.write("""chietkhau"": """)
            response.write(danhsachdonhang(z).Chietkhau)
            response.write("""")
            response.write(",")
            response.write("""thanhtoan"": """)
            response.write(danhsachdonhang(z).Thanhtoan)
            response.write("""")
            response.write(",")
            response.write("""trangthai"": """)
            response.write(danhsachdonhang(z).Tinhtrang)
            response.write("""")
            response.Write("}")
            if(count < danhsachdonhang.count) then
                response.write(",")
            end if

        next
        response.Write("]")
        response.Write(",""totalPages"":")
        response.Write(dh.Ceil(dh.countlichsu(tk)/limit))
        response.Write("}")
        response.Write("}")
    end if

    if(loai="phantrangdonhang") then
        set dh = new DonHang
        madh = request.querystring("madh")
        sdt = request.querystring("sdt")
        dathangtu = request.querystring("dathangtu")
        dathangden = request.querystring("dathangden")
        hoanthanhtu = request.querystring("hoanthanhtu")
        hoanthanhden = request.querystring("hoanthanhden")
        sapxepthoigian = request.querystring("sapxepthoigian")
        trangthai = request.querystring("trangthai")
        set danhsachdonhang = dh.phantrangdonhang(limit, page, madh, sdt, dathangtu, dathangden, hoanthanhtu, hoanthanhden, trangthai,sapxepthoigian)
        response.Write("{")
        response.Write("""status code"": ""20"",")
        response.Write("""message"": """",")
        response.Write("""data"":{ ""danhsachdonhang"": [")
        dim count 
        count = 0
        for each z in danhsachdonhang
            count = count + 1
            response.Write("{")
            response.Write("")
            response.write("""madh"": """)
            response.write(danhsachdonhang(z).Madh)
            response.write(""",")
            response.Write("")
            response.write("""tk"": """)
            response.write(danhsachdonhang(z).Tk)
            response.write(""",")
            response.write("""tennguoinhan"": """)
            response.write(danhsachdonhang(z).Tennguoinhan)
            response.write(""",")
            response.write("""sdtnguoinhan"": """)
            response.write(danhsachdonhang(z).Sdtnguoinhan)
            response.write("""")
            response.write(",")
            response.write("""diachi"": """)
            response.write(danhsachdonhang(z).Diachinguoinhan)
            response.write("""")
            response.write(",")
            response.write("""idgg"": """)
            response.write(danhsachdonhang(z).Idgiamgia)
            response.write("""")
            response.write(",")
            response.write("""magg"": """)
            response.write(danhsachdonhang(z).Magg)
            response.write("""")
            response.write(",")
            response.write("""ngaydat"": """)
            response.write(danhsachdonhang(z).Ngaydat)
            response.write("""")
            response.write(",")
            response.write("""ngayhoanthanh"": """)
            response.write(danhsachdonhang(z).Ngayhoanthanh)
            response.write("""")
            response.write(",")
            response.write("""phigiaohang"": """)
            response.write(danhsachdonhang(z).Phigiaohang)
            response.write("""")
            response.write(",")
            response.write("""tongtien"": """)
            response.write(danhsachdonhang(z).Tongtien)
            response.write("""")
            response.write(",")
            response.write("""chietkhau"": """)
            response.write(danhsachdonhang(z).Chietkhau)
            response.write("""")
            response.write(",")
            response.write("""thanhtoan"": """)
            response.write(danhsachdonhang(z).Thanhtoan)
            response.write("""")
            response.write(",")
            response.write("""trangthai"": """)
            response.write(danhsachdonhang(z).Tinhtrang)
            response.write("""")
            response.Write("}")
            if(count < danhsachdonhang.count) then
                response.write(",")
            end if

        next
        response.Write("]")
        response.Write(",""totalPages"":")
        response.Write(dh.Ceil(dh.count(madh, sdt, dathangtu, dathangden, hoanthanhtu, hoanthanhden, trangthai)/limit))
        response.Write("}")
        response.Write("}")
    end if
    if(loai="chitietdonhang") then
        set classdh = new DonHang
        listsp = request.form("listsp")
        a = split(listsp,",")
        for each x in a
           b = split(x,":")
           for each y in b
                call classdh.chiTietDonHang(session("madh"),b(0),classdh.layGiaSanPham(b(0)),b(1))
                Exit For
           next
        next
    end if
  set dh = new DonHang
    'call dh.phantrangdonhang(limit, page, "", "", "2023-06-01", "2023-06-02", "", "", "")
%>
