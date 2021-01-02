<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<p class="text-right">총 게시글 수 : ${dataCount}개  (${page}/${total_page} 페이지)</p>
<table class="table text-center">
	<thead>
		<tr>
			<th>글번호</th>
			<th>답변여부</th>
			<th>질문유형</th>
			<th width="50%">제목</th>
			<th>작성자</th>
			<th>등록일자</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="dto" items="${qnaList}">
		<tr>
			<td>${dto.listNum}</td>
			<td>${dto.status}</td>
			<td>${dto.qnaType}</td>
			<td width="50%">${dto.subject}</td>
			<td>${dto.userId}</td>
			<td>${dto.create_date}</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
  <p class="text-center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</p>
<p class="text-right"><button type="button" data-toggle="modal" data-target="#myModal" class="btn btn-primary">글올리기</button></p>


    <!--modal  -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">문의 작성</h4>
	      </div>
	      <div class="modal-body qnaForm">
	       
	               <form name="qnaForm">
		<table class="table qnatable">
			<tr> 
				 <td >
					제목
				 </td>
				 <td >
					<input class="form-control" type="text" name="subject" style="width: 100%;">
					<input type="hidden" name="productNum" value="${productNum}">
				 </td>
			</tr>
			<tr>
				<td>
					질문 유형
			   </td>
				<td>
					<select class="selectField form-control" name="qnaType">
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
					<textarea class="form-control" name="content"></textarea>
			    </td>
			</tr>
		</table>
		</form>   
	
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			<button type='button' class='btn btn-primary createQna' style='padding:10px 20px;'>작성완료</button>
	      </div>
	    </div>
	  </div>
	</div>

<script type="text/javascript">
function createQna(productNum){
	var url = "${pageContext.request.contextPath}/qna/insert";
	var query = "productNum="+productNum;
	
	var fn = function(data){
		$(".qnaForm").html(data);
	};
	
	ajaxFun(url, "get", "html", query, fn);
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

$(function(){
	$(".createQna").click(function(){
		var $tb = $(".qnatable");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		var url="${pageContext.request.contextPath}/qna/insert";
		var query=$("form[name=qnaForm]").serialize();
		
		var fn = function(data){
			$tb.find("textarea").val("");
			 
			var state=data.state;
			if(state==="true") {
				alert("문의내역이 등록되었습니다.");
				location.replace('${pageContext.request.contextPath}/store/article?num=${productNum}&page=${page}'); 
			} else if(state==="false") {
				alert("문의내역을 추가 하지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", "json", query, fn);
	});
});	
</script>