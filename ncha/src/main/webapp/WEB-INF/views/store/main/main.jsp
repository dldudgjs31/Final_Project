<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link href="${pageContext.request.contextPath}/resources/css/carousel.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/carousel.rtl.css" rel="stylesheet">
<style>
.rounded-circle{
	border: 1px solid silver;
	background-size: cover;
	background-repeat: no-repeat;
	background-position: center;
}
.btn{
	font-family: 'Jua', sans-serif;
}
p{
	margin-bottom: 0.5rem;
}
.bd-placeholder-img{
	border: 1px solid silver;
	border-radius: 30px;
	background-size: contain;
	background-position: center;
	background-repeat: no-repeat;
	
}
</style>



    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
      	<c:forEach var="dto" items="${list}" varStatus="status">
      		<li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="${status.index==0?'active':'' }"></li>
      	</c:forEach> 
      </ol>
      
      <div class="carousel-inner" role="listbox">
        <!-- Slide One - Set the background image for this slide in the line below -->
       <c:forEach var="dto" items="${list}" varStatus="status"> 
        <div class="carousel-item ${status.index==0?'active':'' }" style="background-image: url('${pageContext.request.contextPath}/uploads/storebanner/${dto.serverFilename}')">
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
  <!-- Marketing messaging and featurettes
  ================================================== -->
  <!-- Wrap the rest of the page in another container to center all the content. -->

  <div class="container marketing">

    <!-- Three columns of text below the carousel -->
    <h2><i class="fas fa-crown" style="color:gold;"></i>&nbsp;&nbsp;N차 스토어 인기 Best 3</h2>
    <div class="row">
     
     <c:forEach var="best3" items="${bestFollowList}">
      <div class="col-lg-4">
        <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 140x140" preserveAspectRatio="xMidYMid slice" focusable="false" style="background-image: url('${pageContext.request.contextPath}/uploads/member/${best3.profile_imageFilename}');"></svg>

        <h2>${best3.sellerName}</h2>
        <p><a class="btn btn-secondary" href="${pageContext.request.contextPath}/store/myFollowStore?page=1&sellerId=${best3.sellerId}" role="button">스토어로 이동 &raquo;</a></p>
        <p>팔로워 수 : ${best3.storeFollowCount}<p>
        <p>상품 수 : ${best3.productCount}<p>
        <p>스토어 소개</p>
        <p>${best3.introduce}</p>
      </div>
     </c:forEach>
      
      

    </div><!-- /.row -->
    <!-- Three columns of text below the carousel -->
    <h2><i class="fas fa-crown" style="color:gold;"></i>&nbsp;&nbsp;N차 스토어 매출 Best 3</h2>
    <div class="row">
     
     <c:forEach var="salebest3" items="${bestSalesList}">
      <div class="col-lg-4">
        <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 140x140" preserveAspectRatio="xMidYMid slice" focusable="false" style="background-image: url('${pageContext.request.contextPath}/uploads/member/${salebest3.profile_imageFilename}');"></svg>

        <h2>${salebest3.sellerName}</h2>
        <p><a class="btn btn-secondary" href="${pageContext.request.contextPath}/store/myFollowStore?page=1&sellerId=${salebest3.sellerId}" role="button">스토어로 이동 &raquo;</a></p>
        <p>팔로워 수 : ${salebest3.likeCount}<p>
        <p>상품 수 : ${salebest3.productCount}<p>
        <p>스토어 소개</p>
        <p>${salebest3.introduce}</p>
      </div>
     </c:forEach>
      
      

    </div><!-- /.row -->


    <!-- START THE FEATURETTES -->

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h3 class="featurette-heading"><i class="fab fa-hotjar" style="color:red;"></i>&nbsp;HOT 아이템 <span class="text-muted">[의류]</span></h3>
        <h4 class="lead">상품명 : ${dto1.productName}</h4>
        <p class="lead">조회수 : ${dto1.hitcount}</p>
        <p class="lead" style="color:silver;">정가 : <del><fmt:formatNumber type="currency" value="${dto1.price}" />원</del></p>
        <p class="lead">가격 : <fmt:formatNumber type="currency" value="${dto1.price - dto1.discount_rate}" />원&nbsp; <span style="background-color: red; border-radius: 5px; color:white; height: 25px; "><fmt:formatNumber type="number"  pattern="0" value="${(dto1.discount_rate/dto1.price)*100}" />%OFF</span></p>
        <p class="lead">재고 :
        	<c:if test="${dto1.stock==0}">
        		<span style="color:red;">품절</span>
        	</c:if>
        	<c:if test="${dto1.stock>0}">
        		${dto1.stock}
        	</c:if>
         </p>
        <p><a class="btn btn-secondary" href="${pageContext.request.contextPath}/store/article?page=1&num=${dto1.productNum}" role="button">상품으로 이동 &raquo;</a></p>
      </div>
      <div class="col-md-5">
      
        <svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false" style="background-image: url('${pageContext.request.contextPath}/uploads/product/${dto1.imageFilename}');"></svg>

      </div>
    </div>

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7 order-md-2">
        <h2 class="featurette-heading"><i class="fab fa-hotjar" style="color:red;"></i>&nbsp;HOT 아이템 <span class="text-muted">[전자제품]</span></h2>
         <h4 class="lead">상품명 : ${dto2.productName}</h4>
        <p class="lead">조회수 : ${dto2.hitcount}</p>
        <p class="lead" style="color:silver;">정가 : <del><fmt:formatNumber type="currency" value="${dto2.price}" />원</del></p>
        <p class="lead">가격 : <fmt:formatNumber type="currency" value="${dto2.price - dto2.discount_rate}" />원&nbsp; <span style="background-color: red; border-radius: 5px; color:white; height: 25px; "><fmt:formatNumber type="number"  pattern="0" value="${(dto2.discount_rate/dto2.price)*100}" />%OFF</span></p>
        <p class="lead">재고 :
        	<c:if test="${dto2.stock==0}">
        		<span style="color:red;">품절</span>
        	</c:if>
        	<c:if test="${dto2.stock>0}">
        		${dto2.stock}
        	</c:if>
         </p>
        <p><a class="btn btn-secondary" href="${pageContext.request.contextPath}/store/article?page=1&num=${dto2.productNum}" role="button">상품으로 이동 &raquo;</a></p>
      </div>
      <div class="col-md-5 order-md-1">
        <svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false"style="background-image: url('${pageContext.request.contextPath}/uploads/product/${dto2.imageFilename}');"></svg>

      </div>
    </div>

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h2 class="featurette-heading"><i class="fab fa-hotjar" style="color:red;"></i>&nbsp;HOT 아이템 <span class="text-muted">[인테리어가구]</span></h2>
        <h4 class="lead">상품명 : ${dto3.productName}</h4>
        <p class="lead">조회수 : ${dto3.hitcount}</p>
        <p class="lead" style="color:silver;">정가 : <del><fmt:formatNumber type="currency" value="${dto3.price}" />원</del></p>
        <p class="lead">가격 : <fmt:formatNumber type="currency" value="${dto3.price - dto3.discount_rate}" />원&nbsp; <span style="background-color: red; border-radius: 5px; color:white; height: 25px; "><fmt:formatNumber type="number"  pattern="0" value="${(dto3.discount_rate/dto3.price)*100}" />%OFF</span></p>
        <p class="lead">재고 :
        	<c:if test="${dto3.stock==0}">
        		<span style="color:red;">품절</span>
        	</c:if>
        	<c:if test="${dto3.stock>0}">
        		${dto3.stock}
        	</c:if>
         </p>
        <p><a class="btn btn-secondary" href="${pageContext.request.contextPath}/store/article?page=1&num=${dto3.productNum}" role="button">상품으로 이동 &raquo;</a></p>
      </div>
      <div class="col-md-5">
        <svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false" style="background-image: url('${pageContext.request.contextPath}/uploads/product/${dto3.imageFilename}');"></svg>

      </div>
    </div>

    <hr class="featurette-divider">

    <!-- /END THE FEATURETTES -->

  </div>
