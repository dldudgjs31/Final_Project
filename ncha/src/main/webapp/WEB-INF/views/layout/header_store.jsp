<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.navbar_menu a{
	text-decoration: none;
	color: white;
}
.navbar{
	display: flex;
	justify-content: space-between; /* 가로정렬 */
	align-items: center;/* 세로정렬 */
	background-color: #263343;
	padding: 8px 12px;
	font-family: 'Noto Serif KR', serif;
	
}

.navbar_logo{
	font-size: 24px;
	color: white;

}
.navbar_logo i{
	color: #d49466;
}

.navbar_menu{
	display: flex;
	list-style: none;
	padding-left: 0;
	
}
.navbar_menu li {
	padding: 8px 12px;
	font-size: 12px;
}
.navbar_menu li:hover {
	background-color: #d49466;
	border-radius: 4px;
}
.navbar_icons{
	list-style: none;
	color: white;
	display: flex;
		padding-left: 0;
}

.navbar_icons li {
	padding: 8px 12px;
}
.navbar_icons li a{
	color: white;
}
.navbar_icons li:hover {
	background-color: #d49466;
	border-radius: 4px;
}
.navbar_toggleBtn {
	display:none;
	position: absolute;
	right: 32px;
	font-size: 24px;
	color: #d49466;
}
@media screen and (max-width:768px){
	.navbar {
		flex-direction: column; /* 아래 밑으로 정렬  */
		align-items: flex-start;/*  */
		padding: 8px 24px;
	}
	
	.navbar_menu{
		display: none;
		flex-direction: column; /* 아래 밑으로 정렬  */
		align-items: center;/* 세로 가운데 정렬 */
		width: 100%;		
	}
	.navbar_menu li{
		width: 100%;
		text-align: center;
	}
	.navbar_icons{
		display: none;
		justify-content: center;
		width: 100%;
		padding-left: 0;
	}
	.navbar_toggleBtn {
		display: block;
	}
	
	.navbar_menu.active,
	.navbar_icons.active{
		display: flex;
	}
}
</style>
<nav class="navbar">
	<div class="navbar_logo" style="width: 100px;">
		<a href="${pageContext.request.contextPath}/store/main" >
		<img alt="로고" src="${pageContext.request.contextPath}/resources/img/logo2.png" style="width:150px;">
		</a>
	</div>
	<!-- 메인 메뉴바 -->
	<ul class="navbar_menu">
		<li><a href="${pageContext.request.contextPath}/store/main">HOME</a></li>
		<li><a href="${pageContext.request.contextPath}/store/list">N차_스토어</a></li>
		<li><a href="${pageContext.request.contextPath}/event/list">이벤트</a></li>
		<li><a href="${pageContext.request.contextPath}/store/write">판매글올리기</a></li>
		<li><a href="${pageContext.request.contextPath}/">고객센터</a></li>
		<li><a href="${pageContext.request.contextPath}/">중고거래</a></li>
	</ul>
	
	<!-- 로그인/로그아웃 버튼 -->
	<ul class="navbar_icons">
	         <c:if test="${empty sessionScope.member && empty sessionScope.seller}">
               <li><a href="${pageContext.request.contextPath}/seller/login">로그인</a>	</li>
                    &nbsp;&nbsp;
               <li> <a href="${pageContext.request.contextPath}/ncha/member">회원가입</a></li>
            </c:if>
            <c:if test="${not empty sessionScope.member}">
                <li><span style="color:blue;">${sessionScope.member.userName}</span>님</li>
                &nbsp;&nbsp;
      			<li><a href="${pageContext.request.contextPath}/mypage/profile">마이페이지</a></li>
                &nbsp;&nbsp;
               <li> <a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
                &nbsp;&nbsp;
               <li> <a href="${pageContext.request.contextPath}/member/pwd">정보수정</a></li>
                <c:if test="${sessionScope.member.userId=='admin'}">
                    &nbsp;&nbsp;
                    <li><a href="${pageContext.request.contextPath}/admin">관리자</a></li>
                </c:if>
            </c:if>
            
            <c:if test="${not empty sessionScope.seller}">
                <li><span style="color:blue;">${sessionScope.seller.sellerName}</span>님</li>
                &nbsp;&nbsp;
               <li> <a href="${pageContext.request.contextPath}/seller/logout">로그아웃</a></li>
                &nbsp;&nbsp;
               <li> <a href="${pageContext.request.contextPath}/seller/pwd">정보수정</a></li>
                <c:if test="${sessionScope.member.userId=='admin'}">
                    &nbsp;&nbsp;
                    <li><a href="${pageContext.request.contextPath}/admin">관리자</a></li>
                </c:if>
            </c:if>
	</ul>
	
	<a href="#" class="navbar_toggleBtn">
	<i class="fas fa-bars"></i>
	</a>
</nav>
<script>
$(function(){
	var toggleBtn = document.querySelector(".navbar_toggleBtn");
	var menu = document.querySelector(".navbar_menu");
	var icons = document.querySelector(".navbar_icons");
		$("body").on("click",".navbar_toggleBtn",function(){
		menu.classList.toggle("active");
		icons.classList.toggle("active");
		
		});
			
	});
</script>