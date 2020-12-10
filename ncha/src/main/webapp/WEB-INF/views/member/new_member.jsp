<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.body-section{
	width: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
}
.member-title{
	width: 100%;
	height: 250px;
	
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 25px;
}

.member-select{
	width: 100%;
	height: 300px;
	
	display: flex;
	justify-content: center;
	align-items: center;
	
}
.member-detail{
	width: 100%;
	height: 200px;
}
.member-box{
	width : 25%;
	height: 200px;
	background: green;
	margin: 10px;
	
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 25px;
	
	border-radius: 30px;
	color:white;
}
.member-box:nth-child(1){
	background: navy;
}

@media screen and (max-width:768px){
	.member-box{
		width: 40%;
	}
}
</style>
<script type="text/javascript">
function send(){
	var url= "${pageContext.request.contextPath}/member/member";
	location.href=url;
	
}
</script>
<div class="body-section">
	<div class="member-title">
		<p>N차_신상 회원가입</p>
	</div>
	
	<div class="member-select">
		<div class="member-box" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/member/member';">일반회원</div>
		<div class="member-box" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/seller/member';">판매회원</div>
	</div>
	
	<div class="member-detail"></div>
	
</div>