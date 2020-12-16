<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<script type="text/javascript">


</script>
<style type="text/css">
.imgLayout{
	width: 190px;
	height: 205px;
	padding: 10px 5px 10px;
	margin: 5px;
	border: 1px solid #dad9ff;
	cursor: pointer;
}

.subject {
	width: 180px;
	height: 25px;
	line-height: 25px;
	margin: 5px auto;
	border-top: 1px solid #dad9ff;
	display: inline-block;
	white-space: nowrap;
	overflow:hidden;
	text-overflow: ellipsis;
	cursor: pointer;
}
</style>

<div class="body-container" style="width: 900px;">
    <div>
        일상글 리스트입니다.
        
       <br><br> 
       <div>
	       	<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
				<tr height="40">
					<td align="right" width="100">
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/daily/created';">글올리기</button>
					</td>
					<td align="center">
						<form name="searchForm" action="${pageContext.request.contextPath}/daily/list" method="post">
							<select name="condition" class="selectField">
								<option value="all">모두</option>
								<option value="food">음식</option>
								<option value="furn">가구</option>
								<option value="elec">전자제품</option>
								<option value="book">도서</option>
							</select>
							<input type="text" name="keyword" value="${keyword}" class="boxTF">
							<button type="button" class="btn" onclick="searchList()">검색</button>
						</form>
					</td>
					<td align="left" width="100">
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/daily/list';">새로고침</button>
					</td>
					<td>
						<button type="button" class="btn" onclick="">관심 일상 보기</button>
					</td>
				</tr>
				</table>
			   	<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
					<tr height="35">
						<td align="left" width="50%">
							${dataCount}개 (${page}/${total_page} 페이지)
						</td>
						<td align="right">
							&nbsp;
						</td>
					</tr>
				</table>		
       </div>
       
       <div>
       		<div>
	       		<table style="width: 630px; margin: 20px auto 0px; border-spacing: 0px;">
						<c:forEach var="dto" items="${list}" varStatus="status">
						
							<c:if test="${status.index==0}">
								<tr>
							</c:if>
							<c:if test="${status.index!=0 && status.index%4==0}">
								<c:out value="</tr><tr>" escapeXml="false"/>
							</c:if>
							<td width="210" align="center">
								<div class="imgLayout">
									<img  src="${pageContext.request.contextPath}/uploads/daily/${dto.imageFilename}" width="180" height="180" border="0">
									<a href="${articleUrl}&dailyNum=${dto.dailyNum}" class="subject">${dto.subject}</a>
								</div>
							</td>
						</c:forEach>
						
							<c:set var="n" value="${list.size()}"/>
							<c:if test="${n>0 && n%4!=0}">
								<c:forEach var="i" begin="${n%4+1}" end="4">
										<td width="210">
											<div class="imgLayout">&nbsp;</div>
										</td>
								</c:forEach>
							</c:if>   
							
				</table>
				  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
					   <tr height="35">
						<td align="center">
						    ${dataCount==0 ? "등록된 게시물이 없습니다.":paging}
						 </td>
					   </tr>
				</table>
       		</div>
       </div>
    </div>
</div>