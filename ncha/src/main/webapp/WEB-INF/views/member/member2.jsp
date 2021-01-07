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
.btn{
	font-family : 'Jua', sans-serif;
}
h3{
	font-family : 'Jua', sans-serif;
}
</style>


<script type="text/javascript">
function memberOk(userId) {
	var f = document.memberForm;
	var str;
	
	var mode = "${mode}";
	if(mode=="member"&& !f.uploadphoto.value){
		alert("이미지 파일을 선택하세요.");
		f.uploadphoto.focus();
		return;
	}
	
	str = f.userId.value;
	str = str.trim();
	if(!str) {
		alert("아이디를 입력하세요. ");
		f.userId.focus();
		return;
	}
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
		alert("아이디는 5~10자이며 첫글자는 영문자이어야 합니다.");
		f.userId.focus();
		return;
	}
	f.userId.value = str;

	str = f.userPwd.value;
	str = str.trim();
	if(!str) {
		alert("패스워드를 입력하세요. ");
		f.userPwd.focus();
		return;
	}
	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
		alert("패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
		f.userPwd.focus();
		return;
	}
	f.userPwd.value = str;

	if(str!= f.userPwdCheck.value) {
        alert("패스워드가 일치하지 않습니다. ");
        f.userPwdCheck.focus();
        return;
	}
	
    str = f.userName.value;
	str = str.trim();
    if(!str) {
        alert("이름을 입력하세요. ");
        f.userName.focus();
        return;
    }
    f.userName.value = str;

    str = f.birth.value;
	str = str.trim();
    if(!str || !isValidDateFormat(str)) {
        alert("생년월일를 입력하세요[YYYY-MM-DD]. ");
        f.birth.focus();
        return;
    }
    
    str = f.tel1.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel1.focus();
        return;
    }

    str = f.tel2.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel2.focus();
        return;
    }
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.tel2.focus();
        return;
    }

    str = f.tel3.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel3.focus();
        return;
    }
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.tel3.focus();
        return;
    }
    
    str = f.email1.value;
	str = str.trim();
    if(!str) {
        alert("이메일을 입력하세요. ");
        f.email1.focus();
        return;
    }

    str = f.email2.value;
	str = str.trim();
    if(!str) {
        alert("이메일을 입력하세요. ");
        f.email2.focus();
        return;
    }

 	f.action = "${pageContext.request.contextPath}/member/${mode}";

    f.submit();
}

function changeEmail() {
    var f = document.memberForm;
	    
    var str = f.selectEmail.value;
    if(str!="direct") {
        f.email2.value=str; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value="";
        f.email2.readOnly = false;
        f.email1.focus();
    }
}

function userIdCheck() {
	var str = $("#userId").val();
	str = str.trim();
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
		$("#userId").focus();
		return;
	}
	
	var url="${pageContext.request.contextPath}/member/userIdCheck";
	var q="userId="+str;
	
	$.ajax({
		type:"post"
		,url:url
		,data:q
		,dataType:"json"
		,success:function(data) {
			var p=data.passed;
			if(p=="true") {
				var s="<p class='help-block' style='color:blue;font-weight:bold;'>"+str+"</p> 아이디는 사용 가능합니다.";
				$("#userId").next(".help-block").html(s);
			} else {
				var s="<p  class='help-block' style='color:red;font-weight:bold;'>"+str+"</p> 아이디는 사용할 수 없습니다.";
				$("#userId").next(".help-block").html(s);
				$("#userId").val("");
				$("#userId").focus();
			}
		}
	    ,error:function(e) {
	    	console.log(e.responseText);
	    }
	});
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
<br>
<div class="row body-title">
          <h3 style="font-family : 'Jua', sans-serif;"> <i class="fas fa-user-plus"></i>&nbsp;&nbsp;${mode=="member"?"회원 가입":"회원 정보 수정"} </h3>
    </div>
    
    <div class="row alert alert-info">
        <i class="glyphicon glyphicon-info-sign"></i> N차 신상의 회원이 되시면 회원님만의 유익한 정보를 만날수 있습니다.
    </div>
    
