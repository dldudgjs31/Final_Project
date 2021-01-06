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
    font-size: 13px; font-family: 'Jua', sans-serif;
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

function deleteEvent(eventNum) {
	var url="${pageContext.request.contextPath}/admin/list/deleteEvent?eventNum="+eventNum+"&page=${page}";
	if(confirm("자료를 삭제 하시겠습니까?")) {
		location.href=url;
	}
}
function authEvent(eventNum, allow) {
	var url="${pageContext.request.contextPath}/admin/list/authEvent?eventNum="+eventNum+"&allow="+allow+"&page=${page}";
	if(confirm("권한을 변경 하시겠습니까?")) {
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
	    <span style="font-size: 15pt; font-family: 'Jua', sans-serif; font-weight: bold;">이벤트 신청리스트</span>
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
	<th width="80">신청자</th>
	<th width="220">제목</th>
	<th width="120">시작일자</th>
	<th width="120">종료일자</th>
	<th width="60">권한</th>
	<th>변경</th>

</tr>

<c:forEach var="dto" items="${list}">
<tr height="35" bgcolor="#ffffff" align="center">
	<td>${dto.listNum}</td>
	<td>${dto.sellerId}</td>
	<td>${dto.subject}</td>
	<td>${dto.start_date}</td>
	<td>${dto.end_date}</td>
	<td> 
	<c:choose>
		 <c:when test="${dto.allow=='0'}">
	        	<span>없음</span> 
	     </c:when>
	     <c:otherwise>
	       	<span>있음</span> 
	 	</c:otherwise>
	</c:choose>
	 
	 </td>
	<td>
	  <a href="javascript:authEvent('${dto.eventNum}', ${dto.allow})">권한변경</a> |
	  <a href="javascript:deleteEvent('${dto.eventNum}')">삭제</a>
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