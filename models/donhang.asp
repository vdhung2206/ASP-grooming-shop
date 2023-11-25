<!-- #include file="../share/connect.asp" -->
<%
set connDB = Server.CreateObject("ADODB.Connection")

connDB.ConnectionString = strConnection
%>
<% 
Class ChiTietDonHang
    'Private, class member variable
    Private p_madh
    Private p_tensp
    Private p_sl
    Private p_giasp
    ' getter and setter
    Public Property Get Madh()
      Madh = p_madh
    End Property
    Public Property Let Madh(value)
      p_madh = value
    End Property

    Public Property Get Tensp()
      Tensp = p_tensp
    End Property
    Public Property Let Tensp(value)
      p_tensp = value
    End Property

    Public Property Get Sl()
      Sl = p_sl
    End Property
    Public Property Let Sl(value)
      p_sl = value
    End Property

    Public Property Get Giasp()
      Giasp = p_giasp
    End Property
    Public Property Let Giasp(value)
      p_giasp = value
    End Property

    public function layChiTietDonHang(madh)
      Dim connDB
      set connDB = Server.CreateObject("ADODB.Connection")
      Dim strConnection
      strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
      connDB.ConnectionString = strConnection
      connDB.Open()
      dim sql
      
      Dim chitietdonhang
      Set chitietdonhang = Server.CreateObject("Scripting.Dictionary")

      sql = "select * from view1_ChiTietDonHang where MaDH = " + madh
      Set rs = connDB.execute(sql)
      Do While Not rs.EOF
        seq = seq+1
        set ctdh = New ChiTietDonHang
        ctdh.Madh = rs.Fields("MaDH")
        ctdh.Tensp = rs.Fields("TenSp")
        ctdh.Sl = rs.Fields("SL")
        ctdh.Giasp = rs.Fields("GiaSP")
        chitietdonhang.add seq, ctdh
        rs.MoveNext
        Loop 
      conndb.Close()
      set layChiTietDonHang = chitietdonhang
    end function
