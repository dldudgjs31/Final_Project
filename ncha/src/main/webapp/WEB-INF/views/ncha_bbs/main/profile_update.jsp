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
			 <!-- 프로필 사진 업로드 및 미리 보여주기 -->
			 <div style="margin-bottom: 20px; margin-top: 30px; margin-left: 300px;">
				 <label style="font-weight: 900; font-size: 50;">프로필 사진${dto.userId}</label>
				 <div class="profile_photo" >
				  	<img id ="img" src="${pageContext.request.contextPath}/uploads/member/${dto.profile_imageFilename}" style="margin:10px 0;width: 200px; height: 200px; border: 2px solid silver;"/>
				 </div>
				 <input type="file" name="uploadphoto" accept="image/*" onchange="preWatchphoto(this)">	 
			 </div>
			  
			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">설&nbsp;&nbsp;&nbsp;&nbsp;명</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="introduce" rows="12" class="boxTA" style="width: 95%;">${dto.introduce}</textarea>
			      </td>
			  </tr>

			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			       	<input type="hidden" name="profile_imageFilename" value="${dto.profile_imageFilename}">
			       	<input type="hidden" name="introduce" value="${dto.introduce}">
			        <button type="button" name="sendButton" class="btn" onclick="memberOk('${dto.userId}');">정보수정</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/mypage/profile';">수정취소</button>
			      </td>
			    </tr>
			    <tr height="30">
			        <td align="center" style="color: blue;">${message}</td>
			    </tr>
			  </table>
			</form>
        </div>


</div>
