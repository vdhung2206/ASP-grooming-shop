$(document).ready(function () {
    $("#formlogin").submit(function (e) {
        e.preventDefault();
        var tk = $("#tk").val().trim();
        var mk = $("#mk").val().trim();
        if (tk == "") {
            $("#loginmsg").addClass("alert alert-danger mt-2");
            $("#loginmsg").html("Tên đăng nhập không được để trống hoặc chứa toàn dầu cách!");
            $(".alert").fadeTo(500, 1).slideDown(500, function () {
            });
            $("#tk").focus();
            window.setTimeout(function () {
                $(".alert").fadeTo(500, 0).slideUp(500, function () {
                });
            }, 2000);
        } else if(mk==""){
            $("#loginmsg").addClass("alert alert-danger mt-2");
            $("#loginmsg").html("Hãy nhập mật khẩu!");
            $(".alert").fadeTo(500, 1).slideDown(500, function () {
            });
            $("#tk").focus();
            window.setTimeout(function () {
                $(".alert").fadeTo(500, 0).slideUp(500, function () {
                });
            }, 2000);
        }
        else{
            $.ajax({
                method: "get",
                url: "taikhoan-controller.asp",
                data:{
                    tk: tk,
                    mk: mk,
                    loai: "admindangnhap",
                },
                success:function(response){
                    const obj  = JSON.parse(response);
                        if(obj.data.checkLogin){
                        const now = new Date();
                        const expires = new Date(now.getTime() + 30 * 24 * 60 * 60 * 1000).toUTCString();
                        document.cookie = "tk="+tk+"; mk="+mk+";expires=" + expires + "; path=/";
                        window.location.href="index.asp"
                    }
                    $("#loginmsg").addClass("alert alert-danger mt-2");
                    $("#loginmsg").html(obj.message);
                    $(".alert").fadeTo(500, 1).slideDown(500, function () {
                     });
                    $("#tk").focus();
                    window.setTimeout(function () {
                    $(".alert").fadeTo(500, 0).slideUp(500, function () {
                    });
                    }, 2000);
                }
            })
        }
    })
})
