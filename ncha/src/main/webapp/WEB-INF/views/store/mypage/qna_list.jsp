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
//문의 답변 달기
$(function(){
	$(".submitQna").click(function(){
		var $tb = $(".qnatable");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		var url="${pageContext.request.contextPath}/qna/insertAnswer";
		var query=$("form[name=qnaForm]").serialize();
		
		var fn = function(data){
			$tb.find("textarea").val("");
			 
			var state=data.state;
			if(state==="true") {
				alert("답글이 등록되었습니다.");
				location.replace('${pageContext.request.contextPath}/store/mypage/qna'); 
			} else if(state==="false") {
				alert("답글이 등록되지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", "json", query, fn);
	});
});	
//문의 답변 수정
$(function(){
	$(".updateQna").click(function(){
		var $tb = $(".qnatable1");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		var url="${pageContext.request.contextPath}/qna/updateAnswer";
		var query=$("form[name=qnaForm1]").serialize();
		
		var fn = function(data){
			$tb.find("textarea").val("");
			 
			var state=data.state;
			if(state==="true") {
				alert("답글이 수정되었습니다.");
				location.replace('${pageContext.request.contextPath}/store/mypage/qna'); 
			} else if(state==="false") {
				alert("답글이 수정되지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", "json", query, fn);
	});
});	

$(function(){
	// 작성 모달에 데이터 전달
	$(".qnatitle").click(function(){
		var content = $(this).parent().children().eq(1).val();
		var subject = $(this).parent().children().eq(2).val();
		var qnaType = $(this).parent().children().eq(3).val();
		var qnaNum = $(this).parent().children().eq(4).val();
		
		$(".subject").text("");
		$(".content").text("");
		$(".qnaType").text("");
		$("#qnaNum").val("");
		
		$(".subject").text(subject);
		$(".content").text(content);
		$(".qnaType").text(qnaType);
		$("#qnaNum").val(qnaNum);
	});
	//수정 모달에 데이터 전달
	$(".updateqna1").click(function(){
		var content = $(this).parent().children().eq(2).val();
		var subject = $(this).parent().children().eq(3).val();
		var qnaType = $(this).parent().children().eq(4).val();
		var qnaNum = $(this).parent().children().eq(5).val();
		var replyContent = $(this).parent().children().eq(6).val();
		
		$(".subject1").text("");
		$(".content1").text("");
		$(".qnaType1").text("");
		$("#qnaNum1").val("");
		$("#replyContent").val("");
		
		$(".subject1").text(subject);
		$(".content1").text(content);
		$(".qnaType1").text(qnaType);
		$("#qnaNum1").val(qnaNum);
		$("#replyContent").val(replyContent);
	});
});

function deleteQna(qnaNum){
	if(!confirm("문의 답글을 삭제하시겠습니까?")){
		return;
	}
	var url="${pageContext.request.contextPath}/qna/deleteReply";
	var query="qnaNum="+qnaNum;
	var fn = function(data){
		if(data.state=="true"){
			alert("문의 답글이 삭제되었습니다.");
			location.replace('${pageContext.request.contextPath}/store/mypage/qna'); 
		} else if(state==="false") {
			alert("문의 답글을 삭제 하지 못했습니다.");
		}
	};
	ajaxFun(url, "post", "json", query, fn);
}
</script>
<Br>
        <ol class="breadcrumb">
      <li class="breadcrumb-item">MYPAGE</li>
      <li class="breadcrumb-item active">Q&A</li>
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
      	 <h2 class="mt-4 mb-3"> 문의내역 관리
      <small>Q&A 리스트</small>
    </h2>
    <p class="text-right">총 게시글 수 : ${dataCount}개  (${page}/${total_page} 페이지)</p>
<small><table class="table text-center">
	<thead>
		<tr>
			<th>상품명</th>
			<th>문의유형</th>
			<th>답변여부</th>
			<th>등록일자</th>
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="dto" items="${qnaList}">
		<tr>
			<td>${dto.productName}</td>
			<td>${dto.qnaType}</td>
			<td>${dto.status}</td>
			<td>${dto.create_date}</td>
			<td>
			<c:if test="${dto.status=='답변대기'}">
				<button class="btn btn-primary btn-xs qnatitle" data-toggle="modal" data-target="#myModal1">답변</button>
				<input type="hidden" value="${dto.content}" name="content">
				<input type="hidden" value="${dto.subject}" name="subject">
				<input type="hidden" value="${dto.qnaType}" name="qnaType">
				<input type="hidden" name="qnaNum" value="${dto.qnaNum}"> 
			</c:if>
			
			<c:if test="${dto.status=='답변완료'}">
				<button class="btn btn-info btn-xs updateqna1" data-toggle="modal" data-target="#myModal2" >수정</button>
				<button class="btn btn-danger btn-xs " onclick="deleteQna('${dto.qnaNum}')">삭제</button>
				<input type="hidden" value="${dto.content}" name="content">
				<input type="hidden" value="${dto.subject}" name="subject">
				<input type="hidden" value="${dto.qnaType}" name="qnaType">
				<input type="hidden" name="qnaNum" value="${dto.qnaNum}"> 
				<input type="hidden" name="replyContent" value="${dto.replyContent}"> 
			</c:if>
			</td>
		</tr>
	</c:forEach>
		
	</tbody>
</table></small>
      <p class="text-center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</p>
    
    
   	 </div>
    </div>
    
    <!-- 모달 : 글보기 -->
    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title updateQna" id="myModalLabel">문의 내역</h4>
	      </div>
	      <div class="modal-body qnaForm">
	       
	               <form name="qnaForm">
		<table class="table qnatable">
			<tr> 
				 <td>
					제목
				 </td>
				 <td class="subject">
				 </td>
			</tr>
			<tr>
				<td>
					질문 유형
			   </td>
				<td class="qnaType">
			   </td>
			</tr>
			<tr>
			   	<td>
			   		내용
			    </td>
			   	<td class="content">
			    </td>
			</tr>
			<tr>
			   	<td colspan="2" class="text-center">
			   		답변 작성
			    </td>
			</tr>
			<tr>
			   	<td >
			   		답변
			    </td>
			   	<td >
					<textarea class="form-control" name="content"></textarea>
					<input type="hidden" name="qnaNum" id="qnaNum">
			    </td>
			</tr>
		
		
		</table>
		</form>   
	
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			<button type='button' class='btn btn-primary submitQna' style='padding:10px 20px;'>작성완료</button>
	      </div>
	    </div>
	  </div>
	</div>
	
    <!-- 모달 : 글보기 -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title updateQna" id="myModalLabel">문의 내역</h4>
	      </div>
	      <div class="modal-body qnaForm1">
	       
	               <form name="qnaForm1">
		<table class="table qnatable1">
			<tr> 
				 <td>
					제목
				 </td>
				 <td class="subject1">
				 </td>
			</tr>
			<tr>
				<td>
					질문 유형
			   </td>
				<td class="qnaType1">
			   </td>
			</tr>
			<tr>
			   	<td>
			   		내용
			    </td>
			   	<td class="content1">
			    </td>
			</tr>
			<tr>
			   	<td colspan="2" class="text-center">
			   		답변 작성
			    </td>
			</tr>
			<tr>
			   	<td >
			   		답변
			    </td>
			   	<td >
					<textarea class="form-control" name="content" id="replyContent"></textarea>
					<input type="hidden" name="qnaNum" id="qnaNum1">
			    </td>
			</tr>
		
		
		</table>
		</form>   
	
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			<button type='button' class='btn btn-primary updateQna' style='padding:10px 20px;'>수정완료</button>
	      </div>
	    </div>
	  </div>
	</div>