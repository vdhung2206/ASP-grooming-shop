<%
    if(session("uid")<>"") then
%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <title>Tài khoản khách hàng</title>
    </head>
    <body>
        <!-- #include file="./share/header.html" -->
        <div class="container">
        <div class="me-auto p-2 bd-highlight"><h2>Danh sách tài khoản khách hàng</h2></div>
        <form id ="formtimkiem" class="form-inline">
            <div  class="form-group mx-sm-3 mb-2 row" >

                <div  class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1"style="padding-left: 0; margin-left:0">
                        <label for="inputtennguoidung" class="form-label">Tên người dùng: </label>
                    </div>
                    <div class="col-lg-3" >
                        <input type="text" class="form-control" id="inputtennguoidung">
                    </div>
                    <div class="col-lg-2 mr-1"style="padding-left: 0; margin-left:0">
                        <label for="inputsodienthoai" class="form-label">Số điện thoại: </label>
                    </div>
                    <div class="col-lg-3" >
                        <input type="text" class="form-control" id="inputsodienthoai">
                    </div>
                </div>

                <div  class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1"style="padding-left: 0; margin-left:0">
                        <label for="inputtaikhoan" class="form-label">Tài khoản: </label>
                    </div>
                    <div class="col-lg-3" >
                        <input type="text" class="form-control" id="inputtaikhoan">
                    </div>
                    <div class="col-lg-2 mr-1"style="padding-left: 0; margin-left:0">
                        <label for="inputdiachi" class="form-label">Địa chỉ: </label>
                    </div>
                    <div class="col-lg-3" >
                        <input type="text" class="form-control" id="inputdiachi">
                    </div>
                </div>
                <div  class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1"style="padding-left: 0; margin-left:0">
                        <label for="customRange1" class="form-label">Tích điểm trên: </label>
                        <label id="tichdiem"></label>
                    </div>
                    <div class="col-lg-3" >
                        <input type="range" class="form-range" id="customRange1">
                    </div>
                    <div class="col-lg-3" >
                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                        <label class="form-check-label" for="flexCheckDefault">
                            Lọc theo tích điểm
                        </label>    
                    </div>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="checkbox1" value="0" id="cb1">
                    <label class="form-check-label" for="cb1">
                        Khóa
                    </label>
                </div>
                    <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="checkbox1" value ="1" id="cb2">
                    <label class="form-check-label" for="cb2">
                        Hoạt động
                    </label>
                </div>
                <div class="col-lg-4 "style="padding-left: 0; margin-left:0">
                    <button type="submit" class="btn btn-primary mb-2">Tìm kiếm</button>
                </div>
            </div>
        </form>
            <div class="table-responsive">
                <table id="mytable"class="table table-dark">
                    <thead>
                        <tr>
                            <th scope="col">Tài khoản</th>
                            <th scope="col">Tên người dùng</th>
                            <th scope="col">Số điện thoại</th>
                            <th scope="col">Địa chỉ</th>
                            <th scope="col">Tích Điểm</th>
                            <th scope="col">Tình trạng</th>
                            <th scope="col">Thao Tác</th>
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

            <div class="modal" tabindex="-1" id="confirm-unban">                
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Xác nhận mở khóa tài khoản</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Xác nhận mở khóa tài khoản này?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <form>
                                <input id="tkmuonunban" type="hidden" value="">
                                <input id="type" type="hidden" value="">

                                <button id="confirm" type="button" data-bs-dismiss="modal" class="btn btn-success">
                                    Đồng ý
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
        <!--#include file="./share/taikhoanviewfooter.html"-->
    </body>
</html>
<%
    else
    response.redirect("login.asp")
    end if
%>