
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://use.fontawesome.com/releases/v5.0.4/css/all.css" rel="stylesheet">  
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <title>Thêm tài khoản quản lý</title>
</head>
<body>
<div class="container w-50 mt-4">
            <form method="post" action="register.asp">
                <div class="mb-3">
                    <label for="tkregister" class="form-label">Tên đăng nhập</label>
                    <input type="text" class="form-control" id="tkregister" name="tkregister" value="<%=tkregister%>" placeholder="Tên đăng nhập (từ 6-25 kí tự)">
                </div>
                <div class="mb-3">
                    <label for="mkregister" class="form-label">Mật khẩu</label>
                    <input type="password" class="form-control" id="mkregister" name="mkregister" value="<%=mkregister%>" placeholder="Mật khẩu (từ 6 kí tự trở lên, phải có kí tự số)">
                </div>
                <div class="mb-3">
                    <label for="mkconfirm" class="form-label">Xác nhận mật khẩu</label>
                    <input type="password" class="form-control" id="mkconfirm" name="mkconfirm" value="<%=mkconfirm%>" >
                </div>
                <div class="mb-3">
                    <label for="fname" class="form-label">Tên người dùng</label>
                    <input type="text" class="form-control" id="fname" name="fname" value="<%=fname%>">
                </div>     
                <div class="mb-3">
                    <label for="sdt" class="form-label">Số điện thoại</label>
                    <input type="text" class="form-control" id="sdt" name="sdt" placeholder="VD: 0123456789" value="<%=sdt%>">
                </div>     
                <div class="mb-3">
                    <label for="address" class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" id="address" name="address" placeholder="Có thể cập nhật lại sau khi đăng ký" value="<%=address%>">
                </div>            
                <div class="row px-2 mt-4"> 
                <button type="submit" class="btn btn-primary">Đăng ký</button>
                </div>
            </form>
        </div>
</body>
</html>