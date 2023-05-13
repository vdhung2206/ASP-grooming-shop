<!-- #include file="share/connect.asp" -->
<%
Session("count") = 0
%>
<% 
Dim sqlString, rs
    sqlString = "Select * from SanPham"
    connDB.Open()
    set rs = connDB.execute(sqlString)    
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://use.fontawesome.com/releases/v5.0.4/css/all.css" rel="stylesheet">  
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <title>Document</title>
</head>
<body>
  <!-- #include file="share/header.asp" -->
  <!-- #include file="share/carousel.asp" -->    
  <div class = "container"> 
    <hr>
    <h4 style="text-align: center">Sáp vuốt tóc</h4>
  <div class="d-flex flex-wrap justify-content-start">
    <%
    dim i
    i=0
    do while not rs.eof and i<=7
    %>
      <div class="p-2" style="width:25%; min-width:200px">
        <div class="card pt-10" style="width: 17em; border: none">
          <img src="<%=rs("HinhAnh")%>" class="card-img-top" height=300em alt="...">
            <div class="card-body" style="padding:0">
              <h6 class="text-black-50"><%=rs("LoaiSP")%></h6>
              <h6 class="card-title" style="margin:0"><%=rs("TenSp")%></h6>
              <%
              if(rs("GiaSp")<>rs("GiaGocSp")) then
              response.write("<span class=""text text-decoration-line-through text-black-50"">")
              response.write(rs("GiaGocSp")) 
              response.write("<span class=""text-decoration-underline"">đ</span></span>")
              end if
              %>
              <span class="text fs-5"><%= rs("GiaSp")%> <span class="text-decoration-underline">đ</span></span><br>
            <a href="#" class="btn btn-primary btn-center">Thêm vào giỏ hàng</a>
            </div>
        </div>
      </div>
    <%
        i=i+1
        rs.MoveNext
    loop
    rs.Close()
    connDB.Close()
    %>             
  </div>
  </div>
  <!-- #include file="share/footer.asp" -->
</body>
</html>