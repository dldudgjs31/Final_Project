<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="${pageContext.request.contextPath}/resources/css/shop-homepage.css" rel="stylesheet">
<script type="text/javascript">
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
	background-size: contain;
}
p{
margin-bottom: 0.5rem;
}
.store_image{
	width: 200px;
	height: 200px;
	background-size: contain;
	background-repeat: no-repeat;
	background-position: center;
	border: 1px solid silver;
	border-radius: 50%;
}
</style>
<script type="text/javascript">
$(function(){
	<c:if test="${not empty sessionScope.member.userId}">
	followPage();
	</c:if>
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
function followPage(){
	var url="${pageContext.request.contextPath}/store/updateFollowpage";	
	var query="sellerId=${sellerId}";
	var fn = function(data) {
		var check=data.check;
		if(check==1) {
			$("#likeStoreIcon").attr("class","fas fa-heart");
		} else if(check==0) {
			$("#likeStoreIcon").attr("class","far fa-heart");
		}
	};
	ajaxFun(url, "post", "json", query, fn);
}
function StoreLike1(sellerId){

	var url="${pageContext.request.contextPath}/store/updateStoreLike";	
	var query="sellerId="+sellerId;
	var fn = function(data) {
		var state=data.state;
		if(state==="true") {
			alert("스토어 팔로우 완료!")
			$("#likeStoreIcon").attr("class","fas fa-heart");
		} else if(state==="deltrue") {
			alert("스토어 팔로우 취소 완료!");
			$("#likeStoreIcon").attr("class","far fa-heart");
		}else if(state==="false"){
			alert("스토어 팔로우 에 실패했습니다.");
		}
	};
	ajaxFun(url, "post", "json", query, fn);
}
</script>
		<br>
    <div class="row" style="display: flex; align-items: center; justify-content: center;">
      <div class="col-lg-4" style="display: flex; justify-content: center;">
        <div class="store_image" style="background-image: url('${pageContext.request.contextPath}/uploads/member/${sellerDto.profile_imageFilename}');"></div>
      </div>
      <div class="col-lg-8">
        <h2>${sellerDto.sellerName}<span><button type="button" class="btn btn-xs" onclick="StoreLike1('${sellerId}')"><i id="likeStoreIcon" class="far fa-heart"></i></button></span></h2>
        <p>팔로워 수: ${followCount}</p>
        <p>스토어 소개 : </p>
        <p>${sellerDto.introduce}</p>
      </div>
    </div>  
  
  
  
  		<br>
     <ol class="breadcrumb">
      <li class="breadcrumb-item">스토어 판매글</li>
      <li class="breadcrumb-item active">${sellerName} 스토어</li>
    </ol>
    <!-- Content Row -->
    <div class="row">


      <div class="col-lg-12 mb-4">

        <p class="text-right">  총 상품 수  : ${dataCount} &nbsp;&nbsp;&nbsp; (${page}/${total_page} 페이지)</p>
            <div class="row">
      <c:forEach var="dto" items="${list}">
      <div class="col-lg-3 col-sm-6 portfolio-item" style="margin-bottom: 10px; ">
        <div class="card h-100" style="border: none;">
          <a href="${articleUrl}&num=${dto.productNum}"><img class="card-img-top" src="${pageContext.request.contextPath}/uploads/product/${dto.imageFilename}" alt="" style="height: 200px; border: 1px solid silver; border-radius: 20px;"></a>
          <div class="card-body" style="padding-top: 0;">
            <p class="card-text" id="profile">
            <div id="profile">
	            <div id="profile_image" style="background-image: url('${pageContext.request.contextPath}/uploads/member/${dto.profile_imagefilename}');"></div>
	            <div> ${dto.sellerName} &nbsp;<span style="color:#FF6464;"><i class="fas fa-heart"></i> &nbsp;${dto.storeFollowCount}</span></div>
            </div>
            </p>
            <h5 class="card-title">
            <c:if test="${dto.stock=='0'}">
              <del><a href="${pageContext.request.contextPath}/store/article?page=1&num=${dto.productNum}">${dto.productName}</a></del>&nbsp;<span style="color:red;">품절</span>
			</c:if>
			<c:if test="${dto.stock>0}">
              <a href="${pageContext.request.contextPath}/store/article?page=1&num=${dto.productNum}">${dto.productName}</a>
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



