<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dateUtil.js"></script>

<style type="text/css">
.profile_photo{
	width: 100%; margin: 0px auto 0px; border-spacing: 0px;
}
#img{
	border-radius: 100%;
}
</style>


<script type="text/javascript">
function memberOk(userId) {
	var f = document.memberForm;


 	f.action = "${pageContext.request.contextPath}/mypage/profile_update?userId="+userId;

    f.submit();
}



// 프로필 사진 업로드 및 미리 보여주기 
function preWatchphoto(input){
	if(input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function(e){
			$('#img').attr('src',e.target.result).width(200).height(200);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

</script>
<div class="body-container" style="width: 1080px;">
    <div class="body-title">
        <h3><i class="fas fa-user"></i> ${mode=="member"?"회원 가입":"회원 정보 수정"} </h3>
    </div>
    <div>
      <form name="memberForm" method="post" enctype="multipart/form-data">
			<div>
			<label class="col-sm-2 control-label" for="userPwd">프로필 사진</label>
			<div class="profile_photo">
				<c:choose>
				 	<c:when test="${empty dto.profile_imageFilename}">
				  	<img id ="img" src="${pageContext.request.contextPath}/resources/img/nophoto.png" style="margin:10px 0;width: 200px; height: 200px; border: 2px solid silver;"/>
				 	</c:when>
				 	<c:when test="${not empty dto.profile_imageFilename}">
				  	<img id ="img" src="${pageContext.request.contextPath}/uploads/member/${dto.profile_imageFilename}" style="margin:10px 0;width: 200px; height: 200px; border: 2px solid silver;"/>
				 	</c:when>
				 </c:choose>
			</div>
	    </div> 
			  <input type="file" name="uploadphoto" accept="image/*" onchange="preWatchphoto(this)"><br> 	<br> 
	   <table class="table">
		    <tr>
		    	<td>자기소개</td>
		    	<td>
					<textarea class="form-control content" name="introduce">${dto.introduce}</textarea>
		    	</td>
		    </tr>
	  </table>
		
	  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		     <tr height="45"> 
		      <td align="center" >
		       	<input type="hidden" name="profile_imageFilename" value="${dto.profile_imageFilename}">
		       
		        <button type="button" name="sendButton" class="btn btn-primary" style="font-family: 'Jua', sans-serif;" onclick="memberOk('${dto.userId}');">정보수정</button>
		        <button type="reset" class="btn btn-info" style="font-family: 'Jua', sans-serif;">다시입력</button>
		        <button type="button" class="btn btn-danger" style="font-family: 'Jua', sans-serif;" onclick="javascript:location.href='${pageContext.request.contextPath}/mypage/profile';">수정취소</button>
		      </td>
		    </tr>
		    <tr height="30">
		        <td align="center" style="color: blue;">${message}</td>
		    </tr>
	 </table>

</form>
</div>
</div>
