<!-- #include file="../share/connect.asp" -->
<%
set connDB = Server.CreateObject("ADODB.Connection")

connDB.ConnectionString = strConnection
%>
<% 
  Class TaiKhoan
    'Private, class member variable
    Private p_tk
    Private p_mk
    Private p_ten
    Private p_sdt
    private p_diachi
    Private p_loaitk
    Private p_tinhtrang
    Private p_tichdiem
    ' getter and setter
    Public Property Get Tk()
      Tk = p_tk
    End Property
    Public Property Let Tk(value)
      p_tk = value
    End Property

    Public Property Get Mk()
      Mk = p_mk
    End Property
    Public Property Let Mk(value)
      p_mk = value
    End Property
    
    Public Property Get Ten()
      Ten = p_ten
    End Property
    Public Property Let Ten(value)
      p_ten = value
    End Property

    Public Property Get Sdt()
      Sdt = p_sdt
    End Property
    Public Property Let Sdt(value)
      p_sdt = value
    End Property
    
    Public Property Get Loaitk()
      Loaitk = p_loaitk
    End Property
    Public Property Let Loaitk(value)
      p_loaitk = value
    End Property

    Public Property Get Tinhtrang()
      Tinhtrang = p_tinhtrang
    End Property
    Public Property Let Tinhtrang(value)
      p_tinhtrang = value
    End Property
    
    Public Property Get Tichdiem()
      Tichdiem = p_tichdiem
    End Property
    Public Property Let Tichdiem(value)
      p_tichdiem = value
    End Property

    Public Property Get Diachi()
      Diachi = p_diachi
    End Property
    Public Property Let DiaChi(value)
      p_diachi = value
    End Property

    public function getList()
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()

        Dim danhsachtaikhoan
        Set danhsachtaikhoan = Server.CreateObject("Scripting.Dictionary")

        Dim tk, seq

        Set rs = connDB.execute("select * from TaiKhoan where LoaiTK = '0'")
        seq = 0
        Do While Not rs.EOF
            seq = seq+1
            set tk = New TaiKhoan
            tk.Tk = rs.Fields("TK")
            tk.Mk = rs.Fields("MK")
            tk.Ten = rs.Fields("Ten")
            tk.Sdt = rs.Fields("SDT")
            tk.Diachi = rs.Fields("DiaChi")
            tk.Loaitk = rs.Fields("LoaiTK")
            tk.Tinhtrang = rs.Fields("TinhTrang")
            tk.Tichdiem = rs.Fields("TichDiem")
            danhsachtaikhoan.add seq, tk
            rs.MoveNext
        Loop 
        connDB.Close()
        set getList = danhsachtaikhoan
    end function
    public function Ceil(Number)
      Ceil = Int(Number)
      if Ceil<>Number Then
      Ceil = Ceil + 1
      end if
    end function

    function checkPage(cond, ret) 
      if cond=true then
        Response.write ret
      else
        Response.write ""
      end if
    end function

    public function phanTrangTaiKhoan(loaitk,limit, page, taikhoansearch,tennguoidung,diachi,sodienthoai,tichdiem,trangthai,sapxepten,sapxepdiachi,sapxeptichdiem)
        set classtk = new TaiKhoan
        totalRows = classtk.count(loaitk,taikhoansearch,tennguoidung,diachi,sodienthoai,tichdiem,trangthai)
        pages = Ceil(totalRows/limit)
        if (Clng(pages) < Clng(page)) then
            page = pages
        end if
        offset = (Clng(page) * Clng(limit)) - Clng(limit)
        if(offset < 0) then 
            offset =0
        end if
        Dim sql
        if(loaitk = "0") then
          sql = "select * from TaiKhoan where LoaiTK='0'"
        else
          sql = "select * from TaiKhoan where LoaiTK='1'"
        end if
        if(taikhoansearch <> "") then
          sql = sql + " and TK like '%" & taikhoansearch & "%'"
        end if
        if (tennguoidung <>"") then
          sql = sql + " and Ten like '%" & tennguoidung & "%'"
        end if
        if (diachi <>"") then
          sql = sql + " and DiaChi like '%" & diachi & "%'"
        end if
        if (sodienthoai <>"") then
          sql = sql + " and SDT like '%" & sodienthoai & "%'"
        end if
        if (tichdiem <>"") then
          sql = sql + " and TichDiem > " & tichdiem & ""
        end if
        if (trangthai <>"") then
          sql = sql + " and TinhTrang = " & trangthai & ""
        end if
        sql = sql + "order by "
        if (sapxeptichdiem ="0") then
          sql = sql + " TichDiem,"
        end if
        if (sapxeptichdiem ="1") then
          sql = sql + " TichDiem desc,"
        end if
        if(sapxepten ="" and sapxepdiachi ="" and sapxeptichdiem ="") then
          sql = sql + " TK,"
        end if
        if (sapxepten ="0") then
          sql = sql + " Ten,"
        end if
        if (sapxepten ="1") then
          sql = sql + " Ten desc,"
        end if
        if (sapxepdiachi ="0") then
          sql = sql + " DiaChi,"
        end if
        if (sapxepdiachi ="1") then
          sql = sql + " DiaChi desc,"
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

        Dim danhsachtaikhoan
        Set danhsachtaikhoan = Server.CreateObject("Scripting.Dictionary")

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = sql
        Set rs = cmdPrep.execute
        Do While Not rs.EOF
            seq = seq+1
            set myTK = New TaiKhoan
            myTK.Tk = rs.Fields("TK")
            myTK.Mk = rs.Fields("MK")
            myTK.Ten = rs.Fields("Ten")
            myTK.Sdt = rs.Fields("SDT")
            myTK.Loaitk = rs.Fields("LoaiTK")
            myTK.Tinhtrang = rs.Fields("TinhTrang")
            myTK.Tichdiem= rs.Fields("TichDiem")
            myTK.Diachi = rs.Fields("DiaChi")
            danhsachtaikhoan.add seq, myTK
            rs.MoveNext
        Loop 
        conndb.Close()
        set phanTrangTaiKhoan = danhsachtaikhoan
    end function

    public function count(loaitk,taikhoansearch,tennguoidung,diachi,sodienthoai,tichdiem,trangthai)
      Dim sql
      sql ="select count(*) as c from TaiKhoan where"
      if(loaitk = "0") then
        sql = sql +" LoaiTK='0'"
      end if
      if(loaitk = "1") then
        sql = sql +" LoaiTK='1'"
      end if
      if(taikhoansearch <> "") then
        sql = sql + " and TK like '%" & taikhoansearch & "%'"
      end if
      if (tennguoidung <>"") then
        sql = sql + " and Ten like '%" & tennguoidung & "%'"
      end if
      if (diachi <>"") then
        sql = sql + " and DiaChi like '%" & diachi & "%'"
      end if
      if (sodienthoai <>"") then
        sql = sql + " and SDT like '%" & sodienthoai & "%'"
      end if
      if (tichdiem <>"") then
        sql = sql + " and TichDiem > " & tichdiem & ""
      end if
      if (trangthai <>"") then
        sql = sql + " and TinhTrang = " & trangthai & ""
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
    
    public sub moKhoaTaiKhoan(tentk)
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        if (isnull(tentk) OR trim(tentk)="") then
          Response.End
        else
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "Update TaiKhoan set TinhTrang = 1 where TK=?"
        cmdPrep.Parameters(0)=tentk
        cmdPrep.execute
        conndb.Close()
        end if
    end sub

    public sub khoaTaiKhoan(tentk)
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        if (isnull(tentk) OR trim(tentk)="") then
          Response.End
        else
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "Update TaiKhoan set TinhTrang = 0 where TK=?"
        cmdPrep.Parameters(0)=tentk
        cmdPrep.execute
        conndb.Close()
        end if
    end sub

    'Ham tim kiem tai khoan
    function checkTonTai(tk)
      Dim sql
      sql = "select count(*) as c from TaiKhoan where TK=?"
      Dim cmdPrep
      set cmdPrep = Server.CreateObject("ADODB.Command")
      connDB.Open()
      cmdPrep.ActiveConnection = connDB
      cmdPrep.CommandType=1
      cmdPrep.Prepared=true
      cmdPrep.CommandText = sql
      cmdPrep.Parameters(0)=tk
      Dim result
      set result = cmdPrep.execute()
      If(result("c")<>0) Then
        checkTonTai = true
      Else
        checkTonTai = false
      End if
      result.Close()
      connDB.Close()
    end function

    function checkMK(tk,mk)
      Dim sql
      sql = "select count(*) as c from TaiKhoan where TK=? and MK=?"
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
      if(result("c")<>0) then
        checkMK = True
      else
        checkMK = False
      end if
      connDB.Close()
    end function

    function getLoaiTK(tk)
      Dim sql
      sql = "select LoaiTK from TaiKhoan where TK=?"
      Dim cmdPrep
      set cmdPrep = Server.CreateObject("ADODB.Command")
      connDB.Open()
      cmdPrep.ActiveConnection = connDB
      cmdPrep.CommandType=1
      cmdPrep.Prepared=true
      cmdPrep.CommandText = sql
      cmdPrep.Parameters(0)=tk
      Dim result
      set result = cmdPrep.execute()
      getLoaiTK = result("LoaiTK")
      connDB.Close()
    end function

    function getTinhTrang(tk)
      Dim sql
      sql = "select TinhTrang from TaiKhoan where TK=?"
      Dim cmdPrep
      set cmdPrep = Server.CreateObject("ADODB.Command")
      connDB.Open()
      cmdPrep.ActiveConnection = connDB
      cmdPrep.CommandType=1
      cmdPrep.Prepared=true
      cmdPrep.CommandText = sql
      cmdPrep.Parameters(0)=tk
      Dim result
      set result = cmdPrep.execute()
      getTinhTrang = result("TinhTrang")
      connDB.Close()
    end function

    function getUID(tk)
      Dim sql
      sql = "select UID from TaiKhoan where TK=?"
      Dim cmdPrep
      set cmdPrep = Server.CreateObject("ADODB.Command")
      connDB.Open()
      cmdPrep.ActiveConnection = connDB
      cmdPrep.CommandType=1
      cmdPrep.Prepared=true
      cmdPrep.CommandText = sql
      cmdPrep.Parameters(0)=tk
      Dim result
      set result = cmdPrep.execute()
      getUID = result("UID")
      connDB.Close()
    end function

    function kiemTraDinhDangTK(tk) 
      If Len(tk) >= 6 And Len(tk) <= 25 And InStr(tk, " ") = 0 Then
        kiemTraDinhDangTK = true
      Else
        kiemTraDinhDangTK = false
      End If
    end function

    function kiemTraDinhDangMK(mk)
    Dim regex
    Set regex = New RegExp
    regex.Pattern = "\d" ' Biểu thức chính quy kiểm tra có ít nhất một số trong chuỗi
    If (Len(mk) >= 6 And regex.Test(mk)) Then
      kiemTraDinhDangMK = true
    Else
      kiemTraDinhDangMK = false
    End If
    end function

    function kiemTraDinhDangSDT(sdt)
      Dim regex
      Set regex = New RegExp
      regex.Pattern = "^0\d{9}$" ' Biểu thức chính quy kiểm tra có ít nhất một số trong chuỗi
      If (Len(sdt) >= 6 And regex.Test(sdt)) Then
        kiemTraDinhDangSDT = true
      Else
        kiemTraDinhDangSDT = false
      End If
    end function

    function taoTaiKhoanQuanLy(tk, mk ,sdt, ten, diachi)
      Dim sql
      sql = "insert into TaiKhoan values (?,?,?,?,'1','1',null,?)"
      Dim cmdPrep
      set cmdPrep = Server.CreateObject("ADODB.Command")
      connDB.Open()
      cmdPrep.ActiveConnection = connDB
      cmdPrep.CommandType=1
      cmdPrep.Prepared=true
      cmdPrep.CommandText = sql
      cmdPrep.Parameters(0)=tk
      cmdPrep.Parameters(1)=mk
      cmdPrep.Parameters(2)=sdt
      cmdPrep.Parameters(3)=ten
      cmdPrep.Parameters(4)=diachi
      cmdPrep.execute()
      connDB.Close()
    end function
  End Class
  set tk = new TaiKhoan
%>
