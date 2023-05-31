<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="../share/connect.asp" -->
<%
set connDB = Server.CreateObject("ADODB.Connection")

connDB.ConnectionString = strConnection
%>
<% 
Class SanPham
    'Private, class member variable
    Private p_masp
    Private p_tensp
    Private p_danhMuc
    Private p_loaisp
    private p_hangsp
    Private p_sltonkho
    Private p_giagocsp
    Private p_giamgiasp
    Private p_giasp
    Private p_trangthai 
    Private p_hinhanh
    Private p_chitiet
    ' getter and setter
    ' getter and setter
    Public Property Get Masp()
        Masp = p_masp
    End Property
    Public Property Let Masp(value)
        p_masp = value
    End Property

    Public Property Get TenSP()
        TenSP = p_tensp
    End Property
    Public Property Let TenSP(value)
        p_tensp = value
    End Property

    Public Property Get DanhMuc()
        DanhMuc = p_danhMuc
    End Property
    Public Property Let DanhMuc(value)
        p_danhMuc = value
    End Property

    Public Property Get LoaiSP()
        LoaiSP = p_loaisp
    End Property
    Public Property Let LoaiSP(value)
        p_loaisp = value
    End Property

    Public Property Get HangSP()
        HangSP = p_hangsp
    End Property
    Public Property Let HangSP(value)
        p_hangsp = value
    End Property

    Public Property Get SLTonKho()
        SLTonKho = p_sltonkho
    End Property
    Public Property Let SLTonKho(value)
        p_sltonkho = value
    End Property

    Public Property Get GiaGocSP()
        GiaGocSP = p_giagocsp
    End Property
    Public Property Let GiaGocSP(value)
        p_giagocsp = value
    End Property

    Public Property Get GiamGiaSP()
        GiamGiaSP = p_giamgiasp
    End Property
    Public Property Let GiamGiaSP(value)
        p_giamgiasp = value
    End Property

    Public Property Get GiaSP()
        GiaSP = p_giasp
    End Property
    Public Property Let GiaSP(value)
        p_giasp = value
    End Property

    Public Property Get TrangThai()
        TrangThai = p_trangthai
    End Property
    Public Property Let TrangThai(value)
        p_trangthai = value
    End Property

    Public Property Get HinhAnh()
        HinhAnh = p_hinhanh
    End Property
    Public Property Let HinhAnh(value)
        p_hinhanh = value
    End Property

    Public Property Get ChiTiet()
        ChiTiet = p_chitiet
    End Property
    Public Property Let ChiTiet(value)
        p_chitiet = value
    End Property

    public function layThongTinSanPham(masp)
      Dim connDB
      set connDB = Server.CreateObject("ADODB.Connection")
      Dim strConnection
      strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
      connDB.ConnectionString = strConnection
      connDB.Open()
      dim sql
      sql = "select * from view1_SanPham where MaSP = " + masp
      Set rs = connDB.execute(sql)
      if Not rs.EOF then
        set mySP = New SanPham
        mySP.MaSP = rs.Fields("MaSP")
        mySP.TenSP = rs.Fields("TenSP")
        mySP.LoaiSP = rs.Fields("MaLoaiSP")
        mySP.DanhMuc = rs.Fields("MaDM")
        mySP.HangSP = rs.Fields("HangSP")
        mySP.SLTonKho = rs.Fields("SLTonKho")
        mySP.GiaGocSP = rs.Fields("GiaGocSP")
        mySP.GiamGiaSP= rs.Fields("GiamGiaSP")
        mySP.GiaSP = rs.Fields("GiaSP")
        mySP.HinhAnh = rs.Fields("HinhAnh")
        mySP.ChiTiet = rs.Fields("ChiTiet")
        mySP.TrangThai = rs.Fields("TrangThai")
        set layThongTinSanPham = mySP
      else
        layThongTinSanPham = "nothing"
      end if
      conndb.Close()
    end function

    public function checkTonTaiMaLoaiSP(maloaisp)
      Dim connDB
      set connDB = Server.CreateObject("ADODB.Connection")
      Dim strConnection
      strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
      connDB.ConnectionString = strConnection
      connDB.Open()
      dim sql
      sql = "select count(*) as c from LoaiSP where MaLoaiSP = " + maloaisp
      Set rs = connDB.execute(sql)
      if(rs.Fields("c")>0) then
          checkTonTaiMaLoaiSP = true
      else
          checkTonTaiMaLoaiSP = false
      end if
      connDB.Close()
    end function

    public function checkTonTaiMaDMSP(madm)
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        dim sql
        sql = "select count(*) as c from DanhMucSP where MaDM = " + madm
        Set rs = connDB.execute(sql)
        if(rs.Fields("c")>0) then
            checkTonTaiMaDMSP = true
        else
            checkTonTaiMaDMSP = false
        end if
        connDB.Close()
    end function
    public function phanTrangSanPham(limit, page, tenspsearch,danhmucsearch,loaispsearch,hangspsearch,sltonkhosearch1,sltonkhosearch2,giasp1search,giasp2search,trangthaisearch,sapxepphobien, sapxepgia,sapxeptonkho)
        set classSP = new SanPham
        totalRows = classSP.count(tenspsearch,danhmucsearch,loaispsearch,hangspsearch,sltonkhosearch1,sltonkhosearch2,giaspsearch,trangthaisearch)
        pages = Ceil(totalRows/limit)
        if (Clng(pages) < Clng(page)) then
            page = pages
        end if
        offset = (Clng(page) * Clng(limit)) - Clng(limit)
        if(offset < 0) then 
            offset =0
        end if
        Dim sql
        sql = "select * from view1_SanPham where TenSP !=''"
        if(tenspsearch <> "") then
          sql = sql + " and TenSP like '%" & tenspsearch & "%'"
        end if
        if (danhmucsearch <>"") then
          sql = sql + " and MaDM = '" & danhmucsearch & "'"
        end if
        if (loaispsearch <>"") then
          sql = sql + " and MaLoaiSP = '" & loaispsearch & "'"
        end if
        if (hangspsearch <>"") then
          sql = sql + " and HangSP like '%" & hangspsearch & "%'"
        end if
        if (sltonkhosearch1 <>"") then
          sql = sql + " and SLTonKho >= " & sltonkhosearch1 & ""
        end if
        if (sltonkhosearch2 <>"") then
          sql = sql + " and SLTonKho <= " & sltonkhosearch2 & ""
        end if
        if (giasp1search <>"") then
          sql = sql + " and GiaSP >= " & giasp1search & ""
        end if
        if (giasp2search <>"") then
          sql = sql + " and GiaSP =< " & giasp2search & ""
        end if
        if(trangthaisearch ="0")then
          sql = sql +" and TrangThai='0'"
        end If
        if(trangthaisearch ="1")then
          sql = sql +" and TrangThai='1'"
        end If
        sql = sql + "order by "
        if (sapxepphobien ="" and sapxepgia ="" and sapxeptonkho="") then
          sql = sql + " TenSP,"
        end if
        if (sapxepphobien ="1") then
          'xu ly
        end if
        if (sapxepgia ="1") then
          sql = sql + " GiaSP,"
        end if
        if (sapxepgia ="0") then
          sql = sql + " GiaSP desc,"
        end if
        if (sapxeptonkho="0") then
          sql = sql + " SLTonKho,"
        end if
        if (sapxeptonkho="1") then
          sql = sql + " SLTonKho desc,"
        end if
        If Len(sql) > 0 Then
          sql = Left(sql, Len(sql) - 1)
        End If
        sql = sql + " offset " & offset &" rows fetch next " & limit &" rows only"
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()

        Dim danhsachsanpham
        Set danhsachsanpham = Server.CreateObject("Scripting.Dictionary")

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = sql
        Set rs = cmdPrep.execute
        Do While Not rs.EOF
            seq = seq+1
            set mySP = New SanPham
            mySP.MaSP = rs.Fields("MaSP")
            mySP.TenSP = rs.Fields("TenSP")
            mySP.LoaiSP = rs.Fields("TenLoaiSP")
            mySP.DanhMuc = rs.Fields("TenDM")
            mySP.HangSP = rs.Fields("HangSP")
            mySP.SLTonKho = rs.Fields("SLTonKho")
            mySP.GiaGocSP = rs.Fields("GiaGocSP")
            mySP.GiamGiaSP= rs.Fields("GiamGiaSP")
            mySP.GiaSP = rs.Fields("GiaSP")
            mySP.HinhAnh = rs.Fields("HinhAnh")
            mySP.ChiTiet = rs.Fields("ChiTiet")
            mySP.TrangThai = rs.Fields("TrangThai")
            danhsachsanpham.add seq, mySP
            rs.MoveNext
        Loop 
        conndb.Close()
        set phantrangsanpham = danhsachsanpham
    end function

    public function gioHang()
        set classSP = new SanPham
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()

        Dim danhsachsanpham
        Set danhsachsanpham = Server.CreateObject("Scripting.Dictionary")

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = sql
        Set rs = cmdPrep.execute
        Do While Not rs.EOF
            seq = seq+1
            set mySP = New SanPham
            mySP.MaSP = rs.Fields("MaSP")
            mySP.TenSP = rs.Fields("TenSP")
            mySP.LoaiSP = rs.Fields("TenLoaiSP")
            mySP.DanhMuc = rs.Fields("TenDM")
            mySP.HangSP = rs.Fields("HangSP")
            mySP.SLTonKho = rs.Fields("SLTonKho")
            mySP.GiaGocSP = rs.Fields("GiaGocSP")
            mySP.GiamGiaSP= rs.Fields("GiamGiaSP")
            mySP.GiaSP = rs.Fields("GiaSP")
            mySP.HinhAnh = rs.Fields("HinhAnh")
            mySP.ChiTiet = rs.Fields("ChiTiet")
            mySP.TrangThai = rs.Fields("TrangThai")
            danhsachsanpham.add seq, mySP
            rs.MoveNext
        Loop 
        conndb.Close()
        set giohang = danhsachsanpham
    end function

    Public Function themSanPham(tensp, maloaisp, hangsp, sltonkho, giagocsp, hinhanh, chitiet)
    Dim sql
    sql = "INSERT INTO SanPham VALUES (?,?,?,?,?,0,?,'1',?,?)"
    
    Dim cmdPrep
    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.Prepared = True
    cmdPrep.CommandText = sql
    
    cmdPrep.Parameters.Append cmdPrep.CreateParameter(, 200, 1, 255, tensp)
    cmdPrep.Parameters.Append cmdPrep.CreateParameter(, 200, 1, 255, maloaisp)
    cmdPrep.Parameters.Append cmdPrep.CreateParameter(, 200, 1, 255, hangsp)
    cmdPrep.Parameters.Append cmdPrep.CreateParameter(, 3, 1, , sltonkho)
    cmdPrep.Parameters.Append cmdPrep.CreateParameter(, 3, 1, , giagocsp)
    cmdPrep.Parameters.Append cmdPrep.CreateParameter(, 3, 1, , giagocsp)
    cmdPrep.Parameters.Append cmdPrep.CreateParameter(, 200, 1, 255, hinhanh)
    cmdPrep.Parameters.Append cmdPrep.CreateParameter(, 200, 1, 255, chitiet)
    
    cmdPrep.Execute()
    connDB.Close()
