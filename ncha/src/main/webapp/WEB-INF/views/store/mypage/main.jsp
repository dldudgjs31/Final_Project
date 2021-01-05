<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
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
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
}
</style>
<Br>
        <ol class="breadcrumb">
      <li class="breadcrumb-item">MYPAGE</li>
      <li class="breadcrumb-item active">MAIN</li>
    </ol>
    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-xs-6 col-md-4">
        <div class="list-group">
	          <a href="${pageContext.request.contextPath}/store/mypage/main" class="list-group-item">메인</a>
	          <a href="${pageContext.request.contextPath}/store/mypage/saleslist" class="list-group-item">판매내역</a>
	          <a href="${pageContext.request.contextPath}/store/mypage/stockupdate" class="list-group-item">재고관리</a>
	          <a href="${pageContext.request.contextPath}/store/mypage/qna" class="list-group-item">Q&A 관리</a>
	          <a href="${pageContext.request.contextPath}/store/myFollowStore?page=1&sellerId=${sellerId}" class="list-group-item">MY스토어</a>
        </div>
      </div>
      <!-- Content Column -->

      <div class="col-xs-12 col-md-8">
		    <h2 class="mt-4 mb-3">판매자 마이페이지
		      <small>스토어 판매 현황</small>
		    </h2>
      
             <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body text-center">판매 누적 금액</div>
                                    <div class="card-title text-center"><fmt:formatNumber  type="currency"  value="${total_sales}"/>원  <br> 판매 누적 수량 : ${total_salesCount}개 </div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${pageContext.request.contextPath}/store/mypage/saleslist">판매내역 확인하기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-warning text-white mb-4">
                                    <div class="card-body text-center">품절된 상품</div>
                                    <div class="card-title text-center">판매중인 상품 :${recent_sale} 개<br>품절 상품 :${soldout_product} 개</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${pageContext.request.contextPath}/store/mypage/stockupdate">재고 관리하기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-info text-white mb-4">
                                    <div class="card-body text-center">상품 Q&A</div>
                                    <div class="card-title text-center">답변완료${allQna-yetQna} 개<br>답변대기 ${yetQna}개</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${pageContext.request.contextPath}/store/mypage/qna">Q&A 확인하기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-danger text-white mb-4">
                                    <div class="card-body text-center">내 상품 찜 개수</div>
                                    <div class="card-title text-center"><i class="fas fa-heart"></i><br>${likeCount} 개</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <div class="small text-white"><i class="far fa-kiss-wink-heart"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                 
          

                 
                        
            <h3 class="mt-4 mb-3">최근 판매된 상품
		    </h3>
                        
			   <div class="row">
			   <c:forEach var="dto" items="${list}">
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
		
			
			
			    </div>
    </div>
    </div>