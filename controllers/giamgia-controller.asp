<!--#include file="../models/giamgia.asp" -->
<%
    loai = request.querystring("loai")
    if(loai = "") then
        loai = request.form("loai")
    end if
    Set danhsachgiamgia = Server.CreateObject("Scripting.Dictionary")
    
    if(loai="laydanhsachgiamgia") then
        set gg = new GiamGia
        magg = request.querystring("magg")
        tengg = request.querystring("tengg")
        batdautruoc = request.querystring("batdautruoc")
        batdautu = request.querystring("batdautu")
        ketthuctruoc = request.querystring("ketthuctruoc")
        ketthuctu = request.querystring("ketthuctu")
        tichdiem1 = request.querystring("tichdiem1")
        tichdiem2 = request.querystring("tichdiem2")
        tinhtrang = request.querystring("tinhtrang")
        set danhsachgiamgia = gg.getList(magg,tengg,batdautruoc,batdautu,ketthuctruoc,ketthuctu,tichdiem1,tichdiem2,tinhtrang)
        Response.Write("{")
        Response.Write("""status code"": ""6"",")
        Response.Write("""message"": """",")
        Response.Write("""data"":{ ""danhsachgiamgia"": [")
        dim count 
        count = 0
        for each z in danhsachgiamgia
            count = count + 1
            Response.Write("{")
            Response.Write("")
            response.write("""id"": """)
            response.write(danhsachgiamgia(z).Id)
            response.write(""",")
            response.write("""magg"": """)
            response.write(danhsachgiamgia(z).MaGG)
            response.write("""")
            response.write(",")
            response.write("""tengg"": """)
            response.write(danhsachgiamgia(z).TenGG)
            response.write("""")
            response.write(",")
            response.write("""dkkhachhang"": """)
            response.write(danhsachgiamgia(z).DieuKienKH)
            response.write("""")
            response.write(",")
            response.write("""batdau"": """)
            response.write(danhsachgiamgia(z).BatDau)
            response.write("""")
            response.write(",")
            response.write("""ketthuc"": """)
            response.write(danhsachgiamgia(z).KetThuc)
            response.write("""")
            response.write(",")
            response.write("""phantramgg"": """)
            response.write(danhsachgiamgia(z).PhanTramGG)
            response.write("""")
            response.write(",")
            response.write("""sotiengg"": """)
            response.write(danhsachgiamgia(z).SoTienGG)
            response.write("""")
            Response.Write("}")
            if(count < danhsachgiamgia.count) then
                response.write(",")
            end if
        next
        Response.Write("]")
        Response.Write(",""minTichDiem"":")
        Response.Write(gg.minTichDiem())
        Response.Write("")
        Response.Write(",""maxTichDiem"":")
        Response.Write(gg.maxTichDiem)
        Response.Write("}")
        Response.Write("}")
    end if

%>