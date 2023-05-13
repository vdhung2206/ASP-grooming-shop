<nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
  <div class="container">
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <a class="nav-link " aria-current="page" href="/management/index.asp">Tổng quan</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              Quản lý tài khoản
              </a>
              <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                <li><a class="dropdown-item">Tài khoản khách hàng</a></li>
                <%
                  if(session("LoaiTK")=2) then
                %>
                <li><a class="dropdown-item disable" href="/management/accountmanagement/mngaccount.asp?page=1">Tài khoản quản lý</a></li>
                <%
                  end if
                %>
              </ul>
            </li>
            <li class="nav-item">
            <a class="nav-link " href="#">Quản lý sản phẩm</a>
            </li>
            <li class="nav-item">
            <a class="nav-link " href="#">Quản lý đơn đặt hàng</a>
            </li>
          </ul>
            <div class="d-flex">
                <%
                    If (NOT isnull(Session("tkmanager"))) AND (TRIM(Session("tkmanager"))<>"") Then
                %>
                    <span class="navbar-text">Welcome <%=Session("tkmanager")%>!</span>
                    <a href="/management/logout.asp" class="btn btn-outline-warning ms-3">Đăng xuất</a>
                <%                        
                    Else
                %>                
                <%
                    End If
                %>
            </div>
        </div>
  </div>
</nav>
<div class="container" id ="headercontainer" >
  <div id ="msg" class="mt-2" role="alert">
  </div>
      
</div>