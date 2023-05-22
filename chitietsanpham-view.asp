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

  <!-- #include file="./share/header.html" -->
  <div class="container col-6">
    <form id="form-chitiet-sp" action="controllers/sanpham-controller.asp" method="post">
      <div class="form-group">
        <input type="hidden" name="loai" value="chitietsanpham">
      </div>
      <div class="form-group">
        <label for="ten-san-pham">Tên sản phẩm</label>
        <input type="text" name="tensp" class="form-control" id="ten-san-pham">
      </div>
      <div class="form-group">
        <label for="danh-muc">Danh mục</label>
        <select name="danhmucsp" id="danhmucsp" class="form-select">
        </select>
      </div>
      <div class="form-group">
        <label for="loai-san-pham">Loại sản phẩm</label>
        <select name="maloaisp" id="loaisp" class="form-select">
        </select>
      </div>
      <div class="form-group">
        <label for="hang">Hãng</label>
        <input type="text" name="hangsp" class="form-control" id="hang">
      </div>
      <div class="form-group">
        <label for="so-luong-ton-kho">Số lượng tồn kho</label>
        <input type="text" name="sltonkho" class="form-control" id="so-luong-ton-kho">
      </div>
      <div class="form-group">
        <label for="gia-goc">Giá gốc</label>
        <input type="text" name="giagocsp" class="form-control" id="gia-goc">
      </div>
      <div class="form-group">
        <label for="gia-goc">Giảm giá</label>
        <input type="text" name="giagocsp" class="form-control" id="gia-giam">
      </div>
      <div class="form-group">
        <label for="gia-goc">Giá bán</label>
        <input type="text" disabled name="giagocsp" class="form-control" id="gia-ban">
      </div>
      <div class="form-group">
        <label for="gia-goc">Chi tiết</label>
        <textarea type="text" name="chitietsp" class="form-control" id="chi-tiet"></textarea>
      </div>
      <div class="form-group">
        <label for="">Hình ảnh</label>
        <img id="anhsp" style="width: 30%;" src="">
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

  $("#danhmucsp").change(function () {
    madm = $(this).val()
    if (madm != "") {
      $.ajax({
        method: "get",
        url: "controllers/danhmuc-controller.asp",
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
      url: "controllers/sanpham-controller.asp",
      data: {
        loai: loai,
        masp: masp
      },
      success: function (response) {
        const obj = JSON.parse(response);
        var dm = obj.data.danhmuc
        var lsp = obj.data.loaisp
        console.log(obj)
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
          url: "controllers/danhmuc-controller.asp",
          data: {
            loai: "getListDanhMuc",
          },
          success: function (response) {
            var str = "";
            const obj = JSON.parse(response);
            madm = obj.data.listdanhmuc[0].madm
            obj.data.listdanhmuc.forEach(element => {
              str += "<option value=\"" + element.madm + "\">" + element.tendm;
              str += "</option>";
            });
            $("#danhmucsp").html(str)
            $("#danhmucsp option[value=\"" + dm + "\"]").prop("selected", true)
            $.ajax({
              method: "get",
              url: "controllers/danhmuc-controller.asp",
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