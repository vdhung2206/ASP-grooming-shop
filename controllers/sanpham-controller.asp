<!--#include file="../models/sanPham.asp" -->
<!-- #include file="../aspuploader/include_aspuploader.asp" -->  
<%
    ' status code 20: Lay danh sach san pham phan trang thanh cong
    loai = request.querystring("loai")
    if(loai = "") then
        loai = request.form("loai")
    end if
    dim page
    page = request.querystring("page")
    Set danhsachsanpham = Server.CreateObject("Scripting.Dictionary")
    limit = 6
    
    tenspsearch = request.querystring("tensp")
    danhmucsearch = request.querystring("madm")
    loaispsearch = request.querystring("loaisp")
    hangspsearch = request.querystring("hangsp")
    sltonkhosearch1 = request.querystring("slton1")
    sltonkhosearch2 = request.querystring("slton2")
    giaspsearch1 = request.querystring("giasp1")
    giaspsearch2 = request.querystring("giasp2")
    trangthaisearch = request.querystring("tinhtrang")
    sapxepphobien = request.querystring("sapxepphobien")
    sapxepgia = request.querystring("sapxepgia")
    sapxeptonkho = request.querystring("sapxeptonkho")
    if(loai="themsanpham") then
        set sp = new SanPham
        Dim uploader   
        Set uploader=new AspUploader 
        Dim mvcfile						
        Set mvcfile=uploader.GetUploadedFile(Request.Form("myuploader"))
        dim hinhanh
        hinhanh= "../image/" + mvcfile.FileName
        tenspthem = request.form("tenspthem")
        maloaispthem = request.form("maloaispthem")
        hangspthem = request.form("hangspthem")
        sltonkhothem = request.form("sltonkhothem")
        giagocspthem = request.form("giagocspthem")
        chitietspthem = request.form("chitietspthem")
        if(tenspthem<>"") then
            if(sp.checkTonTaiMaLoaiSP(maloaispthem)) then
                if(hangspthem <>"") then
                    if(sltonkhothem > 0 and IsNumeric(sltonkhothem)) then
                        if(giagocspthem >0 and IsNumeric(giagocspthem)) then
                            set sp = new SanPham
                            call sp.themSanPham(tenspthem, maloaispthem, hangspthem, sltonkhothem, giagocspthem, hinhanh, chitietspthem)
                            response.redirect("/views/sanpham-view.asp")
                        else
                            Response.Write("""status code"": ""103"",")
                            Response.Write("""message"": ""Giá sản phẩm phải sản phẩm phải lớn hơn 0 và phải là số!"",")
                            Response.Write("""data"":{ ""themSanPham"": false}")
                            response.redirect("themsanpham-view.asp")
                            session("errmsgthem") ="Giá sản phẩm phải sản phẩm phải lớn hơn 0 và phải là số!" 
                        end if
                    else
                        Response.Write("""status code"": ""104"",")
                        Response.Write("""message"": ""Số lượng sản phẩm phải lớn hơn 0!"",")
                        Response.Write("""data"":{ ""themSanPham"": false}")
                        response.redirect("themsanpham-view.asp")
                        session("errmsgthem") ="Số lượng sản phẩm phải lớn hơn 0 và là số!" 
                    end if
                else
                    Response.Write("""status code"": ""103"",")
                    Response.Write("""message"": ""Hãng sản phẩm không được trống!"",")
                    Response.Write("""data"":{ ""themSanPham"": false}")
                    response.redirect("themsanpham-view.asp")
                    session("errmsgthem") ="Hãng sản phẩm không được trống!" 
                end if
            else
                Response.Write("""status code"": ""102"",")
                Response.Write("""message"": ""Loại sản phẩm không tồn tại!"",")
                Response.Write("""data"":{ ""themSanPham"": false}")
                response.redirect("themsanpham-view.asp")
                session("errmsgthem") ="Loại sản phẩm không tồn tại!" 
            end if   
        else
            Response.Write("""status code"": ""101"",")
            Response.Write("""message"": ""Tên sản phẩm không được trống!"",")
            Response.Write("""data"":{ ""themSanPham"": false}")
            response.redirect("themsanpham-view.asp")
            session("errmsgthem") ="Tên sản phẩm không được trống!" 
        end if
    end if

    if(loai="chinhsuathongtinsanpham") then
        set sp = new SanPham
        maspsua = request.form("masp")
        tenspsua = request.form("tensp")
        danhmucspsua = request.form("tensp")
        loaispsua = request.form("loaisp")
        hangspsua = request.form("hangsp")
        sltonkhospsua = request.form("sltonkhosp")
        giagocspsua = request.form("giagocsp")
        giagiamspsua = request.form("giagiamsp")
        trangthaispsua = request.form("trangthai")
        chitietspsua = request.form("chitietsp")
        Response.Write("{")
        if(tenspsua<>"") then
            if(sp.checkTonTaiMaLoaiSP(loaispsua)) then
                if(hangspsua <>"") then
                    if(sltonkhospsua > 0 and IsNumeric(sltonkhospsua)) then
                        if(giagocspsua >0 and IsNumeric(giagocspsua)) then
                            if(giagiamspsua >=0 and IsNumeric(giagiamspsua)) then
                                set sp = new SanPham
                                call sp.suaThongTin(maspsua, tenspsua, loaispsua, hangspsua, sltonkhospsua, giagocspsua, giagiamspsua, trangthaispsua, chitietspsua)     
                                Response.Write("""status code"": ""103"",")
                                Response.Write("""message"": ""Thành công!"",")
                                Response.Write("""data"":{ ""suaSanPham"": true}")                   
                            else
                                Response.Write("""status code"": ""103"",")
                                Response.Write("""message"": ""Giảm giá sản phẩm lớn hơn 0 và phải là số!"",")
                                Response.Write("""data"":{ ""suaSanPham"": false}") 
                                session("errmsgsua") ="Giá sản phẩm phải sản phẩm phải lớn hơn 0 và phải là số!" 
                            end if
                        else
                            Response.Write("""status code"": ""103"",")
                            Response.Write("""message"": ""Giá sản phẩm phải sản phẩm phải lớn hơn 0 và phải là số!"",")
                            Response.Write("""data"":{ ""suaSanPham"": false}")
                            session("errmsgsua") ="Giá sản phẩm phải sản phẩm phải lớn hơn 0 và phải là số!" 
                        end if
                    else
                        Response.Write("""status code"": ""104"",")
                        Response.Write("""message"": ""Số lượng sản phẩm phải lớn hơn 0!"",")
                        Response.Write("""data"":{ ""suaSanPham"": false}")
                        session("errmsgsua") ="Số lượng sản phẩm phải lớn hơn 0 và là số!" 
                    end if
                else
                    Response.Write("""status code"": ""103"",")
                    Response.Write("""message"": ""Hãng sản phẩm không được trống!"",")
                    Response.Write("""data"":{ ""suaSanPham"": false}")
                    session("errmsgsua") ="Hãng sản phẩm không được trống!" 
                end if
            else
                Response.Write("""status code"": ""102"",")
                Response.Write("""message"": ""Loại sản phẩm không tồn tại!"",")
                Response.Write("""data"":{ ""suaSanPham"": false}")
                session("errmsgsua") ="Loại sản phẩm không tồn tại!" 
            end if   
        else
            Response.Write("""status code"": ""101"",")
            Response.Write("""message"": ""Tên sản phẩm không được trống!"",")
            Response.Write("""data"":{ ""suaSanPham"": false}")
            session("errmsgsua") ="Tên sản phẩm không được trống!" 
        end if
        Response.Write("}")
        ' Response.Write("{")
        ' Response.Write("""status code"": ""201"",")
        ' Response.Write("""message"": """",")
        ' Response.Write("""data"":" + """"+tenspsua+"""")
        ' Response.Write("}")
    end if
    if(loai="laydanhsachhang") then
        set sp = new SanPham
        Set danhsachhang = Server.CreateObject("Scripting.Dictionary")
        set danhsachhang = sp.getHang()
        Response.Write("{")
        Response.Write("""status code"": ""20"",")
        Response.Write("""message"": """",")
        Response.Write("""data"":{ ""danhsachhang"": [")
        count = 0
        for each z in danhsachhang
            count = count + 1
            Response.Write("""")
            response.write(danhsachhang(z).HangSP)
            Response.Write("""")
            if(count < danhsachhang.count) then
                response.write(",")
            end if
        next
        Response.Write("]")
        Response.Write("}")
        Response.Write("}")
    end if
    if(loai="laythongtinsanpham") then
        masp = request.queryString("masp")
        set sp = new SanPham
        dim spx
        set spx= sp.layThongTinSanPham(masp)
        Response.Write("{")
        Response.Write("""status code"": ""201"",")
        Response.Write("""message"": """",")
        Response.Write("""data"":")
            Response.Write("{")
            Response.Write("")
            response.write("""hinhanh"": """)
            response.write(spx.HinhAnh)
            response.write(""",")
            Response.Write("")
            response.write("""masp"":""")
            response.write(spx.MaSP)
            response.write(""",")
            response.write("""tensp"": """)
            response.write(spx.TenSP)
            response.write(""",")
            response.write("""danhmuc"": """)
            response.write(spx.DanhMuc)
            response.write("""")
            response.write(",")
            response.write("""loaisp"": """)
            response.write(spx.LoaiSP)
            response.write("""")
            response.write(",")
            response.write("""hang"": """)
            response.write(spx.HangSP)
            response.write("""")
            response.write(",")
            response.write("""sltonkho"": """)
            response.write(spx.SLTonKho)
            response.write("""")
            response.write(",")
            response.write("""giagocsp"": """)
            response.write(spx.GiaGocSP)
            response.write("""")
            response.write(",")
            response.write("""giamgiasp"": """)
            response.write(spx.GiamGiaSP)
            response.write("""")
            response.write(",")
            response.write("""giasp"": """)
            response.write(spx.giasp)
            response.write("""")
            response.write(",")
            response.write("""chitietsp"": """)
            response.write(spx.ChiTiet)
            response.write("""")
            response.write(",")
            response.write("""trangthai"": """)
            response.write(spx.TrangThai)
            response.write("""")
            Response.Write("}")
        Response.Write("}")
    end if
    if(loai="timkiemsanpham") then
        tenspsearch = request.querystring("tensp")
        hangspsearch = request.querystring("hangsp")
        danhmucspsearch = request.querystring("danhmucsp")
        loaispsearch = request.querystring("loaisp")

        set sp = new SanPham
        set danhsachsanpham = sp.timKiemSanPham(tenspsearch,hangspsearch,danhmucspsearch,loaispsearch)
        Response.Write("{")
        Response.Write("""status code"": ""20"",")
        Response.Write("""message"": """",")
        Response.Write("""data"":{ ""danhsachsanpham"": [")
        count = 0
        for each z in danhsachsanpham
            count = count + 1
            Response.Write("{")
            response.write("""masp"": """)
            response.write(danhsachsanpham(z).MaSP)
            Response.Write(""",")
            response.write("""tensp"": """)
            response.write(danhsachsanpham(z).TenSP)
            Response.Write("""")
            Response.Write("}")
            if(count < danhsachsanpham.count) then
                response.write(",")
            end if
        next
        Response.Write("]")
        Response.Write("}")
        Response.Write("}")
    end if
    if(loai="phantrangsanpham") then
        set sp = new SanPham
        dim mincount
        dim maxcount
        mincountall = sp.countMinTonKho("","","","","","","","")
        maxcountall = sp.countMaxTonKho("","","","","","","","")
        mincount = sp.countMinTonKho(tenspsearch,danhmucsearch,loaispsearch,hangspsearch,sltonkhosearch1,sltonkhosearch2,giasp,trangthaisearch)
        maxcount = sp.countMaxTonKho(tenspsearch,danhmucsearch,loaispsearch,hangspsearch,sltonkhosearch1,sltonkhosearch2,giasp,trangthaisearch)
        set danhsachsanpham = sp.phanTrangSanPham(limit, page, tenspsearch,danhmucsearch,loaispsearch,hangspsearch,sltonkhosearch1,sltonkhosearch2,giaspsearch1,giaspsearch2,trangthaisearch,sapxepphobien,sapxepgia,sapxeptonkho)
        Response.Write("{")
        Response.Write("""status code"": ""20"",")
        Response.Write("""message"": """",")
        Response.Write("""data"":{ ""danhsachsanpham"": [")
        dim count 
        count = 0
        for each z in danhsachsanpham
            count = count + 1
            Response.Write("{")
            Response.Write("")
            response.write("""hinhanh"": """)
            response.write(danhsachsanpham(z).HinhAnh)
            response.write(""",")
            Response.Write("")
            response.write("""masp"": """)
            response.write(danhsachsanpham(z).MaSP)
            response.write(""",")
            response.write("""tensp"": """)
            response.write(danhsachsanpham(z).TenSP)
            response.write(""",")
            response.write("""danhmuc"": """)
            response.write(danhsachsanpham(z).DanhMuc)
            response.write("""")
            response.write(",")
            response.write("""loaisp"": """)
            response.write(danhsachsanpham(z).LoaiSP)
            response.write("""")
            response.write(",")
            response.write("""hang"": """)
            response.write(danhsachsanpham(z).HangSP)
            response.write("""")
            response.write(",")
            response.write("""sltonkho"": """)
            response.write(danhsachsanpham(z).SLTonKho)
            response.write("""")
            response.write(",")
            response.write("""giagocsp"": """)
            response.write(danhsachsanpham(z).GiaGocSP)
            response.write("""")
            response.write(",")
            response.write("""giamgiasp"": """)
            response.write(danhsachsanpham(z).GiamGiaSP)
            response.write("""")
            response.write(",")
            response.write("""giasp"": """)
            response.write(danhsachsanpham(z).giasp)
            response.write("""")
            response.write(",")
            response.write("""chitietsp"": """)
            response.write(danhsachsanpham(z).ChiTiet)
            response.write("""")
            response.write(",")
            response.write("""trangthai"": """)
            response.write(danhsachsanpham(z).TrangThai)
            response.write("""")
            Response.Write("}")
            if(count < danhsachsanpham.count) then
                response.write(",")
            end if

        next
        Response.Write("]")
        Response.Write(",""totalPages"":")
        Response.Write(sp.Ceil(sp.count(tenspsearch,danhmucsearch,loaispsearch,hangspsearch,sltonkhosearch1,sltonkhosearch2,giaspsearch,trangthaisearch)/limit))
        Response.Write("")
        Response.Write(",""mintonkho"":")
        Response.Write(mincount)
        Response.Write("")
        Response.Write(",""maxtonkho"":")
        Response.Write(maxcount)
        Response.Write("")
        Response.Write(",""maxtonkhoall"":")
        Response.Write(maxcountall)
        Response.Write("")
        Response.Write(",""mintonkhoall"":")
        Response.Write(mincountall)
        Response.Write("")
        Response.Write("}")
        Response.Write("}")
    end if
%>
