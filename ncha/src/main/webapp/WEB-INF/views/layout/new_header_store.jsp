<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  <link href="${pageContext.request.contextPath}/resources/css/modern-business.css" rel="stylesheet">
  
  <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top" style="font-family: 'Noto Serif KR', serif; font-size: 15px;">
    <div class="container">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/"><img alt="로고" src="${pageContext.request.contextPath}/resources/img/logo2.png" style="width:150px;"></a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/store/main">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/store/list">N차_스토어</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/event/list">이벤트</a>
          </li>

    
		 <c:if test="${not empty sessionScope.seller && sessionScope.member.userId=='admin'}">
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/store/write">판매글올리기</a>
          </li>
          </c:if>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/">중고거래</a>
          </li>
	         <c:if test="${empty sessionScope.member && empty sessionScope.seller}">
	     <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/member/login">로그인</a>
          </li>      
	     <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/ncha/member">회원가입</a>
          </li>      
            </c:if>

            <c:if test="${not empty sessionScope.member}">
             <li  class="nav-item"> 
             	<span class="nav-link" style="color:skyblue;">[${sessionScope.member.userName}]님 </span>
             </li>
              <li class="nav-item">
               	 <a class="nav-link" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
               </li>
                
               <li class="nav-item"> 
               	<a class="nav-link" href="${pageContext.request.contextPath}/member/pwd">정보수정</a>
               </li>
                <c:if test="${sessionScope.member.userId=='admin'}">
                    <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin">관리자</a>
                    </li>
                </c:if>
            </c:if>
            
            <c:if test="${not empty sessionScope.seller}">
             <li  class="nav-item"> 
             	<span class="nav-link" style="color:skyblue;">[${sessionScope.seller.sellerName}]님 </span>
             </li>
              <li class="nav-item">
               	 <a class="nav-link" href="${pageContext.request.contextPath}/seller/logout">로그아웃</a>
               </li>
                
               <li class="nav-item"> 
               	<a class="nav-link" href="${pageContext.request.contextPath}/seller/pwd">정보수정</a>
               </li>
                <c:if test="${sessionScope.member.userId=='admin'}">
                    <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin">관리자</a>
                    </li>
                </c:if>
            </c:if>
	         
        </ul>
      </div>
    </div>
  </nav>