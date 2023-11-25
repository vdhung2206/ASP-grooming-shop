<%
    if(session("uidadmin")<>"") then
%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <title>Danh sách các đơn hàng</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    </head>
    <body>
        <!-- #include file="../share/header.html" -->
        <div class="container">
        <div  class="d-flex bd-highlight mb-3" style="padding-left: 0; margin-left:0">
            <div class="me-auto p-2 bd-highlight">
                <h2>Danh sách các đơn hàng</h2>
            </div>
        </div>
        <form id="formtimkiem" class="form-inline">
            <div class="form-group mx-sm-3 mb-2 row">
                <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="madh" class="form-label">Mã đơn hàng: </label>
                    </div>
                    <div class="col-lg-3">
                        <input type="text" class="form-control" id="madh">
                    </div>
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="sdt" class="form-label">SĐT nhận hàng: </label>
                    </div>
                    <div class="col-lg-3">
                        <input type="text" class="form-control" id="sdt">
                    </div>
                </div>

                <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="dathangtu" class="form-label">Ngày đặt hàng từ: </label>
                    </div>
                    <div class="col-lg-3">
                        <input type="date" class="form-control" id="dathangtu">
                    </div>
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="dathangden" class="form-label">đến: </label>
                    </div>
                    <div class="col-lg-3">
                        <input type="date" class="form-control" id="dathangden">
                    </div>
                </div>
                <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="hoanthanhtu" class="form-label">Ngày hoàn thành từ: </label>
                    </div>
                    <div class="col-lg-3">
                        <input type="date" class="form-control" id="hoanthanhtu">
                    </div>
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="hoanthanhden" class="form-label">đến: </label>
                    </div>
                    <div class="col-lg-3">
                        <input type="date" class="form-control" id="hoanthanhden">
                    </div>
                </div>
                <div class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="trangthai" class="form-label">Trạng thái đơn hàng</label>
                    </div>
                    <div class="col-lg-3 "style="padding-left: 0; margin-left:0">
                        <select id="trangthai" class="form-select">
                            <option value="">Mặc định</option>
                            <option value="0">Chờ duyệt</option>
                            <option value="1">Đang giao</option>
                            <option value="2">Hoàn thành</option>
                            <option value="3">Đã hủy</option>
                        </select>
                    </div>
                    <div class="col-lg-2 mr-1" style="padding-left: 0; margin-left:0">
                        <label for="sapxepthoigian" class="form-label">Thời gian đặt hàng</label>
                    </div>
                    <div class="col-lg-3 "style="padding-left: 0; margin-left:0">
                        <select id="sapxepthoigian" class="form-select">
                            <option value="">Mặc định</option>
                            <option value="0">Mới nhất</option>
                            <option value="1">Cũ nhất</option>
                        </select>
                    </div>
                </div>
                <div class="col-lg-2 " style="padding-left: 0; margin-left:0">
                    <button type="submit" class="btn btn-primary mb-2">Tìm kiếm</button>
                </div>
            </div>
        </form>
            <div class="table-responsive">
                <table id="mytable"class="table table-dark">
                    <thead>
                        <tr>
                            <th scope="col">Mã ĐH</th>
                            <th scope="col">TK đặt</th>
                            <th scope="col">Tên người nhận</th>
                            <th scope="col">SĐT nhận hàng</th>
                            <th scope="col">Địa chỉ</th>
                            <th scope="col">Mã giảm giá</th>
                            <th scope="col">Ngày đặt hàng</th>
                            <th scope="col">Ngày hoàn thành</th>
                            <th scope="col">Phí giao hàng</th>
                            <th scope="col">Tổng tiền</th>
                            <th scope="col">Chiết khấu</th>
                            <th scope="col">Thanh toán</th>
                            <th scope="col">Trạng thái đơn</th>
                            <th scope="col">Thao tác</th>
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
        <!--#include file="../share/donhangviewfooter.html"-->
    </body>
</html>
<%
    else
    response.redirect("login.asp")
    end if
%>