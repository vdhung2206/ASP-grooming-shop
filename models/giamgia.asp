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
    public function getList()
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()

        Dim danhsaschgiamgia
        Set danhsachgiamgia = Server.CreateObject("Scripting.Dictionary")

        Dim gg, seq

        Set rs = connDB.execute("select * from GiamGia")
        seq = 0
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
end class
%>