<!-- #include file="../share/connect.asp" -->
<%
    Class GiamGia
    'Private, class member variable
    private p_id
    Private p_magg
    Private p_tengg
    Private p_dieukienkh
    Private p_batdau
    Private p_kethuc
    Private p_phantramgg
    Private p_sotiengg

    Public Property Get Id()
        Id = p_id
    End Property
    Public Property Let Id(value)
        p_id= value
    End Property

    Public Property Get MaGG()
        MaGG = p_magg
    End Property
    Public Property Let MaGG(value)
        p_magg= value
    End Property

    Public Property Get TenGG()
        TenGG = p_tengg
    End Property
    Public Property Let TenGG(value)
        p_tengg = value
    End Property

    Public Property Get DieuKienKH()
        DieuKienKH = p_dieukienkh
    End Property
    Public Property Let DieuKienKH(value)
        p_dieukienkh = value
    End Property

    Public Property Get BatDau()
        BatDau = p_batdau
    End Property
    Public Property Let BatDau(value)
        p_batdau = value
    End Property

    Public Property Get KetThuc()
        KetThuc = p_kethuc
    End Property
    Public Property Let KetThuc(value)
        p_kethuc = value
    End Property

    Public Property Get PhanTramGG()
        PhanTramGG = p_phantramgg
    End Property
    Public Property Let PhanTramGG(value)
        p_phantramgg = value
    End Property

    Public Property Get SoTienGG()
        SoTienGG = p_sotiengg
    End Property
    Public Property Let SoTienGG(value)
        p_sotiengg = value
    End Property
    ' getter and setter
    public function getList(magg,tengg,batdautruoc,batdautu,ketthuctruoc,ketthuctu,tichdiem1,tichdiem2,tinhtrang)
        set gg = new GiamGia
        Dim sql
        sql = "select * from GiamGia where TenGG != ''"
        if(magg <> "") then
          sql = sql + " and MaGG like '%" & magg & "%'"
        end if
        if (tengg <>"") then
          sql = sql + " and TenGG like '%" & tengg & "%'"
        end if
        if (batdautruoc <>"") then
          sql = sql + " and BatDau < '" & batdautruoc & "'"
        end if
        if (batdautu <>"") then
          sql = sql + " and BatDau >= '" & batdautu & "'"
        end if
        if (ketthuctruoc <>"") then
          sql = sql + " and KetThuc < '" & ketthuctruoc & "'"
        end if
        if (ketthuctu <>"") then
          sql = sql + " and KetThuc > '" & ketthuctu & "'"
        end if
        if (tichdiem1 <>"") then
          sql = sql + " and DKKhachHang >= " & tichdiem1 & ""
        end if
        if (tichdiem2 <>"") then
          sql = sql + " and DKKhachHang <= " & tichdiem2 & ""
        end if
        if(tinhtrang ="0")then
          sql = sql +" and KetThuc < getDate()"
        end If
        if(tinhtrang ="1")then
          sql = sql +" and KetThuc >= getDate()"
        end If

        sql = sql + "order by DKKhachHang"
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()

        Dim danhsachgiamgia
        Set danhsachgiamgia = Server.CreateObject("Scripting.Dictionary")

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = sql
        Set rs = cmdPrep.execute
        Do While Not rs.EOF
            seq = seq+1
            set gg = New GiamGia
            gg.Id = rs.Fields("IDGiamGia")
            gg.MaGG = rs.Fields("MaGG")
            gg.TenGG = rs.Fields("TenGG")
            gg.DieuKienKH = rs.Fields("DKKhachHang")
            gg.BatDau = rs.Fields("BatDau")
            gg.KetThuc = rs.Fields("KetThuc")
            gg.PhanTramGG = rs.Fields("PhanTramGG")
            gg.SoTienGG = rs.Fields("SoTienGG")
            danhsachgiamgia.add seq, gg
            rs.MoveNext
        Loop 
        connDB.Close()
        set getList = danhsachgiamgia
    end function

    function getTichDiem(uid)
      Dim sql
      sql = "select TichDiem from TaiKhoan where UID=?"
      Dim cmdPrep
      set cmdPrep = Server.CreateObject("ADODB.Command")
      connDB.Open()
      cmdPrep.ActiveConnection = connDB
      cmdPrep.CommandType=1
      cmdPrep.Prepared=true
      cmdPrep.CommandText = sql
      cmdPrep.Parameters(0)=uid
      Dim result
      set result = cmdPrep.execute()
      getTichDiem = result("TichDiem")
      connDB.Close()
    end function
    public function checkTonTai(magg)
        Dim sql
        sql = "select * from GiamGia where MaGG ='" + magg +"'"
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
        Set rs = cmdPrep.execute
        If Not rs.EOF then
            set gg = New GiamGia
            gg.Id = rs.Fields("IDGiamGia")
            gg.MaGG = rs.Fields("MaGG")
            gg.TenGG = rs.Fields("TenGG")
            gg.DieuKienKH = rs.Fields("DKKhachHang")
            gg.BatDau = rs.Fields("BatDau")
            gg.KetThuc = rs.Fields("KetThuc")
            gg.PhanTramGG = rs.Fields("PhanTramGG")
            gg.SoTienGG = rs.Fields("SoTienGG")
            set checkTonTai = gg
        Else 
            set gg = New GiamGia
            gg.Id = ""
            set checkTonTai = gg
        End if
        connDB.Close()
    end function
     function minTichDiem() 
       Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()

        Dim tk, seq
        Set rs = connDB.execute("select min(DKKhachHang) as c from GiamGia ")
        If Not rs.EOF then
          minTichDiem = rs.Fields("c")
        end if
        connDB.Close()
    end function
    function ggKhachHang(magg, tengg,tichdiemgg,batdaugg, ketthucgg, phantramgg, sotiengg)
      Dim sql
      sql= "insert into GiamGia values('"+magg+"','"+tengg+"',"+tichdiemgg+",'"+batdaugg+"','"+ketthucgg+" 23:59:59',"
      if(phantramgg <>"") then
        sql = sql + phantramgg +",null)"
      end if
      if(sotiengg <>"") then
        sql = sql +"null,"+sotiengg+")"
      end if
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
      ggKhachHang = rs.Fields("idgiamgia")
      connDB.Close()
    end function

    function suaChiTietGiamGia(idgiamgia, masp)
      Dim connDB
      set connDB = Server.CreateObject("ADODB.Connection")
      Dim strConnection
      strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
      connDB.ConnectionString = strConnection
      connDB.Open()

      Dim tk, seq
      Set rs = connDB.execute("insert into ChiTietGiamGia values('"+idgiamgia +"','"+masp+"')")
      connDB.Close()
    end function
    function maxTichDiem() 
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()

        Dim tk, seq
        Set rs = connDB.execute("select max(DKKhachHang) as c from GiamGia ")
        If Not rs.EOF then
          maxTichDiem = rs.Fields("c")
        end if
        connDB.Close()
    end function
end class
    set gg = new GiamGia
%>