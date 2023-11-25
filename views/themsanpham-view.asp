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
    <form id="form-them-sp" method="post">
      <div class="form-group">
        <input type="hidden" name="loai" value="themsanpham">
      </div>
      <div class="form-group">
        <label for="ten-san-pham">Tên sản phẩm</label>
        <input type="text" name="tenspthem" class="form-control" id="ten-san-pham">
      </div>
      <div class="form-group">
        <label for="danh-muc">Danh mục</label>
        <select name="danhmucsp" id="danhmucsp" class="form-select">
        </select>
      </div>
      <div class="form-group">
        <label for="loai-san-pham">Loại sản phẩm</label>
        <select name="maloaispthem" id="loaisp" class="form-select">
        </select>
      </div>
      <div class="form-group">
        <label for="hang">Hãng</label>
        <input type="text" name="hangspthem" class="form-control" id="hang">
      </div>
      <div class="form-group">
        <label for="so-luong-ton-kho">Số lượng tồn kho</label>
        <input type="text" name="sltonkhothem" class="form-control" id="so-luong-ton-kho">
      </div>
      <div class="form-group">
        <label for="gia-goc">Giá gốc</label>
        <input type="text" name="giagocspthem" class="form-control" id="gia-goc">
      </div>
      <div class="form-group">
        <label for="gia-goc">Chi tiết</label>
        <textarea type="text" name="chitietspthem" class="form-control" id="chi-tiet"></textarea>
      </div>
      <div class="form-group">
        <button class="btn btn-primary" type="submit">Thêm sản phẩm</button>
      </div>
    </form>

    <form id="upload"method="post" enctype="multipart/form-data" action="../controllers/upload.asp">
      <div class="form-group">
        <input type="hidden" name="loai" value="themanhsanpham">
      </div>
      <div class="form-group">
        <label for="hinh-anh">Hình ảnh</label>
      </div>
      <input type="file" id="f" name=YourFile>
      <input type=submit name=submit value="Upload">
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
  var madm
  $("#hinh-anh").change(function () {
    validateFile()
  });
  $("#form-them-sp").submit(function (e) {
    e.preventDefault()
    if ($("#ten-san-pham").val() != "") {
      if ($("#gia-goc").val() != "") {
        if ($("#gia-goc").val().match(/^\d+$/)) {
          if ($("#gia-goc").val() > 0) {
            if ($("#hang").val() != "") {
              if ($("#so-luong-ton-kho").val() != "") {
                if ($("#so-luong-ton-kho").val().match(/^\d+$/)) {
                  if ($("#so-luong-ton-kho").val() > 0) {
                    if ($("#gia-goc").val() != "") {
                      if ($("#gia-goc").val() > 0) {
                        if ($("#gia-goc").val() > 0) {
                          $.ajax({
                            method: "post",
                            url: "../controllers/sanpham-controller.asp",
                            data: {
                              loai: "themsanpham",
                              tenspthem: $("#ten-san-pham").val(),
                              danhmucsp: $("#danhmucsp").val(),
                              maloaispthem: $("#loaisp").val(),
                              hangspthem: $("#hang").val(),
                              sltonkhothem: $("#so-luong-ton-kho").val(),
                              giagocspthem: $("#gia-goc").val(),
                              chitietspthem: $("#chi-tiet").val()
                            },
                            success: function (response) {
                              addAlertSuccess(response)
                              $("#form-them-sp input").prop("disabled", true);
                              $("#form-them-sp select").prop("disabled", true);
                              $("#upload input").prop("disabled", false)
                            }
                          })
                        }
                        else {
                          addAlertDanger("Giá sản phẩm phải là số");
                        }
                      }
                      else {
                        addAlertDanger("Giá sản phẩm phải lớn hơn 0!");
                      }
                    }
                    else {
                      addAlertDanger("Giá sản phẩm không được để trống!");
                    }
                  }
                  else {
                    addAlertDanger("Số lượng sản phẩm phải lớn 0!");
                  }
                }
                else {
                  addAlertDanger("Số lượng sản phẩm phải là số!");
                }
              }
              else {
                addAlertDanger("Số lượng sản phẩm không được để trống!");
              }

            }
            else {
              addAlertDanger("Hãng sản phẩm không được để trống!");
            }
          }
          else {
            addAlertDanger("Giá sản phẩm phải lớn 0!");
          }
        }
        else {
          addAlertDanger("Giá sản phẩm phải là số!");
        }
      }
      else {
        addAlertDanger("Giá sản phẩm không được để trống!");
      }
    }
    else {
      addAlertDanger("Tên sản phẩm không được để trống!");

    }
  })

  $(document).ready(function () {
    $("#upload input").prop("disabled", true)
    $.ajax({
      method: "get",
      url: "../controllers/danhmuc-controller.asp",
      data: {
        loai: "getListDanhMuc",
      },
      success: function (response) {
        var str = "";
        const obj = JSON.parse(response);
        madm = obj.data.listdanhmuc[0].madm
        console.log(madm)
        obj.data.listdanhmuc.forEach(element => {
          str += "<option value=\"" + element.madm + "\">" + element.tendm;
          str += "</option>";
        });
        $("#danhmucsp").html(str)
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
  })
  $("#danhmucsp").change(function () {
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
</script>
<%
    else
    response.redirect("login.asp")
    end if
%>