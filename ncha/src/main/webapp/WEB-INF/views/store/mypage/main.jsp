<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	          <a href="#" class="list-group-item">재고관리</a>
	          <a href="${pageContext.request.contextPath}/store/mypage/qna" class="list-group-item">Q&A 관리</a>
        </div>
      </div>
      <!-- Content Column -->

      <div class="col-xs-12 col-md-8">
      	 <h2 class="mt-4 mb-3">판매자 MYPAGE
      <small>주요 사항</small>
    </h2>
    </div>
    </div>