End Class

  Class DonHang
    'Private, class member variable
    Private p_madh
    Private p_tk
    Private p_tennguoinhan
    Private p_sdtnguoinhan
    private p_diachinguoinhan
    Private p_idgiamgia
    private p_magg
    Private p_ngaydat
    Private p_ngayhoanthanh
    Private p_phigiaohang
    Private p_tongtien
    Private p_chietkhau
    Private p_thanhtoan
    Private p_tinhtrang
    ' getter and setter
    Public Property Get Madh()
      Madh = p_madh
    End Property
    Public Property Let Madh(value)
      p_madh = value
    End Property
    
    Public Property Get Tk()
      Tk = p_tk
    End Property
    Public Property Let Tk(value)
      p_tk = value
    End Property
    
    Public Property Get Tennguoinhan()
      Tennguoinhan = p_tennguoinhan
    End Property
    Public Property Let Tennguoinhan(value)
      p_tennguoinhan = value
    End Property
    
    Public Property Get Sdtnguoinhan()
      Sdtnguoinhan = p_sdtnguoinhan
    End Property
    Public Property Let Sdtnguoinhan(value)
      p_sdtnguoinhan = value
    End Property
    
    Public Property Get Diachinguoinhan()
      Diachinguoinhan = p_diachinguoinhan
    End Property
    Public Property Let Diachinguoinhan(value)
      p_diachinguoinhan = value
    End Property
    
    Public Property Get Idgiamgia()
      Idgiamgia = p_idgiamgia
    End Property
    Public Property Let Idgiamgia(value)
      p_idgiamgia = value
    End Property
    
    Public Property Get Magg()
      Magg = p_magg
    End Property
    Public Property Let Magg(value)
      p_magg = value
    End Property

    Public Property Get Ngaydat()
      Ngaydat = p_ngaydat
    End Property
    Public Property Let Ngaydat(value)
      p_ngaydat = value
    End Property

    Public Property Get Ngayhoanthanh()
      Ngayhoanthanh = p_ngayhoanthanh
    End Property
    Public Property Let Ngayhoanthanh(value)
      p_ngayhoanthanh = value
    End Property
    
    Public Property Get Phigiaohang()
      Phigiaohang = p_phigiaohang
    End Property
    Public Property Let Phigiaohang(value)
      p_phigiaohang = value
    End Property
    
    Public Property Get Tongtien()
      Tongtien = p_tongtien
    End Property
    Public Property Let Tongtien(value)
      p_tongtien = value
    End Property
    
    Public Property Get Chietkhau()
      Chietkhau = p_chietkhau
    End Property
    Public Property Let Chietkhau(value)
      p_chietkhau = value
    End Property

    Public Property Get Thanhtoan()
      Thanhtoan = p_thanhtoan
    End Property
    Public Property Let Thanhtoan(value)
      p_thanhtoan = value
    End Property
    
    Public Property Get Tinhtrang()
      Tinhtrang = p_tinhtrang
    End Property
    Public Property Let Tinhtrang(value)
      p_tinhtrang = value
    End Property

    public function taoDonHang(tk,ten,sdt,diachi,idgg,ngaydat,phigiao,tongtien,chietkhau,thanhtoan,trangthai) 
        Dim sql
        sql= "insert into DonHang values("+tk+",'"+ten+"','"+sdt+"','"+diachi+"',"+cstr(idgg)+",'"+ngaydat+"',NULL,'"+phigiao+"','"+tongtien+"','"+chietkhau+"','"+thanhtoan+"','"+trangthai+"')"
        Dim connDB 
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = sql
        cmdPrep.Execute()
        Set rs = connDB.execute("SELECT @@IDENTITY AS idgiamgia")
        taoDonHang = rs.Fields("idgiamgia")
        connDB.Close()
    end function



    function thaotacdonhang(madh)
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "Update DonHang set TrangThai = ? where MaDH=?"
        set classdh = new DonHang
        set dh= classdh.layThongTinDonHang(madh)
        if(dh.Tinhtrang ="0") then
          cmdPrep.Parameters(0)= "1"
        end if
        if(dh.Tinhtrang ="1") then
          cmdPrep.Parameters(0)= "2"
        end if
        if(dh.Tinhtrang ="2") then
          cmdPrep.Parameters(0)= "2"
        end if
        cmdPrep.Parameters(1)=madh
        cmdPrep.execute
        conndb.Close()
    end function

    function huydonhang(madh)
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "Update DonHang set TrangThai = 3 where MaDH=?"
        set classdh = new DonHang
        set dh= classdh.layThongTinDonHang(madh)
        cmdPrep.Parameters(0)=madh
        cmdPrep.execute
        conndb.Close()
    end function

    public function layGiaSanPham(masp)
      Dim connDB
      set connDB = Server.CreateObject("ADODB.Connection")
      Dim strConnection
      strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
      connDB.ConnectionString = strConnection
      connDB.Open()
      dim sql
      sql = "select * from view1_SanPham where MaSP = " + masp
      Set rs = connDB.execute(sql)
      layGiaSanPham = rs("GiaSP")
      conndb.Close()
    end function

    public function phantrangdonhang(limit, page, madh, sdt, dathangtu, dathangden, hoanthanhtu, hoanthanhden, trangthai,sapxepthoigian)
        set classDH = new DonHang
        totalRows = classDH.count(madh, sdt, dathangtu, dathangden, hoanthanhtu, hoanthanhden, trangthai)
        pages = Ceil(totalRows/limit)
        if (Clng(pages) < Clng(page)) then
            page = pages
        end if
        offset = (Clng(page) * Clng(limit)) - Clng(limit)
        if(offset < 0) then 
            offset =0
        end if
        Dim sql
        sql = "select * from view1_DonHang where MaDH !=''"
        if(madh <> "") then
          sql = sql + " and MaDH like '%" & madh & "%'"
        end if
        if (sdt <>"") then
          sql = sql + " and SDTNguoiNhan like '%" & sdt & "%'"
        end if
        if (dathangtu <>"") then
          sql = sql + " and NgayDat >= '" & dathangtu & "'"
        end if
        if (dathangden <>"") then
          sql = sql + " and NgayDat <= '" & dathangden & "'"
        end if
        if (hoanthanhtu <>"") then
          sql = sql + " and NgayHoanThanh >= '" & hoanthanhtu & "'"
        end if
        if (hoanthanhden <>"") then
          sql = sql + " and NgayHoanThanh <= '" & hoanthanhden & "'"
        end if
        if (trangthai <>"") then
          sql = sql + " and TrangThai = " & trangthai & ""
        end if
        if (tichdiem2 <>"") then
          sql = sql + " and DKKhachHang <= " & tichdiem2 & ""
        end if
        if(sapxepthoigian = "") then
          sql = sql + "order by TrangThai"
        end if
        if(sapxepthoigian = "1") then
          sql = sql +" order by NgayDat"
        end if
        if(sapxepthoigian = "0") then
          sql = sql +" order by NgayDat desc"
        end if
        sql = sql + " offset " & offset &" rows fetch next " & limit &" rows only"
        'response.write(sql)
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()

        Dim danhsachdonhang
        Set danhsachdonhang = Server.CreateObject("Scripting.Dictionary")

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = sql
        Set rs = cmdPrep.execute
        Do While Not rs.EOF
            seq = seq+1
            set dh = New DonHang
            dh.Madh = rs.Fields("MaDH")
            dh.Tk = rs.Fields("TK")
            dh.Tennguoinhan = rs.Fields("TenNguoiNhan")
            dh.Sdtnguoinhan = rs.Fields("SDTNguoiNhan")
            dh.Diachinguoinhan = rs.Fields("DiaChi")
            dh.Idgiamgia = rs.Fields("IDGiamGia")
            dh.Magg = rs.Fields("MaGG")
            dh.Ngaydat = rs.Fields("NgayDat")
            dh.Ngayhoanthanh = rs.Fields("NgayHoanThanh")
            dh.Phigiaohang= rs.Fields("PhiGiaoHang")
            dh.Tongtien = rs.Fields("TongTien")
            dh.Chietkhau = rs.Fields("ChietKhau")
            dh.Thanhtoan = rs.Fields("ThanhToan")
            dh.Tinhtrang = rs.Fields("TrangThai")
            danhsachdonhang.add seq, dh
            rs.MoveNext
        Loop 
        conndb.Close()
        set phantrangdonhang = danhsachdonhang
    end function

    public function lichsudathang(limit, page, tk)
        set classDH = new DonHang
        totalRows = classDH.countlichsu(tk)
        pages = Ceil(totalRows/limit)
        if (Clng(pages) < Clng(page)) then
            page = pages
        end if
        offset = (Clng(page) * Clng(limit)) - Clng(limit)
        if(offset < 0) then 
            offset =0
        end if
        Dim sql
        sql = "select * from view1_DonHang where tk='" & tk &"' order by NgayDat"
        sql = sql + " offset " & offset &" rows fetch next " & limit &" rows only"
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()

        Dim danhsachdonhang
        Set danhsachdonhang = Server.CreateObject("Scripting.Dictionary")

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = sql
        Set rs = cmdPrep.execute
        Do While Not rs.EOF
            seq = seq+1
            set dh = New DonHang
            dh.Madh = rs.Fields("MaDH")
            dh.Tk = rs.Fields("TK")
            dh.Tennguoinhan = rs.Fields("TenNguoiNhan")
            dh.Sdtnguoinhan = rs.Fields("SDTNguoiNhan")
            dh.Diachinguoinhan = rs.Fields("DiaChi")
            dh.Idgiamgia = rs.Fields("IDGiamGia")
            dh.Magg = rs.Fields("MaGG")
            dh.Ngaydat = rs.Fields("NgayDat")
            dh.Ngayhoanthanh = rs.Fields("NgayHoanThanh")
            dh.Phigiaohang= rs.Fields("PhiGiaoHang")
            dh.Tongtien = rs.Fields("TongTien")
            dh.Chietkhau = rs.Fields("ChietKhau")
            dh.Thanhtoan = rs.Fields("ThanhToan")
            dh.Tinhtrang = rs.Fields("TrangThai")
            danhsachdonhang.add seq, dh
            rs.MoveNext
        Loop 
        conndb.Close()
        set lichsudathang = danhsachdonhang
    end function

    public function layThongTinDonHang(madh)
      Dim connDB
      set connDB = Server.CreateObject("ADODB.Connection")
      Dim strConnection
      strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
      connDB.ConnectionString = strConnection
      connDB.Open()
      dim sql
      sql = "select * from view1_DonHang where MaDH = " + madh
      Set rs = connDB.execute(sql)
      if Not rs.EOF then
        set dh = New DonHang
          dh.Madh = rs.Fields("MaDH")
          dh.Tk = rs.Fields("TK")
          dh.Tennguoinhan = rs.Fields("TenNguoiNhan")
          dh.Sdtnguoinhan = rs.Fields("SDTNguoiNhan")
          dh.Diachinguoinhan = rs.Fields("DiaChi")
          dh.Idgiamgia = rs.Fields("IDGiamGia")
          dh.Magg = rs.Fields("MaGG")
          dh.Ngaydat = rs.Fields("NgayDat")
          dh.Ngayhoanthanh = rs.Fields("NgayHoanThanh")
          dh.Phigiaohang= rs.Fields("PhiGiaoHang")
          dh.Tongtien = rs.Fields("TongTien")
          dh.Chietkhau = rs.Fields("ChietKhau")
          dh.Thanhtoan = rs.Fields("ThanhToan")
          dh.Tinhtrang = rs.Fields("TrangThai")
        set layThongTinDonHang = dh
      else
        layThongTinDonHang = "nothing"
      end if
      conndb.Close()
    end function

    public function count(madh, sdt, dathangtu, dathangden, hoanthanhtu, hoanthanhden, trangthai)
      Dim sql
      sql ="select count(*) as c from DonHang where MaDH !='' "
      if(madh <> "") then
          sql = sql + " and MaDH like '%" & madh & "%'"
        end if
        if (sdt <>"") then
          sql = sql + " and SDTNguoiNhan like '%" & sdt & "%'"
        end if
        if (dathangtu <>"") then
          sql = sql + " and NgayDat >= '" & dathangtu & "'"
        end if
        if (dathangden <>"") then
          sql = sql + " and NgayDat <= '" & dathangden & "'"
        end if
        if (hoanthanhtu <>"") then
          sql = sql + " and NgayHoanThanh >= '" & hoanthanhtu & "'"
        end if
        if (hoanthanhden <>"") then
          sql = sql + " and NgayHoanThanh <= '" & hoanthanhden & "'"
        end if
        if (trangthai <>"") then
          sql = sql + " and TrangThai = " & trangthai & ""
        end if
        if (tichdiem2 <>"") then
          sql = sql + " and DKKhachHang <= " & tichdiem2 & ""
        end if
      Dim connDB
      set connDB = Server.CreateObject("ADODB.Connection")
      Dim strConnection
      strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
      connDB.ConnectionString = strConnection
      connDB.Open()
      Set rs = connDB.execute(sql)
      count = rs.Fields("c")
      connDB.Close()
    end function

    public function countlichsu(tk)
      Dim sql
      sql ="select count(*) as c from DonHang where tk ='" & tk &"'"
      Dim connDB
      set connDB = Server.CreateObject("ADODB.Connection")
      Dim strConnection
      strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
      connDB.ConnectionString = strConnection
      connDB.Open()
      Set rs = connDB.execute(sql)
      countlichsu = rs.Fields("c")
      connDB.Close()
    end function

    public function Ceil(Number)
      Ceil = Int(Number)
      if Ceil<>Number Then
      Ceil = Ceil + 1
      end if
    end function

    public function chiTietDonHang(madh,masp,giasp,sl)
      Dim connDB
      set connDB = Server.CreateObject("ADODB.Connection")
      Dim strConnection
      strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
      connDB.ConnectionString = strConnection
      connDB.Open()
      Set rs = connDB.execute("insert into ChiTietDonHang values("&madh &","&masp&","&giasp&","&sl&")")
      connDB.Close()
    end function

        public function thongKeTheoTrangThaiDonHang(trangthai) 
        Dim sql
        sql ="select count(*) as c from DonHang where TrangThai = " & trangthai
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        Set rs = connDB.execute(sql)
        thongKeTheoTrangThaiDonHang = rs.Fields("c")
        connDB.Close()
    end function
    
    public function thongKeHoanThanhTrongThang(month, nam) 
        Dim sql
        sql ="select count(*) as c from DonHang where TrangThai = 2 and Month(NgayHoanThanh)=" & month  +" and Year(NgayHoanThanh) =" +nam
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        Set rs = connDB.execute(sql)
        thongKeHoanThanhTrongThang = rs.Fields("c")
        connDB.Close()
    end function

    public function doanhThuThangHienTai(thang, nam)
        Dim sql
        sql ="select sum(ThanhToan)  as doanhthu from DonHang where TrangThai ='2' and Month(NgayHoanThanh) =  " + thang +" and Year(NgayHoanThanh) =" +nam
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        Set rs = connDB.execute(sql)
        if(isnull(rs.Fields("doanhthu"))) then
          doanhThuThangHienTai = "0"
        else
          doanhThuThangHienTai = rs.Fields("doanhthu")
        end if
        connDB.Close()
    end function

     public function doanhThuTungThangTrongNam(nam)
        Dim arr()
        Dim sql
        sql ="SELECT CAST(MONTH(NgayHoanThanh) AS VARCHAR(2)) as thang, sum(ThanhToan)  as doanhthu from DonHang where TrangThai ='2'and Year(NgayHoanThanh) = +"&nam&" group by CAST(MONTH(NgayHoanThanh) AS VARCHAR(2))"

        Set datalist = Server.CreateObject("Scripting.Dictionary")

        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        Set rs = connDB.execute(sql)
        Do While Not rs.EOF
          dim t
          t = cint(rs.Fields("thang"))
          datalist.add t , clng(rs.Fields("doanhthu"))
          rs.MoveNext
        Loop
        set doanhThuTungThangTrongNam = datalist
      conndb.Close()
    end function

    public function soDonHangTungThangTrongNam(nam)
        Dim arr()
        Dim sql
        sql ="SELECT CAST(MONTH(NgayHoanThanh) AS VARCHAR(2)) as thang, count(MaDH)  as sldh from DonHang where TrangThai ='2'and Year(NgayHoanThanh) = +"&nam&" group by CAST(MONTH(NgayHoanThanh) AS VARCHAR(2))"

        Set datalist = Server.CreateObject("Scripting.Dictionary")

        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        Set rs = connDB.execute(sql)
        Do While Not rs.EOF
          dim t
          t = cint(rs.Fields("thang"))
          datalist.add t , clng(rs.Fields("sldh"))
          rs.MoveNext
        Loop
        set soDonHangTungThangTrongNam = datalist
      conndb.Close()
    end function
    public function doanhThuNamHienTai(nam)
        Dim sql
        sql ="select sum(ThanhToan)  as doanhthu from DonHang where TrangThai ='2' and Year(NgayDat) =  " & nam
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        Set rs = connDB.execute(sql)
        if(isnull(rs.Fields("doanhthu"))) then
          doanhThuNamHienTai = "0"
        else
          doanhThuNamHienTai = rs.Fields("doanhthu")
        end if
        connDB.Close()
    end function
  End Class
  set dh = new DonHang
  'call dh.taoDonHang("duyhung22","hung","0123456789","haiphong","1118","2023-6-2","30000","500000","500000","500000","1")
%>
