<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/util.js"></script>
<script type="text/javascript">
    function sendMail() {
        var f = document.mailForm;
        var str;

        str = f.senderName.value;
        if(!str) {
            alert("이름을 입력하세요. ");
            f.senderName.focus();
            return;
        }
        
    	if(!isValidEmail(f.senderEmail.value)) {
            alert("정상적인 E-Mail을 입력하세요. ");
            f.senderEmail.focus();
            return;
    	}
        
    	if(!isValidEmail(f.receiverEmail.value)) {
            alert("정상적인 E-Mail을 입력하세요. ");
            f.receiverEmail.focus();
            return;
    	}
        
    	str = f.subject.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.subject.focus();
            return;
        }

    	str = f.content.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return;
        }

   		f.action="${pageContext.request.contextPath}/mail/send";

        f.submit();
    }
    
    $(function(){
      	$("body").on("change", "#tb input[name=upload]", function(){
      		if(! $(this).val()) {
      			return;	
      		}
      		
      		var b=false;
      		$("#tb input[name=upload]").each(function(){
      			if(! $(this).val()) {
      				b=true;
      				return false;
      			}
      		});
      		if(b) {
      			return false;
      		}
      		
      		var $tr = $(this).closest("tr").clone(true);
            $tr.find("input").val("");
            $("#tb").append($tr);      		
      	});
    });
    
</script>

<div class="body-container" style="width: 700px;">
     <div class="body-title">
         <h3><i class="far fa-envelope"></i> 메일 보내기 </h3>
     </div>
     
	<div>
		<form name="mailForm" method="post" enctype="multipart/form-data">
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0; border-collapse: collapse;">
				
			  <tbody id="tb">	
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="130" align="right" bgcolor="#eeeeee" style="padding-right: 10px;">보내는사람 이름</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="senderName" maxlength="100" class="boxTF" style="width: 98%;" value="${sessionScope.member.userName}">
			      </td>
			  </tr>

			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="130" align="right" bgcolor="#eeeeee" style="padding-right: 10px;">보내는사람 E-Mail</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="senderEmail" maxlength="100" class="boxTF" style="width: 98%;" value="">
			      </td>
			  </tr>

			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="130" align="right" bgcolor="#eeeeee" style="padding-right: 10px;">받는사람 E-Mail</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="receiverEmail" maxlength="100" class="boxTF" style="width: 98%;" value="">
			      </td>
			  </tr>

			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="130" align="right" bgcolor="#eeeeee" style="padding-right: 10px;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 98%;" value="">
			      </td>
			  </tr>
			
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="130" align="right" bgcolor="#eeeeee" style="padding-right: 10px; padding-top: 5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="content" rows="12" class="boxTA" style="width: 98%; height: 200px;"></textarea>
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
			      <td width="130" align="right" bgcolor="#eeeeee" style="padding-right: 10px;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
			      <td style="padding-left:10px;"> 
			           <input type="file" name="upload" class="boxTF" style="width: 98%; height: 25px;">
			       </td>
			  </tr> 
			  </tbody>
			</table>

			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" class="btn" onclick="sendMail();">메일 전송</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/';">전송 취소</button>
			      </td>
			    </tr>
			</table>
		</form>
     </div>

</div>
