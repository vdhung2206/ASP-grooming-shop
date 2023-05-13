<!-- #include file="../share/connect.asp" -->
<%
    if(isnull(session("tkmanager")) or trim(session("tkmanager"))="") then
        response.redirect("../index.asp")
    end if
    ' for i=LBound(newCart) to UBound(newCart)    
    ' Response.Write newCart(i) & "<br><p>-----</p>"
    ' Next
    ' Else
    '     Response.Write " not an array"
    ' End If
' khi moi san pham duoc add vao gio hang, tien hanh lay ra s_Carts, tang them 1 phan tu cua mang va luu lai trong sesssion
' ham lam tron so nguyen
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function

    function checkPage(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function
' trang hien tai
    page = Request.QueryString("page")
    limit = 5
    strSQL = "SELECT COUNT(TK) AS count FROM TaiKhoan where LoaiTK = '1'"
    connDB.Open()
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing
' lay ve tong so trang
    if (trim(page) = "") or (isnull(page) or Clng(page)<=0) then
        page = 1
    end if
    pages = Ceil(totalRows/limit)
    if (Clng(pages) < Clng(page)) then
        page = pages
    end if
    offset = (Clng(page) * Clng(limit)) - Clng(limit)
    if(offset < 0) then 
    offset =0
    end if
%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <title>CRUD Example</title>
    </head>
    <body>
        <!-- #include file="../share/header.asp" -->

        <div class="container">
            <div class="d-flex bd-highlight mb-3">
                <div class="me-auto p-2 bd-highlight"><h2>Danh sách tài khoản quản lý</h2></div>
                <div class="p-2 bd-highlight">
                    <a href="addeditmngaccount.asp" class="btn btn-primary">Tạo mới</a>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-dark">
                    <thead>
                        <tr>
                            <th scope="col">Tài khoản</th>
                            <th scope="col">Mật khẩu</th>
                            <th scope="col">Tên người dùng</th>
                            <th scope="col">Số điện thoại</th>
                            <th scope="col">Địa chỉ</th>
                            <th scope="col">Tình trạng</th>
                            <th scope="col">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Set cmdPrep = Server.CreateObject("ADODB.Command")
                            cmdPrep.ActiveConnection = connDB
                            cmdPrep.CommandType = 1
                            cmdPrep.Prepared = True
                            cmdPrep.CommandText = "SELECT * FROM TaiKhoan where LoaiTK = '1' ORDER BY TK OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                            cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                            cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)

                            Set Result = cmdPrep.execute
                            do while not Result.EOF
                        %>
                                <tr>
                                    <td><%=Result("TK")%></td>
                                    <td><%=Result("MK")%></td>
                                    <td><%=Result("Ten")%></td>
                                    <td><%=Result("SDT")%></td>
                                    <td><%=Result("DiaChi")%></td>
                                    <td>
                                    <% if(Result("TinhTrang")<>0) then
                                        response.write("Hoạt Động")
                                        else 
                                        response.write("Khóa")
                                    %>
                                    <%
                                    end if
                                    %>
                                    </td>
                                    <td>
                                        <a href="addeditmngaccount.asp?tk=<%=Result("TK")%>" class="btn btn-secondary">Sửa</a>
                                        <%
                                            if(Result("TinhTrang")<>0) then
                                        %>  
                                        <a data-href="<%=Result("TK")%>" onclick="<%session("currentpage")="mngaccount.asp?page="+cstr(page)%>" class="btn btn-danger confirm-ban" data-bs-toggle="modal" data-bs-target="#confirm-ban" title="Ban">Khoá</a>
                                        <%
                                            end if
                                        %>
                                        <%
                                            if(Result("TinhTrang")=0) then
                                        %>  
                                        <a data-href="<%=Result("TK")%>" onclick="<%session("currentpage")="mngaccount.asp?page="+cstr(page)%>"class="btn btn-success confirm-unban" data-bs-toggle="modal" data-bs-target="#confirm-unban" title="Unban">Mở Khóa</a>
                                        <%
                                            end if
                                        %>
                                    </td>
                                </tr>
                        <%
                                Result.MoveNext
                            loop
                        %>
                    </tbody>
                </table>
            </div>

            <nav aria-label="Page Navigation">
                <ul class="pagination pagination-sm justify-content-center my-5">
                    <%
                        dim i
                        i = Request.QueryString("page")
                    %>
                    <li class="page-item "><a class="page-link" <% if(page <= 1) then %>style="pointer-events: none"<%end if%> href="mngaccount.asp?page=<%=Clng(page)-1%>">Trước</a></li>
                    <%  
                        if (pages<=10) then
                        for i = 1 to pages
                    %>
                        <li class="page-item <%=checkPage(Clng(i)=Clng(page),"active")%>"><a class="page-link" href="mngaccount.asp?page=<%=i%>"><%=i%></a></li>
                    <%
                        next
                        end if
                    %>
                    
                    <%  
                        if (pages>10) then
                    %>
                        <li class="page-item <%=checkPage(page = 1,"active")%> "><a class="page-link" href="mngaccount.asp?page=1">1</a></li>
                            <%
                                if(i>3) then
                            %>
                                <li class="page-item"><a class="page-link" style="pointer-events: none" href="">...</a></li>
                            <%
                                end if
                            %>    
                            <% 
                                if (2<page) then
                            %>
                                <li class="page-item "><a class="page-link" href="mngaccount.asp?page=<%=page-1%>"><%=page-1%></a></li>
                            <%
                                end if
                            %>
                            <% 
                                if (page<>1) then
                            %>
                                <li class="page-item <%=checkPage(Clng(i)=Clng(page),"active")%>"><a class="page-link" href="mngaccount.asp?page=<%=page%>"><%=page%></a></li>
                            <%
                                end if
                            %>
                            <% 
                                if (Clng(page)<CLng(pages)-1) then
                            %>
                                <li class="page-item"><a class="page-link" href="mngaccount.asp?page=<%=page+1%>"><%=page+1%></a></li>
                            <%
                                end if
                            %>    
                            <%
                                if(Clng(page)<Clng(pages-2)) then 
                            %>
                                <li class="page-item"><a class="page-link" style="pointer-events: none" href="">...</a></li>
                            <%
                                end if
                            %>    
                            <%
                                if(Clng(pages) > 1 and Clng(page) <Clng(pages)) then
                            %>
                                <li class="page-item <%=checkPage(Clng(page) = Clng(pages),"active")%>"><a class="page-link" href="mngaccount.asp?page=<%=pages%>"><%=pages%></a></li>
                            <%
                                end if
                            %>
                    <%
                        end if
                    %>

                        <li class="page-item "><a class="page-link"<% if(Clng(pages) = Clng(page)) then %>style="pointer-events: none"<%end if%> href="mngaccount.asp?page=<%=Clng(page)+1%>">Sau</a></li>
                </ul>
            </nav>

            <div class="modal" tabindex="-1" id="confirm-ban">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Xác nhận khóa tài khoản</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Xác nhận khóa tài khoản này?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <a id ="dongyban" href="" class="btn btn-danger ">Đồng ý</a>
                        </div>
                    </div>
                </div>
            </div>
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
                            <a id ="dongyunban" href="" class="btn btn-success">Đồng ý</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--#include file="../share/footer.asp"-->
    </body>
</html>