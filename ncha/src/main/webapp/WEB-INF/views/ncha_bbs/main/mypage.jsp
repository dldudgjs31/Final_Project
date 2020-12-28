<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
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
.post-comments {
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
function linkOk(){
	var f = document.mypageForm;
	f.action="${pageContext.request.contextPath}/profile/myArticle";
}

function follow(userId){
	var url="${pageContext.request.contextPath}/mypage/follow?userId="+userId;
	if(confirm("팔로우 하시겠습니까?")) {
		location.href=url;
	}
}

function deleteF(userId){
	var url="${pageContext.request.contextPath}/mypage/deleteFollow?userId="+userId;
	if(confirm("팔로우를 취소 하시겠습니까?")) {
		location.href=url;
	}
}
</script>

<div class="body-container" >
    <div class="profile-title">
    	<div class="profile-img">
    		<div class="imgs" style="background-image:url('${pageContext.request.contextPath}/uploads/member/${dto.profile_imageFilename}');">
    		
    		</div>
    	</div>
    	<div class="profile-introduce">자기소개 !${dto.introduce}세션아이디:${sessionScope.member.userId}, userId:${dto.userId}, userId1:${dto.userId1}, userId2:${dto.userId2}, check:${check}</div>
    	<div class="profile-name">
    		<h1>${dto.userId}</h1>&nbsp;&nbsp;
    		
    			<c:if test="${check==0}">
    				<a href="javascript:follow('${dto.userId}')"><i class="far fa-heart fa-3x"></i></a>
    			</c:if>
    			<c:if test="${check==1}">
    				<a href="javascript:deleteF('${dto.userId}')"><i class="fas fa-heart fa-3x"></i></a>
    			</c:if>
    		
<%--     	<c:choose>
    		<c:when test="${sessionScope.member.userId!= dto.userId || (check == 0 || check == 'null')}">
    			<a href="javascript:follow('${dto.userId}')"><i class="far fa-heart fa-3x"></i></a>
    		</c:when> 
    		<c:when test="${sessionScope.member.userId!= dto.userId || check == 1}">
    			<a href="javascript:follow('${dto.userId}')"><i class="fas fa-heart fa-3x"></i></a>
    		</c:when>
    	</c:choose> --%>
    		
    	</div>
    	<div class="profile-setting">
    	<c:if test="${sessionScope.member.userId == dto.userId}">
    		<span><a href="${pageContext.request.contextPath}/mypage/profileUpdate"><i class="fas fa-user-cog"></i>&nbsp;&nbsp;프로필 수정 </a></span>
    	</c:if>
    	</div>
    <c:if test="${sessionScope.member.userId == dto.userId}">
    	<div class="profile-follower"><a href="${pageContext.request.contextPath}/mypage/followerList"><strong>팔로워 </strong></a>&nbsp;&nbsp;&nbsp;${dto.followerCount }</div>
    	<div class="profile-following"><a href="${pageContext.request.contextPath}/mypage/followingList"><strong>팔로잉 </strong></a>&nbsp;&nbsp;&nbsp;${dto.followingCount }</div>
    </c:if>
      <c:if test="${sessionScope.member.userId != dto.userId}">
    	<div class="profile-follower"><strong>팔로워 </strong>&nbsp;&nbsp;&nbsp;${dto.followerCount }</div>
    	<div class="profile-following"><strong>팔로잉 </strong>&nbsp;&nbsp;&nbsp;${dto.followingCount }</div>
    </c:if>
    	<div class="profile-tab">
    		<div id="profile-tabbox" style="width: 10%; height: 90px; padding-top: 10px; " onclick="openTab('daily')">일상글</div>
    		<div id="profile-tabbox" style="width: 10%; height: 90px; padding-top: 10px;" onclick="openTab('used')">중고글</div>
    	</div>
    </div>
    
<form name="mypageForm" method="post">
<div id="daily" class="tabs">
	<div class="post-list">
	<c:forEach var="dto1" items="${list1}">
	 <c:if test="${dto.userId == dto1.userId}">
	    <a href="${articleUrl1}&dailyNum=${dto1.dailyNum}&mode=${mode}" class="post"> <!-- ${articleUrl1}&dailyNum=${dto1.dailyNum} -->
	      <div class="post-image">
	      	<img alt="" src="${pageContext.request.contextPath}/uploads/daily/${dto1.imageFilename}" width="180" height="180" border="0" >
	      </div>
	      <span class="post-overlay">
	        <p>
	          <span class="post-likes">${dto1.dailyLikeCount }</span>
	          <span class="post-comments">${dto1.replyCount }</span>
	        </p>
	      </span>
	    </a>
	</c:if>  
	</c:forEach>
	</div>
</div>
</form>
<div id="used" class="tabs" style="display:none;">
	 <div class="post-list">
	
	 <c:forEach var="dto2" items="${list2}">
	 <c:if test="${dto.userId == dto2.userId}">	
	    <a href="" class="post">
	      <div class="post-image">
	      	<img alt="" src="${pageContext.request.contextPath}/uploads/used/${dto2.imageFilename}" width="180" height="180" border="0">
	      </div>
	      <span class="post-overlay">
	        <p>
	          <span class="post-likes">${dto2.usedLikeCount }</span>
	          <span class="post-comments">${dto2.replyCount }</span>
	        </p>
	      </span>
	    </a>
	</c:if>  
	</c:forEach>
	</div>
</div>



    
</div>
<script type="text/javascript">
function openTab(bbsName) {
	  var i;
	  var x = document.getElementsByClassName("tabs");
	  for (i = 0; i < x.length; i++) {
	    x[i].style.display = "none";
	  }
	  document.getElementById(bbsName).style.display = "block";
	  
	}
</script>    