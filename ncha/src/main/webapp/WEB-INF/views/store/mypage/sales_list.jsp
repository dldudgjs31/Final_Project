<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.btn{
	font-family : 'Jua', sans-serif;
}
.product_image{
	height:100px;
	width:100%;
	background-position: center;
	background-size: contain;
	background-repeat: no-repeat;
}
.list-group-item{
	color: black !important;
}
</style>
<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}

//오늘날짜 이상보다 체크 못하게 하는 쿼리
$(function(){
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; 
	var yyyy = today.getFullYear();
	if(dd<10){
	  dd='0'+dd
	} 
	if(mm<10){
	   mm='0'+mm
	} 

	today = yyyy+'-'+mm+'-'+dd;
	$(".date").attr("max",today);
});
//시작일보다 큰날짜 선택 못하게 하는 쿼리
$(function(){
	$("input[name=enddate]").change(function(){
		if($("input[name=enddate]").val() < $("input[name=startdate]").val()){
			alert("검색 마지막 날짜를 시작일보다 작게 설정할 수 없습니다.");
			$("input[name=enddate]").val("");
			return;
		}
	});
	
});

$(function(){
	
});
</script>
<Br>
        <ol class="breadcrumb">
      <li class="breadcrumb-item">MYPAGE</li>
      <li class="breadcrumb-item active">판매내역</li>
    </ol>
    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-xs-6 col-md-4">
        <div class="list-group">
	          <a href="${pageContext.request.contextPath}/store/mypage/main" class="list-group-item">메인</a>
	          <a href="${pageContext.request.contextPath}/store/mypage/saleslist" class="list-group-item">판매내역</a>
	          <a href="#" class="list-group-item">재고관리</a>
	          <a href="${pageContext.request.contextPath}/store/mypage/qna" class="list-group-item">Q&A 관리</a>
        </div>
      </div>
      <!-- Content Column -->

      <div class="col-xs-12 col-md-8">
      	 <h2 class="mt-4 mb-3"> 판매내역 리스트
      <small>판매 상품 리스트</small>
    </h2>
    <form name="searchForm" action="${pageContext.request.contextPath}/store/mypage/saleslist" method="post">
    <div class="form-group" style="display: flex; align-items: center; justify-content: center;">
	    <input type="date" class="form-control date" name="startdate" value="${startdate}"  style="width: 27%;" required="required">&nbsp;&nbsp;~&nbsp;&nbsp;
	    <input type="date" class="form-control date" name="enddate"  value="${enddate}" style="width: 27%;" required="required">&nbsp;&nbsp;
	    <select class="form-control" name="categoryNum" class="selectField" style="width: 15%;">
				<option value="0" ${categoryNum==0?"selected='selected'":""}>모두</option>
				<option value="1" ${categoryNum==1?"selected='selected'":""}>의류</option>
				<option value="2" ${categoryNum==2?"selected='selected'":""}>전자제품</option>
				<option value="3" ${categoryNum==3?"selected='selected'":""}>인테리어가구</option>
				<option value="4" ${categoryNum==4?"selected='selected'":""}>생필품</option>
		</select>&nbsp;
	    <button class="btn btn-primary btn-xs" type="button" onclick="searchList()">조회&nbsp;<i class="fas fa-search"></i></button>
    </div>
    </form>
     <p class="text-right">  총 주문 내역 수  : ${dataCount} &nbsp;&nbsp;&nbsp; (${page}/${total_page} 페이지)</p>
		<small><table class="table text-center">
		<thead>
			<tr>
				<td colspan="4"> 
				<h4>판매 총액 :<fmt:formatNumber type="currency" value="${sumSales}" />원</h4>
				<h5>현재 페이지 총액 :<fmt:formatNumber type="currency" value="${total_Sales}" />원</h5>
				
				</td>
			</tr>
			<tr>
				<th>상품이미지</th>
				<th>상품옵션</th>
				<th >결제금액</th>
				<th>구매일자</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="dto" items="${list}">
			<tr>
				<td>
					<div class="product_image" style="background-image: url('${pageContext.request.contextPath}/uploads/product/${dto.imageFilename}"></div>
				</td>
				<td class="text-left">
					<p>상품명 : ${dto.productName} </p>
					<p>옵션 : ${dto.order_option} / [ ${dto.number_sales}개 ]
				</td>
				<td class="sales"><fmt:formatNumber type="currency" value="${dto.total_sales}" />원</td>
				<td>${dto.order_date}</td>
			</tr>	
		</c:forEach>

		</tbody>
		</table></small>
		<p class="text-center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</p>
    
    </div>
    </div>