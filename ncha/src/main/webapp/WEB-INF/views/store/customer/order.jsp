<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
function orderOk(userId) {
	var f = document.orderForm;
 	f.action = "${pageContext.request.contextPath}/store/customer/${mode}";

    f.submit();
}
</script>
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
    <div class="row">
      <div class="col-md-7">
        <a href="#">
          <img class="img-fluid rounded mb-3 mb-md-0" src="http://placehold.it/700x300" alt="">
        </a>
      </div>
      <div class="col-md-5">
        <h3>${dto1.productName}</h3>
        <br>
        <p>옵션 선택 : </p>
        <p>수량 : ${dto1.number_sales}</p>
        <p>총 주문금액 : ${dto1.total_sales } </p>
      </div>
    </div>
    <!-- /.row -->

    
    <hr>
           <p>최종 결제 금액 :${dto1.total_sales} </p>
    <hr>
    <h2 class="mt-4 mb-3">수령인 정보
    </h2>
        <div class="row">
      <div class="col-lg-8 mb-4">
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
              <input type="text" class="form-control" name="address" id="address" value="${dto.zip}${dto.addr1}${dto.addr2}" required data-validation-required-message="Please enter your email address.">
            </div>
          </div>
          <div class="control-group form-group">
            <div class="controls">
              <label>배송시 요청사항</label>
              <textarea rows="5" cols="100" class="form-control" id="message" required data-validation-required-message="Please enter your message" maxlength="999" style="resize:none"></textarea>
            </div>
          </div>
          <input type="hidden" name="productNum" value="${dto1.productNum}">
          <input type="hidden" name="memberIdx" value="${memberIdx}">
          <input type="hidden" name="total_sales" value="${dto1.total_sales}">
          <input type="hidden" name="number_sales" value="${dto1.number_sales}">
          <input type="hidden" name="price" value="${dto1.price}">
          <input type="hidden" name="sellerId" value="${dto1.sellerId}">
          <!-- For success/fail messages -->
          <button type="submit" class="btn btn-primary" id="sendMessageButton" onclick="orderOk();">결제하기</button>
        </form>
      </div>

    </div>
    </div>