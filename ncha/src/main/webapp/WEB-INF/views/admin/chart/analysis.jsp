<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>

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
		        text: 'N차스토어 카테고리별 판매액'
		    },
		    accessibility: {
		        point: {
		            valueSuffix: '%'
		        }
		    },
		    plotOptions: {
		        pie: {
		        	allowPointSelect: true,
		            cursor: 'pointer',
		            depth: 35
		        }
		    },
		    series:data
		});
		
	});
});
</script>


<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><i class="fas fa-user"></i>카테고리별 판매액</h3>
    </div>
    
    <div>
		<div id="categorySales-chart"></div>
	</div>
</div>