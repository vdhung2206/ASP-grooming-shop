<!-- #include file="./share/connect.asp" -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://use.fontawesome.com/releases/v5.0.4/css/all.css" rel="stylesheet">  
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src ="jslogin.js?v=1"></script>
</head>
<div class="container">
</div>
    <div class="container" id ="headercontainer" >
        <div id ="loginmsg" class="" role="alert"></div>
    </div>
    <body>       
        <h2 style="text-align: center">Hãy đăng nhập để tiếp tục</h2> 
        <div class="container w-25 mt-4">
            <form id="formlogin" method="post"> 
                <div class="mb-3">
                    <label for="tk" class="form-label">Tên đăng nhập</label>
                    <input type="text" class="form-control" id="tk" name="tk">
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
    </body>
</html>
