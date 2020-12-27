<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.image{
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
      <li class="breadcrumb-item active">장바구니</li>
    </ol>
    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-xs-6 col-md-4">
        <div class="list-group">
	          <a href="index.html" class="list-group-item">메인</a>
	          <a href="index.html" class="list-group-item">장바구니</a>
	          <a href="about.html" class="list-group-item">주문내역</a>
	          <a href="services.html" class="list-group-item">REVIEW</a>
	          <a href="contact.html" class="list-group-item">Q&A</a>
        </div>
      </div>
      <!-- Content Column -->

      <div class="col-xs-12 col-md-8">
	 <h2 class="mt-4 mb-3">장바구니
      <small>선택한 상품</small>
    </h2>
    <small><table class="table table-striped">
    	<thead>
    	<tr>
    		<th>체크</th>
    		<th>제품 이미지</th>
    		<th>제품명</th>
    		<th>개수</th>
    		<th>개당 가격</th>
    		<th>총 가격</th>
    		<th>삭제</th>
    	</tr>
    	</thead>
    	<tbody>
    	    <c:set var="total_sum" value="0"/>
    	      <c:forEach var="dto1" items="${list}">
    	<tr>
    		<td>
    		 <div class="checkbox">
			    <label>
			      <input type="checkbox">
			    </label>
			  </div>
    		</td>
    		<td>      
    			<div class="image" style="background-image: url('${pageContext.request.contextPath}/uploads/product/${dto1.imageFilename}');"></div>
    		</td>
    		<td>${dto1.productName}</td>
    		<td> ${dto1.quantity}</td>
    		<td><del><fmt:formatNumber type="currency" value="${dto1.price}" />원</del><br>
    		<fmt:formatNumber  type="currency"  value="${dto1.price - dto1.discount_rate}"/>원</td>
    		<td><fmt:formatNumber  type="currency"  value="${dto1.total_sales}"/>원</td>
    		<td><button class="btn btn-danger" type="submit"><small>삭제</small></button></td>
    	</tr>
    	       <c:set var="total_sum" value="${total_sum + dto1.total_sales}"/>
    	      </c:forEach>
    	      
    	      <tr>
    	      	<td colspan="7"><p class="text-center">장바구니 총 금액 : <fmt:formatNumber  type="currency"  value="${total_sum}"/>원 </p></td>
    	      </tr>
    	</tbody>
    </table></small>

    </div>
</div>