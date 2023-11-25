<%
    if(session("uidadmin")<>"") then
%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Tổng quan</title>

    <!-- Custom fonts for this template-->
    <link href="index/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="index/css/sb-admin-2.min.css" rel="stylesheet">

</head>
<body id="page-top">
    <!-- #include file="../share/header.html" -->

    <!-- Page Wrapper -->
    <div class="container" id="wrapper">

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Tổng quan</h1>
                    </div>

                    <!-- Content Row -->
                    <div class="row">

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                Doanh thu tháng này</div>
                                            <div id="doanhthuthang" class="h5 mb-0 font-weight-bold text-gray-800">$40,000</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                Doanh thu cả năm</div>
                                            <div id="doanhthunam" class="h5 mb-0 font-weight-bold text-gray-800">$215,000</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                                Số đơn hàng hoàn thành tháng này
                                            </div>
                                            <div class="row no-gutters align-items-center">
                                                <div class="col-auto">
                                                    <div id="thongkehoanthanh" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pending Requests Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                Số đơn hàng chờ duyệt</div>
                                            <div id="thongkechoduyet" class="h5 mb-0 font-weight-bold text-gray-800">18</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Content Row -->

                    <div class="row">

                        <!-- Area Chart -->
                        <div class="col-xl-12 col-lg-7">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">Tăng trưởng doanh thu</h6>
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                            aria-labelledby="dropdownMenuLink">
                                            <div class="dropdown-header">Dropdown Header:</div>
                                            <a class="dropdown-item" href="#">Action</a>
                                            <a class="dropdown-item" href="#">Another action</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Something else here</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area">
                                        <canvas id="myAreaChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-12 col-lg-7">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">Doanh thu và số lượng đơn hàng</h6>
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                            aria-labelledby="dropdownMenuLink">
                                            <div class="dropdown-header">Dropdown Header:</div>
                                            <a class="dropdown-item" href="#">Action</a>
                                            <a class="dropdown-item" href="#">Another action</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Something else here</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area">
                                        <canvas id="myAreaChart1"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>

                    <!-- Content Row -->
                    <div class="row">

                        <!-- Content Column -->
                        <div class="col-lg-6 mb-4">

                        </div>

                        <div class="col-lg-6 mb-4">


                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->
                <div class="col-lg-9 mr-1"style="padding-left: 0; margin-left:0">
                    <label for="" class="form-label">Doanh số các sản phẩm trong tháng</label>
                    <select id ="month" name="thang" id="thang" class="form-select">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">12</option>
                        <option value="12">12</option>
                    </select>
                    <label for="" class="form-label"> năm</label>
                    <select id="year" name="nam" id="nam" class="form-select">
                    </select>
                </div>

                <div class="table-responsive">
                <table id="mytable"class="table table-dark">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Tên SP</th>
                            <th scope="col">Doanh số</th>
                        </tr>
                    </thead>
                        <tbody id="result">
                        </tbody>
                </table>
                <nav aria-label="Page Navigation">
            <ul id ="thanhphantrang"class="pagination pagination-sm justify-content-center my-5">
                <li class="page-item"><a class ="page-link" style="pointer-events: none" href ="taikhoan-view.asp?page=0">Trước</a></li>
            </ul>
            </nav>
            </div>
            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Nhóm 19</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Bootstrap core JavaScript-->
    <script src="index/vendor/jquery/jquery.min.js"></script>
    <script src="index/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="index/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="index/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="index/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="index/js/demo/chart-area-demo.js"></script>
    <script src="index/js/demo/chart-pie-demo.js"></script>
    <script>
    var currentPage = "1"
        $("#month").change(function(){
            loadData(1)
        })
        $("#year").change(function(){
            loadData(1)
        })
        $(document).ready(function(){
            var date = new Date();
            var str = "";
            str+="<option value="+ date.getFullYear()+">"+ date.getFullYear() +"</option>";
            str+="<option value="+( date.getFullYear()-1)+">"+( date.getFullYear()-1)+"</option>";         
            str+="<option value="+( date.getFullYear()-2)+">"+( date.getFullYear()-2 )+"</option>";           
            $("#year").html(str);
            loadData(1);
            var date = new Date();
            var currentMonth = date.getMonth() + 1;
            $("#month").val(currentMonth);
            loadData(1);
        })
        function loadData(page) {
        currentPage = page
        $.ajax({
        method: "get",
        url: "../controllers/sanpham-controller.asp",
        data: {
            page: page,
            loai: "thongkedoanhsosanpham",
            nam: $("#year").val(),
            thang: $("#month").val(),
        }
        ,
        success: function (response) {
            const obj = JSON.parse(response);
            console.log(obj)
            var danhsachsanpham = obj.data.danhsachsanpham
            var str = ""
            var count = 1;
            danhsachsanpham.forEach(sanpham => {
            str += "<tr>";
            str += "<td>";
            str += sanpham.stt;
            str += "</td>";
            str += "<td>";
            str += sanpham.tensp;
            str += "</td>";
            str += "<td>";
            str += sanpham.doanhso;
            str += "</td>";
            str += "</tr>";
            }
            );
            $("#result").html(str);
            loadThanhPhanTrang(obj.data.totalPages,page)
        }
        });
    }
    function loadThanhPhanTrang(totalPages, currentPage) {
    if (currentPage < 1) {
      currentPage = 1;
    }
    if (currentPage > totalPages) {
      currentPage = totalPages;
    }
    var truoc = "<li class=\"page-item\"" + "><a id=\"truoc\" class =\"page-link\" onclick=\"loadData(" + (currentPage - 1) + ")\" style=\"cursor:pointer";
    truoc += "\">" + "Trước</a></li>"
    var str = "";
    str += truoc;
    if (totalPages <= 10) {
      for (let i = 1; i <= totalPages; i++) {
        str += "<li class=\"page-item"
        if (i == currentPage) {
          str += " active"
        }
        str += "\"><a class =\"page-link\" style=\"cursor:pointer\" onclick=\"loadData(" + i + ")\""
        str += ">" + i + "</a></li>"
      }
    }
    if (totalPages > 10) {
      str += "<li class=\"page-item";
      if (1 == currentPage) {
        str += " active"
      }
      str += "\"><a class=\"page-link\" style=\"cursor:pointer\" onclick=\"loadData(1)\">" + 1 + "</a></li>"
      if (currentPage > 3) {
        str += "<li class=\"page-item\"><a class=\"page-link\" style=\"pointer-events: none\">...</a></li>"
      }
      if (currentPage > 2) {
        str += "<li class=\"page-item \"><a class=\"page-link\" style=\"cursor:pointer\" onclick=\"loadData(" + (parseInt(currentPage) - 1) + ")\">" + (parseInt(currentPage) - 1) + "</a></li>"
      }
      if (currentPage != 1) {
        str += "<li class=\"page-item active\"><a class=\"page-link\">" + currentPage + "</a></li>"
      }
      if (currentPage < (totalPages - 1)) {
        str += "<li class=\"page-item\"><a class=\"page-link\"style=\"cursor:pointer\" onclick=\"loadData(" + (parseInt(currentPage) + 1) + ")\">" + (parseInt(currentPage) + 1) + "</a></li>"
      }
      if (currentPage < (totalPages - 2)) {
        str += "<li class=\"page-item\"><a class=\"page-link\" style=\"pointer-events: none\">...</a></li>"
      }
      if ((totalPages > 1) && (parseInt(currentPage) < parseInt(totalPages))) {
        str += "<li class=\"page-item \"><a class=\"page-link\" style=\"cursor:pointer\" onclick=\"loadData(" + totalPages + ")\">" + totalPages + "</a></li>"
      }
    }
    var sau = "<li class=\"page-item\"" + "><a id=\"sau\" class =\"page-link\" onclick=\"loadData(" + (parseInt(currentPage) + 1) + ")\" style=\"cursor:pointer";
    sau += "\">" + "Sau</a></li>"
    str += sau;
    $("#thanhphantrang").html(str);
    if (currentPage <= 1) {
      $("#truoc").addClass(" disabled")
    }
    if (currentPage >= totalPages) {
      $("#sau").addClass(" disabled")
    }
  }
        const d = new Date();
        let month = d.getMonth() +1;
        let year = d.getFullYear();
        $.ajax({
            method: "get",
            url: "../controllers/donhang-controller.asp",
            data: {
                loai: "doanhthuthanghientai",
                thang: month,
                nam: year
            },
            success: function (response) {
                $("#doanhthuthang").html(response +' đ' ) 
            }
        });
        $.ajax({
            method: "get",
            url: "../controllers/donhang-controller.asp",
            data: {
                loai: "thongkechoduyet",
            },
            success: function (response) {
                $("#thongkechoduyet").html(response +' đơn' ) 
            }
        });
        $.ajax({
            method: "get",
            url: "../controllers/donhang-controller.asp",
            data: {
                loai: "thongkehoanthanh",
                thang: month,
                nam: year

            },
            success: function (response) {
                $("#thongkehoanthanh").html(response +' đơn' ) 
            }
        });
        $.ajax({
            method: "get",
            url: "../controllers/donhang-controller.asp",
            data: {
                loai: "doanhthunamhientai",
                nam: year
            },
            success: function (response) {
                $("#doanhthunam").html(response +' đ' ) 
            }
        });
    </script>
</body>

</html>
<%
    else
    response.redirect("login.asp")
    end if
%>