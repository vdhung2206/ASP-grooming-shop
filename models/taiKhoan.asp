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

    public function phanTrangTaiKhoan(offset, limit, page)
        set classtk = new TaiKhoan
        totalRows = classtk.count("0")
        if (trim(page) = "") or (isnull(page) or Clng(page)<=0) then
            page = 1
        end if
        pages = Ceil(totalRows/limit)
        if (Clng(pages) < Clng(page)) then
            page = pages
        end if
        offset = (Clng(page) * Clng(limit)) - Clng(limit)
        if(offset < 0) then 
            offset =0
        end if

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
        cmdPrep.CommandText = "SELECT * FROM TaiKhoan where LoaiTK='0' ORDER BY TK OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
        cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
        cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)
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
            'response.write("<tr>")
            'response.write("<td>")
            'response.write(rs.Fields("TK"))
            'response.write("</td>")
            'response.write("<td>")
            'response.write(rs.Fields("Ten"))
            'response.write("</td>")
            'response.write("<td>")
            'response.write(rs.Fields("Sdt"))
            'response.write("</td>")
            'response.write("<td>")
            'response.write(rs.Fields("DiaChi"))
            'response.write("<td>")
            'response.write(rs.Fields("TichDiem"))
            'response.write("</td>")
            'response.write("<td>")
            'if(rs.Fields("TinhTrang")="True") then
              'response.write("Hoạt Động")
            'else 
              'response.write("Khóa")
            'end if       
            'response.write("</td>")
            'response.write("<td>")
              'if(rs.Fields("TinhTrang")="False") then
                'response.write "<a data-bs-toggle=modal data-bs-target=#confirm-unban class=""btn btn-success unban"" onclick="""&"getData('" & rs.Fields("TK") &"','unban')"& """>Mở Khóa</a>"
              'end if
            'response.write("<a style = ""margin-left:3px""href =""#""class =""btn btn-info"">Chi Tiết</a>")
            'response.write("</td>")
            'response.write("</tr>")
            rs.MoveNext
        Loop 
        conndb.Close()
        set phanTrangTaiKhoan = danhsachtaikhoan
    end function

    public function phanTrangTaiKhoanQuanLy(offset, limit, page)
        set classtk = new TaiKhoan
        totalRows = classtk.count("1")
        if (trim(page) = "") or (isnull(page) or Clng(page)<=0) then
            page = 1
        end if
        pages = Ceil(totalRows/limit)
        if (Clng(pages) < Clng(page)) then
            page = pages

        end if
        offset = (Clng(page) * Clng(limit)) - Clng(limit)
        if(offset < 0) then 
            offset =0
        end if

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
        cmdPrep.CommandText = "SELECT * FROM TaiKhoan where LoaiTK='1' ORDER BY TK OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
        cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
        cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)
        Set rs = cmdPrep.execute
        Do While Not rs.EOF
            response.write("<tr>")
            response.write("<td>")
            response.write(rs.Fields("TK"))
            response.write("</td>")
            response.write("<td>")
            response.write(rs.Fields("Ten"))
            response.write("</td>")
            response.write("<td>")
            response.write(rs.Fields("Sdt"))
            response.write("</td>")
            response.write("<td>")
            response.write(rs.Fields("DiaChi"))
            response.write("<td>")
            if(rs.Fields("TinhTrang")="True") then
              response.write("Hoạt Động")
            else 
              response.write("Khóa")
            end if       
            response.write("</td>")
            response.write("<td>")
              if(rs.Fields("TinhTrang")="False") then
                response.write "<a data-bs-toggle=modal data-bs-target=#confirmbanunban class=""btn btn-success"" onclick="""&"getData('" & rs.Fields("TK") &"','unban'); setConfirmBox('" & rs.Fields("TK") &"','unban')"& """>Mở Khóa</a>"
              end if
              if(rs.Fields("TinhTrang")="True") then
                response.write "<a data-bs-toggle=modal data-bs-target=#confirmbanunban class=""btn btn-danger"" onclick="""&"getData('" & rs.Fields("TK") &"','ban'); setConfirmBox('" & rs.Fields("TK") &"','ban')"& """>Khóa</a>"
              end if
            response.write("<a style = ""margin-left:3px""href =""#""class =""btn btn-info"">Chi Tiết</a>")
            response.write("</td>")
            response.write("</tr>")
            rs.MoveNext
        Loop 
        response.write("<tr>")
        response.write("<td style=""display:none"" id=""currentPage"">")
        response.write(page)
        response.write("</td>")
        response.write("<td style=""display:none"" id=""totalPages"">")
        response.write(pages)
        response.write("</td>")
        response.write("</tr>")
        conndb.Close()
        set phanTrangTaiKhoanQuanLy = danhsachtaikhoan
    end function

    public function count(key)
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        if(key = 0 ) then
          Set rs = connDB.execute("select count(*) as c from TaiKhoan where LoaiTK = '0'")
        else
          Set rs = connDB.execute("select count(*) as c from TaiKhoan where LoaiTK = '1'")
        end if
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
        If Err.Number = 0 Then
          Session("Success") = "Mở khóa tài khoản thành công"
        Else
          Session("Error") = Err.Description
        End If
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
        If Err.Number = 0 Then
          Session("Success") = "Khóa tài khoản thành công"
        Else
          Session("Error") = Err.Description
        End If
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
  End Class
%>
