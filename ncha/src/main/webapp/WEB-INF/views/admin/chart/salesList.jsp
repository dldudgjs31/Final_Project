<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="body-container" style="width: 700px;">
	 <ol class="breadcrumb">
		    <li class="breadcrumb-item">매출 분석</li>
		    <li class="breadcrumb-item active">매출 리스트</li>
	 </ol>
   
    
      	<table style="width: 100%; margin: 0px auto;">
			<tr height="35">
				<td width="50%">
					${dataCount}개(${page}/${total_page} 페이지)
				</td>
			</tr>
		</table>
		<form name="salesListForm" method="post">
			<table style="width: 100%; margin: 0px auto; border-spacing: 1px; background: #cccccc;">
				<tr height="30" bgcolor="#eeeeee" align="center">
					<th width="50">번호</th>
					<th width="70">주문번호</th>
					<th width="100">판매자</th>
					<th width="100">카테고리</th>
					<th width="200">상품 이름</th>
					<th width="120">구매 총액</th>
					<th width="100">주문 날짜</th>
				</tr>
			
				<c:forEach var="dto" items="${list}">
					<tr height="35" bgcolor="#ffffff" align="center">
						<td>${dto.listNum}</td>
						<td>${dto.orderNum}</td>
						<td>${dto.sellerId}</td>
						<td>${dto.categoryName}</td>
						<td>${dto.productName}</td>
						<td>￦ ${dto.total_sales}</td>
						<td>${dto.order_date}</td>
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

