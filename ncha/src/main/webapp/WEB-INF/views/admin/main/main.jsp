<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<style type="text/css">
tspan{
	font-family: 'Jua', sans-serif;
}
</style>
<script type="text/javascript">

$(function(){
	var url = "${pageContext.request.contextPath}/mainChart/categoryCount"
	$.getJSON(url,function(data){
		console.log(data);
		Highcharts.chart('categoryCount', {
		    chart: {
		        type: 'pie',
		        options3d: {
		            enabled: true,
		            alpha: 45,
		            beta: 0
		        }
		    },
		    title: {
		        text: '카테고리별 일상 게시글(%)'
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


<h1 class="mt-4">N차 신상 관리자</h1>
<ol class="breadcrumb mb-4">
	<li class="breadcrumb-item active">메인</li>
</ol>

                        <div class="row">
                            <div class="col-xl-6 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body text-center">총 회원수</div>
                                    <p class="text-center"> 판매자 : ${count}명</p>
                                    <p class="text-center"> 커뮤니티 회원 : ${count1}명</p>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${pageContext.request.contextPath}/admin/list/member">회원관리 하기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6 col-md-6">
                                <div class="card bg-warning text-white mb-4">
                                    <div class="card-body text-center">총 매출액</div>
                                    <p class="text-center"> 올해 총 매출액 : ￦${sales}</p>
                                    <p class="text-center"> 작년 총 매출액 : ￦${sales1}</p>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${pageContext.request.contextPath}/admin/chart/salesList">매출  분석하기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <br>
                        <hr>
                        <h1 class="mt-4">데이터 분석</h1>
                        <br>
                        <div class="row" style="display: flex; justify-content:space-around; align-items: center; ;">
						      <div class="col-lg-6">
						        	<div id="categoryCount"></div>
						      </div>
						      <div class="col-lg-6" style="padding-left: 100px;">
						       		<p style="font-size: 22px;">현재 접속자 : ${currentCount}</p>
						           	<p style="font-size: 20px;">오늘 접속자 : ${toDayCount}</p>
						           	<p style="font-size: 20px;">어제 접속자 : ${yesterDayCount}</p>
						           	<p style="font-size: 20px;">전체 접속자 : ${totalCount}</p>
						      </div>
					    </div>