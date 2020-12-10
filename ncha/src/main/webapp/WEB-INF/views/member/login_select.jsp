<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.lbl {
   position:absolute; 
   margin-left:15px; margin-top: 17px;
   color: #999999; font-size: 11pt;
}
.loginTF {
  width: 340px; height: 35px;
  padding: 5px;
  padding-left: 15px;
  border:1px solid #999999;
  color:#333333;
  margin-top:5px; margin-bottom:5px;
  font-size:14px;
  border-radius:4px;
}
</style>



<script type="text/javascript">
$(function(){

	$.each($(".print-tab .print-tab-menu > li"), function(index, value){
		var menu = $(value).data('tab-menu');
		var tabID = $(value).parent().parent().data('tab-id');
		var hash = window.location.hash.split("#").join('');
		
		if(hash.length > 0){
				
			if(menu == hash){
				$('.print-tab[data-tab-id="' + tabID + '"] .print-tab-menu > li[data-tab-menu="' + menu + '"]').addClass('active');
				$('.print-tab[data-tab-id="' + tabID + '"] .print-tab-content > div[data-tab-content="' + menu + '"]').addClass('view');
			}
			
		}else{
			$('.print-tab[data-tab-id="' + tabID + '"] .print-tab-menu > li:eq(0)').addClass('active');
			$('.print-tab[data-tab-id="' + tabID + '"] .print-tab-content > div:eq(0)').addClass('view');
		}
	});
	


	$(".print-tab .print-tab-menu > li").click(function(event){
		var $this = $(this),
			$data = $this.data('tab-menu'),
			$tabID = $this.parent().parent().data('tab-id');
		if(!$(this).hasClass("active")){

			window.location.hash = $data;
			
			$('.print-tab[data-tab-id="' + $tabID + '"] .print-tab-menu > li').removeClass('active');
			$(this).addClass('active');
			
			$('.print-tab[data-tab-id="' + $tabID + '"] .print-tab-content > div.view').removeClass('view');
			$('.print-tab[data-tab-id="' + $tabID + '"] .print-tab-content > div[data-tab-content="' + $data + '"]').addClass('view');
		}
	});
});
</script>

<style>
@import url('https://fonts.googleapis.com/css?family=Source+Sans+Pro');

.wrapper {
  margin: 2% auto 0 auto;
  max-width: 700px;
  font-family: 'Source Sans Pro', sans-serif;
}

.print-tab {
  margin-bottom: 3em;
	width: 100%;
	box-shadow: 0px 0px 5px -1px rgba(0,0,0,0.62);
	overflow: hidden;
}
	
.print-tab ul.print-tab-menu {
	width: 100%;
	overflow: hidden;
	overflow-x: auto;
  white-space: nowrap;
	background: #f3f3f3;
	box-shadow: rgba(0, 0, 0, 0.298039) 0px 0px 4px;
}
	
.print-tab ul.print-tab-menu > li {
	position: relative;
	margin: 0 -0.2em 0 0;
	display: inline-block;
	cursor: pointer;
}

.print-tab ul.print-tab-menu > li.active {
	border-top: 3px solid red;
	background: #fff;
	box-shadow: rgba(0, 0, 0, 0.14902) 0px -2px 3px 0px;
	z-index: 2;
}

.print-tab ul.print-tab-menu > li > a {
	display: block;
  min-width: 140px; 
	max-width: 300px;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	color: #818181;
	font-size: 15px;
	line-height: 50px;
	text-align: center;
}

.print-tab .print-tab-content > div {
	margin-top: -3px;
	position: relative;
	padding: 5px;
	display: none;
	background: #fff;
	box-shadow: rgba(0, 0, 0, 0.298039) 1px 0px 10px 1px;
}

.print-tab .print-tab-content > div.view {
	display: block;
	width: 100%;
	min-height: 200px;
}

.print-tab .print-tab-content > div p {
  text-align: center;
  min-height: 200px;
  line-height: 200px;
  display: block;
}

</style>
<div class="body-container">

