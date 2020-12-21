<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
body{
	margin:0;
	color:#6a6f8c;
	background:#c8c8c8;
}
*,:after,:before{box-sizing:border-box}
.clearfix:after,.clearfix:before{content:'';display:table}
.clearfix:after{clear:both;display:block}
a{color:inherit;text-decoration:none}

.login-wrap{
	width:100%;
	margin:auto;
	max-width:525px;
	min-height:670px;
	position:relative;
	box-shadow:0 12px 15px 0 rgba(0,0,0,.24),0 17px 50px 0 rgba(0,0,0,.19);
}
.login-html{
	width:100%;
	height:100%;
	position:absolute;
	padding:90px 70px 50px 70px;
	background:rgba(40,57,101,.9);
}
.login-html .sign-in-htm,
.login-html .sign-up-htm{
	top:0;
	left:0;
	right:0;
	bottom:0;
	position:absolute;
	transform:rotateY(180deg);
	backface-visibility:hidden;
	transition:all .4s linear;
}
.login-html .sign-in,
.login-html .sign-up,
.login-form .group .check{
	display:none;
}
.login-html .tab,
.login-form .group .label,
.login-form .group .button{
	text-transform:uppercase;
}
.login-html .tab{
	font-size:22px;
	margin-right:15px;
	padding-bottom:5px;
	margin:0 15px 10px 0;
	display:inline-block;
	border-bottom:2px solid transparent;
}
.login-html .sign-in:checked + .tab,
.login-html .sign-up:checked + .tab{
	color:#fff;
	border-color:#1161ee;
}
.login-form{
	min-height:345px;
	position:relative;
	perspective:1000px;
	transform-style:preserve-3d;
}
.login-form .group{
	margin-bottom:15px;
}
.login-form .group .label,
.login-form .group .input,
.login-form .group .button{
	width:100%;
	color:#fff;
	display:block;
}
.login-form .group .input,
.login-form .group .button{
	border:none;
	padding:15px 20px;
	border-radius:25px;
	background:rgba(255,255,255,.1);
}
.login-form .group input[data-type="password"]{
	text-security:circle;
	-webkit-text-security:circle;
}
.login-form .group .label{
	color:#aaa;
	font-size:12px;
}
.login-form .group .button{
	background:#1161ee;
	font-size:15px; 
	font-family: 'Noto Serif KR', serif;
}
.login-form .group .button:hover{
	background:skyblue;
}
.login-form .group label .icon{
	width:15px;
	height:15px;
	border-radius:2px;
	position:relative;
	display:inline-block;
	background:rgba(255,255,255,.1);
}
.login-form .group label .icon:before,
.login-form .group label .icon:after{
	content:'';
	width:10px;
	height:2px;
	background:#fff;
	position:absolute;
	transition:all .2s ease-in-out 0s;
}
.login-form .group label .icon:before{
	left:3px;
	width:5px;
	bottom:6px;
	transform:scale(0) rotate(0);
}
.login-form .group label .icon:after{
	top:6px;
	right:0;
	transform:scale(0) rotate(0);
}
.login-form .group .check:checked + label{
	color:#fff;
}
.login-form .group .check:checked + label .icon{
	background:#1161ee;
}
.login-form .group .check:checked + label .icon:before{
	transform:scale(1) rotate(45deg);
}
.login-form .group .check:checked + label .icon:after{
	transform:scale(1) rotate(-45deg);
}
.login-html .sign-in:checked + .tab + .sign-up + .tab + .login-form .sign-in-htm{
	transform:rotate(0);
}
.login-html .sign-up:checked + .tab + .login-form .sign-up-htm{
	transform:rotate(0);
}

.hr{
	height:2px;
	margin:60px 0 50px 0;
	background:rgba(255,255,255,.2);
}
.foot-lnk{
	text-align:center;
}
</style>

<script type="text/javascript">
function bgLabel(ob, id) {
    if(!ob.value) {
	    document.getElementById(id).style.display="";
    } else {
	    document.getElementById(id).style.display="none";
    }
}

function sendLogin() {
    var f = document.loginForm;

    if(! f.userId.value) {
        alert("아이디를 입력하세요. ");
        f.userId.focus();
        return;
    }

    if(! f.userPwd.value) {
        alert("패스워드를 입력하세요. ");
        f.userPwd.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/member/login";
    f.submit();
}
function sendLogin1() {
    var f = document.loginForm1;

    if(! f.sellerId.value) {
        alert("아이디를 입력하세요. ");
        f.sellerId.focus();
        return;
    }

    if(! f.pwd.value) {
        alert("패스워드를 입력하세요. ");
        f.pwd.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/seller/login";
    f.submit();
}
</script>

<div class="body-container">

	 		<br><br><br> 		
<div class="login-wrap">
	<div class="login-html">
		 <div style="text-align: center;">
    		<P><img alt="로고" src="${pageContext.request.contextPath}/resources/img/Nlogo.png" width="250px"></P>
    		<br><br><br>
        </div>
		<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">일반회원 로그인</label>
		<input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">판매회원 로그인</label>
		<div class="login-form">
		
			<div class="sign-in-htm">
			<form name="loginForm" method="post" action="">
			<br>
				<div class="group">
					<label for="userId" id="lblUserId" class="label">아이디</label>
					<input id="userId" name="userId"  type="text" class="input"  onfocus="document.getElementById('lblUserId').style.display='none';"
                           onblur="bgLabel(this, 'lblUserId');">
				</div>
				<div class="group">
					<label for="userPwd" id="lblUserPwd" class="label">패스워드</label>
					<input id="userPwd" name="userPwd" type="password" class="input" data-type="password" onfocus="document.getElementById('lblUserPwd').style.display='none';"
                           onblur="bgLabel(this, 'lblUserPwd');">
				</div>
				<br>
				<div class="group">
					<input type="submit" class="button" value="로&nbsp;&nbsp;그&nbsp;&nbsp;인"  onclick="sendLogin();">
				</div>
				<div class="hr"></div>
				<div class="foot-lnk">
					<span style="color: white;">${message}</span>
				</div>
			</form> 
			</div>
			
			
			
			<div class="sign-up-htm">
			<form name="loginForm1" method="post" action="">
			<br>
				<div class="group">
					<label for="userId" id="lblUserId" class="label">아이디</label>
					<input id="userId" name="sellerId"  type="text" class="input"  onfocus="document.getElementById('lblUserId').style.display='none';"
                           onblur="bgLabel(this, 'lblUserId');">
				</div>
				<div class="group">
					<label for="userPwd" id="lblUserPwd" class="label">패스워드</label>
					<input id="userPwd" name="pwd" type="password" class="input" data-type="password" onfocus="document.getElementById('lblUserPwd').style.display='none';"
                           onblur="bgLabel(this, 'lblUserPwd');">
				</div>
				<br>
				<div class="group">
					<input type="submit" class="button" value="로그인"  onclick="sendLogin1();">
				</div>
				<div class="hr"></div>
				<div class="foot-lnk">
					<span style="color: white;">${message}</span>
				</div>
			</form> 
			</div>
		</div>
	</div>
</div>
  <br><br><br><br><br>
</div>


