<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://code.highcharts.com/8.0.0/highcharts.js"></script>
<script src="https://code.highcharts.com/8.0.0/highcharts-more.js"></script>
<script src="https://code.highcharts.com/8.0.0/themes/dark-unica.js"></script>

<script type="text/javascript">
$(function(){
	var url = "${pageContext.request.contextPath}/admin/chart/categoryAnalysis"

	$.getJSON(url,function(data){
		console.log(data);
		Highcharts.chart('categorySales-chart', {
		    chart: {
		        type: 'pie',
		        options3d: {
		            enabled: true,
		            alpha: 45,
		            beta: 0
		        }
		    },
		    title: {
		        text: '카테고리별 매출(%)'
		    },
		    accessibility: {
		        point: {
		            valueSuffix: '%'
		        }
		    },
		    tooltip: {
		        pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
		    },
		    plotOptions: {
		    	pie: {
		            allowPointSelect: true,
		            cursor: 'pointer',
		            depth: 35,
		            dataLabels: {
		                enabled: true,
		                format: '{point.name}'
		            }
		        }
		    },
		    series:data
		});
		
	});
});




$(function(){
	var url = "${pageContext.request.contextPath}/admin/chart/categoryYearAnalysis"

	$.getJSON(url,function(data){
	
		console.log(data);
		Highcharts.chart("categoryYear-chart", {
		    title: {
		        text:"최근 5년간 카테고리별 매출"
		    },
		    yAxis: {
		        title: {
		            text:"카테고리별 판매액"
		        }
		    },
		    xAxis: {
		    	 categories:[data.currentyear-4,data.currentyear-3,data.currentyear-2,data.currentyear-1,data.currentyear]
		      },

		      legend: {
		        layout: 'vertical',
		        align: 'right',
		        verticalAlign: 'middle'
		      },

		      plotOptions: {
		          series: {
		              label: {
		                  connectorAllowed: false
		              },
		              pointStart: data.currentyear-4
		          }
		      },

		    series: data.series,
		    responsive: {
		        rules: [{
		            condition: {
		                maxWidth: 500
		            },
		            chartOptions: {
		                legend: {
		                    layout: 'horizontal',
		                    align: 'center',
		                    verticalAlign: 'bottom'
		                }
		            }
		        }]
		    }
		});
	});
});
</script>


<div class="body-container" style="width: 700px;">
    <ol class="breadcrumb">
	    <li class="breadcrumb-item">매출 분석</li>
	    <li class="breadcrumb-item active">카테고리별</li>
	</ol>
    
    <div class="col-lg-9 mb-4">
    	<figure class="highcharts-figure">
			<div id="categorySales-chart" style="font: 'Jua'"></div>
		</figure>
		<br><br>
		<figure class="highcharts-figure">
  			<div id="categoryYear-chart"></div>
		</figure>
	</div>
</div>


