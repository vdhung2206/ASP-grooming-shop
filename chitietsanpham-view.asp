
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
      <form id="form-them-sp" action="controllers/sanpham-controller.asp" method="post">
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
          <label for="hinh-anh">Hình ảnh</label>
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
</script>