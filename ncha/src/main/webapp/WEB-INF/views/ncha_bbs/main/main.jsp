<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
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



    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="width: 99%; height: 99%">
      <ol class="carousel-indicators">
        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
      </ol>
      <div class="carousel-inner" role="listbox">
        <!-- Slide One - Set the background image for this slide in the line below -->
          <div class="carousel-item active" style="width:99%; height:500px; background-image: url('${pageContext.request.contextPath}/resources/img/storeHit.PNG');">
		  <%-- <div class="carousel-item active" style="background-image: url('${pageContext.request.contextPath}/uploads/product/${storeRank.imageFilename}')"> --%>
          <div class="carousel-caption d-none d-md-block">
      	  <a href="${pageContext.request.contextPath}/store/article?page=1&num=${storeRank.productNum}" style="font-size: 25px; font-weight: bold;">스토어에서 제일 많이 찾은 상품은?!</a><br>
      	  <a href="${pageContext.request.contextPath}/store/article?page=1&num=${storeRank.productNum}">누르면 스토어 화면으로 이동합니다!!!!</a>
          </div>
        </div>
        <!-- Slide Two - Set the background image for this slide in the line below -->
          <a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank.usedNum}"></a>
        <div class="carousel-item" style="width:99%; height:500px; background-image: url('${pageContext.request.contextPath}/resources/img/usedHit.PNG');">
        <%-- <div class="carousel-item" style="background-image: url('${pageContext.request.contextPath}/uploads/used/${usedRank.imageFilename}');"> --%>
          <div class="carousel-caption d-none d-md-block">
           <a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank.usedNum}" style="font-size: 25px; font-weight: bold;">중고글 최다 조회수!!!!</a><br>
      	   <a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank.usedNum}">누르면 해당 게시글로 이동합니다!!</a>
          </div>
        </div>
          
        <!-- Slide Three - Set the background image for this slide in the line below -->
        <div class="carousel-item" style="width:99%; height:500px; background-image: url('${pageContext.request.contextPath}/resources/img/dailyHit.PNG');">
        <%-- <div class="carousel-item" style="background-image: url('${pageContext.request.contextPath}/uploads/daily/${dailyRank.imageFilename}');"> --%>
          <div class="carousel-caption d-none d-md-block">
           <a href="${pageContext.request.contextPath}/daily/article?page=1&dailyNum=${dailyRank.dailyNum}" style="font-size: 25px; font-weight: bold;">일상글 최다 조회수!!!!</a><br>
      	   <a href="${pageContext.request.contextPath}/daily/article?page=1&dailyNum=${dailyRank.dailyNum}">누르면 해당 게시글로 이동합니다!!</a>
          </div>
        </div>
        
        
        <!-- Slide four - Set the background image for this slide in the line below -->
          <a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank1.usedNum}"></a>
        <div class="carousel-item" style="width:99%; height:500px; background-image: url('${pageContext.request.contextPath}/resources/img/usedLike.PNG');">
        <%-- <div class="carousel-item" style="background-image: url('${pageContext.request.contextPath}/uploads/used/${usedRank1.imageFilename}');"> --%>
          <div class="carousel-caption d-none d-md-block">
          <a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank1.usedNum}" style="font-size: 25px; font-weight: bold;">중고글 최다 좋아요!!!!</a><br>
      	   <a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank1.usedNum}">누르면 해당 게시글로 이동합니다!!</a>
          </div>
        </div>
          
        <!-- Slide five - Set the background image for this slide in the line below -->
        <div class="carousel-item" style="width:99%; height:500px; background-image: url('${pageContext.request.contextPath}/resources/img/dailyLike.PNG');">
        <%-- <div class="carousel-item" style="background-image: url('${pageContext.request.contextPath}/uploads/daily/${dailyRank1.imageFilename}');"> --%>
          <div class="carousel-caption d-none d-md-block">
           <a href="${pageContext.request.contextPath}/daily/article?page=1&dailyNum=${dailyRank1.dailyNum}" style="font-size: 25px; font-weight: bold;">일상글 최다 좋아요!!!!</a><br>
      	   <a href="${pageContext.request.contextPath}/daily/article?page=1&dailyNum=${dailyRank1.dailyNum}">누르면 해당 게시글로 이동합니다!!</a>
          </div>
        </div>
        
        
      </div>
      <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>
    
    <div style="width: 45%; height: 99%; border: 1px solid #DAD9FF; text-align: center; font-size: 25px;">  
    	<h4 style="color: blue;">N차_인기인 TOP 5 </h4>
    	<c:forEach var="vo" items="${listFollower}">
    		<p> ${vo.userId} : 팔로워 ${vo.followerCount}명</p>
    	</c:forEach>
    </div>
    <div style="align-items:right; width: 45%; height: 99%; border: 1px solid #DAD9FF; text-align: center; font-size: 25px;" id="categoryCount"></div>
    
    
    <div>
    		<p>현재 접속자 : ${currentCount}</p>
           	<p>오늘 접속자 : ${toDayCount}</p>
           	<p>어제 접속자 : ${yesterDayCount}</p>
           	<p>전체 접속자 : ${totalCount}</p>
    </div>


    
    






