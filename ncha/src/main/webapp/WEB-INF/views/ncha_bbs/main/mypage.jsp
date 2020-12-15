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

<div class="body-container" >
    <div class="profile-title">
    	<div class="profile-img">
    		<div class="imgs" style="background-image:url('${pageContext.request.contextPath}/uploads/member/${dto.profile_imageFilename}');">
    		
    		</div>
    	</div>
    	<div class="profile-introduce">안녕하세요. n차신상 개발자 이영헌입니다.${dto.introduce}</div>
    	<div class="profile-name">
    		<h1>${sessionScope.member.userId}</h1>&nbsp;&nbsp;
    		<c:if test="${sessionScope.member.userId!= dto.userId}">
    			<span><button class="button">팔로우하기</button></span>
    		</c:if>
    	</div>
    	<div class="profile-setting">
    	<c:if test="${not empty sessionScope.member}">
    		<span><a href="${pageContext.request.contextPath}/mypage/profileUpdate"><i class="fas fa-user-cog"></i>&nbsp;&nbsp;프로필 수정 </a></span>
    	</c:if>
    	</div>
    	<div class="profile-follower"><strong>팔로워 </strong>&nbsp;&nbsp;&nbsp;1000</div>
    	<div class="profile-following"><strong>팔로잉 </strong>&nbsp;&nbsp;&nbsp;1000</div>
    	<div class="profile-tab">
    		<div id="profile-tabbox" style="width: 10%; height: 90px; padding-top: 10px; " onclick="openTab('daily')">일상글</div>
    		<div id="profile-tabbox" style="width: 10%; height: 90px; padding-top: 10px;" onclick="openTab('used')">중고글</div>
    	</div>
    </div>
   
<div id="daily" class="tabs">
	<div class="post-list">
	
	    <a href="" class="post">
	      <div class="post-image">
	      	<img alt="" src="${pageContext.request.contextPath}/resources/img/23627.jpg">
	      </div>
	      <span class="post-overlay">
	        <p>
	          <span class="post-likes">150</span>
	          <span class="post-comments">10</span>
	        </p>
	      </span>
	    </a>  
	    <a href="" class="post">
	      <div class="post-image">
	      	<img alt="" src="${pageContext.request.contextPath}/resources/img/23627.jpg">
	      </div>
	      <span class="post-overlay">
	        <p>
	          <span class="post-likes">150</span>
	          <span class="post-comments">10</span>
	        </p>
	      </span>
	    </a>  
	    <a href="" class="post">
	      <div class="post-image">
	      	<img alt="" src="${pageContext.request.contextPath}/resources/img/23627.jpg">
	      </div>
	      <span class="post-overlay">
	        <p>
	          <span class="post-likes">150</span>
	          <span class="post-comments">10</span>
	        </p>
	      </span>
	    </a>  
	</div>
</div>



<div id="used" class="tabs" style="display:none;">
<div class="post-list">
	
	    <a href="" class="post">
	      <div class="post-image">
	      	<img alt="" src="${pageContext.request.contextPath}/resources/img/logo.png">
	      </div>
	      <span class="post-overlay">
	        <p>
	          <span class="post-likes">150</span>
	          <span class="post-comments">10</span>
	        </p>
	      </span>
	    </a>  
	    
	    <a href="" class="post">
	      <div class="post-image">
	      	<img alt="" src="${pageContext.request.contextPath}/resources/img/logo.png">
	      </div>
	      <span class="post-overlay">
	        <p>
	          <span class="post-likes">150</span>
	          <span class="post-comments">10</span>
	        </p>
	      </span>
	    </a>  
	    
	    <a href="" class="post">
	      <div class="post-image">
	      	<img alt="" src="${pageContext.request.contextPath}/resources/img/logo.png">
	      </div>
	      <span class="post-overlay">
	        <p>
	          <span class="post-likes">150</span>
	          <span class="post-comments">10</span>
	        </p>
	      </span>
	    </a>  
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