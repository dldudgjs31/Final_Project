<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.image{
	background-position: center;
	background-size: contain;
	background-repeat: no-repeat;
}


.product_image{
	height:100px;
	width:100%;
	background-position: center;
	background-size: contain;
	background-repeat: no-repeat;
}
.star {font-size:0; letter-spacing:-4px;}
.star a {
    font-size:22px;
    letter-spacing:0;
    display:inline-block;
    margin-left:3px;
    color:#cccccc;
    text-decoration:none;
}
.star a:first-child {margin-left:0;}
.star a.on {color:#F2CB61;}
.btn{
	font-family: 'Jua', sans-serif;
}
.list-group-item{
	color: black !important;
}
</style>
<script type="text/javascript">
$(function(){
	   $( ".star a" ).click(function() {
	      var b=$(this).hasClass("on");
	       $(this).parent().children("a").removeClass("on");
	       $(this).addClass("on").prevAll("a").addClass("on");
	       if(b) {
	    	   $(this).removeClass("on");
	       }
	       var s=$(".star .on").length;
	       $("#score").val(s);
	   });
	   
	   
	   
});
$(function(){
	$("body").on("click",".reviewGO",function(){
		$("#productNum1").val($(this).parent().children().eq(1).val());
		$("#orderNum").val($(this).parent().children().eq(2).val());
		$("#orderDetail").val($(this).parent().children().eq(3).val());
	});
});


function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

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

//페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "${pageContext.request.contextPath}/review/listReview";
	//var query = "productNum=${dto.productNum}&pageNo="+page;
	var query = "productNum=${dto.productNum}&pageNo="+page;
	
	var fn = function(data){
		$("#listReview").html(data);
	};
	
	ajaxFun(url, "get", "html", query, fn);
}

