<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <title>Danh sách các đơn hàng</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    </head>
    <body>
        <!-- #include file="../share/headerkhachhang.html" -->
        <div class="container">
        <div  class="d-flex bd-highlight mb-3" style="padding-left: 0; margin-left:0">
            <div class="me-auto p-2 bd-highlight">
                <h2>Lịch sử đặt hàng của bạn</h2>
            </div>
        </div>
            <div class="table-responsive">
                <table id="mytable"class="table table-dark">
                    <thead>
                        <tr>
                            <th scope="col">Mã ĐH</th>
                            <th scope="col">Tên người nhận</th>
                            <th scope="col">SĐT nhận hàng</th>
                            <th scope="col">Địa chỉ</th>
                            <th scope="col">Mã giảm giá</th>
                            <th scope="col">Ngày đặt hàng</th>
                            <th scope="col">Phí giao hàng</th>
                            <th scope="col">Tổng tiền</th>
                            <th scope="col">Chiết khấu</th>
                            <th scope="col">Thanh toán</th>
                            <th scope="col">Trạng thái đơn</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                        <tbody id="result">
                        </tbody>
                </table>
            </div>

            <nav aria-label="Page Navigation">
            <ul id ="thanhphantrang"class="pagination pagination-sm justify-content-center my-5">
                <li class="page-item"><a class ="page-link" style="pointer-events: none" href ="taikhoan-view.asp?page=0">Trước</a></li>
            </ul>
            </nav>
        </div>
        <script>
         $(document).ready(function () {
        $.ajax({
            method: "get",
            url: "../controllers/donhang-controller.asp",
            data: {
                loai: "lichsudathang",
                tk: getCookie("tk"),
            },
            success: function (response) {
                const obj = JSON.parse(response);
                console.log(obj)
            }
        })
        loadData(1);
    })

    function loadData(page) {
        currentPage = page
        $.ajax({
            method: "get",
            url: "../controllers/donhang-controller.asp",
            data: {
                page: page,
                loai: "lichsudathang",
                tk: getCookie("tk"),
            }
            ,
            success: function (response) {
                const obj = JSON.parse(response);
                $("#customRange1").prop("min", obj.data.mintonkhoall)
                $("#customRange2").prop("max", obj.data.maxtonkhoall)
                $("#customRange1").prop("max", obj.data.maxtonkhoall)
                $("#customRange2").prop("min", obj.data.mintonkhoall)
                var danhsachdonhang = obj.data.danhsachdonhang
                var str = ""
                danhsachdonhang.forEach(donhang => {
                    str += "<tr>";
                    str += "<td width = 10%>";
                    str += donhang.madh
                    str += "</td>";
                    str += "<td>";
                    str += donhang.tennguoinhan;
                    str += "</td>";
                    str += "<td>";
                    str += donhang.sdtnguoinhan;
                    str += "</td>";
                    str += "<td>";
                    str += donhang.diachi;
                    str += "<td>";
                    str += donhang.magg;
                    str += "</td>";
                    str += "<td>";
                    str += donhang.ngaydat;
                    str += "</td>";
                    str += "<td>";
                    str += donhang.phigiaohang;
                    str += "</td>";
                    str += "<td>";
                    str += donhang.tongtien;
                    str += "</td>";
                    str += "<td>";
                    str += donhang.chietkhau;
                    str += "</td>";
                    str += "<td>";
                    str += donhang.thanhtoan;
                    str += "</td>";
                    str += "<td>";
                    if (donhang.trangthai == "0")
                        str += "Chờ duyệt";
                    else if (donhang.trangthai == "1")
                        str += "Đang giao";
                    else if (donhang.trangthai == "2")
                        str += "Đã hoàn thành"
                    else {
                        str += "Đã hủy"
                    }
                    str += "</td>";
                    str += "<td>";
                    str += "<form action=\"chitietdonhang-view.asp\">"
                    str += "<input type=\"hidden\" name=\"masp\" value=\"" + donhang.masp + "\">"
                    str += "<input type=\"hidden\" name=\"loai\" value=\"laythongtindonhang\">";
                    str += '<a type="submit" href="chitietlichsu.asp?madh='+donhang.madh+'" class="btn btn-success")">Chi tiết</a>';
                    str += "</form>";
                    str += "</td>";
                    str += "</tr>";
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
        </script>
    </body>
</html>