<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

<div class="body-container" style="width: 700px;">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard"></i> 중고글 게시판 </h3>
	</div>

	<div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					${dataCount}개(${page}/${total_page} 페이지)
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>
		
		<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<th width="60" style="color: #787878;">번호</th>
				<th width="60" style="color: #787878;">카테고리</th>
				<th width="100" style="color: #787878;">판매상태</th>
				<th style="color: #787878;">제목</th>
				<th width="100" style="color: #787878;">작성자</th>
				<th width="100" style="color: #787878;">작성일</th>
				<th width="60" style="color: #787878;">조회수</th>
				
			</tr>
		 <c:forEach var="dto" items="${list}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td>${dto.listNum}</td>
				<td>${dto.categoryName}</td>
				<c:if test="${dto.sold_check == 0}">
					<td>구매가능</td>
				</c:if>
				<c:if test="${dto.sold_check == 1}">
					<td>판매완료</td>
				</c:if>
				<td align="left" style="padding-left: 10px;">
					<a href="${articleUrl}&usedNum=${dto.usedNum}">${dto.subject}</a>
				</td>
				<td>${dto.userName}</td>
				<td>${dto.created_date}</td>
				<td>${dto.hitCount}</td>
				<td>
			</tr>
		 </c:forEach>

		</table>

		<table style="width: 100%; border-spacing: 0px;">
			<tr height="35">
				<td align="center">
					${dataCount==0?"등록된 게시물이 없습니다.":paging}
				</td>
			</tr>
		</table>

		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			<tr height="40">
				<td align="left" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/used/list';">새로고침</button>
				</td>
				<td align="right" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/used/created';">글올리기</button>
				</td>
			</tr>
		</table>
	</div>

</div>