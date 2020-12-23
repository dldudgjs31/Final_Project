<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
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
</style>

<script type="text/javascript">
function deleteBoard(num) {
	<c:if test="${sessionScope.seller.sellerId==dto.sellerId || sessionScope.member.userId=='admin'}">
	if(confirm("게시물을 삭제 하시겠습니까 ?")) {
		var q = "num=" +${dto.productNum} + "&${query}";
		var url="${pageContext.request.contextPath}/store/delete?"+q;
		location.href=url;
	}
	</c:if>
	<c:if test="${sessionScope.seller.sellerId!=dto.sellerId && sessionScope.member.userId!='admin'}">
		alert("게시글을 삭제할 수 없습니다.");
	</c:if>
}



function updateBoard(num){
	<c:if test="${sessionScope.seller.sellerId==dto.sellerId}">
		var q="num="+${dto.productNum}+"&page=${page}";
		var url="${pageContext.request.contextPath}/store/update?"+q;
		location.href=url;
	</c:if>
	<c:if test="${sessionScope.seller.sellerId!=dto.sellerId}">
		alert("게시글을 수정할 수 없습니다.");
	</c:if>
}


</script>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}
</script>
<div class="body-container" style="width: 700px;">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard"></i> 자유 게시판 </h3>
	</div>

	<div>
		<table style="width: 100%; margin-top: 20px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="center">
					${dto.productName}
				</td>
			</tr>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td width="50%" align="left" style="padding-left: 5px;">
					이름 : ${dto.sellerId}
				</td>
				<td width="50%" align="right" style="padding-right: 5px;">
					${dto.created_date } | 조회 ${dto.hitCount}
				</td>
			</tr>
			
			<tr >
				<td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
					${dto.detail}
				</td>
			</tr>

<%-- 			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					첨부 :
					<c:if test="${not empty dto.saveFilename}">
						<a href="${pageContext.request.contextPath}/bbs/downlaod?num=${dto.num}">${dto.originalFilename}</a>
					</c:if>
					
				</td>
			</tr>
 --%>
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					이전글 : 
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/store/article?${query}&num=${preReadDto.productNum}">${preReadDto.productName}</a>
					</c:if>
					
				</td>
			</tr>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/store/article?${query}&num=${nextReadDto.productNum}">${nextReadDto.productName}</a>
					</c:if>
				</td>
			</tr>
		</table>

		<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
				<td width="300" align="left">
					<button type="button" class="btn" onclick="updateBoard('${dto.productNum}');">수정</button>
					<button type="button" class="btn" onclick="deleteBoard('${dto.productNum}');">삭제</button>
				</td>

				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/store/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
	</div>
	
<div class="body-container" style="width: 700px;">

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
	var query = "productNum=3&pageNo="+page;
	
	var fn = function(data){
		$("#listReview").html(data);
	};
	
	ajaxFun(url, "get", "html", query, fn);
}

//리뷰 등록
$(function(){
	$(".btnSendReview").click(function(){
		//var productNum="${dto.productNum}";
		var productNum="3";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		var url="${pageContext.request.contextPath}/review/insertReview";
		var query=$("form[name=reviewForm]").serialize();
		query+="&productNum="+productNum;
		
		var fn = function(data){
			$tb.find("textarea").val("");
			$("form[name=reviewForm] input[name=score]").val("0");
			$( ".star a" ).removeClass("on");
			 
			var state=data.state;
			if(state==="true") {
				listPage(1);
			} else if(state==="false") {
				alert("리뷰을 추가 하지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", "json", query, fn);
	});
});

</script>

    <div>
        <form name="reviewForm">
		<table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
			<tr height='30'> 
				 <td align='left' >
				 	<span style='font-weight: bold;' >리뷰쓰기</span>
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
			<tr>
			   <td align='right'>
			        <button type='button' class='btn btnSendReview' style='padding:10px 20px;'>리뷰 등록</button>
			    </td>
			 </tr>
		</table>
		</form>     
		<div id="listReview"></div>
    
    </div>
</div>

<table style='width: 100%; margin: 10px auto 30px; border-spacing: 0px;'>
	<thead id='listReviewHeader'>
		<tr height='35'>
		    <td colspan='2'>
		       <div style='clear: both;'>
		           <div style='float: left;'><span>[리뷰 목록]</span></div>
		           <div style='float: right; text-align: right;'>전체평점 : <fmt:formatNumber value="${reviewScore}" pattern="0.0"/></div>
		       </div>
		    </td>
		</tr>
	</thead>
	
	<tbody id='listReviewBody'>
		<c:forEach var="vo" items="${list}">
	    <tr height='35' style='background: #eeeeee;'>
	       <td width='50%' style='padding:5px 5px; border:1px solid #cccccc; border-right:none;'>
	           <span><b>${vo.userName}</b></span>
	        </td>
	       <td width='50%' style='padding:5px 5px; border:1px solid #cccccc; border-left:none;' align='right'>
	           <span><c:forEach var="score" items="${ratingOptions}" varStatus="status" begin="1" end="${vo.score}">★</c:forEach></span> |
	           <span>${vo.created_date}</span>
	        </td>
	    </tr>
	    <tr>
	        <td colspan='2' valign='top' style='padding:5px 5px;'>
	              ${vo.content}
	        </td>
	    </tr>
	</c:forEach>
	</tbody>
	
	<tfoot id='listReviewFooter'>
		<tr height='40' align="center">
            <td colspan='2' >
              ${paging}
            </td>
           </tr>
	</tfoot>
</table>

</div>