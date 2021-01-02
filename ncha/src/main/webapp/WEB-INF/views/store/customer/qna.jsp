<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style type="text/css">
.btn{
	font-family : 'Jua', sans-serif;
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

//문의내역 삭제
function deleteQna(qnaNum){
	if(!confirm("문의내역을 삭제하시겠습니까?")){
		return;
	}
	var url="${pageContext.request.contextPath}/qna/delete";
	var query="qnaNum="+qnaNum;
	var fn = function(data){
		if(data.state=="true"){
			alert("문의내역이 삭제되었습니다.");
			location.replace('${pageContext.request.contextPath}/qna/mypage/qnalist'); 
		} else if(state==="false") {
			alert("문의내역을 삭제 하지 못했습니다.");
		}
	};
	ajaxFun(url, "post", "json", query, fn);
}

$(function(){
	$(".updateQna").click(function(){
		var subject = $(this).parent().children().eq(2).val();
		var qnaNum = $(this).parent().children().eq(3).val();
		var qnaType = $(this).parent().children().eq(4).val();
		var content = $(this).parent().children().eq(5).val();
		$(".subject").val(subject);
		$(".content").val(content);
		
		$("#qnaNum").val(qnaNum);
	});
});

$(function(){
	$(".submitQna").click(function(){
		var $tb = $(".qnatable");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		var url="${pageContext.request.contextPath}/qna/update";
		var query=$("form[name=qnaForm]").serialize();
		
		var fn = function(data){
			$tb.find("textarea").val("");
			 
			var state=data.state;
			if(state==="true") {
				alert("문의내역이 수정되었습니다.");
				location.replace('${pageContext.request.contextPath}/qna/mypage/qnalist'); 
			} else if(state==="false") {
				alert("문의내역을 수정 하지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", "json", query, fn);
	});
});	
</script>
<Br>
        <ol class="breadcrumb">
      <li class="breadcrumb-item">MYPAGE</li>
      <li class="breadcrumb-item active">장바구니</li>
    </ol>
    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-xs-6 col-md-4">
        <div class="list-group">
	          <a href="${pageContext.request.contextPath}/store/customer/mypage" class="list-group-item">메인</a>
	          <a href="${pageContext.request.contextPath}/store/customer/cartlist" class="list-group-item">장바구니</a>
	          <a href="${pageContext.request.contextPath}/store/customer/cartlist" class="list-group-item">주문내역</a>
	          <a href="${pageContext.request.contextPath}/store/customer/review" class="list-group-item">REVIEW</a>
	          <a href="${pageContext.request.contextPath}/qna/mypage/qnalist" class="list-group-item">Q&A</a>
        </div>
      </div>
      <!-- Content Column -->

      <div class="col-xs-12 col-md-8">
      	 <h2 class="mt-4 mb-3">Q&A
      <small>문의 내역</small>
    </h2>
    
    <p class="text-right">총 게시글 수 : ${dataCount}개  (${page}/${total_page} 페이지)</p>
<small><table class="table text-center">
	<thead>
		<tr>
			<th>상품명</th>
			<th>답변여부</th>
			<th >제목</th>
			<th>등록일자</th>
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="dto" items="${qnaList}">
		<tr>
			<td>${dto.productName}</td>
			<td>${dto.status}</td>
			<td width="30%">[${dto.qnaType}] ${dto.subject}</td>
			<td>${dto.create_date}</td>
			<td>
				<button class="btn btn-primary btn-xs updateQna" data-toggle="modal" data-target="#myModal">수정</button>
				<button class="btn btn-danger btn-xs" onclick="deleteQna('${dto.qnaNum}')">삭제</button>
				<input type="hidden" name="subject" value="${dto.subject}">
				<input type="hidden" name="qnaNum" value="${dto.qnaNum}">
				<input type="hidden" name="qnaType" value="${dto.qnaType}">
				<input type="hidden" name="content" value="${dto.content}">
			</td>
		</tr>
		
	</c:forEach>
	</tbody>
</table></small>
  <p class="text-center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</p>
    
      </div>
      
      
          <!--modal  -->
		
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title updateQna" id="myModalLabel">문의 수정</h4>
	      </div>
	      <div class="modal-body qnaForm">
	       
	               <form name="qnaForm">
		<table class="table qnatable">
			<tr> 
				 <td >
					제목
				 </td>
				 <td >
					<input class="form-control subject" type="text" name="subject" style="width: 100%;">
					<input type="hidden" id="qnaNum" name="qnaNum">
				 </td>
			</tr>
			<tr>
				<td>
					질문 유형
			   </td>
				<td>
					<select class="selectField form-control qnaType" name="qnaType">
						<option value="사이즈">사이즈</option>
						<option value="배송">배송</option>
						<option value="재입고">재입고</option>
						<option value="기타">기타</option>
					</select>
			   </td>
			</tr>
			<tr>
			   	<td>
			   		내용
			    </td>
			   	<td>
					<textarea class="form-control content" name="content"></textarea>
			    </td>
			</tr>
		</table>
		</form>   
	
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			<button type='button' class='btn btn-primary submitQna' style='padding:10px 20px;'>수정완료</button>
	      </div>
	    </div>
	  </div>
	</div>
      