<div class="wrapper">

  <div class="print-tab" data-tab-id="1">
    <ul class="print-tab-menu">
      <li data-tab-menu="tab1"><a>Tab 1</a></li>
      <li data-tab-menu="tab2"><a>Tab 2</a></li>
    </ul>
    <div class="print-tab-content">
      <div data-tab-content="tab1">
      <div style="width:360px; margin: 0px auto; padding-top:90px;">
    	<div style="text-align: center;">
        	<span style="font-weight: bold; font-size:27px; color: #424951;">회원 로그인</span>
        </div>
        
		<form name="loginForm" method="post" action="">
		  <table style="margin: 15px auto; width: 100%; border-spacing: 0px;">
		  <tr align="center" height="60"> 
		      <td> 
                <label for="userId" id="lblUserId" class="lbl" >아이디</label>
		        <input type="text" name="userId" id="userId" class="loginTF" maxlength="15"
		                   tabindex="1"
                           onfocus="document.getElementById('lblUserId').style.display='none';"
                           onblur="bgLabel(this, 'lblUserId');">
		      </td>
		  </tr>
		  <tr align="center" height="60"> 
		      <td>
		        <label for="userPwd" id="lblUserPwd" class="lbl" >패스워드</label>
		        <input type="password" name="userPwd" id="userPwd" class="loginTF" maxlength="20" 
		                   tabindex="2"
                           onfocus="document.getElementById('lblUserPwd').style.display='none';"
                           onblur="bgLabel(this, 'lblUserPwd');">
		      </td>
		  </tr>
		  <tr align="center" height="65" > 
		      <td>
		        <button type="button" onclick="sendLogin();" class="btnConfirm">로그인</button>
		      </td>
		  </tr>

		  <tr align="center" height="45">
		      <td>
		       		<a href="${pageContext.request.contextPath}/">아이디찾기</a>&nbsp;&nbsp;&nbsp;
		       		<a href="${pageContext.request.contextPath}/">패스워드찾기</a>&nbsp;&nbsp;&nbsp;
		       		<a href="${pageContext.request.contextPath}/member/member">회원가입</a>
		       		<a href="${pageContext.request.contextPath}/seller/login">판매회원 로그인</a>
		      </td>
		  </tr>
		  
		  <tr align="center" height="40" >
		    	<td><span style="color: blue;">${message}</span></td>
		  </tr>
		  
		  </table>
		</form>           
	</div>
      </div>
      <div data-tab-content="tab2">
      <div style="width:360px; margin: 0px auto; padding-top:90px;">
    	<div style="text-align: center;">
        	<span style="font-weight: bold; font-size:27px; color: #424951;">판매회원 로그인</span>
        </div>
        
		<form name="loginForm" method="post" action="">
		  <table style="margin: 15px auto; width: 100%; border-spacing: 0px;">
		  <tr align="center" height="60"> 
		      <td> 
                <label for="userId" id="lblUserId" class="lbl" >아이디</label>
		        <input type="text" name="sellerId" id="userId" class="loginTF" maxlength="15"
		                   tabindex="1"
                           onfocus="document.getElementById('lblUserId').style.display='none';"
                           onblur="bgLabel(this, 'lblUserId');">
		      </td>
		  </tr>
		  <tr align="center" height="60"> 
		      <td>
		        <label for="userPwd" id="lblUserPwd" class="lbl" >패스워드</label>
		        <input type="password" name="pwd" id="userPwd" class="loginTF" maxlength="20" 
		                   tabindex="2"
                           onfocus="document.getElementById('lblUserPwd').style.display='none';"
                           onblur="bgLabel(this, 'lblUserPwd');">
		      </td>
		  </tr>
		  <tr align="center" height="65" > 
		      <td>
		        <button type="button" onclick="sendLogin1();" class="btnConfirm">로그인</button>
		      </td>
		  </tr>

		  <tr align="center" height="45">
		      <td>
		       		<a href="${pageContext.request.contextPath}/">아이디찾기</a>&nbsp;&nbsp;&nbsp;
		       		<a href="${pageContext.request.contextPath}/">패스워드찾기</a>&nbsp;&nbsp;&nbsp;
		       		<a href="${pageContext.request.contextPath}/member/member">회원가입</a>
		       		<a href="${pageContext.request.contextPath}/member/login">일반회원 로그인</a>
		      </td>
		  </tr>
		  
		  <tr align="center" height="40" >
		    	<td><span style="color: blue;">${message}</span></td>
		  </tr>
		  
		  </table>
		</form>           
	</div>
      </div>
    </div>
  </div>
  
  
</div>


</div>
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
    var f = document.loginForm;

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