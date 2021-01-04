<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dateUtil.js"></script>

<style type="text/css">
*{
    margin: 0; padding: 0;
}
body {
    font-size: 13px; font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
a{
    color: #000000;
    text-decoration: none;
    cursor: pointer;
}
a:active, a:hover {
    text-decoration: underline;
    color: tomato;
}
.btn {
    color:#333;
    font-weight:500;
    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
    border:1px solid #cccccc;
    background-color:#ffffff;
    text-align:center;
    cursor:pointer;
    padding:3px 10px 5px;
    border-radius:4px;
}
.btn:active, .btn:focus, .btn:hover {
    background-color:#e6e6e6;
    border-color: #adadad;
    color: #333333;
}
.boxTF {
    border:1px solid #999999;
    padding:3px 5px 5px;
    border-radius:4px;
    background-color:#ffffff;
    font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
.selectField {
    border:1px solid #999999;
    padding:3px 5px 3px;
    border-radius:4px;
    font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
.title {
    font-weight: bold;
    font-size:15px;
    margin-bottom:10px;
    font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
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
function searchProfile(userId) {
	var url="${pageContext.request.contextPath}/mypage/searchProfile?userId="+userId;
	if(confirm("팔로우 프로필로 이동하시겠습니까?")) {
		location.href=url;
	}
}

function deleteFollowing(userId1, userId2) {
	
	var url="${pageContext.request.contextPath}/mypage/deleteFollowing?userId1="+userId1+"&userId2="+userId2+"&page=${page}";
	if(confirm("팔로우를 삭제 하시겠습니까?")) {
		location.href=url;
	}
}
</script>

</head>
<body>

<div style="width: 700px; margin: 30px auto 0px;">
<table style="width: 100%; margin: 0px auto;">
<tr height="50">
	<td align="center" colspan="2">
	    <span style="font-size: 15pt; font-family: 맑은 고딕, 돋움; font-weight: bold;">팔로잉 리스트</span>
	</td>
</tr>

<tr height="35">
	<td width="50%">
		${dataCount}개(${page}/${total_page} 페이지)
	</td>
</tr>
</table>

<form name="followingListForm" method="post">
<table style="width: 100%; margin: 0px auto; border-spacing: 1px; background: #cccccc;">
<tr bgcolor="#eeeeee" align="center">
	<th width="180" height="45" >프로필사진</th>
	<th width="100">아이디</th>	
</tr>

<c:forEach var="dto" items="${list}">
<tr bgcolor="#ffffff" align="center"  style="border-bottom: 1px solid #cccccc;">
	<td>
		<div class="profile-img">
   		<c:if test="${dto.profile_imageFilename==null || dto.profile_imageFilename==''}">
				<div class="imgs" style="background-image:url('${pageContext.request.contextPath}/resources/images/noimage.png'); border-bottom: 1px solid #cccccc;"></div>
			</c:if>
			<c:if test="${dto.profile_imageFilename!=null && dto.profile_imageFilename!=''}">			
   				<div class="imgs" style="background-image:url('${pageContext.request.contextPath}/uploads/member/${dto.profile_imageFilename}'); border-bottom: 1px solid #cccccc;"></div>
			</c:if>
   		</div>
	</td>
	<td class="userId">
		<a href="javascript:searchProfile('${dto.userId1}')">${dto.userId1}</a>
	</td>
	<td width="70">
		<a href="javascript:deleteFollowing('${dto.userId1}','${dto.userId2}')">삭제</a>
	</td>
	
	<td>
	${dto.introduce}
	</td>
</tr>
</c:forEach>
</table>
</form>

<table style="width: 100%; margin: 10px auto;">
<tr height="30" align="center">
	<td>${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
</tr>
</table>


</div>

</body>
</html>