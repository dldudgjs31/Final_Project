<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.image{
	background-position: center;
	background-size: contain;
	background-repeat: no-repeat;
}

#myCarousel .list-inline {
    white-space:nowrap;
    overflow-x:auto;
}

#myCarousel .carousel-indicators {
    position: static;
    left: initial;
    width: initial;
    margin-left: initial;
}

#myCarousel .carousel-indicators > li {
    width: initial;
    height: initial;
    text-indent: initial;
}

#myCarousel .carousel-indicators > li.active img {
    opacity: 0.7;
}
.list-group-item{
	color: black !important;
}
.btn{
	font-family : 'Jua', sans-serif;
}
.card-text{
	margin-bottom: 0.5rem;
}
.imagebox{
	background-size: contain;
	background-position: center;
	background-repeat: no-repeat;
}
</style>
<Br>
        <ol class="breadcrumb">
      <li class="breadcrumb-item">MYPAGE</li>
      <li class="breadcrumb-item active">메인</li>
    </ol>
    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-xs-6 col-md-4">
        <div class="list-group">
	          <a href="${pageContext.request.contextPath}/store/customer/mypage" class="list-group-item">메인</a>
	          <a href="${pageContext.request.contextPath}/store/customer/likeList" class="list-group-item">찜한상품</a>
	          <a href="${pageContext.request.contextPath}/store/customer/followStore" class="list-group-item">팔로잉스토어</a>
	          <a href="${pageContext.request.contextPath}/store/customer/cartlist" class="list-group-item">장바구니</a>
	          <a href="${pageContext.request.contextPath}/store/customer/buylist" class="list-group-item">주문내역</a>
	          <a href="${pageContext.request.contextPath}/store/customer/review" class="list-group-item">REVIEW</a>
	          <a href="${pageContext.request.contextPath}/qna/mypage/qnalist" class="list-group-item">Q&A</a>
        </div>
      </div>
      <!-- Content Column -->

      <div class="col-xs-12 col-md-8">
		    <h2 class="mt-4 mb-3">고객 마이페이지
		    	<small>스토어 이용 현황</small>
		    </h2>
      
             <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body text-center">구매 총 금액</div>
                                    <div class="card-title text-center"><fmt:formatNumber  type="currency"  value="${total_sales}"/>원  <br> 상품 수 : ${total_salesCount}개 </div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${pageContext.request.contextPath}/store/customer/buylist">주문내역 확인하기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-success text-white mb-4">
                                    <div class="card-body text-center">장바구니 담은 상품</div>
                                    <div class="card-title text-center"><i class="fas fa-shopping-cart"></i><br>${cartCount}개</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${pageContext.request.contextPath}/store/customer/cartlist">장바구니 확인하기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-warning text-white mb-4">
                                    <div class="card-body text-center">작성한 구매후기</div>
                                    <div class="card-title text-center"><i class="fas fa-user-edit"></i><br>${reviewCount}개</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${pageContext.request.contextPath}/store/customer/review">구매후기 확인하기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-info text-white mb-4">
                                    <div class="card-body text-center">Q&A현황</div>
                                    <div class="card-title text-center">답변완료 ${total_qna - yet_qna}개<br>답변대기 ${yet_qna}개</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${pageContext.request.contextPath}/qna/mypage/qnalist">Q&A 확인하기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
            <h3 class="mt-4 mb-3">최근 구매한 상품
		    </h3>
                        
			   <div class="row">
			   <c:forEach var="dto" items="${orderList}">
			      <div class="col-lg-4 mb-4">
			        <div class="card h-80">
			          <h4 class="card-header">${dto.productName}</h4>
			          <div class="card-body">
			          <div class="imagebox" style="width: 100%; height: 100px; background-image:url('${pageContext.request.contextPath}/uploads/product/${dto.imageFilename}'); border: 1px solid silver; border-radius: 20px;margin-bottom: 10px;">
			          
			          </div>
			            <p class="card-text">결제 금액 : <fmt:formatNumber  type="currency"  value="${dto.total_sales}"/>원</p>
			            <p class="card-text">주문 옵션 : ${dto.order_option}</p>
			            <p class="card-text">[수량: ${dto.number_sales}]</p>
			            <p class="card-text">주문일자 : ${dto.order_date}</p>
			          </div>
			          <div class="card-footer">
			            <a href="${pageContext.request.contextPath}/store/article?page=1&num=${dto.productNum}" class="btn btn-primary">해당 상품글보기</a>
			          </div>
			        </div>
			      </div>
			   </c:forEach>
		
			<hr>
			
			    </div>
			    <hr>
            <h3 class="mt-4 mb-3">내가 찜한 상품
		    </h3>
			   <div class="row">
              <c:forEach var="dto1" items="${likeList}">           
			      <div class="col-lg-4 mb-4">
			        <div class="card h-80">
			          <h4 class="card-header">${dto1.productName}</h4>
			          <div class="card-body">
			          <div class="imagebox" style="width: 100%; height: 100px; background-image:url('${pageContext.request.contextPath}/uploads/product/${dto1.imageFilename}'); border: 1px solid silver; border-radius: 20px;margin-bottom: 10px;">
			          
			          </div>
			            <p class="card-text">판매점 : ${dto1.sellerName} </p>
			            <p class="card-text">가격 : <fmt:formatNumber  type="currency"  value="${dto1.price - dto1.discount_rate}"/>원</p>
			            <p class="card-text">카테고리 : ${dto1.categoryName} </p>
			          </div>
			          <div class="card-footer">
			            <a href="${pageContext.request.contextPath}/store/article?page=1&num=${dto1.productNum}" class="btn btn-primary">해당 상품글보기</a>
			          </div>
			        </div>
			      </div>
			 </c:forEach>
			
			
			    </div>


    </div>
</div>