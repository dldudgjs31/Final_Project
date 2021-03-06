<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">

.imgLayout{
	width: 190px;
	height: 205px;
	padding: 10px 5px 10px;
	margin: 5px;
	border: 1px solid #dad9ff;
	cursor: pointer;
}

.subject {
	width: 180px;
	height: 25px;
	line-height: 25px;
	margin: 5px auto;
	border-top: 1px solid #dad9ff;
	display: inline-block;
	white-space: nowrap;
	overflow:hidden;
	text-overflow: ellipsis;
	cursor: pointer;
}

.body-container{
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	width: 70%;
}
.post-list {
  display: grid;
  width:99%;
  grid-template-columns: repeat(3, minmax(100px, 293px));
  grid-template-rowls: repeat(auto, minmax(100px, 293px));
  justify-content: center;
  gap: 28px;
}

.post {
  cursor: pointer;
  position: relative;
  display: block; /*Es un ancla por eso le cambio el displya*/
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
}

.post-image {
  margin: 0;
  display: flex;
  justify-content: center;
  align-items: center;
}
.image{
	width: 100%;
	height: 100%;
}
.post-image img {
  object-fit: cover;
  width:100%;
  height: 293px;
}
.post-overlay {
  background-color: rgb(0, 0, 0, 0.4);
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  top: 0;
  display: none;
  align-items: center;
  justify-content: center;
  color: white;
  text-align: center;
}
.post:hover .post-overlay {
  display: flex;
}
.post-likes,
.post-hitCount {
  width: 80px;
  margin: 5px;
  font-weight: bold;
  text-align: center;
  display: inline-block;
}

.profile-title{
	display: grid;
	grid-template-columns: repeat(3, minmax(100px, 293px));
	grid-template-rows: repeat(4,100px);
	grid-template-areas:
    "img name setting"
    "img follower following"
    "img intro intro"
    "tab tab tab";
}
.profile-img{
	grid-area:img;
	display: flex;
	justify-content: center;
	align-items: center;
}
.imgs{
	width: 200px; 
	height: 200px; 
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
	border-radius: 50%;
	border: 1px solid silver;
}
.profile-introduce{
	grid-area:intro;
}
.profile-name{
	grid-area:name;
	display: flex;
	align-items: flex-end;
	align-content: center;
}
.profile-setting{
	grid-area:setting;
	display: flex;
	align-items: flex-end;
	align-content: center;
}
.profile-follower{
	grid-area:follower;
	display: flex;
	align-items: center;
	align-content: center;	
}
.profile-following{
	grid-area:following;
	display: flex;
	align-items: center;
	align-content: center;	
}
.profile-tab{
	grid-area:tab;
	display: flex;
	align-items: center;
	justify-content:center;
	border-top: 1px solid #ccc;
	font-size : 15px;
	color:silver;
}
.tabs{
	display: flex;
	justify-content: center;
}
#profile-tabbox{
	width: 10%;
	height: 90px; 
	padding-top: 10px; 
	margin:10px; 
	text-align: center;
}
#profile-tabbox:hover{
	border-top: 2px solid black;
	color:black;
}

.button {
  padding: 15px 25px;
  font-size: 10px;
  text-align: center;
  cursor: pointer;
  outline: none;
  color: #fff;
  background-color: #2196F3;
  border: none;
  border-radius: 15px;
  box-shadow: 0 9px #999;
}

