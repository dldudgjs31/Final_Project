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
	$(".searchbtn").click(function(){
		if($("input[name=enddate]").val()=="" || $("input[name=startdate]").val()==""){
			alert("날짜를 선택해주세요.");
			return;
		}
		searchList();
	});
});

function ajaxFun(url, method, dataType, query, fn) {
	$.ajax({
		type:method
		,enctype: 'multipart/form-data'
		,url:url
		,data:query
		,dataType:dataType
		,success:function(data) {
			fn(data);
			
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status===403) {
	    		login();
	    		return false;
	    	}
	    	
	    	console.log(jqXHR.responseText);
	    }
	});
}
function updateSubmit(num) {
	var url="${pageContext.request.contextPath}/store/mypage/stock_update";
	var boardForm= "boardForm"+num;
	var query=$("form[name="+boardForm+"]").serialize();
	
	var fn = function(data){
		var state=data.state;
		if(state==="true") {
			alert("옵션이 등록되었습니다.");
			location.replace('${pageContext.request.contextPath}/store/mypage/stockupdate'); 
		} else if(state==="false") {
			alert("옵션을 추가 하지 못했습니다.");
		}
	};
	
	ajaxFun(url, "post", "json", query, fn);
}

</script>
<Br>
        <ol class="breadcrumb">
      <li class="breadcrumb-item">MYPAGE</li>
      <li class="breadcrumb-item active">재고관리</li>
    </ol>
    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-xs-6 col-md-4">
        <div class="list-group">
	          <a href="${pageContext.request.contextPath}/store/mypage/main" class="list-group-item">메인</a>
	          <a href="${pageContext.request.contextPath}/store/mypage/saleslist" class="list-group-item">판매내역</a>
	          <a href="${pageContext.request.contextPath}/store/mypage/stockupdate" class="list-group-item">재고관리</a>
	          <a href="${pageContext.request.contextPath}/store/mypage/qna" class="list-group-item">Q&A 관리</a>
        </div>
      </div>
      <!-- Content Column -->

      <div class="col-xs-12 col-md-8">
      	 <h2 class="mt-4 mb-3"> 재고관리
      <small>판매 상품 리스트</small>
    </h2>
    <form name="searchForm" action="${pageContext.request.contextPath}/store/mypage/stockupdate" method="post">
    <div class="form-group" style="display: flex; align-items: center; justify-content: center;">
	    <select class="form-control" name="categoryNum" class="selectField" style="width: 30%;">
				<option value="0" ${categoryNum==0?"selected='selected'":""}>모두</option>
				<option value="1" ${categoryNum==1?"selected='selected'":""}>의류</option>
				<option value="2" ${categoryNum==2?"selected='selected'":""}>전자제품</option>
				<option value="3" ${categoryNum==3?"selected='selected'":""}>인테리어가구</option>
				<option value="4" ${categoryNum==4?"selected='selected'":""}>생필품</option>
		</select>&nbsp;
	    <button class="btn btn-primary btn-xs searchbtn" type="button" onclick="searchList()">조회&nbsp;<i class="fas fa-search"></i></button>
    </div>
    </form>
    
    <p class="text-right">  총 주문 내역 수  : ${dataCount} &nbsp;&nbsp;&nbsp; (${page}/${total_page} 페이지)</p>
		<small><table class="table text-center">
		<thead>
			<tr>
				<th>상품명</th>
				<th >옵션</th>
				<th >재고업데이트</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="dto" items="${list}">
			<tr>
				<td class="text-left">
					<p>상품명 : ${dto.productName} </p>
					<p>제품 카테고리 : ${dto.categoryName}</p>
					<p>작성일 :${dto.created_date} </p>
				</td>
				<td class="sales">
				<form name="boardForm${dto.productNum}">
					<c:forEach var="dto1" items="${dto.optionlist}">
							<p style="display: flex; align-items: center;">
								옵션명 : ${dto1.opt_detail} |  재고 : &nbsp;
								<input class="form-control optionstock${dto1.optionNum}"  value="${dto1.opt_stock}" name="option_stock" id="" style="width: 20%;"> 
							</p>
							<input type="hidden" name="optionDetail" value="${dto1.opt_detail}">
					</c:forEach>
				<input type="hidden" name="stock" value="${dto.stock}" >
					<input type="hidden" name="productNum" value="${dto.productNum}">
				</form>
				</td>
				<td>
					<button type="button" class="btn btn-info btn-xs updatestock" onclick="updateSubmit(${dto.productNum})">수정</button>
					<input type="hidden" name="productNum" value="${dto.productNum}">
				</td>
			</tr>	
		</c:forEach>

		</tbody>
		</table></small>
		<p class="text-center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</p>
    
    </div>
    </div>