
<%@ Language="VBScript" %>
<!-- #include file="../share/connect.asp" -->
<!-- #include file="vbsUpload.asp" -->
<%
Dim objUpload, lngLoop

        If Request.TotalBytes > 0 Then
            Set objUpload = New vbsUpload

        For lngLoop = 0 to objUpload.Files.Count - 1
            'If accessing this page annonymously,
            'the internet guest account must have
            'write permission to the path below.
            objUpload.Files.Item(lngLoop).Save "C:\Users\Admin\Desktop\DAWEB\image"
            response.write(objUpload.Files.Item(lngLoop).FileName)
                set connDB = Server.CreateObject("ADODB.Connection")
                strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
                connDB.ConnectionString = strConnection
                connDB.Open()
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "Update SanPham set Hinhanh='../image/" & objUpload.Files.Item(lngLoop).FileName &"' where MaSP =" & session("masp")
                'response.write("Update SanPham set Hinhanh=" & objUpload.Files.Item(lngLoop).FileName &" where MaSP =" & session("masp"))
                cmdPrep.execute
                conndb.Close()
                session.contents.remove("masp")
                response.redirect("/views/sanpham-view.asp")
            Next
        End if

%>