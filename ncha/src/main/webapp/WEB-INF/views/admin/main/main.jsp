<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

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
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body">총 회원수</div>
                                    <div> 판매자 : ${count}명</div>
                                    <div> 커뮤니티 회원 : ${count1}명</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="#">회원관리 하기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-warning text-white mb-4">
                                    <div class="card-body">총 매출액</div>
                                    <div> 올해 총 매출액 : ￦${sales}</div>
                                    <div> 작년 총 매출액 : ￦${sales1}</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="#">매출 관리하기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-success text-white mb-4">
                                    <div class="card-body">Success Card</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="#">View Details</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-danger text-white mb-4">
                                    <div class="card-body">Danger Card</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="#">View Details</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <br>
                        <br>
                        <div class="row" style="display: flex; justify-content: center;">
						      <div class="col-lg-6">
						        	<div id="categoryCount"></div>
						      </div>
						      <div class="col-lg-6">
						       		<p style="font-size: 22px;">현재 접속자 : ${currentCount}</p>
						           	<p style="font-size: 20px;">오늘 접속자 : ${toDayCount}</p>
						           	<p style="font-size: 20px;">어제 접속자 : ${yesterDayCount}</p>
						           	<p style="font-size: 20px;">전체 접속자 : ${totalCount}</p>
						      </div>
					    </div>