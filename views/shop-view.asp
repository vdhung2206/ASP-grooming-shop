<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
  <style>
    .bold {
      font-weight: bold;
    }
  </style>
  <title>Document</title>
</head>

<body>
  <!-- #include file="../share/headerkhachhang.html" -->

  <div class="container-fluid">
    <div class="row flex-nowrap">
      <div class="col-auto col-md-5 col-xl-3 px-sm-2 px-0 bg-light">
        <div class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 text-black min-vh-100">
          <a href="/" class="d-flex align-items-center pb-3 mb-md-0 me-md-auto text-black text-decoration-none">
            <span class="fs-5 d-none d-sm-inline">Danh mục sản phẩm</span>
          </a>
          <ul style="width:100%"
            class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start" id="menu">
            <li>
              <a style="display:inline-block" href="#submenu1" data-bs-toggle="collapse"
                class="nav-link text-dark px-0 align-middle">
                V
              </a>
              <a id="sapvuottoc" style="display:inline-block; margin-left:20px" href="#" class="danhmuc nav-link px-0">
                <span class="d-none text-dark d-sm-inline">Sáp vuốt tóc</a>
              <ul class="collapse show nav flex-column ms-1" id="submenu1" data-bs-parent="#menu">
                <li class="w-100">
                  <a id="clay" href="#" class="loaisp nav-link px-0"> <span
                      class="d-none text-dark d-sm-inline">Clay</a>
                </li>
                <li>
                  <a href="#" id="wax" class="loaisp nav-link px-0"> <span class="d-none text-dark d-sm-inline">Wax</a>
                </li>
                <li>
                  <a href="#" id="pomade" class="loaisp nav-link px-0"> <span
                      class="d-none text-dark d-sm-inline">Pomade</a>
                </li>
              </ul>
            </li>

            <li>
              <a style="display:inline-block" href="#submenu2" data-bs-toggle="collapse"
                class="nav-link text-dark px-0 align-middle">
                V
              </a>
              <a id="chamsoctoc" style="display:inline-block; margin-left:20px" href="#" class="danhmuc nav-link px-0">
                <span class="d-none text-dark d-sm-inline">Chăm sóc tóc</a>
              <ul class="collapse show nav flex-column ms-1" id="submenu2" data-bs-parent="#menu">
                <li class="w-100">
                  <a id="daugoi" href="#" class="loaisp nav-link px-0"> <span class="d-none text-dark d-sm-inline">Dầu
                      gội</a>
                </li>
                <li>
                  <a href="#" id="dauxa" class="loaisp nav-link px-0"> <span class="d-none text-dark d-sm-inline">Dầu
                      xả</a>
                </li>
                <li>
                  <a href="#" id="duongtoc" class="loaisp nav-link px-0"> <span
                      class="d-none text-dark d-sm-inline">Dưỡng tóc</a>
                </li>
              </ul>
            </li>

            <li>
              <a style="display:inline-block" href="#submenu3" href="#submenu3" data-bs-toggle="collapse"
                class="nav-link text-dark px-0 align-middle">
                V</a>
              <a id="sanphamhotro" style="display:inline-block; margin-left:20px" href="#"
                class="danhmuc nav-link px-0"> <span class="d-none text-dark d-sm-inline">Sản phẩm hỗ trợ</a>
              <ul class="collapse show nav flex-column ms-1" id="submenu3" data-bs-parent="#menu">
                <li class="w-100">
                  <a href="#" id="hotrotaokieu" class="loaisp nav-link px-0"> <span
                      class="d-none text-dark d-sm-inline">Hỗ trợ tạo kiểu</a>
                </li>
                <li>
                  <a href="#" id="nuochoa" class="loaisp nav-link px-0"> <span class="d-none text-dark d-sm-inline">Nước
                      hoa</a>
                </li>
              </ul>
            </li>
            <li style="width:100%">
              <div class="form-group">
                <label for="loai-san-pham">Sắp xếp theo</label>
                <select name="sapxep" id="sapxep" class="form-select">
                  <option value="0">Thứ tự mặc định</option>
                  <option value="1">Thứ tự theo giá từ cao xuống thấp</option>
                  <option value="2">Thứ tự theo giá từ thấp lên cao</option>
                </select>
              </div>
            </li>
          </ul>
          <hr>
        </div>
      </div>
      <div class="col py-3">
        <div class="container">
          <div id="result" class="d-flex flex-wrap justify-content-start">
          </div>
          <nav aria-label="Page Navigation">
            <ul id="thanhphantrang" class="pagination pagination-sm justify-content-center my-5">
              <li class="page-item"><a class="page-link" style="pointer-events: none"
                  href="taikhoan-view.asp?page=0">Trước</a></li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
    <div class="d-flex p-3 ">
      <div style="display: inline-block; width: 50%;" class="">
        <img style="width:80%" id="hinhanhsp">
      </div>
      <div id="thongtinsp" style="display: inline-block; width: 50%;" class="">
      </div>
    </div>
    <footer class="py-3 my-4">
      <ul class="nav justify-content-center border-bottom pb-3 mb-3">
        <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Home</a></li>
        <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Features</a></li>
        <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Pricing</a></li>
        <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">FAQs</a></li>
        <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">About</a></li>
      </ul>
      <p class="text-center text-muted">&copy; 2023 Nhóm 19</p>
    </footer>
  </div>
  <script>
    var currentPage = "1"
    var tensp = ""
    var madm = ""
    var loaisp = ""
    var sapxep = ""
    var sapxepgia=""
    var sapxepphobien = ""
    var giohang = []

    $("#sapxep").change(function(){
      sapxep = $("#sapxep").find(":selected").val()
      if(sapxep ==0){
        sapxepgia=""
        loadData(1)
      }else if(sapxep==1){
        sapxepgia =0;
        loadData(1)
      }else if(sapxep==2){
        sapxepgia =1;
        loadData(1)
      }
    })
    $(document).ready(function () {
      var queryString = window.location.search;

      var searchParams = new URLSearchParams(queryString);

      currentPage = searchParams.get('page');
      if (currentPage == null) {
        currentPage = "1";
      }
      madm = searchParams.get('madm');
      loaisp = searchParams.get('loaisp');
      sapxep = searchParams.get('sapxep')
      if(sapxep =="" ||sapxep==null){
        sapxep = 0
      }
      if(madm == 1){
        $("#sapvuottoc").addClass("bold")
      }else if(madm ==3){
        $("#chamsoctoc").addClass("bold")
      }else if(madm==4){
        $("#sanphamhotro").addClass("bold")
      }
      if(loaisp==1){
        $("#clay").addClass("bold")
      }
      else if(loaisp==2){
        $("#wax").addClass("bold")
      }
      else if(loaisp==3){
        $("#pomade").addClass("bold")
      }
      else if(loaisp==4){
        $("#daugoi").addClass("bold")
      }
      else if(loaisp==5){
        $("#dauxa").addClass("bold")
      }
      else if(loaisp==6){
        $("#duongtoc").addClass("bold")
      }
      else if(loaisp==1006){
        $("#hotrotaokieu").addClass("bold")
      }
      else if(loaisp==1007){
        $("#nuochoa").addClass("bold")
      }
      if (getCookie("giohang") == null) {
        const now = new Date();
        const expires = new Date(now.getTime() + 24 * 60 * 60 * 1000).toUTCString();
        var json_str = JSON.stringify(giohang);
        document.cookie = "giohang=" + json_str + ";expires=" + expires + "; path=/";
      }
      else{
        $("#giagiohang").html(tinhGiaGioHang())
      }
      loadData(currentPage)
    })
    function removeBold() {
      $(".danhmuc").removeClass("bold")
      $(".loaisp").removeClass("bold")
    }
    $("#sapvuottoc").click(function (e) {
      loaisp = ""
      e.preventDefault()
      removeBold()
      $(this).addClass(" bold")
      madm = 1;
      loadData(1)
    })
    $("#clay").click(function (e) {
      madm = ""
      e.preventDefault()
      removeBold()
      $(this).addClass(" bold")
      loaisp = 1;
      loadData(1)
    })
    $("#wax").click(function (e) {
      madm = ""
      e.preventDefault()
      removeBold()
      $(this).addClass(" bold")
      loaisp = 2;
      loadData(1)
    })
    $("#pomade").click(function (e) {
      madm = ""
      e.preventDefault()
      removeBold()
      $(this).addClass(" bold")
      loaisp = 3;
      loadData(1)
    })
    $("#chamsoctoc").click(function (e) {
      loaisp = ""
      e.preventDefault()
      removeBold()
      $(this).addClass(" bold")
      madm = 3;
      loadData(1)
    })
    $("#daugoi").click(function (e) {
      madm = ""
      e.preventDefault()
      removeBold()
      $(this).addClass(" bold")
      loaisp = 4;
      loadData(1)
    })
    $("#dauxa").click(function (e) {
      madm = ""
      e.preventDefault()
      removeBold()
      $(this).addClass(" bold")
      loaisp = 5;
      loadData(1)
    })
    $("#duongtoc").click(function (e) {
      madm = ""
      e.preventDefault()
      removeBold()
      $(this).addClass(" bold")
      loaisp = 6;
      loadData(1)
    })
    $("#sanphamhotro").click(function (e) {
      loaisp = ""
      e.preventDefault()
      removeBold()
      $(this).addClass(" bold")
      madm = 4;
      loadData(1)
    })
    $("#hotrotaokieu").click(function (e) {
      madm = ""
      e.preventDefault()
      removeBold()
      $(this).addClass(" bold")
      loaisp = 1006;
      loadData(1)
    })
    $("#nuochoa").click(function (e) {
      madm = ""
      e.preventDefault()
      removeBold()
      $(this).addClass(" bold")
      loaisp = 1007;
      loadData(1)
    })
    function delete_cookie(name) {
      document.cookie = name + '=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
    }
    function themgiohang(masp,giasp,hinhanh) {
      var json_str = getCookie('giohang');
      giohang = JSON.parse(json_str);
      var obj = {}
      var key = masp
      obj["giasp"] = giasp
      obj["hinhanh"] = hinhanh
      obj[key] = 1
      if (!lookup(masp)) {
        giohang.push(obj)
        var json_str = JSON.stringify(giohang);
        const now = new Date();
        const expires = new Date(now.getTime() + 24* 60 * 60 * 1000).toUTCString();
        document.cookie = "giohang=" + json_str + ";expires=" + expires + "; path=/";
      }
      else {
        increase(masp)
      }
      tinhGiaGioHang()
      addAlertSuccess("Thêm vào giỏ hàng thành công")
    }

     function addAlertSuccess(msg) {
    $("#msg").addClass("alert alert-success mt-2");
    $("#msg").html(msg);
    $(".alert").fadeTo(500, 1).slideDown(500, function () {
    });
    window.setTimeout(function () {
      $(".alert").fadeTo(500, 0).slideUp(500, function () {
      });
    }, 2000);
  }
    function loadData(page) {
      var newUrl = "shop-view.asp?page=" + currentPage
      if(madm !=null && madm!=""){
        newUrl += "&madm="+madm
      }
      if(loaisp !=null && loaisp!=""){
        newUrl += "&loaisp="+loaisp
      }
      if(sapxep !=null && sapxep !=""){
        newUrl += "&sapxep=" + sapxep
      }
      $("#sapxep").val(sapxep)
      history.pushState(null, null, newUrl);
      $.ajax({
        method: "get",
        url: "../controllers/sanpham-controller.asp",
        data: {
          page: page,
          loai: "phantrangsanpham",
          tensp: tensp,
          madm: madm,
          loaisp: loaisp,
          sapxepgia: sapxepgia,
          sapxepphobien: sapxepphobien
        }
        ,
        success: function (response) {
          const obj = JSON.parse(response);
          console.log(obj)
          var danhsachsanpham = obj.data.danhsachsanpham
          var str = ""
          danhsachsanpham.forEach(sanpham => {
            str += "<div class=\"p-2\" style=\"width:33%; min-width:100px\">"
            str += "<div class=\"card pt-10\" style=\"width: 18rem; border: none\">";
            str += "<a href=\"/views/chitietsanpham.asp?masp=" + sanpham.masp + "\">"
            str += "<img class=\"card-img-top\" src=" + sanpham.hinhanh + " height=333em alt=\"Card image cap\">"
            str += "</a>"
            str += "<div class=\"card-body\" style=\"padding:0\">";
            str += "<h6 class=\"text-black-50\">" + sanpham.loaisp + "</h6>"
            str += "<h6 class=\"card-title\" style=\"margin:0\">" + sanpham.tensp + "</h6>"
            if (sanpham.giasp != sanpham.giagocsp) {
              str += "<span class=\"text text-decoration-line-through text-black-50\">"
              str += sanpham.giagocsp
              str += "<span class=\"text-decoration-underline\">đ</span></span>"
            }
            str += "<span class=\"text fs-5\"> " + sanpham.giasp + "<span class=\"text-decoration-underline\">đ</span></span><br>"
            if (sanpham.sltonkho > 0) {
              str += "<a onclick=\"themgiohang('" + sanpham.masp + "','" + sanpham.giasp +"','" + sanpham.hinhanh + "')\" class=\"btnthemsp btn btn-primary btn-center\">Thêm vào giỏ hàng</a>"
            }
            else {
              str += "Đã hết hàng"
            }
            str += "</div></div></div>"
          }
          );
          $("#result").html(str);
          loadThanhPhanTrang(obj.data.totalPages, page)
        }
      });
    }
    function loadThanhPhanTrang(totalPages, currentPage) {
      if (currentPage < 1) {
        currentPage = 1;
      }
      if (currentPage > totalPages) {
        currentPage = totalPages;
      }
      var truoc = "<li class=\"page-item\"" + "><a id=\"truoc\" class =\"page-link\" onclick=\"loadData(" + (currentPage - 1) + ")\" style=\"cursor:pointer";
      truoc += "\">" + "Trước</a></li>"
      var str = "";
      str += truoc;
      if (totalPages <= 10) {
        for (let i = 1; i <= totalPages; i++) {
          str += "<li class=\"page-item"
          if (i == currentPage) {
            str += " active"
          }
          str += "\"><a class =\"page-link\" style=\"cursor:pointer\" onclick=\"loadData(" + i + ")\""
          str += ">" + i + "</a></li>"
        }
      }
      if (totalPages > 10) {
        str += "<li class=\"page-item";
        if (1 == currentPage) {
          str += " active"
        }
        str += "\"><a class=\"page-link\" style=\"cursor:pointer\" onclick=\"loadData(1)\">" + 1 + "</a></li>"
        if (currentPage > 3) {
          str += "<li class=\"page-item\"><a class=\"page-link\" style=\"pointer-events: none\">...</a></li>"
        }
        if (currentPage > 2) {
          str += "<li class=\"page-item \"><a class=\"page-link\" style=\"cursor:pointer\" onclick=\"loadData(" + (parseInt(currentPage) - 1) + ")\">" + (parseInt(currentPage) - 1) + "</a></li>"
        }
        if (currentPage != 1) {
          str += "<li class=\"page-item active\"><a class=\"page-link\">" + currentPage + "</a></li>"
        }
        if (currentPage < (totalPages - 1)) {
          str += "<li class=\"page-item\"><a class=\"page-link\"style=\"cursor:pointer\" onclick=\"loadData(" + (parseInt(currentPage) + 1) + ")\">" + (parseInt(currentPage) + 1) + "</a></li>"
        }
        if (currentPage < (totalPages - 2)) {
          str += "<li class=\"page-item\"><a class=\"page-link\" style=\"pointer-events: none\">...</a></li>"
        }
        if ((totalPages > 1) && (parseInt(currentPage) < parseInt(totalPages))) {
          str += "<li class=\"page-item \"><a class=\"page-link\" style=\"cursor:pointer\" onclick=\"loadData(" + totalPages + ")\">" + totalPages + "</a></li>"
        }
      }
      var sau = "<li class=\"page-item\"" + "><a id=\"sau\" class =\"page-link\" onclick=\"loadData(" + (parseInt(currentPage) + 1) + ")\" style=\"cursor:pointer";
      sau += "\">" + "Sau</a></li>"
      str += sau;
      $("#thanhphantrang").html(str);
      if (currentPage <= 1) {
        $("#truoc").addClass(" disabled")
      }
      if (currentPage >= totalPages) {
        $("#sau").addClass(" disabled")
      }
    }
    function getCookie(name) {
      var cookieArr = document.cookie.split(";");
      for (var i = 0; i < cookieArr.length; i++) {
        var cookiePair = cookieArr[i].split("=");
        if (name == cookiePair[0].trim()) {
          return decodeURIComponent(cookiePair[1]);
        }
      }
      return null;
    }
    function delete_cookie(name) {
      document.cookie = name + '=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
    }
    function tinhGiaGioHang() {
    var json_str = getCookie('giohang');
    var tongtien = 0
    giohang = JSON.parse(json_str);
    giohang.forEach(element => {
      for(var x in element){
        tongtien += element[x] * element["giasp"]
        break
      }
    });
    $("#giagiohang").html(tongtien);
    return tongtien
    }
    function lookup(name) {
      var json_str = getCookie('giohang');
      giohang = JSON.parse(json_str);
      for (var i = 0, len = giohang.length; i < len; i++) {
        if (name in giohang[i])
          return true;
      }
      return false;
    }
    function increase(masp) {
      for (var i = 0, len = giohang.length; i < len; i++) {
        if (masp in giohang[i]) {
          for (var x in giohang[i]) {
            giohang[i][x] += 1
            var json_str = JSON.stringify(giohang);
            const now = new Date();
            const expires = new Date(now.getTime() + 24 *60 * 60 * 1000).toUTCString();
            document.cookie = "giohang=" + json_str + ";expires=" + expires + "; path=/";
            break;  
          }
        }
      }
    }
    function findValue(arr, key) {
      return arr.find(function (o) { return o.key === key }).value;
    }
  </script>
</body>

</html>