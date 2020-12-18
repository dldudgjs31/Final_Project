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


<div class="body-container" style="width: 700px;">

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
		<c:forEach var="vo" items="${images}">
			<c:if test="${vo.usedNum == dto.usedNum}">
        		<div  class="slider-image" style="background-image: url('${pageContext.request.contextPath}/uploads/used/${vo.imageFilename}');"></div>
			</c:if>  
		</c:forEach>
    </div>
    
	<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">	
		<tr style="border-bottom: 1px solid #cccccc;">
		  <td colspan="2" align="left" style="padding-left: 5px;">
		     카테고리 : ${dto.categoryName}  
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
            <button type="button" class="btn" onclick="updateForm('${dto.usedNum}', '${pageNo}');">수정</button>
        </c:if>
        <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
            <button type="button" class="btn" onclick="deleteBoard('${dto.usedNum}', '${pageNo}');">삭제</button>
        </c:if>
    </td>

    <td align="right">
        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/used/list?${query}';">리스트</button>
    </td>
	</tr>
</table>
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