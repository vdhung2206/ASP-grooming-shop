<%
    if(session("uidadmin")<>"" and session("loaitk")=2) then
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://use.fontawesome.com/releases/v5.0.4/css/all.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
  <title>Document</title>
</head>

<body>

  <!-- #include file="../share/header.html" -->
  <div class="container col-6">
    <form id="form-chitiet-sp">
      <div class="form-group">
        <input type="hidden" name="loai" value="chitietsanpham">
      </div>
      <div class="form-group">
        <label for="ten-san-pham">Tên sản phẩm</label>
        <input type="text" name="tensp" class="form-control" id="ten-san-pham">
        <label id="msgtensp" for="ten-san-pham"></label>
      </div>
      <div class="form-group">
        <label for="danh-muc">Danh mục</label>
        <select name="danhmucsp" id="danhmucsp" class="form-select">
        </select>
        <label id="msgdanhmuc" for="danhmucsp"></label>
      </div>
      <div class="form-group">
        <label for="loai-san-pham">Loại sản phẩm</label>
        <select name="maloaisp" id="loaisp" class="form-select">
        </select>
        <label id="msgloaisp" for=""></label>
      </div>
      <div class="form-group">
        <label for="hang">Hãng</label>
        <input type="text" name="hangsp" class="form-control" id="hang">
        <label id="msghangsp" for=""></label>
      </div>
      <div class="form-group">
        <label for="so-luong-ton-kho">Số lượng tồn kho</label>
        <input type="text" name="sltonkho" class="form-control" id="so-luong-ton-kho">
        <label id="msgtonkho" for=""></label>
      </div>
      <div class="form-group">
        <label for="gia-goc">Giá gốc</label>
        <input type="text" name="giagocsp" class="form-control" id="gia-goc">
        <label id="msggiagoc" for=""></label>
      </div>
      <div class="form-group">
        <input type="hidden" name="giagocsp" class="form-control" id="gia-giam">
      </div>
      <div class="form-group">
        <label for="gia-goc">Chi tiết</label>
        <textarea type="text" name="chitietsp" class="form-control" id="chi-tiet"></textarea>
      </div>
      <div class="form-group">
        <label for="trangthai">Trạng thái</label>
        <select name="trangthai" id="trangthai" class="form-select">
          <option value="1">Đang bán</option>
          <option value="0">Ngừng bán</option>
        </select>
      </div>
      <button id="confirm" type="submit" class="btn btn-primary">
        Lưu thay đổi
      </button>
  </div>
  </form>
  </div>
</body>

