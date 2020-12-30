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


.product_image{
	height:50px;
	width:100%;
	background-position: center;
	background-size: contain;
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
          <a href="${pageContext.request.contextPath}/store/customer/cartlist" class="list-group-item">장바구니</a>
          <a href="about.html" class="list-group-item">주문내역</a>
          <a href="${pageContext.request.contextPath}/store/customer/review" class="list-group-item">REVIEW</a>
          <a href="contact.html" class="list-group-item">Q&A</a>
        </div>
      </div>
      <!-- Content Column -->

      <div class="col-xs-12 col-md-8">
		<h2 class="mt-4 mb-3">구매한 상품
			<small>리뷰 리스트</small>
	    </h2>
		<table class="table text-center">
		<thead>
			<tr>
				<th>상품이미지</th>
				<th>상품정보</th>
				<th>구매일</th>
				<th>후기</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<div class="product_image" style="background-image: url('${pageContext.request.contextPath}/resources/img/logo.png');"></div>
				</td>
				<td class="text-left">
					<p>판매자 : </p>
					<p>상품명 : </p>
				</td>
				<td></td>
				<td>
					<button class="btn btn-primary" style="font-family: 'Jua', sans-serif;">등록하기</button>
				</td>
			</tr>	
		</tbody>
		</table>
    </div>
</div>