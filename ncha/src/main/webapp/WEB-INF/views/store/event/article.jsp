<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="${pageContext.request.contextPath}/resources/css/shop-homepage.css" rel="stylesheet">
<script type="text/javascript">
function deleteEvent() {
	<c:if test="${sessionScope.seller.sellerId=='admin' || sessionScope.seller.sellerId==dto.sellerId}">
		var q = "eventNum=${dto.eventNum}&${query}";
	    var url = "${pageContext.request.contextPath}/event/delete?" + q;

	    if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
	  	  location.href=url;
	</c:if>    
	<c:if test="${sessionScope.seller.sellerId!='admin' && sessionScope.seller.sellerId!=dto.sellerId}">
	  alert("게시물을 삭제할 수  없습니다.");
	</c:if>
	}

	function updateEvent() {
	<c:if test="${sessionScope.seller.sellerId==dto.sellerId}">
		var q = "eventNum=${dto.eventNum}&page=${page}";
	    var url = "${pageContext.request.contextPath}/event/update?" + q;

	    location.href=url;
	</c:if>

	<c:if test="${sessionScope.seller.sellerId!=dto.sellerId}">
	   alert("게시물을 수정할 수  없습니다.");
	</c:if>
	}
</script>
<style type="text/css">
.list-group-item{
	color : black !important;
}
</style>
  <!-- Page Content -->
    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
 	  <c:forEach var="dto" items="${list}">
        <li data-target="#carouselExampleIndicators" data-slide-to="${listNum}" class="active"></li>
       </c:forEach>
      </ol>
   
      <div class="carousel-inner" role="listbox">
       	  <c:forEach var="dto" items="${list}">
      <div class="carousel-item active" style="background-image: url('${pageContext.request.contextPath}/uploads/event/${dto.imageFilename}')"></div>
       </c:forEach>
       </div>
     
      <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>
    <!-- Page Heading/Breadcrumbs -->
<Br><Br>

          <ol class="breadcrumb">
      <li class="breadcrumb-item">이벤트</li>
      <li class="breadcrumb-item active">진행중 이벤트</li>
    </ol>
    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-lg-3 mb-4">
        <div class="list-group">
          <a href="${pageContext.request.contextPath}/event/proceedList" class="list-group-item">진행중 이벤트</a>
          <a href="${pageContext.request.contextPath}/event/endList" class="list-group-item">종료된 이벤트</a>
          <a href="${pageContext.request.contextPath}/event/list" class="list-group-item">전체 이벤트</a>
       </div>
      </div>
      <!-- Content Column -->
	
    <div>
			<table class="table" style="width: 100%; max-width:800px;  margin: 10px auto; border-spacing: 0px;">
			<tr class="card-body" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="center">
				   ${dto.subject}
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">
			       주최 : ${dto.sellerName}
			    </td>
			</tr>
			
			<tr>
			  <td colspan="2" align="left" style="padding: 10px 5px;">
			      <img src="${pageContext.request.contextPath}/uploads/event/${dto.imageFilename}" style="max-width:100%; height:auto; resize:both;">
			   </td>
			</tr>			
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="50">
			      ${dto.content}
			   </td>
			</tr>
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
				진행 기간 : <span style="font-style: italic;"> ${dto.start_date}~ ${dto.end_date} </span>  
				</td>
			</tr>
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       이전글 :
			         <c:if test="${not empty preReadDto}">
			              <a href="${pageContext.request.contextPath}/event/article?${query}&eventNum=${preReadDto.eventNum}">${preReadDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       다음글 :
			         <c:if test="${not empty nextReadDto}">
			              <a href="${pageContext.request.contextPath}/event/article?${query}&eventNum=${nextReadDto.eventNum}">${nextReadDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			    <td align="left">
			       <c:if test="${sessionScope.seller.sellerId==dto.sellerId}">				    
			          <button type="button" class="btn" onclick="updateEvent();">수정</button>
			       </c:if>
			       <c:if test="${sessionScope.seller.sellerId=='admin' || sessionScope.seller.sellerId==dto.sellerId}">				    
			          <button type="button" class="btn" onclick="deleteEvent();">삭제</button>
			       </c:if>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/event/proceedlist?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
    </div>
    
<div class="body-container" >
	<div class="body-title">
	</div>


</div>

