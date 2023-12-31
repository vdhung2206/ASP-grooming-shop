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
    <style>
        .table-responsive {
            max-height: 300px;
        }
    </style>
</head>

<body>

    <!-- #include file="../share/header.html" -->
    <div class="container col-6">
        <form id="form-them-gg">
            <div class="form-group">
                <input type="hidden" name="loai" value="themsanpham">
            </div>
            <div class="form-group">
                <label for="magg">Mã giảm giá</label>
                <input type="text" name="magg" class="form-control" id="magg">
            </div>
            <div class="form-group">
                <label for="tengg">Tên giảm giá</label>
                <input type="text" name="tengg" class="form-control" id="tengg">
            </div>
            <div class="form-group">
                <label for="loaigg">Loại giảm giá</label>
                <select name="loaigg" id="loaigg" class="form-select">
                    <option value="0">Giảm giá khách hàng</option>
                    <option value="1">Giảm giá sản phẩm</option>
                    <option value="2">Giảm giá theo hãng, danh mục, loại sản phẩm</option>
                </select>
            </div>
            <div class="form-group">
                <label for="tichdiem">Tích điểm lớn hơn:</label>
                <input type="number" name="tichdiem" class="form-control" id="tichdiem">
            </div>
            <div class="form-group">
                <label for="sp">Sản phẩm</label>
                <input type="text" id="searchsp" name="city" list="listsp" class="form-control">
                <datalist id="listsp">
                </datalist>
                <button id="addlist" class="btn btn-primary">Thêm vào danh sách</button>
            </div>
            <div class="form-group">
                <label for="hang">Hãng</label>
                <select name="hangsp" id="hangsp" class="form-select">
                </select>
            </div>
            <div class="form-group">
                <label for="danhmuc">Danh mục</label>
                <select name="danhmuc" id="danhmuc" class="form-select">
                </select>
            </div>
            <div class="form-group">
                <label for="loaisp">Loại</label>
                <select name="loaisp" id="loaisp" class="form-select">
                </select>
            </div>

            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">STT</th>
                            <th scope="col">Tên sản phẩm</th>
                            <th scope="col">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="result">
                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <label for="sotiengg">Số tiền giảm giá:</label>
                <input type="number" name="sotiengg" class="form-control" id="sotiengg">
            </div>
            <div class="form-group">
                <label for="phantramgg">Phần trăm giảm giá:</label>
                <input type="number" max=100 min=0 name="phantramgg" class="form-control" id="phantramgg">
            </div>
            <div class="form-group">
                <label for="ngaybatdau">Ngày bắt đầu:</label>
                <input type="date" name="ngaybatdau" class="form-control" id="ngaybatdau">
            </div>
            <div class="form-group">
                <label for="ngayketthuc">Ngày kết thúc:</label>
                <input type="date" name="ngayketthuc" class="form-control" id="ngayketthuc">
            </div>
            <div class="row px-2 mt-4">
                <button type="submit" class="btn btn-primary">Tạo mới</button>
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
    var loaisp = ""
    var hangsp = ""
    var danhmucsp = ""
    var tensp = ""
    var madm = ""
    var listsp = []


    function loadTable() {
        $("#result").html("")
        var str = ""
        if (listsp.length > 0) {
            for (i = 0; i < listsp.length; i++) {
                str += "<tr>";
                str += "<td>" + (i + 1) + "</td>"
                str += "<td>" + listsp[i].name + "</td>"
                str += "<td>" + "<button class=\"btn btn-danger\" onclick=\"remove(" + listsp[i].key + ")\">Xóa</button>" + "</td>"
                str += "</tr>";
                $("#result").html(str)
            }
        }
        else {
            $("#result").html("")
        }
    }
    function remove(masp) {
        lookupandremove(masp)
        console.log(listsp)
    }
    function lookup(name) {
        for (var i = 0, len = listsp.length; i < len; i++) {
            if (listsp[i].key === name)
                return true;
        }
        return false;
    }
    function lookupandremove(name) {
        for (var i = 0, len = listsp.length; i < len; i++) {
            console.log(listsp[i])
            if (listsp[i].key == name) {
                listsp.splice(i, 1)
                break;
            }
        }
        loadTable()
    }
    $("#addlist").click(function (e) {
        e.preventDefault()
        var key = $("#listsp option[value='" + $('#searchsp').val() + "']").attr('data-value')
        var name = $('#searchsp').val()
        const obj = { key: key, name: name }
        if (obj.key != undefined) {
            if (!lookup(obj.key)) {
                listsp.push(obj)
            }
            else {
                addAlertDanger("Bạn đã chọn sản phẩm này rồi!")
            }
        }
        else {
            addAlertDanger("Bạn chưa chọn sản phẩm nào")
        }
        console.log(listsp)
        loadTable()
    })
    $("#searchsp").keyup(function () {
        $.ajax({
            method: "get",
            url: "../controllers/sanpham-controller.asp",
            data: {
                tensp: $(this).val(),
                loai: "timkiemsanpham",
            },
            success: function (response) {
                const obj = JSON.parse(response);
                var str = ""
                obj.data.danhsachsanpham.forEach(element => {
                    str += "<option data-value=\"" + element.masp + "\"value=\"" + element.tensp + "\"</option>";
                })
                $("#listsp").html(str)
            }
        })
    })
    $("#form-them-gg").submit(function (e) {
        e.preventDefault()
        var magg = $("#magg").val()
        var tengg = $("#tengg").val()
        var loaigg = $("#loaigg").val()
        var tichdiem = $("#tichdiem").val()
        var hangsp = $("#hangsp").val()
        var loaisp = $("#loaisp").val()
        var danhmuc = $("#danhmuc").val()
        var sotiengg = $("#sotiengg").val()
        var phantramgg = $("#phantramgg").val()
        var ngaybatdau = $("#ngaybatdau").val()
        var ngayketthuc = $("#ngayketthuc").val()
        var d = new Date();
        var month = d.getMonth() + 1;
        var day = d.getDate();
        var today = d.getFullYear() + '-' + (month < 10 ? '0' : '') + month + '-' + (day < 10 ? '0' : '') + day
        if (loaigg == 0) {
            if (magg != "") {
                if (tengg != "") {
                    if (tichdiem != "" && tichdiem.match(/^\d+$/)) {
                        if (!(sotiengg != "" && phantramgg != "")) {
                            if (ngaybatdau != "" && ngayketthuc != "") {
                                if (ngaybatdau >= today && ngayketthuc >= today && ngayketthuc >= ngaybatdau) {
                                    $.ajax({
                                        method: "post",
                                        url: "../controllers/giamgia-controller.asp",
                                        data: {
                                            loai: "taochuongtrinhgiamgiakhachhang",
                                            magg: magg,
                                            tengg: tengg,
                                            tichdiemgg: tichdiem,
                                            sotiengg: sotiengg,
                                            phantramgg: phantramgg,
                                            ngaybatdaugg: ngaybatdau,
                                            ngayketthucgg: ngayketthuc,
                                        },
                                        success: function (response) {
                                            const obj = JSON.parse(response);
                                            if(obj.data.themGiamGia){
                                                sessionStorage.setItem("themggMSG","Tạo chương trình giảm giá thành công")
                                                window.location.href="giamgia-view.asp"
                                            }
                                        }
                                    })
                                }
                                else {
                                    addAlertDanger("Ngày bắt đầu và ngày kết thúc không hợp lệ")
                                }
                            }
                            else {
                                addAlertDanger("Hãy chọn ngày bắt đầu và ngày kết thúc")
                            }
                        }
                        else {
                            addAlertDanger("Chỉ được chọn một loại giảm giá (giảm theo tiền hoặc %)")
                        }
                    }
                    else {
                        addAlertDanger("Tích điểm không được để trống và phải là số lớn hơn hoặc bằng 0!")
                    }
                }
                else {
                    addAlertDanger("Tên chương trình giảm giá không được để trống!")
                }
            }
            else {
                addAlertDanger("Mã giảm giá không được để trống!")
            }
        }
        if (loaigg == 1 || loaigg == 2) {
            if (magg != "") {
                if (tengg != "") {
                    if (!(sotiengg != "" && phantramgg != "")) {
                        if (listsp.length > 0) {
                            var listspgg = "";
                            var c = 0
                            listsp.forEach(element=>{
                                c++;
                                listspgg += element.key;
                                if(c<listsp.length){
                                 listspgg+= ","
                                }
                            })
                            if (ngaybatdau != "" && ngayketthuc != "") {
                                if (ngaybatdau >= today && ngayketthuc >= today && ngayketthuc >= ngaybatdau) {
                                    $.ajax({
                                        method: "post",
                                        url: "../controllers/giamgia-controller.asp",
                                        data: {
                                            loai: "taochuongtrinhgiamgiasanpham",
                                            magg: magg,
                                            tengg: tengg,
                                            listspgg: listspgg,
                                            sotiengg: sotiengg,
                                            phantramgg: phantramgg,
                                            ngaybatdaugg: ngaybatdau,
                                            ngayketthucgg: ngayketthuc,
                                        },
                                        success: function (response) {
                                            const obj = JSON.parse(response);
                                            sessionStorage.setItem("themggMSG","Tạo chương trình giảm giá thành công")
                                            window.location.href = "giamgia-view.asp"
                                        }
                                    })
                                }
                                else {
                                    addAlertDanger("Ngày bắt đầu và ngày kết thúc không hợp lệ")
                                }
                            }
                            else {
                                addAlertDanger("Hãy chọn ngày bắt đầu và ngày kết thúc")
                            }
                        }
                        else {
                            addAlertDanger("Hãy chọn ít nhất một sản phẩm ")
                        }
                    }
                    else {
                        addAlertDanger("Chỉ được chọn một loại giảm giá (giảm theo tiền hoặc %)")
                    }
                }
                else {
                    addAlertDanger("Tên chương trình giảm giá không được để trống!")
                }
            }
            else {
                addAlertDanger("Mã giảm giá không được để trống!")
            }
        }
    })
    $("#danhmuc").change(function () {
        madm = $(this).val()
        console.log(madm)
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
                    var str = "<option value=\"\">Không</option>"
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
        else {
            $("#loaisp").html("<option value=\"\">Không</option>");
        }
        listsp = []
        danhmucsp = $(this).val()
        if (danhmucsp == "") {
            loaisp == ""
        }
        console.log(danhmucsp)
        console.log(hangsp)
        console.log(tensp)
        console.log(loaisp)
        $.ajax({
            method: "get",
            url: "../controllers/sanpham-controller.asp",
            data: {
                tensp: tensp,
                danhmucsp: danhmucsp,
                loaisp: loaisp,
                hangsp: hangsp,
                loai: "timkiemsanpham",
            },
            success: function (response) {
                const obj = JSON.parse(response);
                console.log(obj)
                obj.data.danhsachsanpham.forEach(element => {
                    var ob = { key: element.masp, name: element.tensp }
                    //$("#listsearchsp").append(element.tensp + "&#13;&#10; ")
                    listsp.push(ob)
                })
                loadTable()
            }
        })
        console.log(listsp)
    })
    $("#loaisp").change(function () {
        listsp = []
        loaisp = $(this).val()
        console.log(danhmucsp)
        console.log(hangsp)
        console.log(tensp)
        console.log(loaisp)
        $.ajax({
            method: "get",
            url: "../controllers/sanpham-controller.asp",
            data: {
                tensp: tensp,
                danhmucsp: danhmucsp,
                loaisp: loaisp,
                hangsp: hangsp,
                loai: "timkiemsanpham",
            },
            success: function (response) {
                const obj = JSON.parse(response);
                console.log(obj)
                obj.data.danhsachsanpham.forEach(element => {
                    var ob = { key: element.masp, name: element.tensp }
                    //$("#listsearchsp").append(element.tensp + "&#13;&#10; ")
                    listsp.push(ob)
                })
                loadTable()
            }
        })
        console.log(listsp)

    })
    $("#hangsp").change(function () {
        listsp = []
        hangsp = $(this).find(":selected").val();
        console.log(danhmucsp)
        console.log(hangsp)
        console.log(tensp)
        console.log(loaisp)
        $.ajax({
            method: "get",
            url: "../controllers/sanpham-controller.asp",
            data: {
                tensp: tensp,
                danhmucsp: danhmucsp,
                loaisp: loaisp,
                hangsp: hangsp,
                loai: "timkiemsanpham",
            },
            success: function (response) {
                const obj = JSON.parse(response);
                console.log(obj)
                obj.data.danhsachsanpham.forEach(element => {
                    var ob = { key: element.masp, name: element.tensp }
                    //$("#listsearchsp").append(element.tensp + "&#13;&#10; ")
                    listsp.push(ob)
                })
                loadTable()
            }
        })
        console.log(listsp)

    })
    $("#loaigg").change(function () {
        if ($(this).val() == 0) {
            $("#hangsp").prop("disabled", true)
            $("#danhmuc").prop("disabled", true)
            $("#loaisp").prop("disabled", true)
            $("#tichdiem").prop("disabled", false)
            $("#addlist").prop("disabled", true)
            $("#searchsp").prop("disabled", true)
        }
        if ($(this).val() == 1) {
            $("#hangsp").prop("disabled", true)
            $("#danhmuc").prop("disabled", true)
            $("#loaisp").prop("disabled", true)
            $("#tichdiem").prop("disabled", true)
            $("#addlist").prop("disabled", false)
            $("#searchsp").prop("disabled", false)
        }
        if ($(this).val() == 2) {
            $("#hangsp").prop("disabled", false)
            $("#danhmuc").prop("disabled", false)
            $("#loaisp").prop("disabled", false)
            $("#tichdiem").prop("disabled", true)
            $("#addlist").prop("disabled", true)
            $("#searchsp").prop("disabled", true)
        }
    })
    $(document).ready(function () {
        $("#hangsp").prop("disabled", true)
        $("#danhmuc").prop("disabled", true)
        $("#loaisp").prop("disabled", true)
        $("#tichdiem").prop("disabled", false)
        $("#addlist").prop("disabled", true)
        $("#searchsp").prop("disabled", true)
        $.ajax({
            method: "get",
            url: "../controllers/danhmuc-controller.asp",
            data: {
                loai: "getListDanhMuc",
            },
            success: function (response) {
                var str = "<option value=\"\">Không</option>"

                const obj = JSON.parse(response);
                madm = obj.data.listdanhmuc[0].madm
                obj.data.listdanhmuc.forEach(element => {
                    str += "<option value=\"" + element.madm + "\">" + element.tendm;
                    str += "</option>";
                });
                $("#danhmuc").html(str)
                $.ajax({
                    method: "get",
                    url: "../controllers/danhmuc-controller.asp",
                    data: {
                        madm: madm,
                        loai: "getList",
                    },
                    success: function (response) {
                        var str = "<option value=\"\">Không</option>"
                        $("#loaisp").html(str)
                    }
                })
            }
        })
        $.ajax({
            method: "get",
            url: "../controllers/sanpham-controller.asp",
            data: {
                loai: "laydanhsachhang",
            },
            success: function (response) {
                const obj = JSON.parse(response);
                var str = "<option value=\"\">Không</option>"
                if (madm != "") {
                    obj.data.danhsachhang.forEach(element => {
                        str += "<option value=\"" + element + "\">";
                        str += element;
                        str += "</option>";
                    })
                }
                $("#hangsp").html(str)
            }
        })
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
</script>
<%
    else
    response.redirect("login.asp")
    end if
%>