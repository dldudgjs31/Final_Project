<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
<c:if test="${mode=='update'}">
  function deleteFile(fileNum) {
		var url="${pageContext.request.contextPath}/notice/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$("#f"+fileNum).remove();
		}, "json");
  }
</c:if>

function ajaxJSON(url, method, query, fn) {
	$.ajax({
		type:method
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status===403) {
	    		login();
	    		return false;
	    	}
	    	
	    	console.log(jqXHR.responseText);
	    }
	});
}
function ajaxFileJSON(url, method, query, fn) {
	$.ajax({
		type:method
		,url:url
        ,processData: false  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
        ,contentType: false  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status===403) {
	    		login();
	    		return false;
	    	}
	    	
	    	console.log(jqXHR.responseText);
	    }
	});
}
</script>

<div class="alert-info">
   <i class="fas fa-info-circle"></i>
     중요한 일정 및 알림, 이벤트 등은 공지사항 통해 고객님께 알려 드립니다.
</div>

<form name="noticeForm" method="post" enctype="multipart/form-data">
  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
  <tbody id="tb">
  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
      <td style="padding-left:10px;"> 
        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.subject}">
      </td>
  </tr>

  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">공지여부</td>
      <td style="padding-left:10px;"> 
            <input type="checkbox" name="notice" value="1" ${dto.notice==1 ? "checked='checked' ":"" } > 공지
      </td>
  </tr>

  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
      <td style="padding-left:10px;"> 
          ${sessionScope.member.userName}
      </td>
  </tr>

  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
      <td valign="top" style="padding:5px 0px 5px 10px;"> 
        <textarea name="content" id="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
      </td>
  </tr>
  
  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
      <td style="padding-left:10px;"> 
          <input type="file" name="upload" multiple="multiple" class="boxTF" size="53" style="width: 95%; height: 25px;">
       </td>
  </tr>
  </tbody>
  
<c:if test="${mode=='update'}">
   <c:forEach var="vo" items="${listFile}">
		  <tr id="f${vo.fileNum}" height="40" style="border-bottom: 1px solid #cccccc;"> 
		      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨부된파일</td>
		      <td style="padding-left:10px;">
		        <a href="javascript:deleteFile('${vo.fileNum}');"><i class="far fa-trash-alt"></i></a> 
				${vo.originalFilename}
		      </td>
		  </tr>
   </c:forEach>
</c:if>	  
  </table>

  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
     <tr height="45"> 
      <td align="center" >
        <button type="submit" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
        <button type="reset" class="btn">다시입력</button>
        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/notice/list';">${mode=='update'?'수정취소':'등록취소'}</button>
         <c:if test="${mode=='update'}">
         	 <input type="hidden" name="num" value="${dto.num}">
        	 <input type="hidden" name="page" value="${page}">
        </c:if>
      </td>
    </tr>
  </table>
</form>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "${pageContext.request.contextPath}/resources/se/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["content"].getIR();
	alert(sHTML);
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}

function sendOk() {
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	
    var f = document.noticeForm;

	var str = f.subject.value;
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return false;
    }

    var mode="${mode}";
    var url="${pageContext.request.contextPath}/notice/"+mode;
    var query = new FormData(f);
    var page = "${page}";
    
	var fn = function(data){
		var state=data.state;
        if(state=="false")
            alert("게시물을 추가(수정)하지 못했습니다. !!!");

    	if(page==undefined || page=="")
    		page="1";
    	
    	if(mode=="created") {
		url="${pageContext.request.contextPath}/notice/list?page="+page;
    	} else {
    		page="1";
    	}
	};
	return true;
	ajaxFileJSON(url, "post", query, fn);		
}
</script>