<hr>
	<form  name="memberForm" method="post" enctype="multipart/form-data">
 			 <div >
 			 <label class="col-sm-2 control-label" for="userPwd">프로필 사진</label>
				 <div class="profile_photo" >
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
    <tr>
    	<td>아이디</td>
    	<td>
    		<input class="form-control" id="userId"  onchange="userIdCheck();" name="userId" type="text" placeholder="아이디"
	                       value="${dto.userId}"
	                       ${mode=="update" ? "readonly='readonly' style='border:none;'":""}>
	            <p class="help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</p>
    	</td>
    </tr>
    <tr>
    	<td>패스워드</td>
    	<td>
	            <input class="form-control" id="userPwd" name="userPwd" type="password" placeholder="비밀번호">
	            <p class="help-block">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p>
    	</td>
    </tr>
    <tr>
    	<td>패스워드 확인</td>
    	<td>
	            <input class="form-control" id="userPwdCheck" name="userPwdCheck" type="password" placeholder="비밀번호 확인">
	            <p class="help-block">패스워드를 한번 더 입력해주세요.</p>
    	</td>
    </tr>
    <tr>
    	<td>이름 </td>
    	<td>
	            <input class="form-control" id="userName" name="userName" type="text" placeholder="이름"
	                       value="${dto.userName}" ${mode=="update" ? "readonly='readonly' style='border:none;' ":""}>
    	</td>
    </tr>
    <tr>
    	<td>생년월일 </td>
    	<td>
	            <input class="form-control" id="birth" name="birth" type="text" placeholder="생년월일" value="${dto.birth}">
	            <p class="help-block">생년월일은 2000-01-01 형식으로 입력 합니다.</p>
    	</td>
    </tr>
    <tr>
    	<td>우편번호 </td>
    	<td>
	            <input class="form-control" type="text" name="zip" id="zip" value="${dto.zip}">
	           <button type="button" class="btn btn-info btn-xs" onclick="daumPostcode();" style="margin-top: 10px;"> 우편번호</button>    
    	</td>
    </tr>
    <tr>
    	<td>상세주소 </td>
    	<td>
	         <input class="form-control" type="text" name="addr1" id="addr1"  value="${dto.addr1}" placeholder="기본 주소" readonly="readonly">
	         <input class="form-control" type="text" name="addr2" id="addr2" value="${dto.addr2}" placeholder="나머지 주소">
    	</td>
    </tr>
    <tr>
    	<td>이메일 </td>
    	<td>
    	<div class="row" style="display: flex; align-items:  center;">
	         			<input class="form-control" type="text" name="email1" value="${dto.email1}" size="13" maxlength="30" style="width: 30%;">
			          &nbsp;  @ &nbsp;
	            		<select name="selectEmail" onchange="changeEmail();" class="selectField form-control" style="width: 30%;">
			                <option value="">선 택</option>
			                <option value="naver.com" ${dto.email2=="naver.com" ? "selected='selected'" : ""}>네이버 메일</option>
			                <option value="hanmail.net" ${dto.email2=="hanmail.net" ? "selected='selected'" : ""}>한 메일</option>
			                <option value="hotmail.com" ${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>핫 메일</option>
			                <option value="gmail.com" ${dto.email2=="gmail.com" ? "selected='selected'" : ""}>지 메일</option>
			                <option value="direct">직접입력</option>
			            </select>&nbsp;
			            <input class="form-control" type="text" name="email2" value="${dto.email2}" size="13" maxlength="30"  readonly="readonly"style="width: 30%;">
    	</div>
    	</td>
    </tr>
    <tr>
    	<td>연락처 </td>
    	<td>
	             <div class="row" style="display: flex;align-items: center;">
							  <select class="form-control" id="tel1" name="tel1" style="width: 30%;">
									<option value="">선 택</option>
									<option value="010" ${dto.tel1=="010" ? "selected='selected'" : ""}>010</option>
									<option value="011" ${dto.tel1=="011" ? "selected='selected'" : ""}>011</option>
									<option value="016" ${dto.tel1=="016" ? "selected='selected'" : ""}>016</option>
									<option value="017" ${dto.tel1=="017" ? "selected='selected'" : ""}>017</option>
									<option value="018" ${dto.tel1=="018" ? "selected='selected'" : ""}>018</option>
									<option value="019" ${dto.tel1=="019" ? "selected='selected'" : ""}>019</option>
							  </select>
	
							&nbsp;-&nbsp;
	 						  <input class="form-control" id="tel2" name="tel2" type="text" value="${dto.tel2}" maxlength="4" style="width: 30%;">
							&nbsp;-&nbsp;
							  <input class="form-control" id="tel3" name="tel3" type="text" value="${dto.tel3}" maxlength="4" style="width: 30%;">
	             </div>
    	</td>
    </tr>
      <tr>
    	<td>약관동의 </td>
    	<td>
    		        <input id="agree" name="agree" type="checkbox" checked="checked"
	                         onchange="form.sendButton.disabled = !checked"> <a href="#">이용약관</a>에 동의합니다.
    	</td>
    </tr>
    <tr>
    	<td colspan="2">
    	
    	<c:if test="${mode=='update'}">
			       			<input type="hidden" name="profile_imageFilename" value="${dto.profile_imageFilename}">
		</c:if>
		<div class="row" style="display: flex; justify-content: center;">
	            <button type="button"  name="sendButton" class="btn btn-primary" onclick="memberOk();">${mode=="member"?"회원가입":"정보수정"} <span class="glyphicon glyphicon-ok"></span></button>
	            &nbsp;&nbsp;<button type="reset" class="btn btn-primary">다시입력</button>
	            &nbsp;&nbsp;<button type="button" class="btn btn-danger" onclick="javascript:location.href='${pageContext.request.contextPath}/';">${mode=="member"?"가입취소":"수정취소"} <span class="glyphicon glyphicon-remove"></span></button>
		</div>
	                <p class="form-control-static">${message}</p>
    	</td>
    </tr>
    </table>
	</form>		

     

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addr2').focus();
            }
        }).open();
    }
</script>
