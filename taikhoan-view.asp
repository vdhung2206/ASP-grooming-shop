
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <title>CRUD Example</title>
    </head>
    <body>
        <!-- #include file="./share/header.asp" -->

        <div class="container">
            <div class="d-flex bd-highlight mb-3">
                <div class="me-auto p-2 bd-highlight"><h2>Danh sách tài khoản khách hàng</h2></div>
                <div class="p-2 bd-highlight">
                    <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#searchbyname" title="searchbyname" class="btn btn-primary">Tìm kiếm theo tên</a>
                    <a href="" class="btn btn-primary">Chức năng 2</a>
                    <a href="" class="btn btn-primary">Chức năng 3</a>
                    <a href="" class="btn btn-primary">Chức năng 4</a>
                </div>
            </div>
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