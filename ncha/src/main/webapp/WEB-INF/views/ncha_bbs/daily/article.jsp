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
</script>

<div class="body-container" style="width: 700px;">
	<div class="profile-img">
   		<div class="imgs" style="background-image:url('${pageContext.request.contextPath}/uploads/member/${dto.profile_imageFilename}'); border-bottom: 1px solid #cccccc;">
   		</div><span class="userId">&nbsp; ${dto.userId}</span>
   	</div>
   	

    <div class="slick-items" style="height: 450px;">
		<c:forEach var="vo" items="${list1}">
			<c:if test="${vo.dailyNum == dto.dailyNum}">
			      <div  class="slider-image" style="background-image: url('${pageContext.request.contextPath}/uploads/daily/${vo.imageFilename}');"></div>
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
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/daily/list?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
    </div>
</div>
<script type="text/javascript">

$(document).ready(function () {

	//alert('123');

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