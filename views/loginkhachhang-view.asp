<!-- #include file="../share/connect.asp" -->
<%
    dim t 
    set t= request.form("loai")
    if(t = "dangxuat") then
        Session.Contents.RemoveAll()
    end if
    'Session.Contents.RemoveAll()
    if(session("uid")="") then
    
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <link href="https://use.fontawesome.com/releases/v5.0.4/css/all.css" rel="stylesheet">  
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <title>Document</title>
</head>
    <body>
        <!-- #include file="../share/headerkhachhang.html" -->
        <div class="container" id ="headercontainer" >
            <div id ="loginmsg" class="" role="alert"></div>
        </div>        
        <div class="container w-25 mt-4">
            <form id="formlogin" method="post" action=""> 
                <div class="mb-3">
                    <label for="tk" class="form-label">Tên đăng nhập</label>
                    <input value="<%=session("taikhoan")%>"type="text" class="form-control" id="tk" name="tk">
                </div>
                <div class="mb-3">
                    <label for="mk" class="form-label">Mật khẩu</label>
                    <input type="password" class="form-control" id="mk" name="mk">
                </div>
                <div class="row px-2 mt-4"> 
                <button type="submit" class="btn btn-primary">Login</button>
                </div>
            </form>
        </div>
    
    <script>
    $(document).ready(function () {
    $("#formlogin").submit(function (e) {
        e.preventDefault();
        var tk = $("#tk").val();
        var regex = /\s/;
        var mk = $("#mk").val();
        if (!regex.test(tk)){
            if (tk == "") {
                $("#loginmsg").addClass("alert alert-danger mt-2");
                $("#loginmsg").html("Tên đăng nhập không được để trống hoặc chứa toàn dấu cách!");
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
                    url: "../controllers/taikhoan-controller.asp",
                    data:{
                        tk: tk,
                        mk: mk,
                        loai: "khachhangdangnhap",
                    },
                    success:function(response){
                        const obj  = JSON.parse(response);
                            if(obj.data.checkLogin){
                            const now = new Date();
                            const expires = new Date(now.getTime() + 20 * 60 * 1000).toUTCString();
                            document.cookie = "tk="+tk+"; mk="+mk+";expires=" + expires + "; path=/";
                            window.location.href="trangchukhachhang-view.asp"
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
        }
        else{
            $("#loginmsg").addClass("alert alert-danger mt-2");
                $("#loginmsg").html("Tên đăng nhập không được chứa dấu cách!");
                $(".alert").fadeTo(500, 1).slideDown(500, function () {
                });
                $("#tk").focus();
                window.setTimeout(function () {
                    $(".alert").fadeTo(500, 0).slideUp(500, function () {
                    });
                }, 2000);
        }
    })
})
    </script>
    </body>
</html>
<%
    else
        response.redirect("trangchukhachhang-view.asp")
    end if
%>