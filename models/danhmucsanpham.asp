<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="../share/connect.asp" -->

<%
Class LoaiSanPham
    'Private, class member variable
    Private p_maloaisp
    Private p_tenloaisp
    ' getter and setter
    ' getter and setter
    Public Property Get Maloaisp()
        Maloaisp = p_maloaisp
    End Property
    Public Property Let Maloaisp(value)
        p_maloaisp = value
    End Property

    Public Property Get Tenloaisp()
        Tenloaisp= p_tenloaisp
    End Property
    Public Property Let Tenloaisp(value)
        p_tenloaisp = value
    End Property

    public function checkTonTai(maloaisp)
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
            checkTonTai = true
        else
            checkTonTai = false
        end if
        connDB.Close()
    end function

    public function getTenLoaiSP(maloaisp)
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        dim sql
        sql = "select TenLoaiSP from LoaiSP where MaLoaiSP = " + maloaisp
        Set rs = connDB.execute(sql)
        if Not rs.EOF then
            getTenLoaiSP = rs.Fields("TenLoaiSP")
        else
            getTenLoaiSP =""
        end if
        connDB.Close()
    end function

    public function getDanhMucLoaiSP(maloaisp)
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        dim sql
        sql = "select MaDM from LoaiSP where MaLoaiSP = " + maloaisp
        Set rs = connDB.execute(sql)
        if Not rs.EOF then
            getDanhMucSP = rs.Fields("MaDM")
        else
            getDanhMucSP =""
        end if
        connDB.Close()
    end function

    public function getList(madm) 
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        Dim listloaisp
        Set listloaisp = Server.CreateObject("Scripting.Dictionary")
        dim sql
        sql = "select TenLoaiSP, MaLoaiSP from LoaiSP where MaDM =  " + madm
        Dim seq
        Set rs = connDB.execute(sql)
        seq = 0
        Do While Not rs.EOF
            seq = seq +1
            set loaisp = New LoaiSanPham
            loaisp.Tenloaisp = rs.Fields("TenLoaiSP")
            loaisp.Maloaisp = rs.Fields("MaLoaiSP")
            listloaisp.add seq, loaisp
            rs.MoveNext
        Loop 
        connDB.Close()
        set getList = listloaisp
    end function
End class
Class DanhMucSanPham
    'Private, class member variable
    Private p_madm
    Private p_tendm
    Private p_loaisanphamArr()
    ' getter and setter
    ' getter and setter
    Public Property Get Madm()
        Madm = p_madm
    End Property
    Public Property Let Madm(value)
        p_madm = value
    End Property

    Public Property Get Tendm()
        Tendm = p_tendm
    End Property
    Public Property Let Tendm(value)
        p_tendm = value
    End Property

    public function getTenDanhMuc(madm)
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        dim sql
        sql = "select TenDM from DanhMucSP where MaDM = " + madm
        Set rs = connDB.execute(sql)
        if Not rs.EOF then
            getTenDanhMuc = rs.Fields("TenDM")
        else
            getTenDanhMuc=""
        end if
        connDB.Close()
    end function

    public function checkTonTai(madm)
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
            checkTonTai = true
        else
            checkTonTai = false
        end if
        connDB.Close()
    end function

    public function getListDanhMuc() 
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        Dim listdanhmuc
        Set listdanhmuc = Server.CreateObject("Scripting.Dictionary")
        dim sql
        sql = "select MaDM,TenDM from DanhMucSP "
        Dim seq
        Set rs = connDB.execute(sql)
        seq = 0
        Do While Not rs.EOF
            seq = seq +1
            set dm = New DanhMucSanPham
            dm.Tendm = rs.Fields("TenDM")
            dm.Madm = rs.Fields("MaDM")
            listdanhmuc.add seq, dm
            rs.MoveNext
        Loop 
        connDB.Close()
        set getListDanhMuc = listDanhMuc
    end function


    public function countDanhMuc() 
        Dim connDB
        set connDB = Server.CreateObject("ADODB.Connection")
        Dim strConnection
        strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
        connDB.ConnectionString = strConnection
        connDB.Open()
        dim sql
        sql ="select count (distinct MaDM) as c from DanhMucSP "
        Dim seq
        Set rs = connDB.execute(sql)
        countDanhMuc = rs.Fields("c")
        connDB.Close()
    end function
End class
    set dmsp = new DanhMucSanPham
    set lsp = new LoaiSanPham
%>