.button:hover {background-color: #0b7dda;}

.button:active {
  background-color: #0b7dda;
  box-shadow: 0 5px #666;
  transform: translateY(4px);
}
@media screen and (max-width: 768px) {
	.body-container{
		width:100%;
	}
	  .post-list {
	    gap: 3px;
	    grid-template-columns: repeat(3, 180px);
	  }
	  .post-image img {
	  height: 180px;
	  }
	  .imgs{
	  width: 150px;
	  height: 150px;
	  }
}

</style>

<script type="text/javascript">

function goArticle(usedNum){
	location.href ="${pageContext.request.contextPath}/used/article?usedNum="+usedNum;
}


function deleteKeep(usedNum){
	var url="${pageContext.request.contextPath}/used/deleteKeep?usedNum="+usedNum;
	if(confirm("찜을 삭제 하시겠습니까?")) {
		location.href=url;
	}
}

function searchProfile(userId) {
	var url="${pageContext.request.contextPath}/mypage/searchProfile?userId="+userId;
		location.href=url;
	
}
</script>
<Br><Br>

<ol class="breadcrumb">
      <li class="breadcrumb-item">${userId}의 찜목록</li>
</ol>

  <table class="table">
      <tr>
      	<td align= "left" width="50%">
      	 찜한 상품 수  : ${keepCount} 
      	</td>
      	<td align="right" width="50%">
    	<button type="button" class="btn btn-secondary"  style="font-family: 'Jua', sans-serif; align: right" onclick="javascript:location.href='${pageContext.request.contextPath}/used/list';"><i class="fas fa-share"></i>&nbsp;이전으로</button>
     	</td>
     </table>
      
 <div class="col-lg-9 mb-4">
     
     
      
      <div class="row">
      <c:forEach var="dto" items="${list}">
      <div class="col-lg-4 col-sm-6 portfolio-item" style="margin-bottom: 10px;">
        
        <div class="card h-100">
        
        <!-- 판매완료되면 이미지 흑백, 제목에 줄그음 -->
        <c:if test="${dto.sold_check == 0}">
          <a href="${pageContext.request.contextPath}/used/article?usedNum=${dto.usedNum}&page=1" >
          <img class="card-img-top" src="${pageContext.request.contextPath}/uploads/used/${dto.imageFilename}" alt="" style="height: 200px;">
          </a>
         </c:if>
        
        <c:if test="${dto.sold_check == 1}">
          <a href="${pageContext.request.contextPath}/used/article?usedNum=${dto.usedNum}&page=1">
          <img class="card-img-top" src="${pageContext.request.contextPath}/uploads/used/${dto.imageFilename}" alt="" style="height: 200px; filter:grayscale(100%);">
          </a>
         </c:if>
          
          <div class="card-body" align="center">
          
         	<p class="card-text" onclick="javascript:searchProfile('${dto.userId}')">@${dto.userId}</p>
         	
           	<c:if test="${dto.sold_check == 0}">
            <h4 class="card-title">
              <a href="${pageContext.request.contextPath}/used/article?usedNum=${dto.usedNum}&page=1"  style="color: #8C8C8C !important;">${dto.subject}</a>
            </h4>
            </c:if>
            
            <c:if test="${dto.sold_check == 1}">
            <h4 class="card-title">
              <del><a href="${pageContext.request.contextPath}/used/article?usedNum=${dto.usedNum}&page=1"  style="color: #8C8C8C !important;">&nbsp;${dto.subject}&nbsp;</a></del>
            </h4>
            </c:if>
            
            <c:if test="${dto.sold_check == 0}">
            <p class="card text-white bg-info mb-4">
            	판매가 
            	<br>
            	<fmt:formatNumber type="currency" value="${dto.price}"/>원
            </p>
            </c:if>
            <c:if test="${dto.sold_check == 1}">
            <p class="card text-white bg-dark mb-4">
            	<del>&nbsp;판매가&nbsp;</del>
            	<del>&nbsp;<fmt:formatNumber type="currency" value="${dto.price}"/>원&nbsp;</del>
            </p>
            </c:if>
            
             <button type="button" class="btn btn-danger btn-xs"  style="font-family: 'Jua', sans-serif;" onclick="deleteKeep('${dto.usedNum}');">삭제</button>
          </div>
          
        </div>
        
      </div>
      </c:forEach>
    </div>
    
  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
	<tr height="35">
		<td align="center">
		<c:if test="${keepCount==0}">
			찜목록이 비었습니다.
		</c:if>
		</td>
	</tr>
 </table>
</div>
