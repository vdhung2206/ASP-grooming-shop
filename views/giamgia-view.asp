<%
    if(session("uidadmin")<>"") then
%>
<html lang="en">

<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <title>Giảm giá</title>
</head>

<body>
    <!-- #include file="../share/header.html" -->

    <div class="container">
        <div class="d-flex bd-highlight mb-3" style="padding-left: 0; margin-left:0">

            <div class="me-auto p-2 bd-highlight">
                <h2>Danh sách các chương trình giảm giá </h2>
            </div>
            <div class="p-2 bd-highlight">
                <a href="" class="btn btn-primary">Thêm</a>
            </div>
        </div>
        <form id="formtimkiem" class="form-inline">
            <div class="form-group mx-sm-3 mb-2 row">
                <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="inputmagg" class="form-label">Mã giảm giá: </label>
                    </div>
                    <div class="col-lg-3">
                        <input type="text" class="form-control" id="inputmagg">
                    </div>
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="inputtengg" class="form-label">Tên chương trình: </label>
                    </div>
                    <div class="col-lg-3">
                        <input type="text" class="form-control" id="inputtengg">
                    </div>
                </div>

                <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="inputbatdautruoc" class="form-label">Bắt đầu trước: </label>
                    </div>
                    <div class="col-lg-3">
                        <input type="date" class="form-control" id="inputbatdautruoc">
                    </div>
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="inputbatdautu" class="form-label">Bắt đầu từ: </label>
                    </div>
                    <div class="col-lg-3">
                        <input type="date" class="form-control" id="inputbatdautu">
                    </div>
                </div>
                <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="inputketthuctruoc" class="form-label">Kết thúc trước: </label>
                    </div>
                    <div class="col-lg-3">
                        <input type="date" class="form-control" id="inputketthuctruoc">
                    </div>
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="inputketthuctu" class="form-label">Kết thúc từ: </label>
                    </div>
                    <div class="col-lg-3">
                        <input type="date" class="form-control" id="inputketthuctu">
                    </div>
                </div>
                <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="customRange1" class="form-label">Tích điểm≥ </label>
                        <label id="tichdiemtren"></label>
                    </div>
                    <div class="col-lg-3">
                        <input type="range" class="form-range" id="customRange1">
                    </div>
                    <div class="col-lg-3">
                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                        <label class="form-check-label" for="flexCheckDefault">
                            Lọc theo tích điểm
                        </label>
                    </div>
                </div>
                <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="customRange1" class="form-label">Tích điểm ≤ </label>
                        <label id="tichdiemduoi"></label>
                    </div>
                    <div class="col-lg-3">
                        <input type="range" class="form-range" id="customRange2">
                    </div>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="checkbox1" value="0" id="cb1">
                    <label class="form-check-label" for="cb1">
                        Đã kết thúc
                    </label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="checkbox1" value="1" id="cb2">
                    <label class="form-check-label" for="cb2">
                        Chưa kết thúc
                    </label>
                </div>
                <div class="col-lg-2 " style="padding-left: 0; margin-left:0">
                    <button type="submit" class="btn btn-primary mb-2">Tìm kiếm</button>
                </div>
            </div>
        </form>
        <div class="table-responsive">
            <table id="mytable" class="table table-dark">
                <thead>
                    <tr>
                        <th scope="col">Mã giảm giá</th>
                        <th scope="col">Tên chương trình</th>
                        <th scope="col">Điều kiện áp dụng</th>
                        <th scope="col">Bắt đầu</th>
                        <th scope="col">Kết thúc</th>
                        <th scope="col">Phần trăm</th>
                        <th scope="col">Số tiền</th>
                        <th scope="col">Thao Tác</th>
                    </tr>
                </thead>
                <tbody id="result">
                </tbody>
            </table>
        </div>
    </div>
    <script>
        var tengg
        var magg
        var batdautruoc
        var batdautu
        var ketthuctruoc
        var ketthuctu
        var tichdiem1 = ""
        var tichdiem2 = ""
        var selectedValue = ""
        $("#formtimkiem").submit(function (e) {
            e.preventDefault()
            tengg = $("#inputtengg").val();
            magg = $("#inputmagg").val();
            batdautruoc = $("#inputbatdautruoc").val()
            batdautu = $("#inputbatdautu").val()
            ketthuctruoc = $("#inputketthuctruoc").val()
            ketthuctu = $("#inputketthuctu").val()
            if ($('#flexCheckDefault').is(':checked')) {
                tichdiem1 = $("#customRange1").val();
                tichdiem2 = $("#customRange2").val();
            }
            selectedValue = ""
            tinhtrang = document.getElementsByName('checkbox1');
            for (var i = 0, length = tinhtrang.length; i < length; i++) {
                if (tinhtrang[i].checked) {
                    selectedValue = tinhtrang[i].value;
                    break;
                }
            }
            loadData(1)
        })
        $("#inputbatdautruoc").on('input', function () {
            if ($(this).val() != '') {
                $("#inputbatdautu").prop("disabled", true)
            }
            else {
                $("#inputbatdautu").prop("disabled", false)
            }
        })
        $("#inputketthuctruoc").on('input', function () {
            if ($(this).val() != '') {
                $("#inputketthuctu").prop("disabled", true)
            }
            else {
                $("#inputketthuctu").prop("disabled", false)
            }
        })
        $("#inputketthuctu").on('input', function () {
            if ($(this).val() != '') {
                $("#inputketthuctruoc").prop("disabled", true)
            }
            else {
                $("#inputketthuctruoc").prop("disabled", false)
            }
        })
        $("#inputbatdautu").on('input', function () {
            if ($(this).val() != '') {
                $("#inputbatdautruoc").prop("disabled", true)
            }
            else {
                $("#inputbatdautruoc").prop("disabled", false)
            }
        })
        $(document).on('input', '#customRange1', function () {
            var val1 = $(this).val();
            if (parseInt(val1) > parseInt($("#customRange2").val())) {
                $(this).val($("#customRange2").val())
            }
            $("#tichdiemtren").html($(this).val())
        });
        $(document).on('input', '#customRange2', function () {
            var val1 = $(this).val();
            if (parseInt(val1) < parseInt($("#customRange1").val())){
                $(this).val($("#customRange1").val())
            }
            $("#tichdiemduoi").html($(this).val())
        });
        $("#flexCheckDefault").change(function () {
            if ($('#flexCheckDefault').is(':checked')) {
                $(".form-range").prop('disabled', false)
                var val = $("#customRange1").val();
                $("#tichdiemtren").html(val)
                val = $("#customRange2").val();
                $("#tichdiemduoi").html(val)
            } else {
                $(".form-range").prop('disabled', true)
                $("#tichdiemtren").html("")
                $("#tichdiemduoi").html("")
            }
        })
        const checkboxes = document.getElementsByName('checkbox1');

        checkboxes.forEach((checkbox) => {
            checkbox.addEventListener('click', (event) => {
                // Nếu ô checkbox đang được chọn
                if (checkbox.checked) {
                    // Vô hiệu hóa tất cả các ô checkbox khác
                    checkboxes.forEach((otherCheckbox) => {
                        if (otherCheckbox !== checkbox) {
                            otherCheckbox.disabled = true;
                        }
                    });
                } else {
                    // Kích hoạt lại tất cả các ô checkbox
                    checkboxes.forEach((otherCheckbox) => {
                        otherCheckbox.disabled = false;
                    });
                }
            });
        });
        $(document).ready(function () {
            if (sessionStorage.getItem("themggMSG") != null && sessionStorage.getItem("themggMSG") != "") {
                console.log(sessionStorage.getItem("themggMSG"))
                $("#msg").html(sessionStorage.getItem("themggMSG"));
                $("#msg").addClass("alert alert-success");
                $(".alert").fadeTo(500, 1).slideDown(500, function () {
                });
                window.setTimeout(function () {
                    $(".alert").fadeTo(500, 0).slideUp(500, function () {
                    });
                }, 2000);
                sessionStorage.removeItem("themggMSG");
            }
            $(".form-range").prop('disabled', true)
            $("#tichdiemtren").html("")
            $("#tichdiemduoi").html("")
            $.ajax({
                method: "get",
                url: "../controllers/giamgia-controller.asp",
                data: {
                    loai: "laydanhsachgiamgia",
                }, success: function (response) {
                    const obj = JSON.parse(response);
                    var mintichdiem = obj.data.minTichDiem
                    var maxtichdiem = obj.data.maxTichDiem
                    $("#customRange1").prop("min", mintichdiem)
                    $("#customRange1").prop("max", maxtichdiem)
                    $("#customRange1").val(mintichdiem)
                    $("#customRange2").prop("min", mintichdiem)
                    $("#customRange2").prop("max", maxtichdiem)
                    $("#customRange2").val(maxtichdiem)
                }
            })
            loadData();
        });
        function loadData() {
            $.ajax({
                method: "get",
                url: "../controllers/giamgia-controller.asp",
                data: {
                    loai: "laydanhsachgiamgia",
                    tengg: tengg,
                    magg: magg,
                    batdautruoc: batdautruoc,
                    batdautu: batdautu,
                    ketthuctruoc: ketthuctruoc,
                    ketthuctu: ketthuctu,
                    tichdiem1: tichdiem1,
                    tichdiem2: tichdiem2,
                    tinhtrang: selectedValue,
                }
                ,
                success: function (response) {
                    const obj = JSON.parse(response);
                    var danhsachgiamgia = obj.data.danhsachgiamgia
                    var str = ""
                    danhsachgiamgia.forEach(giamgia => {
                        str += "<tr>";
                        str += "<td>";
                        str += giamgia.magg;
                        str += "</td>";
                        str += "<td>";
                        str += giamgia.tengg;
                        str += "</td>";
                        str += "<td>";
                        str += giamgia.dkkhachhang;
                        str += "</td>";
                        str += "<td>";
                        str += giamgia.batdau;
                        str += "<td>";
                        str += giamgia.ketthuc;
                        str += "</td>";
                        str += "<td>";
                        str += giamgia.phantramgg;
                        str += "</td>";
                        str += "<td>";
                        str += giamgia.sotiengg;
                        str += "</td>";
                        str += "<td>";
                        str += "</tr>";
                    }
                    );
                    $("#result").html(str);
                }
            });
        }
    </script>
</body>

</html>
<%
    else
    response.redirect("login.asp")
    end if
%>