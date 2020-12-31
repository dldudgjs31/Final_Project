<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
function orderOk(userId) {
	var f = document.orderForm;
 	f.action = "${pageContext.request.contextPath}/store/customer/cart/order";

    f.submit();
}

$(function(){
	$("body").on("click", ".cancel",function(){
		$(this).parent().parent().remove();
		location.href="${pageContext.request.contextPath}/store/customer/cart/order";
	});
});

function deleteCart(num) {
	var url="${pageContext.request.contextPath}/store/customer/deleteCart";
	$.post(url, {num:num}, function(data){
	}, "json");
}

</script>
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
      <li class="breadcrumb-item">장바구니</li>
      <li class="breadcrumb-item active">주문하기</li>
    </ol>
    
      <div class="container">

    <!-- Page Heading/Breadcrumbs -->
    <h2 class="mt-4 mb-3">주문서
      <small>선택한 상품</small>
    </h2>


    <!-- Project One -->
    <small><table class="table table-hover text-center">
    	<thead>
    	<tr>
    		<th>상품 이미지</th>
    		<th>상품명</th>
    		<th>상품 옵션</th>
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
    			<div class="image" style="background-image: url('${pageContext.request.contextPath}/uploads/product/${dto1.imageFilename}');"></div>
    			<input class="cartNum" type="hidden" value="${dto1.cartNum}">
    		</td>
    		<td>${dto1.productName}</td>
    		<td>${dto1.order_option}</td>
    		<td> ${dto1.quantity}</td>
    		<td><del><fmt:formatNumber type="currency" value="${dto1.price}" />원</del><br>
    		<fmt:formatNumber  type="currency"  value="${dto1.price - dto1.discount_rate}"/>원</td>
    		<td><fmt:formatNumber  type="currency"  value="${dto1.total_sales}"/>원</td>
    		<td><button class="btn btn-danger cancel" type="submit" onclick="deleteCart('${dto1.cartNum}')"><small>삭제</small></button></td>
    	</tr>
    	       <c:set var="total_sum" value="${total_sum + dto1.total_sales}"/>
    	      </c:forEach>
    	      

    	</tbody>
    </table></small>
    <!-- /.row -->

    
    <hr>
		<p class="text-center">결제 총 금액 : <fmt:formatNumber  type="currency"  value="${total_sum}"/>원 </p>
    <hr>
    <h2 class="mt-4 mb-3">수령인 정보
    </h2>
        <div class="row">
      <div class="col-lg-12 mb-4">
        <form name="orderForm" id="contactForm" method="post" novalidate>
          <div class="control-group form-group">
            <div class="controls">
              <label>수령인</label>
              <input type="text" class="form-control" name="userName" id="userName" value="${dto.userName}" required data-validation-required-message="Please enter your name.">
              <p class="help-block"></p>
            </div>
          </div>
          <div class="control-group form-group">
            <div class="controls">
              <label>연락처</label>
              <input type="tel" class="form-control" name="tel" id="tel" value="${dto.tel}" required data-validation-required-message="Please enter your phone number.">
            </div>
          </div>
          <div class="control-group form-group">
            <div class="controls">
              <label>배송지 주소</label>
              <input type="text" class="form-control" name="address" id="address" value="(${dto.zip}) ${dto.addr1}${dto.addr2}" required data-validation-required-message="Please enter your email address.">
            </div>
          </div>
          <div class="control-group form-group">
            <div class="controls">
              <label>배송시 요청사항</label>
              <textarea rows="5" cols="100" name="deliveryDetail" class="form-control" id="message" required data-validation-required-message="Please enter your message" maxlength="999" style="resize:none"></textarea>
            </div>
          </div>
          <!-- For success/fail messages -->
          <button type="submit" class="btn btn-primary" id="sendMessageButton" onclick="orderOk();">결제하기</button>
        </form>
      </div>

    </div>
    </div>