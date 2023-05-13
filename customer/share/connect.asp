<%
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=DUYHUNG\SQLEXPRESS;Database=DoAnWEB;User Id=sa;Password=duyhung21"
connDB.ConnectionString = strConnection
%>