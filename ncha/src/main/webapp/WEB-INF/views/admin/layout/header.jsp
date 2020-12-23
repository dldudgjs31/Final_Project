<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  <link href="${pageContext.request.contextPath}/resources/css/modern-business.css" rel="stylesheet">
  
 <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top" style="font-family: 'Noto Serif KR', serif; font-size: 15px;">
    <div class="container">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/"><img alt="로고" src="${pageContext.request.contextPath}/resources/img/logo.png" style="width:150px;"></a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin">Home</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownPortfolio" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              	회원 관리
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownPortfolio">
              <a class="dropdown-item" href="${pageContext.request.contextPath}/">일반회원</a>
              <a class="dropdown-item" href="${pageContext.request.contextPath}/">판매회원</a>
            </div>
          </li>
   
   		  <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownPortfolio" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              	게시판 관리
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownPortfolio">
              <a class="dropdown-item" href="${pageContext.request.contextPath}/">이벤트게시판</a>
              <a class="dropdown-item" href="${pageContext.request.contextPath}/">공지게시판</a>
            </div>
          </li>
          
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/">주문내역관리</a>
          </li>
           <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/">N차_신상</a>
          </li>
           <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/store/main">N차_스토어</a>
          </li>
	       

            <c:if test="${not empty sessionScope.member}">
             <li  class="nav-item"> 
             	<span class="nav-link" style="color:skyblue;">[${sessionScope.member.userName}]님 </span>
             </li>
             </c:if>
              <li class="nav-item">
               	 <a class="nav-link" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
               </li>
	         
        </ul>
      </div>
    </div>
  </nav>
    	