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
#profile{
	width: 100%;
	display: flex;
	align-items: flex-end;
}
#profile_image{
	width:50px; 
	height:50px; 
	border-radius:50%; 
	border:1px solid silver; 
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
}
p{
margin-bottom: 0.5rem;
}
</style>
  <!-- Page Content -->
    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner" role="listbox">
        <!-- Slide One - Set the background image for this slide in the line below -->
        <div class="carousel-item active" style="background-image: url('${pageContext.request.contextPath}/resources/img/banner1.png')">
          <div class="carousel-caption d-none d-md-block">
            <h3>신혼집 첫 인테리어에 필요한 가구는?</h3>
            <p>N차 신상에서 해결하자~!</p>
          </div>
        </div>
        <!-- Slide Two - Set the background image for this slide in the line below -->
        <div class="carousel-item" style="background-image: url('${pageContext.request.contextPath}/resources/img/banner2.png')">
          <div class="carousel-caption d-none d-md-block">
            <h3>Second Slide</h3>
            <p>This is a description for the second slide.</p>
          </div>
        </div>
        <!-- Slide Three - Set the background image for this slide in the line below -->
        <div class="carousel-item" style="background-image: url('http://placehold.it/1900x1080')">
          <div class="carousel-caption d-none d-md-block">
            <h3>Third Slide</h3>
            <p>This is a description for the third slide.</p>
          </div>
        </div>
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
      <li class="breadcrumb-item">카테고리</li>
      <li class="breadcrumb-item active">${categoryName}</li>
    </ol>
    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-lg-3 mb-4">
        <div class="list-group">
          <a href="${pageContext.request.contextPath}/store/list" class="list-group-item">전체</a>
          <a href="${pageContext.request.contextPath}/store/list?categoryNum=1" class="list-group-item">의류</a>
          <a href="${pageContext.request.contextPath}/store/list?categoryNum=2" class="list-group-item">전자제품</a>
          <a href="${pageContext.request.contextPath}/store/list?categoryNum=3" class="list-group-item">가구인테리어</a>
          <a href="${pageContext.request.contextPath}/store/list?categoryNum=4" class="list-group-item">생필품</a>
        </div>
      </div>
      <!-- Content Column -->


      <div class="col-lg-9 mb-4">
        <p class="text-right">  총 상품 수  : ${dataCount} &nbsp;&nbsp;&nbsp; (${page}/${total_page} 페이지)</p>
        	<table  class="table" style="width: 100%; margin: 10px auto; border-spacing: 0px;">
				<tr height="40">
					<td> 
						<button type="button" class="btn btn-secondary" style="font-family: 'Jua', sans-serif;" onclick="javascript:location.href='${pageContext.request.contextPath}/store/list';">새로고침</button>
					</td>
					<td >
						<form name="searchForm" action="${pageContext.request.contextPath}/store/list" method="post">
						<div class="row">
							<select class="form-control col-md-3" name="condition" class="selectField">
								<option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
								<option value="productName" ${condition=="productName"?"selected='selected'":""}>제품명</option>
								<option value="detail" ${condition=="detail"?"selected='selected'":""}>제품상세</option>
								<option value="sellerName" ${condition=="sellerName"?"selected='selected'":""}>판매자</option>
								<option value="created_date" ${condition=="created_date"?"selected='selected'":""}>등록일</option>
							</select>
							&nbsp;
							<input type="text" name="keyword" value="${keyword}" class="form-control col-md-6">
							<input type="hidden" name="categoryNum" value="${categoryNum}"> 
							<button type="button" class="btn" onclick="searchList()"><i class="fas fa-search"></i></button>
						</div>
						</form>
					</td>
					<td >
					<c:if test="${not empty sessionScope.seller}">
						<button type="button" class="btn btn-secondary" style="font-family: 'Jua', sans-serif;" onclick="javascript:location.href='${pageContext.request.contextPath}/store/created';">글올리기</button>
					</c:if>
					</td>
				</tr>
			</table>
            <div class="row">
      <c:forEach var="dto" items="${list}">
      <div class="col-lg-4 col-sm-6 portfolio-item" style="margin-bottom: 10px; ">
        <div class="card h-100" style="border: none;">
          <a href="${articleUrl}&num=${dto.productNum}"><img class="card-img-top" src="${pageContext.request.contextPath}/uploads/product/${dto.imageFilename}" alt="" style="height: 200px; border: 1px solid silver; border-radius: 20px;"></a>
          <div class="card-body" style="padding-top: 0;">
            <p class="card-text" id="profile">
            <div id="profile">
	            <div id="profile_image" style="background-image: url('${pageContext.request.contextPath}/uploads/member/${dto.profile_imageFilename}');"></div>
	            <div> ${dto.sellerName} &nbsp;<span style="color:#FF6464;"><i class="fas fa-heart"></i> &nbsp;${dto.storeFollowCount}</span></div>
            </div>
            </p>
            <h5 class="card-title">
            <c:if test="${dto.stock=='0'}">
              <del><a href="${articleUrl}&num=${dto.productNum}">${dto.productName}</a></del>&nbsp;<span style="color:red;">품절</span>
			</c:if>
			<c:if test="${dto.stock>0}">
              <a href="${articleUrl}&num=${dto.productNum}">${dto.productName}</a>
			</c:if>
            </h5>
            
           <p class="card-text" style="color:silver;">정가 :  <del><fmt:formatNumber type="currency" value="${dto.price}" />원</p></del>
            <p class="card-text">세일가 : <fmt:formatNumber  type="currency"  value="${dto.price - dto.discount_rate}"/>원</p>
            <p> <span style="color:	#FF6464;"><i class="fas fa-heart"></i> &nbsp;${dto.likeCount}</span>&nbsp;&nbsp;<span style="color:#FFCD28;">${dto.score}</span></p>
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