</html>
<script src="share.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous">
  </script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
  var masp
  var tenspbandau
  var danhmucspbandau
  var loaispbandau
  var hangspbandau
  var sltonbandau
  var giagocbandau
  var giamgiabandau
  var trangthai

  $("#form-chitiet-sp").submit(function (e) {
    e.preventDefault();
    if ($("#ten-san-pham").val() != "") {
      if ($("#hang").val() != "") {
        if ($("#so-luong-ton-kho").val() != "") {
          if ($("#so-luong-ton-kho").val() >= 0) {
            if ($("#so-luong-ton-kho").val().match(/^\d+$/)) {
              if ($("#gia-goc").val() != "" && $("#gia-goc").val().match(/^\d+$/)) {
                if ($("#gia-giam").val() != "" && $("#gia-giam").val().match(/^\d+$/)) {
                  if (parseInt($("#gia-giam").val()) < parseInt($("#gia-goc").val())) {
                    $.ajax({
                      method: "post",
                      url: "../controllers/sanpham-controller.asp",
                      data: {
                        masp: masp,
                        trangthai: $("#trangthai").val(),
                        loai: "chinhsuathongtinsanpham",
                        tensp : $("#ten-san-pham").val(),
                        danhmucsp: $("#danhmucsp").val(),
                        loaisp: $("#loaisp").val(),
                        hangsp: $("#hang").val(),
                        sltonkhosp: $("#so-luong-ton-kho").val(),
                        giagocsp: $("#gia-goc").val(),
                        giagiamsp: $("#gia-giam").val(),
                        chitietsp: $("#chi-tiet").val()
                      },success: function(response){
                        const obj = JSON.parse(response);
                        console.log(obj)
                        if(obj.data.suaSanPham){
                          sessionStorage.setItem("suaspMSG","Sửa thông tin sản phẩm thành công")
                          window.location.href = "sanpham-view.asp"
                        }
                      }
                    })
                  }
                  else {
                    addAlertDanger("Giảm giá sản phẩm phải nhỏ hơn giá gốc")
                  }
                }
                else {
                  addAlertDanger("Giảm giá sản phẩm không được để trống, phải là số và lớn hơn hoặc bằng 0 ")
                }
              }
              else {
                addAlertDanger("Giá gốc sản phẩm không được để trống, phải là số và lớn hơn 0 ")
              }
            }
            else {
              addAlertDanger("Số lượng tồn kho phải là số!")
            }
          }
          else {
            addAlertDanger("Số lượng tồn kho phải lớn hơn hoặc bằng 0!")
          }
        }
        else {
          addAlertDanger("Số lượng tồn kho không được để trống!")
        }
      }
      else {
        addAlertDanger("Hãng sản phẩm không được để trống!")
      }
    }
    else {
      addAlertDanger("Tên sản phẩm không được để trống!")
    }
  })
  $("#gia-goc").keyup(function () {
    var val = $(this).val();
    console.log(giagocbandau)
    if (val != giagocbandau) {
      $("#msggiagoc").html("Bạn đã điều chỉnh giá gốc của sản phẩm! (Giá trị ban đầu là: " + giagocbandau + ")")
    }
    else {
      $("#msggiagoc").html("")
    }
  })

  $("#gia-giam").keyup(function () {
    var val = $(this).val();
    if (val != giamgiabandau) {
      $("#msggiamgia").html("Bạn đã điều chỉnh giảm giá của sản phẩm! (Giá trị ban đầu là: " + giamgiabandau + ")")
    }
    else {
      $("#msggiamgia").html("")
    }
  })

  $("#so-luong-ton-kho").keyup(function () {
    var val = $(this).val();
    if (val != sltonbandau) {
      $("#msgtonkho").html("Bạn đã điều chỉnh số lượng sản phẩm! (Giá trị ban đầu là: " + sltonbandau + ")")
    }
    else {
      $("#msgtonkho").html("")
    }
  })
  $("#ten-san-pham").keyup(function () {
    var val = $(this).val();
    if (val != tenspbandau) {
      $("#msgtensp").html("Bạn đã điều chỉnh tên sản phẩm! (Giá trị ban đầu là: " + tenspbandau + ")")
    }
    else {
      $("#msgtensp").html("")
    }
  })
  $("#hang").keyup(function () {
    var val = $(this).val();
    if (val != hangspbandau) {
      $("#msghangsp").html("Bạn đã điều chỉnh hãng sản phẩm! (Giá trị ban đầu là: " + hangspbandau + ")")
    }
    else {
      $("#msghangsp").html("")
    }
  })
  $("#danhmucsp").change(function () {
    if ($(this).val() != danhmucspbandau) {
      $("#msgdanhmuc").html("Bạn đã thay đổi danh mục của sản phẩm (Giá trị ban đầu là: " + $("#danhmucsp option[value=\"" + danhmucspbandau + "\"]").html() + ")")
    }
    else {
      $("#msgdanhmuc").html("");
    }
    madm = $(this).val()
    if (madm != "") {
      $.ajax({
        method: "get",
        url: "../controllers/danhmuc-controller.asp",
        data: {
          madm: madm,
          loai: "getList",
        },
        success: function (response) {
          const obj = JSON.parse(response);
          var str = ""
          if (madm != "") {
            obj.data.listloaisp.forEach(element => {
              str += "<option value=\"" + element.maloaisp + "\">";
              str += element.tenloaisp
              str += "</option>";
            })
          }
          $("#loaisp").html(str)
        }
      })
    }
  })
  $("#loaisp").change(function () {
    if ($(this).val() != loaispbandau) {
      $("#msgloaisp").html("Bạn đã thay đổi loại sản phẩm (Giá trị ban đầu là: " + $("#loaisp option[value=\"" + loaispbandau + "\"]").html() + ")")
    }
    else {
      $("#msgloaisp").html("");
    }
  })
  function addAlertDanger(msg) {
    $("#msg").addClass("alert alert-danger mt-2");
    $("#msg").html(msg);
    $(".alert").fadeTo(500, 1).slideDown(500, function () {
    });
    window.setTimeout(function () {
      $(".alert").fadeTo(500, 0).slideUp(500, function () {
      });
    }, 2000);
  }
  $(document).ready(function () {
    var queryString = window.location.search;

    // Tạo đối tượng URLSearchParams từ query string
    var searchParams = new URLSearchParams(queryString);

    // Lấy giá trị của tham số có tên là 'paramName'
    masp = searchParams.get('masp');
    if (masp == null) {
      masp = "";
    }
    loai = searchParams.get('loai');
    if (loai == null) {
      loai = ""
    }
    $.ajax({
      method: "get",
      url: "../controllers/sanpham-controller.asp",
      data: {
        loai: loai,
        masp: masp
      },
      success: function (response) {
        const obj = JSON.parse(response);
        danhmucspbandau = obj.data.danhmuc;
        loaispbandau = obj.data.loaisp
        hangspbandau = obj.data.hang
        tenspbandau = obj.data.tensp;
        sltonbandau = obj.data.sltonkho
        giagocbandau = obj.data.giagocsp
        giamgiabandau = obj.data.giamgiasp
        if (obj.data.trangthai == "True") {
          trangthai = "1";
        }
        else {
          trangthai = "0";
        }
        var dm = obj.data.danhmuc;
        var lsp = obj.data.loaisp;
        $("#ten-san-pham").val(obj.data.tensp);
        $("#hang").val(obj.data.hang);
        $("#so-luong-ton-kho").val(obj.data.sltonkho);
        $("#gia-goc").val(obj.data.giagocsp);
        $("#gia-giam").val(obj.data.giamgiasp);
        $("#gia-ban").val(obj.data.giasp);
        $("#chi-tiet").val(obj.data.chitietsp);
        $("#ten-san-pham").val(obj.data.tensp);
        $("#anhsp").prop("src", obj.data.hinhanh);
        $('#danhmucsp option[value="' + obj.data.danhmuc + '"]').prop("selected", true)
        $('#loaisp option[value="' + obj.data.loaisp + '"]').prop("selected", true)
        $.ajax({
          method: "get",
          url: "../controllers/danhmuc-controller.asp",
          data: {
            loai: "getListDanhMuc",
          },
          success: function (response) {
            var str = "";
            const obj = JSON.parse(response);
            console.log(trangthai)
            $("#trangthai option[value = \"" + trangthai + "\"]").prop("selected", true)
            madm = obj.data.listdanhmuc[0].madm
            obj.data.listdanhmuc.forEach(element => {
              str += "<option value=\"" + element.madm + "\">" + element.tendm;
              str += "</option>";
            });
            $("#danhmucsp").html(str)
            $("#danhmucsp option[value=\"" + dm + "\"]").prop("selected", true)
            $.ajax({
              method: "get",
              url: "../controllers/danhmuc-controller.asp",
              data: {
                madm: dm,
                loai: "getList",
              },
              success: function (response) {
                const obj = JSON.parse(response);
                var str = ""
                if (madm != "") {
                  obj.data.listloaisp.forEach(element => {
                    str += "<option value=\"" + element.maloaisp + "\">";
                    str += element.tenloaisp
                    str += "</option>";
                  })
                }
                $("#loaisp").html(str)
                $("#loaisp option[value=\"" + lsp + "\"]").prop("selected", true)
              }
            })
          }
        })
      }
    })
  })
</script>
<%
    else
    response.redirect("login.asp")
    end if
%>