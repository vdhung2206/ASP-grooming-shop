<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <link href="https://use.fontawesome.com/releases/v5.0.4/css/all.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
  <title>Document</title>
</head>

<body>
  <!-- #include file="../share/headerkhachhang.html" -->

  <div class="container">
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
    var giohang = []
    $(document).ready(function () {
      if (getCookie("giohang") == null) {
        const now = new Date();
        const expires = new Date(now.getTime() + 24 * 60 * 60 * 1000).toUTCString();
        var json_str = JSON.stringify(giohang);
        document.cookie = "giohang=" + json_str + ";expires=" + expires + "; path=/";
      }
      else {
        $("#giagiohang").html(tinhGiaGioHang())
      }
    })
    var queryString = window.location.search;

    // Tạo đối tượng URLSearchParams từ query string
    var searchParams = new URLSearchParams(queryString);

    // Lấy giá trị của tham số có tên là 'paramName'
    masp = searchParams.get('masp');
    $.ajax({
      method: "get",
      url: "/controllers/sanpham-controller.asp",
      data: {
        loai: "laythongtinsanpham",
        masp: masp
      },
      success: function (response) {
        const obj = JSON.parse(response);
        console.log(obj)
        if (obj.data.trangthai == "True") {
          $("#hinhanhsp").prop("src", obj.data.hinhanh)
          var str = "";
          str += "<h4>" + obj.data.tensp + "</h4>"
          if (obj.data.giasp != obj.data.giagocsp) {
            str += "<span class=\"text text-decoration-line-through text-black-50\">"
            str += obj.data.giagocsp
            str += "<span class=\"text-decoration-underline\">đ</span></span>"
          }
          str += "<span class=\"text fs-5\"> " + obj.data.giasp + "<span class=\"text-decoration-underline\">đ</span></span><br>"
          str += "<div style=\"max-width:100%;word-wrap: break-word;\">" + obj.data.chitietsp + "</div>"

          if (obj.data.sltonkho > 0) {
            str += "<h6 class=\"text-black-80\" style=\"margin:0\">Số lượng có sẵn: " + obj.data.sltonkho + "</h6>"
            str += "<a onclick=\"themgiohang('" + obj.data.masp + "','" + obj.data.giasp + "','" + obj.data.hinhanh +"','"+obj.data.sltonkho+ "')\" class=\"btnthemsp btn btn-primary btn-center\">Thêm vào giỏ hàng</a>"
            str += "<input value=\"1\" min=1 max="+obj.data.sltonkho+" id=\"soluongsp\"type = \"number\" class=\"form-control\" style=\"display: inline-block; width:10%\; padding-top:2px; margin-left:10px\">"
          }
          else {
            str += "Đã hết hàng"
          }
          $("#thongtinsp").html(str)
        }
        else{
          $("#thongtinsp").html("<h4>Sản phẩm ngừng kinh doanh</h4>")
        }
      }
    });
    function delete_cookie(name) {
      document.cookie = name + '=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
    }
    function themgiohang(masp, giasp, hinhanh,sltonkho) {
      var json_str = getCookie('giohang');
      giohang = JSON.parse(json_str);
      var obj = {}
      var key = masp
      var sl = parseInt($("#soluongsp").val())
      obj["giasp"] = giasp
      obj["hinhanh"] = hinhanh
      obj["sltonkho"] = sltonkho
      obj[key] = sl
      if (!lookup(masp)) {
        giohang.push(obj)
        var json_str = JSON.stringify(giohang);
        const now = new Date();
        const expires = new Date(now.getTime() + 24 * 60 * 60 * 1000).toUTCString();
        document.cookie = "giohang=" + json_str + ";expires=" + expires + "; path=/";
      }
      else {
        increase(masp)
      }
      tinhGiaGioHang()
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
    function tinhGiaGioHang() {
      var json_str = getCookie('giohang');
      var tongtien = 0
      giohang = JSON.parse(json_str);
      giohang.forEach(element => {
        for (var x in element) {
          tongtien += element[x] * element["giasp"]
          break
        }
      });
      $("#giagiohang").html(tongtien);
      return tongtien
    }
    function increase(masp) {
      var sl = parseInt($("#soluongsp").val())
      for (var i = 0, len = giohang.length; i < len; i++) {
        if (masp in giohang[i]) {
          for (var x in giohang[i]) {
            if (((giohang[i][x])+sl) <= giohang[i]["sltonkho"]) {
            giohang[i]["sltonkho"]
            giohang[i][x] += sl
            var json_str = JSON.stringify(giohang);
            const now = new Date();
            const expires = new Date(now.getTime() + 24 * 60 * 60 * 1000).toUTCString();
            document.cookie = "giohang=" + json_str + ";expires=" + expires + "; path=/";
            addAlertSuccess("Thêm vào giỏ hàng thành công!")
          }
          else{
            addAlertDanger("Số lượng tồn kho không đủ để đáp ứng!")
          }
          break;
          }
        }
      }
    }
    function findValue(arr, key) {
      return arr.find(function (o) { return o.key === key }).value;
    }
    function addAlertSuccess(msg) {
      $("#msg").removeClass("alert alert-danger mt-2")
      $("#msg").addClass("alert alert-success mt-2");
      $("#msg").html(msg);
      $(".alert").fadeTo(500, 1).slideDown(500, function () {
      });
      window.setTimeout(function () {
        $(".alert").fadeTo(500, 0).slideUp(500, function () {
        });
      }, 2000);
    }
    function addAlertDanger(msg) {
      $("#msg").removeClass("alert alert-success mt-2");
      $("#msg").addClass("alert alert-danger mt-2");
      $("#msg").html(msg);
      $(".alert").fadeTo(500, 1).slideDown(500, function () {
      });
      window.setTimeout(function () {
        $(".alert").fadeTo(500, 0).slideUp(500, function () {
        });
      }, 2000);
    }
  </script>
</body>

</html>