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

tspan{
	font-family: 'Jua', sans-serif;
	font-size: 18px;
}
</style>





<script type="text/javascript">
function searchProfile(userId) {
	var url="${pageContext.request.contextPath}/mypage/searchProfile?userId="+userId;
		location.href=url;
}

function searchArticleD(dailyNum) {
	var url="${pageContext.request.contextPath}/daily/article?page=1&dailyNum="+dailyNum;
		location.href=url;
}

function searchArticleU(usedNum) {
	var url="${pageContext.request.contextPath}/used/article?page=1&usedNum="+usedNum;
		location.href=url;
}



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
        		<a href="${pageContext.request.contextPath}/store/article?page=1&num=${storeRank.productNum}" style="font-size: 25px; font-weight: bold; color: #F6F6F6;">스토어에서 제일 많이 찾은 상품은?!</a><br>
      	  		<a href="${pageContext.request.contextPath}/store/article?page=1&num=${storeRank.productNum}" style="color: #F6F6F6;">누르면 스토어 화면으로 이동합니다.</a>
        	</c:if>
          </div>
        	
        	<div class="carousel-caption d-none d-md-block">
        	<c:if test="${status.index==1}">
        		 <a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank.usedNum}" style="font-size: 25px; font-weight: bold; color:#FFA873">중고글 최다 조회수</a><br>
      	   		<a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank.usedNum}" style="color:#FFA873">누르면 해당 게시글로 이동합니다.</a>
        	</c:if>
        	 </div>
        	
        	<div class="carousel-caption d-none d-md-block">
        	<c:if test="${status.index==2}">
        		<a href="${pageContext.request.contextPath}/daily/article?page=1&dailyNum=${dailyRank.dailyNum}" style="font-size: 25px; font-weight: bold; color: #F6F6F6;">일상글 최다 조회수</a><br>
      	   		<a href="${pageContext.request.contextPath}/daily/article?page=1&dailyNum=${dailyRank.dailyNum}" style="color: #F6F6F6;;">누르면 해당 게시글로 이동합니다.</a>
        	</c:if>
        	 </div>
        	
        	<div class="carousel-caption d-none d-md-block">
        	<c:if test="${status.index==3}">
          		<a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank1.usedNum}" style="font-size: 25px; font-weight: bold; color:#A3A0ED;">중고글 최다 좋아요</a><br>
      	   		<a href="${pageContext.request.contextPath}/used/article?page=1&usedNum=${usedRank1.usedNum}" style="color:#A3A0ED;">누르면 해당 게시글로 이동합니다.</a>
        	</c:if>
        	 </div>
        	 
        	<div class="carousel-caption d-none d-md-block">
        	<c:if test="${status.index==4}">
				<a href="${pageContext.request.contextPath}/daily/article?page=1&dailyNum=${dailyRank1.dailyNum}" style="font-size: 25px; font-weight: bold; color:#79ABFF;">일상글 최다 좋아요</a><br>
      	  		 <a href="${pageContext.request.contextPath}/daily/article?page=1&dailyNum=${dailyRank1.dailyNum}" style="color:#79ABFF;">누르면 해당 게시글로 이동합니다.</a>
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
    	<div class="row" style="display: flex; justify-content: center;">
    	<h4 style="color: #949494; align-items: center;">N차_인기인 TOP</h4>
    	<c:forEach var="vo" items="${listFollower}">		
    			<div style="padding-right: 100px;">
    			<div class="profile-img">
	    			<div class="imgs" style="background-image:url('${pageContext.request.contextPath}/uploads/member/${vo.profile_imageFilename}');"></div>
		    	</div>
		    	<div class="profile-name"><a href="javascript:searchProfile('${vo.userId}')" style="color: black !important; font-size: 30px; font-weight: bold;">${vo.userId}</a></div>
		    	<div class="profile-introduce" style="font-size: 18px;">
		    		<c:if test="${vo.introduce == null || vo.introduce == ''}">&nbsp;</c:if>
		    		<c:if test="${vo.introduce != null || vo.introduce != ''}"><p style="width: 175px;">${vo.introduce}</p></c:if>
		    	</div>
		    	<div>팔로워 : ${vo.followerCount}</div>	 
		    	</div>   	
    	</c:forEach>
    	</div>
    	<br>
    	<br>
    	<br>
		<p>현재 인기 글! / 조금 인기 글! (일상)</p>
		<div class="row" style="display: flex; justify-content: center;">
			<c:forEach var="vo" items="${dailyRank2}">
		      <div class="col-lg-2" >
		        <img class="img-fluid rounded mb-3" src="${pageContext.request.contextPath}/uploads/daily/${vo.imageFilename}" alt="" >
		      </div>
		      <div class="col-lg-3" >
		      <h2><a href="javascript:searchArticleD('${vo.dailyNum}')" style="color: black !important;">${vo.subject}</a></h2>
		        <p>${vo.content}</p>
		        <p>조회수 :${vo.hitCount}</p>
		      </div>
		      </c:forEach>
		</div>
 		<br>
    	<br>
    	<br> 
		<p>현재 인기 글! / 조금 인기 글! (중고)</p>
		<div class="row" style="display: flex; justify-content: center;">
			<c:forEach var="vo" items="${usedRank2}">
		      <div class="col-lg-2">
		        <img class="img-fluid rounded mb-3" src="${pageContext.request.contextPath}/uploads/used/${vo.imageFilename}" alt="" >
		      </div>
		      <div class="col-lg-3">
		        <h2><a href="javascript:searchArticleU('${vo.usedNum}')" style="color: black !important;">${vo.subject}</a></h2>
		        <p>내용 :${vo.content}</p>
		        <p>가격 :${vo.price}</p>
		        <p>조회수 :${vo.hitCount}</p>
		      </div>
		      </c:forEach>
		</div> 
		<br>
    	<br>
    	<br>
	   
	
    
    