End Function

    public function countMinTonKho(tensp,danhmuc,loaisp,hangsp,sltonkho1,sltonkho2,giasp,trangthai) 
      Dim sql
      sql ="select min(SLTonKho) as c from view1_SanPham where MaSP !='' "
      if(tensp <> "") then
        sql = sql + " and TenSP like '%" & tensp & "%'"
      end if
      if (danhmuc <>"") then
        sql = sql + " and MaDM like '%" & danhmuc & "%'"
      end if
      if (loaisp <>"") then
        sql = sql + " and MaLoaiSP like '%" & loaisp & "%'"
      end if
      if (hangsp <>"") then
        sql = sql + " and HangSP like '%" & hangsp & "%'"
      end if
      if (sltonkho1 <>"") then
        sql = sql + " and SLTonKho >= " & sltonkho1 & ""
      end if
      if (sltonkho2 <>"") then
        sql = sql + " and SLTonKho <= " & sltonkho2 & ""
      end if
      if (giasp <>"") then
        sql = sql + " and GiaSP = " & giasp & ""
      end if
      if (trangthai <>"") then
        sql = sql + " and TrangThai = " & trangthai & ""
      end if
      Dim connDB
      set connDB = Server.CreateObject("ADODB.Connection")
      Dim strConnection
      strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
      connDB.ConnectionString = strConnection
      connDB.Open()
      Set rs = connDB.execute(sql)
      if(rs.Fields("c")<>"") then
        countMinTonKho = rs.Fields("c")
      else
        countMinTonKho ="0"
      end if
      connDB.Close()
    end function

    public function minGiaSP(tensp,danhmuc,loaisp,hangsp,sltonkho1,sltonkho2,giasp,trangthai) 
      Dim sql
      sql ="select min(GiaSP) as c from view1_SanPham where MaSP !='' "
      if(tensp <> "") then
        sql = sql + " and TenSP like '%" & tensp & "%'"
      end if
      if (danhmuc <>"") then
        sql = sql + " and MaDM like '%" & danhmuc & "%'"
      end if
      if (loaisp <>"") then
        sql = sql + " and MaLoaiSP like '%" & loaisp & "%'"
      end if
      if (hangsp <>"") then
        sql = sql + " and HangSP like '%" & hangsp & "%'"
      end if
      if (sltonkho1 <>"") then
        sql = sql + " and SLTonKho >= " & sltonkho1 & ""
      end if
      if (sltonkho2 <>"") then
        sql = sql + " and SLTonKho <= " & sltonkho2 & ""
      end if
      if (giasp <>"") then
        sql = sql + " and GiaSP = " & giasp & ""
      end if
      if (trangthai <>"") then
        sql = sql + " and TrangThai = " & trangthai & ""
      end if
      Dim connDB
      set connDB = Server.CreateObject("ADODB.Connection")
      Dim strConnection
      strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
      connDB.ConnectionString = strConnection
      connDB.Open()
      Set rs = connDB.execute(sql)
      if(rs.Fields("c")<>"") then
        minGiaSP = rs.Fields("c")
      else
        minGiaSP ="0"
      end if
      connDB.Close()
    end function

    public function countMaxTonKho(tensp,danhmuc,loaisp,hangsp,sltonkho1,sltonkho2,giasp,trangthai) 
      Dim sql
      sql ="select max(SLTonKho) as c from view1_SanPham where MaSP !='' "
      if(tensp <> "") then
        sql = sql + " and TenSP like '%" & tensp & "%'"
      end if
      if (danhmuc <>"") then
        sql = sql + " and MaDM like '%" & danhmuc & "%'"
      end if
      if (loaisp <>"") then
        sql = sql + " and MaLoaiSP like '%" & loaisp & "%'"
      end if
      if (hangsp <>"") then
        sql = sql + " and HangSP like '%" & hangsp & "%'"
      end if
      if (sltonkho1 <>"") then
        sql = sql + " and SLTonKho >= " & sltonkho1 & ""
      end if
      if (sltonkho2 <>"") then
        sql = sql + " and SLTonKho <= " & sltonkho2 & ""
      end if
      if (giasp <>"") then
        sql = sql + " and GiaSP = " & giasp & ""
      end if
      if (trangthai <>"") then
        sql = sql + " and TrangThai = " & trangthai & ""
      end if
      Dim connDB
      set connDB = Server.CreateObject("ADODB.Connection")
      Dim strConnection
      strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
      connDB.ConnectionString = strConnection
      connDB.Open()
      Set rs = connDB.execute(sql)
      if(rs.Fields("c")<>"") then
        countMaxTonKho = rs.Fields("c")
      else
        countMaxTonKho ="0"
      end if
      connDB.Close()
    end function

    public function Ceil(Number)
      Ceil = Int(Number)
      if Ceil<>Number Then
      Ceil = Ceil + 1
      end if
    end function
    public function timKiemSanPham(tensp,hangsp,danhmucsp,loaisp)
        set classSP = new SanPham
        Dim sql
        if (tensp<>"" or hangsp<>"" or danhmucsp<>"" or loaisp<>"") then
          sql = "select * from view1_SanPham where"
          if(tensp <>"") then
            sql = sql +" TenSP like'%" & tensp & "%' and"
          end if
          if(hangsp <>"") then
              sql = sql +" HangSP ='" & hangsp & "' and"
          end if
          if(danhmucsp <>"") then
            sql = sql +" MaDM =" & danhmucsp & "and"
          end if
          if(danhmucsp ="")then
            sql = sql +" MaDM !='' and"
          end if
          if(loaisp <>"") then
            sql = sql +" MaLoaiSP =" & loaisp & "and"
          end if
          if(danhmucsp ="")then
            sql = sql +" MaLoaiSP !='' and"
          end if
          sql = Left(sql, Len(sql) - 3)
        else
          sql = "select * from view1_SanPham where 1=2"
        end if
        'response.write(sql)
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()

        Dim danhsachsanpham
        Set danhsachsanpham = Server.CreateObject("Scripting.Dictionary")

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = sql
        Set rs = cmdPrep.execute
        Do While Not rs.EOF
            seq = seq+1
            set mySP = New SanPham
            mySP.MaSP = rs.Fields("MaSP")
            mySP.TenSP = rs.Fields("TenSP")
            danhsachsanpham.add seq, mySP
            rs.MoveNext
        Loop 
        conndb.Close()
        set timkiemsanpham = danhsachsanpham
    end function
    public function getHang()
      Dim connDB
      set connDB = Server.CreateObject("ADODB.Connection")
      Dim strConnection
      strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
      connDB.ConnectionString = strConnection
      connDB.Open()

      Dim danhsachhang
      Set danhsachhang = Server.CreateObject("Scripting.Dictionary")

      dim sql
      sql = "select distinct HangSP from SanPham"
      Set rs = connDB.execute(sql)
      Do While Not rs.EOF
        seq = seq+1
        set mySP = New SanPham
        mySP.HangSP = rs.Fields("HangSP")
        danhsachhang.add seq, mySP
        rs.MoveNext
      Loop
        set getHang = danhsachhang
      conndb.Close()
    end function
    public function suaThongTin(masp,tensp,maloaisp,hangsp,sltonkho,giagocsp,giamgiasp,trangthai,chitiet)
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
      cmdPrep.CommandText = "Update SanPham set TenSp = ?, MaLoaiSP =?, HangSP =?, SLTonKho =?, GiaGocSP = ?, GiamGiaSP=?, TrangThai=?, ChiTiet=? where MaSP = ?"
      cmdPrep.Parameters(0)=tensp
      cmdPrep.Parameters(1)=maloaisp
      cmdPrep.Parameters(2)=hangsp
      cmdPrep.Parameters(3)=sltonkho
      cmdPrep.Parameters(4)=giagocsp
      cmdPrep.Parameters(5)=giamgiasp
      cmdPrep.Parameters(6)=trangthai
      cmdPrep.Parameters(7)=chitiet
      cmdPrep.Parameters(8)=masp
      cmdPrep.execute
      conndb.Close()
    end function
    public function count(tensp,danhmuc,loaisp,hangsp,sltonkho1,sltonkho2,giasp,trangthai)
      Dim sql
      sql ="select count(*) as c from view1_SanPham where MaSP !='' "
      if(tensp <> "") then
        sql = sql + " and TenSP like '%" & tensp & "%'"
      end if
      if (danhmuc <>"") then
        sql = sql + " and MaDM like '%" & danhmuc & "%'"
      end if
      if (loaisp <>"") then
        sql = sql + " and MaLoaiSP like '%" & loaisp & "%'"
      end if
      if (hangsp <>"") then
        sql = sql + " and HangSP like '%" & hangsp & "%'"
      end if
      if (sltonkho1 <>"") then
        sql = sql + " and SLTonKho >= " & sltonkho1 & ""
      end if
      if (sltonkho2 <>"") then
        sql = sql + " and SLTonKho <= " & sltonkho2 & ""
      end if
      if (giasp <>"") then
        sql = sql + " and GiaSP = " & giasp & ""
      end if
      if (trangthai <>"") then
        sql = sql + " and TrangThai = " & trangthai & ""
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
End Class
  set sp = new SanPham
  call sp.timkiemsanpham("","","","")
  'response.write(sp.suaThongTin("2","Hanz de Fuko Quicksand","1","Hanz De Fuko keke","9","560000","0","1","ko co gi"))
%>