<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick.css" />
<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick-theme.css" />
<script type="text/javascript" src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script>
<style type="text/css">
.slick-items{
	width: 99%;
}

.slider-image{
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
	height: 450px;
}

.profile-img{
	grid-area:img;
	display: flex;
	justify-content: center;
	align-items: left;
}
.imgs{
	width: 100px; 
	height: 100px; 
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
	border-radius: 50%;
	border: 1px solid silver;
}
.userId{
	font-weight: bold;
	font-size: 18px;
}


</style>

<script type="text/javascript">
function searchProfile(userId) {
	var url="${pageContext.request.contextPath}/mypage/searchProfile?userId="+userId;
		location.href=url;
	
}
function deleteDaily(dailyNum) {
	<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin' }">
		if(confirm("게시물을 삭제 하시겠습니까 ?")) {
			var q="dailyNum="+dailyNum+"&${query}";
			var url="${pageContext.request.contextPath}/daily/delete?"+q;
			location.href=url;
		}
	</c:if>

	<c:if test="${sessionScope.member.userId!=dto.userId && sessionScope.member.userId!='admin' }">
		alert("게시글을 삭제할 수 없습니다.");
	</c:if>
	}

function updateDaily(dailyNum) {
<c:if test="${sessionScope.member.userId==dto.userId}">
	var q="dailyNum="+dailyNum+"&page=${page}";
	var url="${pageContext.request.contextPath}/daily/update?"+q;
	location.href=url;
</c:if>
<c:if test="${sessionScope.member.userId!=dto.userId}">
	alert("게시글을 수정할 수 없습니다.");
</c:if>
}



