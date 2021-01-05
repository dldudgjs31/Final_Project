<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dateUtil.js"></script>
<script type="text/javascript">
function memberOk() {
	var f = document.memberForm;
	var str;
	
	var mode = "${mode}";
	if(mode=="seller" && ! f.uploadphoto.value){
		alert("이미지 파일을 선택하세요.");
		f.uploadphoto.focus();
		return;
	}
	
	str = f.sellerId.value;
	str = str.trim();
	if(!str) {
		alert("아이디를 입력하세요. ");
		f.sellerId.focus();
		return;
	}
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
		alert("아이디는 5~10자이며 첫글자는 영문자이어야 합니다.");
		f.sellerId.focus();
		return;
	}
	f.sellerId.value = str;

	str = f.pwd.value;
	str = str.trim();
	if(!str) {
		alert("패스워드를 입력하세요. ");
		f.pwd.focus();
		return;
	}
	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
		alert("패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
		f.pwd.focus();
		return;
	}
	f.pwd.value = str;

	if(str!= f.pwdCheck.value) {
        alert("패스워드가 일치하지 않습니다. ");
        f.pwdCheck.focus();
        return;
	}
	
    str = f.sellerName.value;
	str = str.trim();
    if(!str) {
        alert("이름을 입력하세요. ");
        f.sellerName.focus();
        return;
    }
    f.sellerName.value = str;
    
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

 	f.action = "${pageContext.request.contextPath}/seller/${mode}";

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

function sellerIdCheck() {
	var str = $("#sellerId").val();
	str = str.trim();
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
		$("#sellerId").focus();
		return;
	}
	
	var url="${pageContext.request.contextPath}/seller/sellerIdCheck";
	var q="sellerId="+str;
	
	$.ajax({
		type:"post"
		,url:url
		,data:q
		,dataType:"json"
		,success:function(data) {
			var p=data.passed;
			if(p=="true") {
				var s="<span style='color:blue;font-weight:bold;'>"+str+"</span> 아이디는 사용 가능합니다.";
				$("#sellerId").parent().next(".help-block").html(s);
			} else {
				var s="<span style='color:red;font-weight:bold;'>"+str+"</span> 아이디는 사용할 수 없습니다.";
				$("#sellerId").parent().next(".help-block").html(s);
				$("#sellerId").val("");
				$("#sellerId").focus();
			}
		}
	    ,error:function(e) {
	    	console.log(e.responseText);
	    }
	});
	
} 

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
          <h3 style="font-family : 'Jua', sans-serif;"> <i class="fas fa-user-plus"></i>&nbsp;&nbsp;${mode=="seller"?"판매회원 가입":"회원 정보 수정"} </h3>
    </div>
    
    <div class="row alert alert-info">
        <i class="glyphicon glyphicon-info-sign"></i> N차 신상 스토어의 판매회원이 되시면 회원님만의 스토어를 운영할 수 있습니다.
    </div>

        <div>
			<form name="memberForm" method="post" enctype="multipart/form-data">
			  	
			 <!-- 프로필 사진 업로드 및 미리 보여주기 -->
 			 <div >
 			 <label class="col-sm-2 control-label" for="userPwd">프로필 사진</label>
				 <div class="profile_photo" >
				 <c:choose>
				 	<c:when test="${empty dto.profile_imageFilename}">
				  	<img id ="img" src="${pageContext.request.contextPath}/resources/img/nophoto.png"" style="margin:10px 0;width: 200px; height: 200px; border: 2px solid silver;"/>
				 	</c:when>
				 	<c:when test="${not empty dto.profile_imageFilename}">
				  	<img id ="img" src="${pageContext.request.contextPath}/uploads/member/${dto.profile_imageFilename}" style="margin:10px 0;width: 200px; height: 200px; border: 2px solid silver;"/>
				 	</c:when>
				 </c:choose>
				 </div>
			 </div> 
			  <input   type="file" name="uploadphoto" accept="image/*" onchange="preWatchphoto(this)">
			  <br>
			  <br>
			  <table class="table">
			  <tr>
			      <td>
			           아이디
			      </td>
			      <td >
			        <p>
			            <input  class="form-control" type="text" name="sellerId" id="sellerId" value="${dto.sellerId}"
                         onchange="sellerIdCheck();"
                         ${mode=="update" ? "readonly='readonly' ":""}
                         maxlength="15" class="boxTF" placeholder="아이디">
			        </p>
			        <p class="help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</p>
			      </td>
			  </tr>
			
			  <tr>
			      <td >
			            패스워드
			      </td>
			      <td>
			        <p>
			            <input class="form-control" type="password" name="pwd" maxlength="15" class="boxTF"
			                        placeholder="패스워드">
			        </p>
			        <p class="help-block">패스워드는 5~10자 이내이며, 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p>
			      </td>
			  </tr>
			
			  <tr>
			      <td>
			      	      패스워드 확인
			      </td>
			      <td >
			        <p >
			            <input class="form-control" type="password" name="pwdCheck" maxlength="15" class="boxTF"
			                       placeholder="패스워드 확인">
			        </p>
			        <p class="help-block">패스워드를 한번 더 입력해주세요.</p>
			      </td>
			  </tr>
			
			  <tr>
			      <td>
			          판매 브랜드명
			      </td>
			      <td >
			        <p>
			            <input  class="form-control" type="text" name="sellerName" value="${dto.sellerName}" maxlength="30" class="boxTF"
		                      ${mode=="update" ? "readonly='readonly' ":""}
		                      placeholder="브랜드명">
			        </p>
			      </td>
			  </tr>
			  <tr>
			      <td>
			          브랜드 소개글
			      </td>
			      <td >
			        <p>
			            <textarea class="form-control content" name="introduce" placeholder="회원님의 브랜드를 소개하는 글을 작성해주세요.">${dto.introduce}</textarea>
			        </p>
			      </td>
			  </tr>
			  
			  <tr>
			      <td>
			           이메일
			      </td>
			      <td>
			        <div class="row" style="display: flex; align-items:  center;justify-content: center;" >
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
			      <td>
			       	    전화번호
			      </td>
			      <td>
			        	             <div class="row" style="display: flex;align-items: center;justify-content: center;">
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
			  
			  <c:if test="${mode=='seller'}">
				  <tr>
				      <td >
				        	   약관동의
				      </td>
				      <td>
				        <p >
				                 <input id="agree" name="agree" type="checkbox" checked="checked"
				                      onchange="form.sendButton.disabled = !checked"> <a href="#">이용약관</a>에 동의합니다.
				        </p>
				      </td>
				  </tr>
			  </c:if>
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			      <c:if test="${mode=='update'}">
			       	<input type="hidden" name="profile_imageFilename" value="${dto.profile_imageFilename}">
					</c:if>
			        <button type="button" name="sendButton" class="btn btn-primary" onclick="memberOk();">${mode=="seller"?"회원가입":"정보수정"}</button>
			        <button type="reset" class="btn btn-primary">다시입력</button>
			        <button type="button" class="btn btn-danger" onclick="javascript:location.href='${pageContext.request.contextPath}/';">${mode=="seller"?"가입취소":"수정취소"}</button>
			      </td>
			    </tr>
			    <tr height="30">
			        <td align="center" style="color: blue;">${message}</td>
			    </tr>
			  </table>
			</form>
        </div>
