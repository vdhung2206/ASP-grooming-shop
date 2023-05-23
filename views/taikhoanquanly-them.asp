<%
    if(session("uid")<>"" and session("loaitk")=2) then
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://use.fontawesome.com/releases/v5.0.4/css/all.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <title>Thêm tài khoản quản lý</title>
</head>

<body>
    <div class="container" id="headercontainer">
        <div class="container" id="headercontainer">
            <div id="createmsg" class="" role="alert"></div>
        </div>
    </div>
    <div class="container w-50 mt-4">
        <form id="taotaikhoanquanly">
            <div class="mb-3">
                <label for="tkql-dangky" class="form-label">Tên đăng nhập</label>
                <input type="text" class="form-control" id="tkql-dangky" name="tkql-dangky"
                    placeholder="Tên đăng nhập (từ 6-25 kí tự)">
            </div>
            <div class="mb-3">
                <label for="mkql-dangky" class="form-label">Mật khẩu</label>
                <input type="password" class="form-control" id="mkql-dangky" name="mkql-dangky"
                    placeholder="Mật khẩu (từ 6 kí tự trở lên, phải có kí tự số)">
            </div>
            <div class="mb-3">
                <label for="mkql-dangky-xacnhan" class="form-label">Xác nhận mật khẩu</label>
                <input type="password" class="form-control" id="mkql-dangky-xacnhan" name="mkql-dangky-xacnhan">
            </div>
            <div class="mb-3">
                <label for="tenql-dangky" class="form-label">Tên người dùng</label>
                <input type="text" class="form-control" id="tenql-dangky" name="tenql-dangky">
            </div>
            <div class="mb-3">
                <label for="sdtql-dangky" class="form-label">Số điện thoại</label>
                <input type="text" class="form-control" id="sdtql-dangky" name="sdtql-dangky"
                    placeholder="VD: 0123456789">
            </div>
            <div class="mb-3">
                <label for="diachiql-dangky" class="form-label">Địa chỉ</label>
                <input type="text" class="form-control" id="diachiql-dangky" name="diachiql-dangky">
            </div>
            <div class="row px-2 mt-4">
                <button type="submit" class="btn btn-primary">Tạo mới</button>
            </div>
        </form>
    </div>
</body>

</html>
<script>
    $("#taotaikhoanquanly").submit(function (e) {
        e.preventDefault()
        var tkqldangky = $("#tkql-dangky").val();
        var mkqldangky = $("#mkql-dangky").val();
        var mkcheck = /^(?=.*\d)[a-zA-Z\d]{6,}$/;
        var mkqldangkyxacnhan = $("#mkql-dangky-xacnhan").val();
        var tenqldangky = $("#tenql-dangky").val();
        var sdtqldangky = $("#sdtql-dangky").val();
        var sdtcheck = /^0[0-9]{9}$/;
        var diachiqldangky = $("#diachiql-dangky").val();
        if (tkqldangky !== "" && mkqldangky !== "" && mkqldangkyxacnhan !== "" && tenqldangky !== "" && sdtqldangky !== "" && diachiqldangky !== "") {
            if (!(tkqldangky.indexOf(' ') !== -1)) {
                if (tkqldangky.length >= 6 && tkqldangky.length <= 25) {
                    if (mkcheck.test(mkqldangky)) {
                        if (mkqldangky == mkqldangkyxacnhan) {
                            if (sdtcheck.test(sdtqldangky)) {
                                $.ajax({
                                    method: "post",
                                    url: "../controllers/taikhoan-controller.asp",
                                    data: {
                                        loai: "taotaikhoanquanly",
                                        tkqldangky: tkqldangky,
                                        mkqldangky: mkqldangky,
                                        tenqldangky: tenqldangky,
                                        sdtqldangky: sdtqldangky,
                                        diachiqldangky: diachiqldangky
                                    },
                                    success: function (response) {
                                        const obj = JSON.parse(response);
                                        if (obj.data.checkCreate) {
                                            sessionStorage.setItem("createMSG","Tạo tài khoản thành công")
                                            window.location.href="taikhoanquanly-view.asp"
                                        }
                                        else{
                                            addAlertDanger(obj.message)
                                        }
                                    }
                                })
                            }
                            else {
                                addAlertDanger("Số điện thoại không đúng định dạng");
                                $("#sdtql-dangky").focus();
                            }
                        }
                        else {
                            addAlertDanger("Mật khẩu và xác nhận mật khẩu không khớp nhau!");
                            $("#mkql-dangky-xacnhan").focus();
                        }
                    }
                    else {
                        addAlertDanger("Mật khẩu phải từ 6 kí tự trở lên và chứa ít nhất một kí tự số!");
                        $("#mkql-dangky").focus();
                    }
                }
                else {
                    addAlertDanger("Tên đăng nhập phải từ 6-25 kí tự!");
                    $("#tkql-dangky").focus();

                }
            }
            else {
                addAlertDanger("Tên đăng nhập không được chứa dấu cách!");
                $("#tkql-dangky").focus();
            }
        }
        else {
            addAlertDanger("Hãy nhập đầy đủ các trường thông tin!")
        }
    })

    function addAlertDanger(msg) {
        $("#createmsg").addClass("alert alert-danger mt-2");
        $("#createmsg").html(msg);
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