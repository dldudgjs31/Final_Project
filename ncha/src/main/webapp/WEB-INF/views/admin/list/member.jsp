<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dateUtil.js"></script>

<style type="text/css">
*{
    margin: 0; padding: 0;
}
body {
    font-size: 13px; font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
a{
    color: #000000;
    text-decoration: none;
    cursor: pointer;
}
a:active, a:hover {
    text-decoration: underline;
    color: tomato;
}
</style>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}

function deleteMember(userId) {
	var url="${pageContext.request.contextPath}/admin/list/deleteMember?userId="+userId+"&page=${page}";
	if(confirm("자료를 삭제 하시겠습니까?")) {
		location.href=url;
	}
}
function authMember(userId, allow) {
	var url="${pageContext.request.contextPath}/admin/list/authMember?userId="+userId+"&allow="+allow+"&page=${page}";
	if(confirm("권한을 변경하시겠습니까?")) {
		location.href=url;
	}
}
</script>

</head>
<body>

<div style="width: 800px; margin: 30px auto 0px;">
<table style="width: 100%; margin: 0px auto;">
<tr height="50">
	<td align="center" colspan="2">
	    <span style="font-size: 15pt; font-family: 'Jua', sans-serif; font-weight: bold;">회원리스트</span>
	</td>
</tr>

<tr height="35">
	<td width="50%">
		${dataCount}개(${page}/${total_page} 페이지)
	</td>
</tr>
</table>
<form name="scoreListForm" method="post">
<table style="width: 100%; margin: 0px auto; border-spacing: 1px; background: #cccccc;">
<tr height="30" bgcolor="#eeeeee" align="center">
	<th width="50">번호</th>
	<th width="80">아이디</th>
	<th width="80">이름</th>
	<th width="120">생년월일</th>
	<th width="120">전화번호</th>
	<th width="160">이메일</th>
	<th width="100">계정상태</th>
	<th>변경</th>

</tr>

<c:forEach var="dto" items="${list}">
<tr height="35" bgcolor="#ffffff" align="center">
	<td>${dto.listNum}</td>
	<td>${dto.userId}</td>
	<td>${dto.userName}</td>
	<td>${dto.birth}</td>
	<td>${dto.tel}</td>
	<td>${dto.email}</td>
	<td> 
	<c:choose>
		 <c:when test="${dto.allow=='1'}">
	        	<span>사용정지</span> 
	     </c:when>
	     <c:otherwise>
	       	<span>사용가능</span> 
	 	</c:otherwise>
	</c:choose>
	 
	 </td>
	<td>
	  <a href="javascript:authMember('${dto.userId}', ${dto.allow})">권한변경</a> |
	  <a href="javascript:deleteMember('${dto.userId}')">삭제</a>
		</td>
</tr>
</c:forEach>
</table>
</form>

<table style="width: 100%; margin: 10px auto;">
<tr height="30" align="center">
	<td>${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
</tr>
</table>


</div>

</body>
</html>