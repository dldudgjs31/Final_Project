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
    <ol class="breadcrumb">
	    <li class="breadcrumb-item">매출 분석</li>
	    <li class="breadcrumb-item active">스토어별</li>
	</ol>
    
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-lg-3 mb-3">
         <div class="list-group">
          <a href="${pageContext.request.contextPath}/admin/chart/salesList" class="list-group-item">매출 리스트</a>	
          <a href="${pageContext.request.contextPath}/admin/chart/category" class="list-group-item">카테고리별 매출분석</a>
          <a href="${pageContext.request.contextPath}/admin/chart/store" class="list-group-item">스토어별 매출분석</a>
        </div>
      </div>
      
    <div class="col-lg-9 mb-4">
		<div id="categorySales-chart" style="font: 'Jua'"></div>
	</div>
	</div>
</div>