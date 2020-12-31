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
	width: 30px; 
	height: 30px; 
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
function searchList1() {
	var f1=document.searchFormList;

	f1.submit();
}

function searchList2() {
	var f2=document.searchFormKeyword;

	f2.submit();
}

function searchList3() {
	var f3=document.SearchFormFollow;
	
	f3.submit();
}
function goArticle(dailyNum){
	location.href ="${articleUrl}&dailyNum="+dailyNum;
}
</script>
<Br><Br>

<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
				<tr height="40">
					<td align="right" width="100">
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/daily/created';">글올리기</button>
					</td>
				
					<td align="center" width="150">
						<form name="searchFormKeyword" action="${pageContext.request.contextPath}/daily/list" method="post">
							<input type="text" name="keyword" value="${keyword}" class="boxTF ">
							<button type="button" class="btn" onclick="searchList2();">검색 </button>
						</form>
					</td>
					<td align="center" width="150">
						<form name="searchFormList" action="${pageContext.request.contextPath}/daily/list" method="post">
							<select class="selectField form-control" id="categoryNum" name="categoryNum" onchange="searchList1();">
								<option value="">::카테고리 모아보기::</option>
								<option value="1" ${dto.categoryNum=="1"?"selected='selected'":""}>의류</option>
								<option value="2" ${dto.categoryNum=="2"?"selected='selected'":""}>가구</option>
								<option value="3" ${dto.categoryNum=="3"?"selected='selected'":""}>전자제품</option>
								<option value="4" ${dto.categoryNum=="4"?"selected='selected'":""}>도서</option>
								<option value="5" ${dto.categoryNum=="5"?"selected='selected'":""}>기타</option>
							</select>
						</form>	
					</td>
					<td align="left" width="100">
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/daily/list';">새로고침</button>
					</td>
					
					<td  align="left" width="150">
						<form name="SearchFormFollow" method="post">
							<input type="hidden" name="sessionId" value="${sessionScope.member.userId}"> 
							<button type="button" class="btn" onclick="searchList3();">주변 일상글</button>
						</form>
					</td>
				</tr>
</table>

<ol class="breadcrumb">
      <li class="breadcrumb-item">카테고리</li>
      <li class="breadcrumb-item active">${dto.categoryName}</li>
</ol>

 <div class="col-lg-9 mb-4">
        <p class="text-right">  총 게시글 수  : ${dataCount} &nbsp;&nbsp;&nbsp; (${page}/${total_page} 페이지)</p>
      <div class="row">
    
      <c:forEach var="dto" items="${list}">
      <div class="col-lg-4 col-sm-6 portfolio-item" style="margin-bottom: 10px;">   
        <div class="card h-100">         
          <a href="${articleUrl}&dailyNum=${dto.dailyNum}">       	
	          <img class="card-img-top" src="${pageContext.request.contextPath}/uploads/daily/${dto.imageFilename}" alt=""  style="height: 200px;">   		          		
	          <span class="post-overlay">		       
			          <span class="post-likes">${dto.dailyLikeCount }</span>
			          <span class="post-comments">${dto.replyCount }</span>			      
			  </span>
          </a>              
          <div class="card-body" align="center">       
            <div class="profile-img card-text">
   			<div class="imgs" style="background-image:url('${pageContext.request.contextPath}/uploads/member/${dto.profile_imageFilename}'); border-bottom: 1px solid #cccccc;" >
   			</div><a href="javascript:searchProfile('${dto.userId}')" style="color: black !important;">${dto.userId}</a>
   			</div>
            <h4 class="card-title">
              <a href="${articleUrl}&dailyNum=${dto.dailyNum}" style="color: #8C8C8C !important;">${dto.subject}</a>
            </h4>
          </div>
        </div>
      </div>
      </c:forEach>
    </div>
      
    <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
				   <tr height="35">
					<td align="center">
					    ${dataCount==0 ? "등록된 게시물이 없습니다.":paging}
					 </td>
				   </tr>
	</table>
</div>