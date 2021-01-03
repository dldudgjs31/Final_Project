<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style type="text/css">
.btn{
	font-family : 'Jua', sans-serif;
}
</style>


<Br>
        <ol class="breadcrumb">
      <li class="breadcrumb-item">MYPAGE</li>
      <li class="breadcrumb-item active">문의내역</li>
    </ol>
    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-xs-6 col-md-4">
        <div class="list-group">
	          <a href="${pageContext.request.contextPath}/store/customer/mypage" class="list-group-item">메인</a>
	          <a href="${pageContext.request.contextPath}/store/customer/cartlist" class="list-group-item">장바구니</a>
	          <a href="${pageContext.request.contextPath}/store/customer/buylist" class="list-group-item">주문내역</a>
	          <a href="${pageContext.request.contextPath}/store/customer/review" class="list-group-item">REVIEW</a>
	          <a href="${pageContext.request.contextPath}/qna/mypage/qnalist" class="list-group-item">Q&A</a>
        </div>
      </div>
      <!-- Content Column -->

      <div class="col-xs-12 col-md-8">
      	 <h2 class="mt-4 mb-3">주문 내역
      <small>구매한 상품</small>
    </h2>
    
<small><table class="table text-center">
	<thead>
		<tr>
			<th>상품명</th>
			<th>답변여부</th>
			<th >제목</th>
			<th>등록일자</th>
			<th>관리</th>
		</tr>
	</thead>
	<tbody>

	</tbody>
</table></small>
    
      </div>
      
      
