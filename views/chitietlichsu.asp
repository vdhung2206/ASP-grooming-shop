<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <title>Chi tiết đơn hàng</title>
</head>

<body>
<!-- #include file="../share/headerkhachhang.html" -->
    <div class="container">
        <div class="d-flex bd-highlight mb-3" style="padding-left: 0; margin-left:0">
            <div class="me-auto p-2 bd-highlight">
                <h2>Chi tiết đơn hàng</h2>
            </div>
        </div>
        <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
            <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                <label for="madh" class="form-label">Mã đơn hàng: </label>
            </div>
            <div class="col-lg-3">
                <input readonly type="text" class="form-control" id="madh">
            </div>
            <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                <label for="sdt" class="form-label">SĐT nhận hàng: </label>
            </div>
            <div class="col-lg-3">
                <input  readonly type="text" class="form-control" id="sdt">
            </div>
        </div>

        <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
            <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                <label for="ten" class="form-label">Tên người nhận: </label>
            </div>
            <div class="col-lg-3">
                <input readonly type="text" class="form-control" id="ten">
            </div>
            <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                <label for="diachi" class="form-label">Địa chỉ nhận hàng: </label>
            </div>
            <div class="col-lg-3">
                <input  readonly type="text" class="form-control" id="diachi">
            </div>
        </div>
        <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
            <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                <label for="magg" class="form-label">Mã giảm giá áp dụng: </label>
            </div>
            <div class="col-lg-3">
                <input  readonly type="text" class="form-control" id="magg">
            </div>
            <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                <label for="ngaydat" class="form-label">Ngày đặt hàng </label>
            </div>
            <div class="col-lg-3">
                <input readonly type="text" class="form-control" id="ngaydat">
            </div>
        </div>
        <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
            <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                <label for="chietkhau" class="form-label">Chiết khấu: </label>
            </div>
            <div class="col-lg-3">
                <input  readonly type="text" class="form-control" id="chietkhau">
            </div>
            <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                <label for="hoanthanh" class="form-label">Thời gian hoàn thành: </label>
            </div>
            <div class="col-lg-3">
                <input readonly type="text" class="form-control" id="hoanthanh">
            </div>
        </div>
        <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
            <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                <label for="tongtien" class="form-label">Tổng tiền: </label>
            </div>
            <div class="col-lg-3">
                <input readonly type="text" class="form-control" id="tongtien">
            </div>
            <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                <label for="thanhtoan" class="form-label">Thanh toán: </label>
            </div>
            <div class="col-lg-3">
                <input readonly type="text" class="form-control" id="thanhtoan">
            </div>
        </div>
        <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
            <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                <label for="trangthai" class="form-label">Trạng thái </label>
            </div>
            <div class="col-lg-2">
                <input readonly  type="text" class="form-control" id="trangthai">
            </div>     
        </div>
        <div class="table-responsive">
            <table id="mytable" class="table table-dark">
                <thead>
                    <tr>
                        <th scope="col">Tên sản phẩm</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Đơn giá</th>
                        <th scope="col">Thành tiền</th>
                    </tr>
                </thead>
                <tbody id="result">
                </tbody>
            </table>
        </div>
        <script>
            var madh = ""
            $(document).ready(function () {
                var queryString = window.location.search;

                // Tạo đối tượng URLSearchParams từ query string
                var searchParams = new URLSearchParams(queryString);

                // Lấy giá trị của tham số có tên là 'paramName'
                madh = searchParams.get('madh');
                loadData()
            })

            function loadData() {
                $.ajax({
                    method: "get",
                    url: "../controllers/donhang-controller.asp",
                    data: {
                        loai: "laythongtindonhang",
                        madh: madh,
                    }
                    ,
                    success: function (response) {
                        const obj = JSON.parse(response);
                        console.log(obj)
                        $("#madh").val(obj.data.madh)
                        $("#sdt").val(obj.data.sdtnguoinhan)
                        $("#ten").val(obj.data.tennguoinhan)
                        $("#diachi").val(obj.data.diachi)
                        $("#magg").val(obj.data.magg)
                        $("#ngaydat").val(obj.data.ngaydat)
                        $("#chietkhau").val(obj.data.chietkhau)
                        $("#hoanthanh").val(obj.data.ngayhoanthanh)
                        $("#ngaydat").val(obj.data.ngaydat)
                        $("#tongtien").val(obj.data.tongtien)
                        $("#thanhtoan").val(obj.data.thanhtoan)

                        if(obj.data.trangthai== "0"){
                            $("#trangthai").val("Chờ duyệt")
                        }
                        if(obj.data.trangthai== "1"){
                            $("#trangthai").val("Đang giao")
                        }
                        if(obj.data.trangthai== "2"){
                            $("#trangthai").val("Hoàn thành")
                        }
                        if(obj.data.trangthai=="3"){
                            $("#trangthai").val("Đã hủy")
                        }
                        $.ajax({
                            method: "get",
                            url: "../controllers/donhang-controller.asp",
                            data: {
                                loai: "laychitietdonhang",
                                madh: madh,
                            }, success: function (response) {
                                const obj1 = JSON.parse(response);
                                var chitietdonhang = obj1.data.chitietdonhang
                                var str = ""
                                chitietdonhang.forEach(ctdh => {
                                    str += "<tr>";
                                    str += "<td width = 10%>";
                                    str += ctdh.tensp
                                    str += "</td>";
                                    str += "<td>";
                                    str += ctdh.sl;
                                    str += "</td>";
                                    str += "<td>";
                                    str += ctdh.giasp;
                                    str += "</td>";
                                    str += "<td>";
                                    str += ctdh.sl * ctdh.giasp;
                                    str += "</td>";
                                    str += "</tr>";
                                }
                                );
                                $("#result").html(str);
                            }
                        })
                    }
                });
            }
        </script>
</body>

</html>