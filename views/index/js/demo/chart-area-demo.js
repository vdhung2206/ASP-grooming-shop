// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

function number_format(number, decimals, dec_point, thousands_sep) {
  // *     example: number_format(1234.56, 2, ',', ' ');
  // *     return: '1 234,56'
  number = (number + '').replace(',', '').replace(' ', '');
  var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function (n, prec) {
      var k = Math.pow(10, prec);
      return '' + Math.round(n * k) / k;
    };
  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '').length < prec) {
    s[1] = s[1] || '';
    s[1] += new Array(prec - s[1].length + 1).join('0');
  }
  return s.join(dec);
}
var datalist = {}
const date = new Date();
let nam = date.getFullYear();
$.ajax({
  method: "get",
  url: "../controllers/donhang-controller.asp",
  data: {
    loai: "doanhthutungthang",
    nam: nam
  },
  success: function (response) {
    const obj = JSON.parse(response);
    console.log(obj);
    drawChart(obj)
    datalist = obj
    $.ajax({
      method: "get",
      url: "../controllers/donhang-controller.asp",
      data:{
        loai: "sodonhangtungthang",
        nam: nam
      },
      success: function(response){
        const obj1 = JSON.parse(response);
        datalist = obj1
        drawChart1(obj,obj1)
      }
    })
  }
});


// Area Chart Example
function drawChart1(obj,obj1) {
  var monthbegin
  for (var x in obj.data.datalist[0]) {
    monthbegin = x
  }
  var temp = []
  for (var i = 0; i < monthbegin - 1; i++) {
    temp.push(null)
  }
  var datalist = []
  obj.data.datalist.forEach(element => {
    for (var x in element) {
      datalist.push(parseInt(element[x]))
    }
  });

  var temp1 = []
  for (var i = 0; i < monthbegin - 1; i++) {
    temp1.push(null)
  }
  var datalist1 = []
  obj1.data.datalist.forEach(element => {
    for (var x in element) {
      datalist1.push(parseInt(element[x]))
    }
  });

  var lastdatalist = temp.concat(datalist)
  var lastdatalist1 = temp1.concat(datalist1)
  var canvas = document.getElementById('myAreaChart1');
  new Chart(canvas, {
    type: 'line',
    data: {
      labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"],
      datasets: [{
        label: 'Doanh thu: ',
        yAxisID: 'A',
        lineTension: 0.3,
        backgroundColor: "rgba(78, 115, 223, 0.05)",
        fill: false,
        borderColor: "rgba(78, 115, 223, 1)",
        pointRadius: 3,
        pointBackgroundColor: "rgba(78, 115, 223, 1)",
        pointBorderColor: "rgba(78, 115, 223, 1)",
        pointHoverRadius: 3,
        pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
        pointHoverBorderColor: "rgba(78, 115, 223, 1)",
        pointHitRadius: 10,
        pointBorderWidth: 2,
        data: lastdatalist
      }, {
        label: 'Số lượng đơn hàng: ',
        lineTension: 0.3,
        backgroundColor: "rgba(78, 115, 223, 0.05)",
        fill: false,
        borderColor: "rgba(255, 115, 223, 1)",
        pointRadius: 3,
        pointBackgroundColor: "rgba(255, 115, 223, 1)",
        pointBorderColor: "rgba(255, 115, 223, 1)",
        pointHoverRadius: 3,
        pointHoverBackgroundColor: "rgba(255, 115, 223, 1)",
        pointHoverBorderColor: "rgba(255, 115, 223, 1)",
        pointHitRadius: 10,
        pointBorderWidth: 2,
        yAxisID: 'B',
        data: lastdatalist1
      }]
    },
    options: {
      maintainAspectRatio: false,
      layout: {
        padding: {
          left: 10,
          right: 25,
          top: 25,
          bottom: 0
        }
      },
      tooltips: {
        backgroundColor: "rgb(255,255,255)",
        bodyFontColor: "#858796",
        titleMarginBottom: 10,
        titleFontColor: '#6e707e',
        titleFontSize: 14,
        borderColor: '#dddfeb',
        borderWidth: 1,
        xPadding: 15,
        yPadding: 15,
        displayColors: false,
        intersect: false,
        mode: 'index',
        caretPadding: 10,
        callbacks: {
          label: function (tooltipItem, chart) {
            var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
            return datasetLabel + ':' + number_format(tooltipItem.yLabel);
          }
        }
      },
      scales: {
        yAxes: [{
          id: 'A',
          type: 'linear',
          position: 'left',
          ticks: {
            maxTicksLimit: 5,
            padding: 10,
            // Include a dollar sign in the ticks
            callback: function (value, index, values) {
              return number_format(value) + 'đ';
            }
          },
          gridLines: {
            color: "rgb(234, 236, 244)",
            zeroLineColor: "rgb(234, 236, 244)",
            drawBorder: false,
            borderDash: [2],
            zeroLineBorderDash: [2]
          }
        }, {
          id: 'B',
          type: 'linear',
          position: 'right',
          ticks: {
            maxTicksLimit: 5,
            padding: 10,
            // Include a dollar sign in the ticks
            callback: function (value, index, values) {
              return number_format(value) + ' đơn';
            }
          },
          gridLines: {
            color: "rgb(234, 236, 244)",
            zeroLineColor: "rgb(234, 236, 244)",
            drawBorder: false,
            borderDash: [2],
            zeroLineBorderDash: [2]
          }
        }]
      }
    }
  });
}

