<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link href="${pageContext.request.contextPath}/resources/css/carousel.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/carousel.rtl.css" rel="stylesheet">

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<style type="text/css">
.profile-img{
	grid-area:img;
	display: flex;
	justify-content: center;
	align-items: center;
}
.imgs{
	width: 175px; 
	height: 175px; 
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
	border-radius: 50%;
	border: 1px solid silver;
}
.profile-introduce{
	grid-area:intro;
}
.profile-name{
	grid-area:name;
	display: flex;
	align-items: flex-end;
	align-content: center;
}
</style>





<script type="text/javascript">
function searchProfile(userId) {
	var url="${pageContext.request.contextPath}/mypage/searchProfile?userId="+userId;
		location.href=url;
}
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
      	<c:forEach var="dto" items="${bannerlist}" varStatus="status">
      		<li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="${status.index==0?'active':'' }"></li>
      	</c:forEach> 
      </ol>

  
      <div class="carousel-inner" role="listbox">
        <!-- Slide One - Set the background image for this slide in the line below -->
       <c:forEach var="dto" items="${bannerlist}" varStatus="status"> 
        <div class="carousel-item ${status.index==0?'active':'' }" style="background-image: url('${pageContext.request.contextPath}/uploads/ncha_banner/${dto.serverFilename}')">
        	<div class="carousel-caption d-none d-md-block">
        	<c:if test="${status.index==0}">
        		<a href="${pageContext.request.contextPath}/store/article?page=1&num=${storeRank.productNum}" style="font-size: 25px; font-weight: bold;">스토어에서 제일 많이 찾은 상품은?!</a><br>
      	  		<a href="${pageContext.request.contextPath}/store/article?page=1&num=${storeRank.productNum}">누르면 스토어 화면으로 이동합니다!!!!</a>
        	</c:if>
        </div>
        	
        	<div class="carousel-caption d-none d-md-block">
        	<c:if test="${status.index==1}">
        		 <a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank.usedNum}" style="font-size: 25px; font-weight: bold;">중고글 최다 조회수!!!!</a><br>
      	   		<a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank.usedNum}">누르면 해당 게시글로 이동합니다!!</a>
        	</c:if>
        	 </div>
        	
        	<div class="carousel-caption d-none d-md-block">
        	<c:if test="${status.index==2}">
        		<a href="${pageContext.request.contextPath}/daily/article?page=1&dailyNum=${dailyRank.dailyNum}" style="font-size: 25px; font-weight: bold;">일상글 최다 조회수!!!!</a><br>
      	   		<a href="${pageContext.request.contextPath}/daily/article?page=1&dailyNum=${dailyRank.dailyNum}">누르면 해당 게시글로 이동합니다!!</a>
        	</c:if>
        	 </div>
        	
        	<div class="carousel-caption d-none d-md-block">
        	<c:if test="${status.index==3}">
          		<a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank1.usedNum}" style="font-size: 25px; font-weight: bold;">중고글 최다 좋아요!!!!</a><br>
      	   		<a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank1.usedNum}">누르면 해당 게시글로 이동합니다!!</a>
        	</c:if>
        	 </div>
        	 
        	<div class="carousel-caption d-none d-md-block">
        	<c:if test="${status.index==4}">
				<a href="${pageContext.request.contextPath}/daily/article?page=1&dailyNum=${dailyRank1.dailyNum}" style="font-size: 25px; font-weight: bold;">일상글 최다 좋아요!!!!</a><br>
      	  		 <a href="${pageContext.request.contextPath}/daily/article?page=1&dailyNum=${dailyRank1.dailyNum}">누르면 해당 게시글로 이동합니다!!</a>
        	</c:if>
        	</div>
        </div>
       </c:forEach>
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
    
    
<br>
<br>
 
    	<div class="row">
    	<h4 style="color: blue; align-items: center;">N차_인기인 TOP</h4>
    	<c:forEach var="vo" items="${listFollower}">		
    			<div style="padding-right: 100px;">
    			<div class="profile-img">
	    			<div class="imgs" style="background-image:url('${pageContext.request.contextPath}/uploads/member/${vo.profile_imageFilename}');"></div>
		    	</div>
		    	<div class="profile-name"><h1>${vo.userId}</h1></div>
		    	<div class="profile-introduce" style="font-size: 18px;">
		    		<c:if test="${vo.introduce == null || vo.introduce == ''}">&nbsp;</c:if>
		    		<c:if test="${vo.introduce != null || vo.introduce != ''}">${vo.introduce}</c:if>
		    	</div>
		    	<div>팔로워 : ${vo.followerCount}</div>	 
		    	</div>   	
    	</c:forEach>
    	</div>
    	<br>
    	<br>
<div style="display: flex; justify-content: center;">   
	<div style=" width: 45%; height: 300px;; border: 1px solid #DAD9FF; text-align: center; font-size: 25px;" id="categoryCount"></div>
    
    <div style=" width: 25%; height: 300px;; border: 1px solid #DAD9FF; text-align: center; font-size: 25px;">
    		<p>현재 접속자 : ${currentCount}</p>
           	<p>오늘 접속자 : ${toDayCount}</p>
           	<p>어제 접속자 : ${yesterDayCount}</p>
           	<p>전체 접속자 : ${totalCount}</p>
    </div>
</div>
    
    






