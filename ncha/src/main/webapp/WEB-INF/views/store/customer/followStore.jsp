<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
.image{
	height:50px;
	width:100%;
	background-position: center;
	background-size: contain;
	background-repeat: no-repeat;
}
</style>
<script type="text/javascript">
function ajaxFun(url, method, dataType, query, fn) {
	$.ajax({
		type:method
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
function deleteCart(sellerId){
	if(!confirm("스토어를 언팔로우하시겠습니까?")){
		return;
	}
	var url="${pageContext.request.contextPath}/store/updateStoreLike";	
	var query="sellerId="+sellerId;
	var fn = function(data) {
		var state=data.state;
		if(state==="true") {
			alert("팔로우 완료!")
		} else if(state==="deltrue") {
			alert("팔로우 취소 완료!");
			location.replace('${pageContext.request.contextPath}/store/customer/followStore'); 
		}else if(state==="false"){
			alert("팔로우 등록에 실패했습니다.");
		}
	};
	ajaxFun(url, "post", "json", query, fn);
}
</script>
<Br>
        <ol class="breadcrumb">
      <li class="breadcrumb-item">MYPAGE</li>
      <li class="breadcrumb-item active">찜한 상품</li>
    </ol>
    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-xs-6 col-md-4">
        <div class="list-group">
	          <a href="${pageContext.request.contextPath}/store/customer/mypage" class="list-group-item">메인</a>
	          <a href="${pageContext.request.contextPath}/store/customer/likeList" class="list-group-item">찜한상품</a>
	          <a href="${pageContext.request.contextPath}/store/customer/followStore" class="list-group-item">팔로잉스토어</a>
	          <a href="${pageContext.request.contextPath}/store/customer/cartlist" class="list-group-item">장바구니</a>
	          <a href="${pageContext.request.contextPath}/store/customer/buylist" class="list-group-item">주문내역</a>
	          <a href="${pageContext.request.contextPath}/store/customer/review" class="list-group-item">REVIEW</a>
	          <a href="${pageContext.request.contextPath}/qna/mypage/qnalist" class="list-group-item">Q&A</a>
        </div>
      </div>
      <!-- Content Column -->

      <div class="col-xs-12 col-md-8" style="min-height: 700px;">
   <h2 class="mt-4 mb-3">내가 팔로우하는 스토어
      <small>리스트</small>
    </h2>
       <p class="text-right">스토어 수 : ${dataCount}개  (${page}/${total_page} 페이지)</p>
		<small><table class="table text-center">
		<thead>
			<tr>
				<th>상품이미지</th>
				<th>스토어명</th>
				<th>바로가기</th>
				<th>설정</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="dto" items="${list}">
			<tr>
				<td>
					<div class="image" style="background-image: url('${pageContext.request.contextPath}/uploads/member/${dto.profile_imageFilename}');"></div>
				</td>
				<td>${dto.sellerName}</td>
				<td><a href="${pageContext.request.contextPath}/store/myFollowStore?page=1&sellerId=${dto.sellerId}"> [스토어로 이동]</a></td>
				<td>
					<button class="btn btn-danger btn-xs" onclick="deleteCart('${dto.sellerId}')" >삭제</button>
				</td>
			</tr>
		</c:forEach>
		</tbody>
		</table></small>
          <p class="text-center">${dataCount==0?"등록된 스토어가 없습니다.":paging}</p>
    
    
      </div>
      </div>
      
