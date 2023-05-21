<!--#include file="../models/danhmucsanpham.asp" -->
<%
    ' status code 30: Lay danh sach loai san pham thanh cong
    ' status code 30: Lay danh sach danh muc thanh cong
    loai = request.querystring("loai")
    if(loai = "") then
        loai = request.form("loai")
    end if
    madm = request.querystring("madm")
    
    if(loai = "getList") then
        set classLoaiSP = new LoaiSanPham
        Set listloaisp = Server.CreateObject("Scripting.Dictionary")
        set listloaisp = classLoaiSP.getList(madm)
        Response.Write("{")
        Response.Write("""status code"": ""30"",")
        Response.Write("""message"": """",")
        Response.Write("""data"": { ""listloaisp"": [")
        for each z in listloaisp
            count = count + 1
            Response.Write("{")
            Response.Write("")
            response.write("""tenloaisp"": """)
            response.write(listloaisp(z).Tenloaisp)
            response.write(""",")
            response.write("""maloaisp"": """)
            response.write(listloaisp(z).Maloaisp)
            response.write("""")
            Response.Write("}")
            if(count < listloaisp.count) then
                response.write(",")
            end if
        next
        Response.Write("]}")
        Response.Write("}")
    end if
    if(loai="getListDanhMuc") then
        set dmsp = new DanhMucSanPham
        Set listdanhmuc = Server.CreateObject("Scripting.Dictionary")
        set listDanhMuc = dmsp.getListDanhMuc()
        Response.Write("{")
        Response.Write("""status code"": ""31"",")
        Response.Write("""message"": """",")
        Response.Write("""data"": { ""listdanhmuc"": [")
        for each z in listDanhMuc
            count = count + 1
            Response.Write("{")
            Response.Write("")
            response.write("""tendm"": """)
            response.write(listDanhMuc(z).Tendm)
            response.write(""",")
            response.write("""madm"": """)
            response.write(listDanhMuc(z).Madm)
            response.write("""")
            Response.Write("}")
            if(count < listDanhMuc.count) then
                response.write(",")
            end if
        next
        Response.Write("]}")
        Response.Write("}")
    end if
%>
