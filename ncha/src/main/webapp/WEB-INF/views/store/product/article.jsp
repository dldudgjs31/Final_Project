<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
function deleteBoard(num) {
	<c:if test="${sessionScope.seller.sellerId==dto.sellerId || sessionScope.member.userId=='admin'}">
	if(confirm("게시물을 삭제 하시겠습니까 ?")) {
		var q = "num=" +${dto.productNum} + "&${query}";
		var url="${pageContext.request.contextPath}/store/delete?"+q;
		location.href=url;
	}
	</c:if>
	<c:if test="${sessionScope.seller.sellerId!=dto.sellerId && sessionScope.member.userId!='admin'}">
		alert("게시글을 삭제할 수 없습니다.");
	</c:if>
}



function updateBoard(num){
	<c:if test="${sessionScope.seller.sellerId==dto.sellerId}">
		var q="num="+${dto.productNum}+"&page=${page}";
		var url="${pageContext.request.contextPath}/store/update?"+q;
		location.href=url;
	</c:if>
	<c:if test="${sessionScope.seller.sellerId!=dto.sellerId}">
		alert("게시글을 수정할 수 없습니다.");
	</c:if>
}
</script>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}
</script>
<div class="body-container" style="width: 700px;">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard"></i> 자유 게시판 </h3>
	</div>

	<div>
		<table style="width: 100%; margin-top: 20px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="center">
					${dto.productName}
				</td>
			</tr>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td width="50%" align="left" style="padding-left: 5px;">
					이름 : ${dto.sellerId}
				</td>
				<td width="50%" align="right" style="padding-right: 5px;">
					${dto.created_date } | 조회 ${dto.hitCount}
				</td>
			</tr>
			
			<tr >
				<td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
					${dto.detail}
				</td>
			</tr>

<%-- 			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					첨부 :
					<c:if test="${not empty dto.saveFilename}">
						<a href="${pageContext.request.contextPath}/bbs/downlaod?num=${dto.num}">${dto.originalFilename}</a>
					</c:if>
					
				</td>
			</tr>
 --%>
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					이전글 : 
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/store/article?${query}&num=${preReadDto.productNum}">${preReadDto.productName}</a>
					</c:if>
					
				</td>
			</tr>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/store/article?${query}&num=${nextReadDto.productNum}">${nextReadDto.productName}</a>
					</c:if>
				</td>
			</tr>
		</table>

		<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
				<td width="300" align="left">
					<button type="button" class="btn" onclick="updateBoard('${dto.productNum}');">수정</button>
					<button type="button" class="btn" onclick="deleteBoard('${dto.productNum}');">삭제</button>
				</td>

				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/store/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
	</div>
</div>