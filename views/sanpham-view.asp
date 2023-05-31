<%
    if(session("uidadmin")<>"") then
%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <title>Danh sách sản phẩm</title>
    </head>
    <body>
        <!-- #include file="../share/header.html" -->
        <div class="container">
        <div  class="d-flex bd-highlight mb-3" style="padding-left: 0; margin-left:0">
            <div class="me-auto p-2 bd-highlight">
                <h2>Danh sách sản phẩm</h2>
            </div>
            <div class="p-2 bd-highlight">
                <a href="" class="btn btn-primary">Thêm sản phẩm</a>
            </div>
        </div>
        <form id ="formtimkiem" class="form-inline">
            <div  class="form-group mx-sm-3 mb-2 row" >

                <div  class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1"style="padding-left: 0; margin-left:0">
                        <label for="tensp" class="form-label">Tên sản phẩm: </label>
                    </div>
                    <div class="col-lg-3" >
                        <input type="text" class="form-control" id="tensp">
                    </div>
                    <div class="col-lg-1 mr-1"style="padding-left: 0; margin-left:0">
                        <label for="danhmucsp" class="form-label">Danh mục: </label>

                    </div>
                    <div class="col-lg-2 mr-1"style="padding-left: 0; margin-left:0">
                        <select name="danhmucsp" id="danhmucsp" class="form-select">
                        </select>
                    </div>
                    <div class="col-lg-1 mr-1"style="padding-left: 0; margin-left:0">
                        <label for="loaisp" class="form-label">Loại: </label>

                    </div>
                    <div class="col-lg-2 mr-1"style="padding-left: 0; margin-left:0">
                        <select name="loaisp" id="loaisp" class="form-select">
                            
                        </select>
                    </div>
                </div>

                <div  class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1"style="padding-left: 0; margin-left:0">
                        <label for="hangsp" class="form-label">Hãng: </label>
                    </div>
                    <div class="col-lg-3" >
                        <input type="text" class="form-control" id="hangsp">
                    </div>
                </div>
                <div  class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 mr-1"style="padding-left: 0; margin-left:0">
                        <label for="customRange1" class="form-label">Số lượng tồn ≥: </label>
                        <label id="tonkhotren"></label>
                    </div>
                    <div class="col-lg-3" >
                        <input type="range" class="form-range" id="customRange1">
                    </div>
                    <div class="col-lg-3" >
                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                        <label class="form-check-label" for="flexCheckDefault">
                            Lọc theo số lượng tồn kho
                        </label>    
                    </div>
                </div>
                <div class="form-group row mt-3" style="padding-left: 0; margin-left:0" >
                    <div class="col-lg-2 mr-1"style="padding-left: 0; margin-left:0">
                        <label for="customRange1" class="form-label">Số lượng tồn ≤: </label>
                        <label id="tonkhoduoi"></label>
                    </div>
                    <div class="col-lg-3" >
                        <input type="range" class="form-range" id="customRange2">
                    </div>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="checkbox1" value="1" id="cb1">
                    <label class="form-check-label" for="cb1">
                        Đang bán
                    </label>
                </div>
                    <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="checkbox1" value ="0" id="cb2">
                    <label class="form-check-label" for="cb2">
                        Ngừng bán
                    </label>
                </div>
                <div  class="form-group row mt-3" style="padding-left: 0; margin-left:0">
                    <div class="col-lg-2 "style="padding-left: 0; margin-left:0">
                        <button type="submit" class="btn btn-primary mb-2">Tìm kiếm</button>
                    </div>
                    <div class="col-lg-3 "style="padding-left: 0; margin-left:0">
                        <select id="sapxeptonkho" class="form-select">
                            <option value="">Sắp xếp theo số lượng tồn kho</option>
                            <option value="0">Tăng dần</option>
                            <option value="1">Giảm dần</option>
                        </select>
                    </div>
                </div>
            </div>
        </form>
            <div class="table-responsive">
                <table id="mytable"class="table table-dark">
                    <thead>
                        <tr>
                            <th scope="col">Hình ảnh</th>
                            <th scope="col">Tên SP</th>
                            <th scope="col">Danh mục</th>
                            <th scope="col">Loại</th>
                            <th scope="col">Hãng</th>
                            <th scope="col">SL Tồn</th>
                            <th scope="col">Giá gốc</th>
                            <th scope="col">Giảm giá</th>
                            <th scope="col">Giá bán</th>
                            <th scope="col">Trạng thái</th>
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
        <!--#include file="../share/sanphamviewfooter.html"-->
    </body>
</html>
<%
    else
    response.redirect("login.asp")
    end if
%>