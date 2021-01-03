<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://code.highcharts.com/8.0.0/highcharts.js"></script>
<script src="https://code.highcharts.com/8.0.0/highcharts-more.js"></script>
<script src="https://code.highcharts.com/8.0.0/themes/dark-unica.js"></script>

<script type="text/javascript">
$(function(){
	var url = "${pageContext.request.contextPath}/admin/chart/storeAnalysis"

	$.getJSON(url,function(data){
		console.log(data);
		Highcharts.chart('storeSales-chart', {
		    chart: {
		        type: 'pie',
		        options3d: {
		            enabled: true,
		            alpha: 45,
		            beta: 0
		        }
		    },
		    title: {
		        text: '스토어별 매출(%)'
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
</script>


<div class="body-container" style="width: 700px;">
    <ol class="breadcrumb">
	    <li class="breadcrumb-item">매출 분석</li>
	    <li class="breadcrumb-item active">스토어별</li>
	</ol>
    
   <div class="col-lg-9 mb-4">
	    <figure class="highcharts-figure">
			<div id="storeSales-chart" style="font: 'Jua'"></div>
		</figure>
	</div>
</div>


