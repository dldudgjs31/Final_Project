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

<div class="body-container" style="width: 1080px;">
    <div>
        스토어 상품 리스트 페이지
        <Br><Br><Br>
        <p> <a href="${pageContext.request.contextPath}/store/product">글보기</a> </p>
    </div>
	<div class="body-title">
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
				<th style="color: #787878;">상품명</th>
				<th width="100" style="color: #787878;">정가 가격</th>
				<th width="100" style="color: #787878;">할인된 가격</th>
				<th width="100" style="color: #787878;">작성자</th>
				<th width="80" style="color: #787878;">작성일</th>
				<th width="60" style="color: #787878;">조회수</th>
			</tr>
		 <c:forEach var="dto" items="${list}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td>${dto.listNum}</td>
				<td align="left" style="padding-left: 10px;">
					<a href="${articleUrl}&num=${dto.productNum}">${dto.productName}</a>
<%-- 					<c:if test="${dto.replyCount!=0}">
						(${dto.replyCount})
					</c:if> --%>
					
				</td>
				<td>${dto.price}</td>
				
				<td><fmt:formatNumber value="${dto.price * ((100 - dto.discount_rate)/100) }" pattern=""/>원</td>
				<td>${dto.sellerId}</td>
				<td>${dto.created_date}</td>
				<td>${dto.hitCount}</td>
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
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/store/list';">새로고침</button>
				</td>
				<td align="center">
					<form name="searchForm" action="${pageContext.request.contextPath}/store/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
							<option value="productName" ${condition=="productName"?"selected='selected'":""}>제품명</option>
							<option value="detail" ${condition=="detail"?"selected='selected'":""}>제품상세</option>
							<option value="sellerName" ${condition=="sellerName"?"selected='selected'":""}>판매자</option>
							<option value="created_date" ${condition=="created_date"?"selected='selected'":""}>등록일</option>
						</select>
						<input type="text" name="keyword" value="${keyword}" class="boxTF">
						<button type="button" class="btn" onclick="searchList()">검색</button>
					</form>
				</td>
				<td align="right" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/store/created';">글올리기</button>
				</td>
			</tr>
		</table>
	</div>

</div>

