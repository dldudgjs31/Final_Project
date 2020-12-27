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
          <a href="index.html" class="list-group-item">메인</a>
          <a href="${pageContext.request.contextPath}/store/customer/cartlist" class="list-group-item">장바구니</a>
          <a href="about.html" class="list-group-item">주문내역</a>
          <a href="services.html" class="list-group-item">REVIEW</a>
          <a href="contact.html" class="list-group-item">Q&A</a>
        </div>
      </div>
      <!-- Content Column -->

      <div class="col-xs-12 col-md-8">


    </div>
</div>