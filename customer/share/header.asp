<nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
  <div class="container">
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <a class="nav-link " aria-current="page" href="index.asp">Trang chủ</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              Sáp vuốt tóc
              </a>
              <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                <li><a class="dropdown-item" href="#">Clay</a></li>
                <li><a class="dropdown-item" href="#">Pomade</a></li>
                <li><a class="dropdown-item" href="#">Wax</a></li>
              </ul>
            </li>
            <li class="nav-item">
              <a class="nav-link " href="#">Prestyle</a>
            </li>
            <li class="nav-item">
              <a class="nav-link " href="#">Chăm sóc tóc</a>
            </li>
          </ul>
            <form class="d-flex">
              <input class="form-control me-2" type="search" placeholder="Tìm kiếm sản phẩm?" aria-label="Search">
              <button class="btn" type="submit"><i class="fa fa-search"></i></button>
            </form>
            <div class="d-flex">
                <%
                    If (NOT isnull(Session("tkcustomer"))) AND (TRIM(Session("tkcustomer"))<>"") Then
                %>
                    <span class="navbar-text">Welcome <%=Session("tkcustomer")%>!</span>
                    <a href="logout.asp" class="btn btn-outline-warning ms-3">Đăng xuất</a>
                <%                        
                    Else
                %>                
                    <a href="login.asp" class="btn btn-light ms-3">Đăng nhập</a>
                    <%
                    if(session("count")=0) then
                    %>
                    <a href="register.asp" class="btn btn-light ms-3">Đăng ký</a>
                    <%
                    End If
                %>
                <%
                    End If
                %>
            </div>
        </div>
  </div>
</nav>
<div class="container">
    <%
        If (NOT isnull(Session("Success"))) AND (TRIM(Session("Success"))<>"") Then
    %>
            <div class="alert alert-success mt-2" role="alert">
                <%=Session("Success")%>
            </div>
    <%
            Session.Contents.Remove("Success")
        End If
    %>
    <%
        If (NOT IsEmpty(Session("Error")) AND NOT isnull(Session("Error"))) AND (TRIM(Session("Error"))<>"") Then
    %>
            <div class="alert alert-danger mt-2" role="alert">
                <%=Session("Error")%>
            </div>
    <%
            Session.Contents.Remove("Error")
        End If
    %>    
</div>