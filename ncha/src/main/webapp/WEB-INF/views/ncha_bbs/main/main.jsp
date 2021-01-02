<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



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


    
    






