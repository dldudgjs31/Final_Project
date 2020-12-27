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
.slick-prev{
	color: gray;
}

.slick-next{
	color: gray;
}
</style>
<script type="text/javascript">
function updateForm(usedNum, page){
	<c:if test="${sessionScope.member.userId == dto.userId}">
		var q = "usedNum="+usedNum+"&page="+page;
		location.href = "${pageContext.request.contextPath}/used/update?"+q;
	</c:if>
	<c:if test="${sessionScope.member.userId != dto.userId}">
		alert("게시글을 수정할 수 없습니다.");
	</c:if>
}

function deleteBoard(usedNum,page){
	<c:if test="${sessionScope.member.userId == dto.userId || sessionScope.member.userId=='admin'}">
		var q = "usedNum="+usedNum+"&page="+page;
		location.href = "${pageContext.request.contextPath}/used/delete?"+q;
	</c:if>
}

function goList(page){
	location.href = "${pageContext.request.contextPath}/used/list?page="+page;
}

//jqXHR : jQuery XMLHttpRequest, jqXHR객체는 $.ajax () 함수에 의해 반환
function ajaxJSON(url, method, query, fn){
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:"json",
		success:function(data){
			fn(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX",true);
		},
		error:function(jqXHR){
			if(jqXHR.status === 403){
				login();
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

function ajaxHTML(url, method, query, selector){
	$.ajax({
		type: method,
		url : url,
		data: query,
		success:function(data){
			$(selector).html(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX",true);
		},
		error:function(jqXHR){
			if(jqXHR.status===403){
				login();
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});	
}

//중고글 공감버튼
$(function(){
	$(".btnSendUsedLike").click(function(){
		if(! confirm("게시글을 좋아요 하시겠습니까?")){
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/used/insertUsedLike";
		var usedNum = "${dto.usedNum}";
		var query = "usedNum="+usedNum;
		
		var fn = function(data){
			var state=data.state;
			if(state==="true"){
				var count = data.usedLikeCount;
				$("#usedLikeCount").text(count);
			}else if(state==="false"){
				alert("좋아요는 한번만 가능합니다");
			}
		};
		ajaxJSON(url,"post",query,fn);
	});
});


//댓글 페이징처리
$(function(){
	listPage(1);
});

function listPage(page){
	var url = "${pageContext.request.contextPath}/used/listReply";
	var query = "usedNum=${dto.usedNum}&page="+page;
	var selector = "#listReply";
	
	ajaxHTML(url,"get",query,selector);
}

//댓글 등록
$(function(){
	$(".btnSendReply").click(function(){
		var usedNum = "${dto.usedNum}";
		var $tb = $(this).closest("table");
		var content =$tb.find("textarea").val().trim();
		if(! content){
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url = "${pageContext.request.contextPath}/used/insertReply";
		var query = "usedNum="+usedNum+"&content="+content+"&answer=0";
		
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var state = data.state;
			if(state==="true"){
				listPage(1);
			} else if(state==="false"){
				alert("댓글을 추가하지 못했습니다.");
			}
		};
		
		ajaxJSON(url,"post",query,fn);
	});
});

//댓글 삭제
$(function(){
	$("body").on("click",".deleteReply",function(){
		if(! confirm("댓글을 삭제하시겠습니까?")){
			return false;
		}
		
		var used_reviewNum = $(this).attr("data-used_reviewNum");
		var page = $(this).attr("data-page");
		
		var url = "${pageContext.request.contextPath}/used/deleteReply";
		var query="used_reviewNum="+used_reviewNum+"&mode=reply";
		
		var fn = function(data){
			listPage(page);
		};
		
		ajaxJSON(url,"post",query,fn);
	});
});

//댓글 좋아요 등록
$(function(){
	$("body").on("click",".btnSendReplyLike",function(){
		var used_reviewNum= $(this).attr("data-used_reviewNum");
		var replyLike = $(this).attr("data-replyLike");
	
		var msg = "댓글을 좋아요 하시겠습니까?";
		if(replyLike === 1){
			msg = "댓글을 좋아요 하시겠습니까?";
		}
		if(! confirm(msg)){
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/used/insertReplyLike";
		var query = "used_reviewNum="+used_reviewNum+"&replyLike="+replyLike;
		
		var fn = function(data){
			var state = data.state;
			if(state==="true"){
				var likeCount = data.likeCount;
				$("#usedReplyLikeCount").text(likeCount);
			}else if(state==="false"){
				alert("좋아요는 한번만 가능합니다.");
			}
		};
		ajaxJSON(url,"post",query,fn);
	});
});

//대댓글
//대댓글 리스트
function listReplyAnswer(answer){
	var url = "${pageContext.request.contextPath}/used/listReplyAnswer";
	var query = "answer="+answer;
	var selector = "#listReplyAnswer"+answer;
	
	ajaxHTML(url,"get", query,selector);
}

//대댓글 개수
function replyAnswerCount(answer){
	var url = "${pageContext.request.contextPath}/used/replyAnswerCount";
	var query = "answer="+answer;
	
	var fn = function(data){
		var count = data.count;
		var vid = "#answerCount"+answer;
		$(vid).html(count);
	};
	ajaxJSON(url,"post",query,fn);
}

//대댓글 버튼(대댓글 등록폼 및 대댓글 리스트)
$(function(){
	$("body").on("click",".btnReplyAnswerLayout",function(){
		var $trReplyAnswer = $(this).closest("tr").next();
		
		var isVisible = $trReplyAnswer.is(':visible');
		var used_reviewNum = $(this).attr("data-used_reviewNum");
		
		if(isVisible){
			$trReplyAnswer.hide();
		}else{
			$trReplyAnswer.show();
			
			//답글리스트
			listReplyAnswer(used_reviewNum);
			
			//답글 개수
			replyAnswerCount(used_reviewNum);
		}
	});
});

//대댓글 등록
//trim 문자열 공백제거 
$(function(){
	$("body").on("click",".btnSendReplyAnswer", function(){
		var usedNum = "${dto.usedNum}";
		var used_reviewNum = $(this).attr("data-used_reviewNum");
		var $td = $(this).closest("td");
		
		var content = $td.find("textarea").val().trim();
		if(!content){
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url = "${pageContext.request.contextPath}/used/insertReply";
		var query = "usedNum="+usedNum+"&content="+content+"&answer="+used_reviewNum;
		
		var fn = function(data){
			$td.find("textarea").val("");
			
			var state = data.state;
			if(state==="true"){
				//답글리스트
				listReplyAnswer(used_reviewNum);
				
				//답글 개수
				replyAnswerCount(used_reviewNum);
			}
		};
		
		ajaxJSON(url,"post",query,fn);
	});
});


//대댓글 삭제
$(function(){
	$("body").on("click",".deleteReplyAnswer", function(){
		if(!confirm("댓글을 삭제하시겠습니까?")){
			return;
		}
		
		var used_reviewNum = $(this).attr("data-used_reviewNum");
		var answer = $(this).attr("data-answer");
		
		var url = "${pageContext.request.contextPath}/used/deleteReply";
		var query = "used_reviewNum="+used_reviewNum+"&mode=answer";
		
		var fn = function(data){
			//답글리스트
			listReplyAnswer(answer);
			
			//답글 개수
			replyAnswerCount(answer);
		};
		ajaxJSON(url,"post",query,fn);
	});
});


</script>

<div class="body-container" style="width: 700px;">
	
	<div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="center" style="padding-left: 50px;">
			      ${dto.subject}
			    </td>
			    <td width="50%" align="right" style="padding-right: 5px;">
			        ${dto.created_date} | 조회 ${dto.hitCount}
			    </td>
			</tr>
		</table>
		
		<div id="slick-items" style="padding:10px 10px;">
			<c:forEach var="vo" items="${imageList}">
				<c:if test="${vo.usedNum == dto.usedNum}">
	        		<div  class="slider-image" style="background-image: url('${pageContext.request.contextPath}/uploads/used/${vo.imageFilename}');"></div>
				</c:if>  
			</c:forEach>
	    </div>
	    
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">	
			<tr style="border-bottom: 1px solid #cccccc;">
				<td align="center" class="btnSendUsedLike">
					<img alt="좋아요버튼" src="${pageContext.request.contextPath}/resources/images/heart.png" style="height: 25px; width: 25px">
					<span id="usedLikeCount">${usedLikeCount}</span>
				</td>
			</tr>
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="left" style="padding-left: 5px;">
			     카테고리 :${dto.categoryName}  
			  </td>
			</tr>
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="left" style="padding-left: 5px;">
			     가격 : ￦ ${dto.price}  
			  </td>
			</tr>
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="left" style="padding-left: 5px;">
			     상품상태 : ${dto.productCondition}  
			  </td>
			</tr>
			<tr style="border-bottom: 1px solid #cccccc;">
			 <td colspan="2" align="left" style="padding-left: 5px;">
			     결제방법 : ${dto.dealingMode}  
			  </td>
			</tr>
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="left" style="padding-left: 5px;">
			     거래지역 : ${dto.location}  
			  </td>
			</tr>
			
			<tr height="100" style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" >
			      ${dto.content}
			   </td>
			</tr>
			
			
			<tr height="30" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       이전글 :
			        <c:if test="${not empty preReadDto}">
			            <a href="${pageContext.request.contextPath}/used/article?${query}&usedNum=${preReadDto.usedNum}">${preReadDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="30" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       다음글 :
			        <c:if test="${not empty nextReadDto}">
			            <a href="${pageContext.request.contextPath}/used/article?${query}&usedNum=${nextReadDto.usedNum}">${nextReadDto.subject}</a>
			        </c:if>
			     </td>
			</tr>
		</table>
	
	
		<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
		    <td width="300" align="left">
		        <c:if test="${sessionScope.member.userId==dto.userId}">
		            <button type="button" class="btn" onclick="updateForm('${dto.usedNum}','${page}');">수정</button>
		        </c:if>
		        <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
		            <button type="button" class="btn" onclick="deleteBoard('${dto.usedNum}','${page}');">삭제</button>
		        </c:if>
		    </td>
		
		    <td align="right">
		        <button type="button" class="btn" onclick="goList('${page}');">리스트</button>
		    </td>
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
 		<div id="listReply"></div>
 	</div>
 	
</div>

<script type="text/javascript">

$('#slick-items').slick({
	slide: 'div',		//슬라이드 되어야 할 태그 ex) div, li 
	infinite : true, 	//무한 반복 옵션	 
	slidesToShow : 1,		// 한 화면에 보여질 컨텐츠 개수
	slidesToScroll : 1,		//스크롤 한번에 움직일 컨텐츠 개수
	speed : 100,	 // 다음 버튼 누르고 다음 화면 뜨는데까지 걸리는 시간(ms)
	arrows : true, 		// 옆으로 이동하는 화살표 표시 여부
	dots : true, 		// 스크롤바 아래 점으로 페이지네이션 여부
	autoplay : false,			// 자동 스크롤 사용 여부
	autoplaySpeed : 100, 		// 자동 스크롤 시 다음으로 넘어가는데 걸리는 시간 (ms)
	pauseOnHover : true,		// 슬라이드 이동	시 마우스 호버하면 슬라이더 멈추게 설정
	vertical : false,		// 세로 방향 슬라이드 옵션
	prevArrow : "<button type='button' class='slick-prev' style='background-color:black;'></button>",// 이전 화살표 모양 설정
	nextArrow : "<button type='button' class='slick-next' style='background-color:black;'></button>",// 다음 화살표 모양 설정
	dotsClass : "slick-dots", 	//아래 나오는 페이지네이션(점) css class 지정
	draggable : true, 	//드래그 가능 여부 
	
	responsive: [ // 반응형 웹 구현 옵션
		{  
			breakpoint: 960, //화면 사이즈 960px
			settings: {
				//위에 옵션이 디폴트 , 여기에 추가하면 그걸로 변경
				slidesToShow:1 
			} 
		},
		{ 
			breakpoint: 768, //화면 사이즈 768px
			settings: {	
				//위에 옵션이 디폴트 , 여기에 추가하면 그걸로 변경
				slidesToShow:1 
			} 
		}
	]
	
});
</script>