// 댓글 및 답글, 좋아요처리
function ajaxJSON(url, method, query, fn) {
	$.ajax({
		type:method
		,url:url
		,data:query
		,dataType:"json"
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

function ajaxHTML(url, method, query, selector) {
	$.ajax({
		type:method
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
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

// 게시글 공감 여부
$(function(){
	$(".btnSendDailyLike").click(function(){
		if(! confirm("게시물에 공감 하십니까 ? ")) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/daily/insertDailyLike";
		var dailyNum="${dto.dailyNum}";
		var query="dailyNum="+dailyNum;
		
		var fn = function(data){
			var state=data.state;
			if(state==="true") {
				var count = data.dailyLikeCount;
				$("#dailyLikeCount").text(count);
			} else if(state==="false") {
				alert("좋아요는 한번만 가능합니다. !!!");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

// 페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "${pageContext.request.contextPath}/daily/listReply";
	var query = "dailyNum=${dto.dailyNum}&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url, "get", query, selector);
}

// 리플 등록
$(function(){
	$(".btnSendReply").click(function(){
		var dailyNum="${dto.dailyNum}";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/daily/insertReply";
		var query="dailyNum="+dailyNum+"&content="+content+"&answer=0";
		
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var state=data.state;
			if(state==="true") {
				listPage(1);
			} else if(state==="false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});


// 댓글 삭제
$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var daily_replyNum=$(this).attr("data-daily_replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="${pageContext.request.contextPath}/daily/deleteReply";
		var query="daily_replyNum="+daily_replyNum+"&mode=reply";
		
		var fn = function(data){
			listPage(page);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

// 댓글 좋아요 / 싫어요
$(function(){
	// 댓글 좋아요 / 싫어요 등록
	$("body").on("click", ".btnSendReplyLike", function(){		
		var daily_replyNum=$(this).attr("data-daily_replyNum");
		var replyLike=$(this).attr("data-replyLike");
		var $btn = $(this);
		var msg = "";
		
		if(replyLike==='1') {
			msg="추 천 ?";
		}else {
			msg="비 추 천 ?";
		}
		
		if(! confirm(msg)) {
			return false;
		}
		var url="${pageContext.request.contextPath}/daily/insertReplyLike";
		var query="daily_replyNum="+daily_replyNum+"&replyLike="+replyLike;
		
		var fn = function(data){
			var state=data.state;
			if(state==="true") {
				var likeCount=data.likeCount;
				var disLikeCount=data.disLikeCount;
				
				$btn.parent("td").children().eq(0).find("span").html(likeCount);
				$btn.parent("td").children().eq(1).find("span").html(disLikeCount);
			} else if(state==="false") {
				alert("게시물 공감 여부는 한번만 가능합니다. !!!");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

// 댓글별 답글 리스트
function listReplyAnswer(answer) {
	var url="${pageContext.request.contextPath}/daily/listReplyAnswer";
	var query="answer="+answer;
	var selector="#listReplyAnswer"+answer;
	
	ajaxHTML(url, "get", query, selector);
}

// 댓글별 답글 개수
function countReplyAnswer(answer) {
	var url="${pageContext.request.contextPath}/daily/countReplyAnswer";
	var query="answer="+answer;
	
	var fn = function(data){
		var count=data.count;
		var vid="#answerCount"+answer;
		$(vid).html(count);
	};
	
	ajaxJSON(url, "post", query, fn);
}

// 답글 버튼(댓글별 답글 등록폼 및 답글리스트)
$(function(){
	$("body").on("click", ".btnReplyAnswerLayout", function(){
		var $trReplyAnswer = $(this).closest("tr").next();
		
		var isVisible = $trReplyAnswer.is(':visible');
		var daily_replyNum = $(this).attr("data-daily_replyNum");
			
		if(isVisible) {
			$trReplyAnswer.hide();
		} else {
			$trReplyAnswer.show();
            
			// 답글 리스트
			listReplyAnswer(daily_replyNum);
			
			// 답글 개수
			countReplyAnswer(daily_replyNum);
		}
	});
	
});

// 댓글별 답글 등록
$(function(){
	$("body").on("click", ".btnSendReplyAnswer", function(){
		var dailyNum="${dto.dailyNum}";
		var daily_replyNum=$(this).attr("data-daily_replyNum");
		var $td=$(this).closest("td");
		
		var content=$td.find("textarea").val().trim();
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/daily/insertReply";
		var query="dailyNum="+dailyNum+"&content="+content+"&answer="+daily_replyNum;
		
		var fn = function(data){
			$td.find("textarea").val("");
			
			var state=data.state;
			if(state==="true") {
				listReplyAnswer(daily_replyNum);
				countReplyAnswer(daily_replyNum);
			}
		};
		
		ajaxJSON(url, "post", query, fn);
		
	});
});

// 댓글별 답글 삭제
$(function(){
	$("body").on("click", ".deleteReplyAnswer", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? ")) {
		    return;
		}
		
		var daily_replyNum=$(this).attr("data-daily_replyNum");
		var answer=$(this).attr("data-answer");
		
		var url="${pageContext.request.contextPath}/daily/deleteReply";
		var query="daily_replyNum="+daily_replyNum+"&mode=answer";
		
		var fn = function(data){
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});


</script>

<div class="body-container" style="width: 700px;">
	<div class="profile-img">
   		<div class="imgs" style="background-image:url('${pageContext.request.contextPath}/uploads/member/${dto.profile_imageFilename}'); border-bottom: 1px solid #cccccc;">
   		</div><a href="javascript:searchProfile('${dto.userId}')">${dto.userId}</a>
   	</div>
   	

    <div class="slick-items" style="height: 450px;">
		<c:forEach var="vo" items="${list1}">
			<c:if test="${vo.dailyNum == dto.dailyNum}">
			      <div  class="slider-image">
			      	<img alt="" src="${pageContext.request.contextPath}/uploads/daily/${vo.imageFilename}" height="450px" width="693px">
			      </div>
			</c:if>  
		</c:forEach>
    </div>
     <div>
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style=" border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="center">
				   ${dto.subject}
			    </td>
			</tr>
			
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
			      ${dto.content}
			   </td>
			</tr>
			<tr>
			    <td width="50%" align="right" style="padding-right: 5px;">
			        ${dto.created_date} | 조회 ${dto.hitCount} | 카테고리 : ${dto.categoryName}
			    </td>
			</tr>
			
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       이전글 :
			         <c:if test="${not empty preReadDto}">
			              <a href="${pageContext.request.contextPath}/daily/article?${query}&dailyNum=${preReadDto.dailyNum}">${preReadDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       다음글 :
			         <c:if test="${not empty nextReadDto}">
			              <a href="${pageContext.request.contextPath}/daily/article?${query}&dailyNum=${nextReadDto.dailyNum}">${nextReadDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			    <td width="300" align="left">
			       <c:if test="${sessionScope.member.userId==dto.userId}">				    
			          <button type="button" class="btn" onclick="updateDaily('${dto.dailyNum}');">수정</button>
			       </c:if>
			       <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">				    
			          <button type="button" class="btn" onclick="deleteDaily('${dto.dailyNum}');">삭제</button>
			       </c:if>
			    </td>
			
				<td align="center" class="btnSendDailyLike">
					<img alt="좋아요버튼" src="${pageContext.request.contextPath}/resources/images/heart.png" style="height: 25px; width: 25px">
					<span id="dailyLikeCount">${dto.dailyLikeCount}</span>
				</td>
			
			<c:if test="${mode=='mypage'}">
			    <td align="right">
			       <a href="javascript:searchProfile('${dto.userId}')">마이페이지</a>
			    </td>
			</c:if>
			<c:if test="${mode!='mypage'}">
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/daily/list?${query}';">리스트</button>
			    </td>
			</c:if>
			</tr>
			</table>
			
    </div>
    
    <div>
   		 <table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
			<tr height='30'> 
				 <td align='left' >
				 	<span style='font-weight: bold;' >댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
				 </td>
			</tr>
			<tr>
			   	<td style='padding:5px 5px 0px;'>
					<textarea class='boxTA' style='width:99%; height: 70px;'></textarea>
			    </td>
			</tr>
			<tr>
			   <td align='right'>
			        <button type='button' class='btn btnSendReply' style='padding:10px 20px;'>댓글 등록</button>
			    </td>
			 </tr>
		 </table>
    		
    </div>
		 <div id="listReply"></div>
</div>
<script type="text/javascript">

$(document).ready(function () {


	$('.slick-items').slick({
		autoplay : true,
		dots: true,
		speed : 300 /* 이미지가 슬라이딩시 걸리는 시간 */,
		infinite: true,
		autoplaySpeed: 3000 /* 이미지가 다른 이미지로 넘어 갈때의 텀 */,
		arrows: true,
		slidesToShow: 1,
		slidesToScroll: 1,
		fade: false
	});
});

</script>