function drawChart(obj) {
  var monthbegin
  for (var x in obj.data.datalist[0]) {
    monthbegin = x
  }
  var temp = []
  for (var i = 0; i < monthbegin - 1; i++) {
    temp.push(null)
  }
  var datalist = []
  obj.data.datalist.forEach(element => {
    for (var x in element) {
      datalist.push(parseInt(element[x]))
    }
  });

 
 var lastdatalist = temp.concat(datalist)
  var tangtruong =[]
  for(var x = 0; x<lastdatalist.length; x++){
    var count
    if(lastdatalist[x] != null && lastdatalist[x-1]!= null && lastdatalist[x-1]!= undefined){
      tangtruong.push(100* (lastdatalist[x] - lastdatalist[x-1])/ lastdatalist[x-1])
    }
    if(lastdatalist[x] != null && (lastdatalist[x-1]== null && lastdatalist[x-1]== undefined)){
      tangtruong.push(0)
    }
    if(lastdatalist[x] == null){
      tangtruong.push(null)
    }
  }
  var ctx = document.getElementById("myAreaChart");
  var myLineChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"],
      datasets: [{
        label: "Tăng trưởng",
        lineTension: 0.3,
        backgroundColor: "rgba(78, 115, 223, 0.05)",
        borderColor: "rgba(78, 115, 223, 1)",
        pointRadius: 3,
        pointBackgroundColor: "rgba(78, 115, 223, 1)",
        pointBorderColor: "rgba(78, 115, 223, 1)",
        pointHoverRadius: 3,
        pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
        pointHoverBorderColor: "rgba(78, 115, 223, 1)",
        pointHitRadius: 10,
        pointBorderWidth: 2,
        data: tangtruong,
      }
      ],
    },
    options: {
      maintainAspectRatio: false,
      plugins: {
        title: {
            display: true,
            text: 'Custom Chart Title'
        }
      },
      layout: {
        padding: {
          left: 10,
          right: 25,
          top: 25,
          bottom: 0
        }
      },
      scales: {
        xAxes: [{
          time: {
            unit: 'date'
          },
          gridLines: {
            display: false,
            drawBorder: false
          },
          ticks: {
            maxTicksLimit: 7
          }
        }],
        yAxes: [{
          ticks: {
            maxTicksLimit: 5,
            padding: 10,
            // Include a dollar sign in the ticks
            callback: function (value, index, values) {
              return number_format(value) + '%';
            }
          },
          gridLines: {
            color: "rgb(234, 236, 244)",
            zeroLineColor: "rgb(234, 236, 244)",
            drawBorder: false,
            borderDash: [2],
            zeroLineBorderDash: [2]
          }
        }],
      },
      legend: {
        display: false
      },
      tooltips: {
        backgroundColor: "rgb(255,255,255)",
        bodyFontColor: "#858796",
        titleMarginBottom: 10,
        titleFontColor: '#6e707e',
        titleFontSize: 14,
        borderColor: '#dddfeb',
        borderWidth: 1,
        xPadding: 15,
        yPadding: 15,
        displayColors: false,
        intersect: false,
        mode: 'index',
        caretPadding: 10,
        callbacks: {
          label: function (tooltipItem, chart) {
            var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
            return datasetLabel + ':' +Number(tooltipItem.yLabel.toFixed(2)) + '%';
          }
        }
      }
    }
  });
}
