<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function deleteBoard(num) {
	if(confirm("게시물을 삭제 하시겠습니까 ?")) {
		var url="${pageContext.request.contextPath}/";
		location.href=url;
	}
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
					${dto.subject}
				</td>
			</tr>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td width="50%" align="left" style="padding-left: 5px;">
					이름 : ${dto.userName}
				</td>
				<td width="50%" align="right" style="padding-right: 5px;">
					${dto.created } | 조회 ${dto.hitCount}
				</td>
			</tr>
			
			<tr style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
					${dto.content}
				</td>
			</tr>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					첨부 :
					<c:if test="${not empty dto.saveFilename}">
						<a href="${pageContext.request.contextPath}/bbs/downlaod?num=${dto.num}">${dto.originalFilename}</a>
					</c:if>
					
				</td>
			</tr>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					이전글 : 
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/bbs/article?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
					</c:if>
					
				</td>
			</tr>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/bbs/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
		</table>

		<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
				<td width="300" align="left">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/';">수정</button>
					<button type="button" class="btn" onclick="deleteBoard('1');">삭제</button>
				</td>

				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/bbs/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
	</div>

</div>