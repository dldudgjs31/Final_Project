<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="${pageContext.request.contextPath}/resources/css/shop-homepage.css" rel="stylesheet">
<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}


$(document).ready(function() {
    $('#list').click(function(event){event.preventDefault();$('#products .item').addClass('list-group-item');});
    $('#grid').click(function(event){event.preventDefault();$('#products .item').removeClass('list-group-item');$('#products .item').addClass('grid-group-item');});
});


</script>
<style type="text/css">
.list-group-item{
	color : black !important;
}
</style>

  <!-- Page Content -->
    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
      	 	  <c:forEach var="dto" items="${list}" varStatus="status">
		        	<li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" ${status.index==0?"class='active'":"" }></li>
	       	</c:forEach>
      </ol>
   
      <div class="carousel-inner" role="listbox">
      
      	  <c:forEach var="dto" items="${list}" varStatus="status">
     		<div class="carousel-item ${status.index==0?'active':'' }" style="background-image: url('${pageContext.request.contextPath}/uploads/event/${dto.imageFilename}')"></div>
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
      <li class="breadcrumb-item active">종료된 이벤트</li>
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


      <div class="col-lg-9 mb-4">
        <p class="text-right"> (${page}/${total_page} 페이지)</p>
        	<table  class="table" style="width: 100%; margin: 10px auto; border-spacing: 0px;">
				<tr height="40">
					<td align="left"> 
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/event/list';">새로고침</button>
					</td>
					<c:if
					test="${sessionScope.member.userId=='admin'||sessionScope.seller.allow=='1'}">
					<td align="right">
						<button type="button" class="btn"
							onclick="javascript:location.href='${pageContext.request.contextPath}/event/created';">글올리기</button>
					</td>
				</c:if>
				</tr>
			</table>
			
			
            <div class="row">
      <c:forEach var="dto" items="${list}">
      <div class="col-lg-4 col-sm-6 portfolio-item" style="margin-bottom: 10px;">
        <div class="card h-100">
          <a href="${articleUrl}&eventNum=${dto.eventNum}"><img class="card-img-top" src="${pageContext.request.contextPath}/uploads/event/${dto.imageFilename}" alt="" style="height: 200px;"></a>
          <div class="card-body">
            <p class="card-text">${dto.sellerId}</p>
            <h4 class="card-title">
              <a  href="${articleUrl}&eventNum=${dto.eventNum}">${dto.subject}</a>
            </h4>
            
            <p class="card-text">진행 기간 <br>
              <span style="font-style: italic;"> ${dto.start_date}~ ${dto.end_date} </span>   </p>
          </div>
        </div>
      </div>
      </c:forEach>
    </div>
  <p class="text-center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</p>
        

      </div>
    </div>


<div class="body-container" >
	<div class="body-title">
	</div>


</div>