//리뷰 등록
$(function(){
	$(".btnSendReview").click(function(){
		var $tb = $(".reviewtable");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		var url="${pageContext.request.contextPath}/review/insertReview";
		var query=$("form[name=reviewForm]").serialize();
		
		var fn = function(data){
			$tb.find("textarea").val("");
			$("form[name=reviewForm] input[name=score]").val("0");
			$( ".star a" ).removeClass("on");
			 
			var state=data.state;
			if(state==="true") {
				listPage(1);
				alert("리뷰가 등록되었습니다.");
				location.replace('${pageContext.request.contextPath}/store/customer/review'); 
			} else if(state==="false") {
				alert("리뷰을 추가 하지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", "json", query, fn);
	});
	
	//리뷰 수정 submit
	$(".btnupdateReview").click(function(){
		var $tb = $(".updateTable");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		var content, score, reviewNum;
		content = $("#content").val();
		score = $("#score").val();
		reviewNum= $("#reviewNum123").val();
		var query= "content=" +content+"&score=" +score +"&reviewNum="+ reviewNum;
		var url="${pageContext.request.contextPath}/review/updateSubmit";
		var fn = function(data){
			var state=data.state;
			if(state==="true") {
				alert("리뷰가 수정되었습니다.");
				location.replace('${pageContext.request.contextPath}/store/customer/review'); 
			} else if(state==="false") {
				alert("리뷰을 수정 하지 못했습니다.");
			}
		};
		ajaxFun(url, "post", "json", query, fn);
	});
});
//리뷰 삭제
function deleteReview(reviewNum){
		if(!confirm("리뷰를 삭제하시겠습니까?")){
			return;
		}
		var url="${pageContext.request.contextPath}/review/deleteReview";
		var query="reviewNum="+reviewNum;
		var fn = function(data){
			if(data.state=="true"){
				alert("리뷰가 삭제되었습니다.");
				location.replace('${pageContext.request.contextPath}/store/customer/review'); 
			} else if(state==="false") {
				alert("리뷰을 삭제 하지 못했습니다.");
			}
		};
		ajaxFun(url, "post", "json", query, fn);
	
}
//리뷰 수정
function updateReview(reviewNum){
	var url = "${pageContext.request.contextPath}/review/reviewUpdate";
	//var query = "productNum=${dto.productNum}&pageNo="+page;
	var query = "reviewNum="+reviewNum;
	
	var fn = function(data){
		$(".reviewForm").html(data);
	};
	
	ajaxFun(url, "get", "html", query, fn);
}
</script>
<Br>
        <ol class="breadcrumb">
      <li class="breadcrumb-item">MYPAGE</li>
      <li class="breadcrumb-item active">리뷰</li>
    </ol>
    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-xs-6 col-md-4" >
        <div class="list-group">
	          <a href="${pageContext.request.contextPath}/store/customer/mypage" class="list-group-item">메인</a>
	          <a href="${pageContext.request.contextPath}/store/customer/likeList" class="list-group-item">찜한상품</a>
	          <a href="${pageContext.request.contextPath}/store/customer/cartlist" class="list-group-item">장바구니</a>
	          <a href="${pageContext.request.contextPath}/store/customer/buylist" class="list-group-item">주문내역</a>
	          <a href="${pageContext.request.contextPath}/store/customer/review" class="list-group-item">REVIEW</a>
	          <a href="${pageContext.request.contextPath}/qna/mypage/qnalist" class="list-group-item">Q&A</a>
        </div>
      </div>
      <!-- Content Column -->

      <div class="col-xs-12 col-md-8" style="min-height: 400px;">
		<h2 class="mt-4 mb-3">구매한 상품
			<small>리뷰 리스트</small>
	    </h2>
	    <p class="text-right">  총 주문 내역 수  : ${dataCount} &nbsp;&nbsp;&nbsp; (${page}/${total_page} 페이지)</p>
		<small><table class="table text-center">
		<thead>
			<tr>
				<th>상품이미지</th>
				<th>상품정보</th>
				<th>구매일</th>
				<th>후기</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="dto" items="${list}">
			<tr>
				<td>
					<div class="product_image" style="background-image: url('${pageContext.request.contextPath}/uploads/product/${dto.imageFilename}"></div>
				</td>
				<td class="text-left">
					<p>판매자 : ${dto.sellerId} </p>
					<p>상품명 : ${dto.productName} </p>
					<p>옵션 : ${dto.order_option} / [ ${dto.number_sales}개 ]
				</td>
				<td>${dto.order_date}</td>
				<td>
				<c:if test="${dto.reviewCount == 0}">
					<button class="btn btn-primary btn-xs reviewGO" data-toggle="modal" data-target="#myModal" style="font-family: 'Jua', sans-serif;"><small>등록</small></button>
					<input type="hidden" name="productNum" value="${dto.productNum}" id="productNumber">
					<input type="hidden" name="orderNum" value="${dto.orderNum}" id="orderNumber">
					<input type="hidden" name="orderDetail" value="${dto.orderDetail}" >
				</c:if>
				<c:if test="${dto.reviewCount >= 1}">
					<button class="btn btn-info btn-xs reviewUpdate" onclick="updateReview('${dto.reviewNum}')"  data-toggle="modal" data-target="#myModal1" style="font-family: 'Jua', sans-serif;"><small>수정</small></button>
					<button class="btn btn-danger btn-xs reviewDelete" onclick="deleteReview('${dto.reviewNum}')"  style="font-family: 'Jua', sans-serif;"><small>삭제</small></button>
					<input type="hidden" name="reviewNum" value="${dto.reviewNum}">
					<input type="hidden" name="orderDetail" value="${dto.orderDetail}" >
				</c:if>	
				</td>
			</tr>	
		</c:forEach>
		</tbody>
		</table></small>
		<p class="text-center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</p>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">후기 작성</h4>
      </div>
      <div class="modal-body">
        <form name="reviewForm">
		<table class="table reviewtable">
			<tr height='30'> 
				 <td align='left' >
				 	<span style='font-weight: bold;' >리뷰쓰기</span>
				 	<p> 주문한 상품 : <input type="text" name="orderDetail" id="orderDetail" readonly="readonly" style="width:70%;"> </p>
					 <input type="hidden" name="productNum" id="productNum1">
					 <input type="hidden" name="orderNum" id="orderNum">
					
				 </td>
			</tr>
			<tr>
				<td>
		  			<p class="star">
		      			<a href="#">★</a>
		       			<a href="#">★</a>
		       			<a href="#">★</a>
		       			<a href="#">★</a>
		       			<a href="#">★</a>
		   			</p>
					<input type="hidden" name="score" id="score" value="0">
			   </td>
			</tr>
			<tr>
			   	<td style='padding:5px 5px 0px;'>
					<textarea name="content" class='boxTA' style='width:99%; height: 70px;'></textarea>
			    </td>
			</tr>
		</table>
		</form>   


      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
		<button type='button' class='btn btn-primary btnSendReview' style='padding:10px 20px;'>리뷰 등록</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">리뷰 수정</h4>
      </div>
      <div class="modal-body reviewForm">
       

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
		<button type='button' class='btn btn-primary btnupdateReview' style='padding:10px 20px;'>수정 완료</button>
      </div>
    </div>
  </div>
</div>
    </div>
</div>