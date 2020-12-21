<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
    function check() {
        var f = document.boardForm;

    	var str = f.subject.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.subject.focus();
            return false;
        }
	//기본으로 들어가는 값 설정
        str = f.content.value;
        if(!str || str=="<p>&nbsp;</p>") {
            f.content.focus();
            return false;
        }

    	f.action="${pageContext.request.contextPath}/store/${mode}";

        return true;
    }
    
    function preWatchphoto(event){
    	for (var image of event.target.files) {
    			var reader = new FileReader();
    			reader.onload = function(event){
    				var img =document.createElement("img");
    				img.setAttribute("src",event.target.result);
    				document.querySelector("div#main_img").appendChild(img);
    			}
    			reader.readAsDataURL(image);
    		}
    }

      <c:if test="${mode=='update'}">
      function deleteFile(store_imageFilenum) {
    		var url="${pageContext.request.contextPath}/store/deleteFile";
    		$.post(url, {daily_imageFilenum:daily_imageFilenum}, function(data){
    			$("#"+daily_imageFilenum).remove();
    		}, "json");
      }
    </c:if>
    
$(function(){
    	
    	$("form input[name=upload]").change(function(){
    		if(! $(this).val()) return;
    		
    		var b=false;
    		$("form input[name=upload]").each(function(){
    			if(! $(this).val()) {
    				b=true;
    				return;
    			}
    		});
    		if(b) {
    			return false;
    		}
    	
    		var $tr = $(this).closest("tr").clone(true); // 이벤트도 복제
    		$tr.find("input").val("");
    		$("#boardBody").append($tr);
    		
    		
    	});
});

</script>

<div class="body-container" style="width: 830px;">
    <div class="body-title">
        <h3><i class="fab fa-asymmetrik"></i> ${mode=='update'?'판매글 수정하기':'판매글 올리기'} </h3>
    </div>
    				<label style="font-weight: 900; font-size: 50;">메인 사진</label>
				 <div class="profile_photo" id="main_img">

				 </div>	 
    <div>
			<form name="boardForm" method="post" onsubmit="return submitContents(this);" enctype="multipart/form-data">
			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			  <tbody id="boardBody">
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">상품명</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="productName" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.productName}">
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
			      <td style="padding-left:10px;"> 
			          ${sessionScope.seller.sellerName}
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제품 가격</td>
			      <td style="padding-left:10px;"> 
			        <input type="number" name="price" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.price}">
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">재고</td>
			      <td style="padding-left:10px;"> 
			        <input type="number" name="stock" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.stock}">
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">할인률</td>
			      <td style="padding-left:10px;"> 
			        <input type="number" name="discount_rate" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.discount_rate}">
			      </td>
			  </tr>
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제품 카테고리 선택</td>
			      <td style="padding-left:10px;"> 
						<select name="categoryNum" class="selectField">
							<option value="1" >의류</option>
							<option value="2" >전자가전</option>
							<option value="3" >가구</option>
							<option value="4" >생필품</option>
						</select>
			       </td>
			  </tr>
			
			
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">상세페이지</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="detail" id="content" class="boxTA" style="width:98%; height: 270px;">${dto.detail}</textarea>
			      </td>
			  </tr>
			 
			  
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">대표 이미지</td>
			      <td style="padding-left:10px;"> 
			          <input type="file" id="image" name="upload"  multiple="multiple"  class="boxTF" onchange="preWatchphoto(event);" multiple size="53" style="width: 95%; height: 25px; multiple">
			      </td>
			  </tr>
			  </tbody>
			  	<c:if test="${mode=='update'}">
				   <c:forEach var="vo" items="${listFile}">
						  <tr id="${vo.main_productFileNum}" height="40" style="border-bottom: 1px solid #cccccc;"> 
						      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨부된파일</td>
						      <td style="padding-left:10px;"> 
								<a href="javascript:deleteFile('${vo.main_productFileNum}');"><i class="far fa-trash-alt"></i></a> 
								${vo.imageFilename}
						      </td>
						  </tr>
				   </c:forEach>
				</c:if>
			  
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			      	<c:if test="${mode=='update'}">
						<input type="hidden" name="productNum" value="${dto.productNum}">
						<input type="hidden" name="page" value="${page}">
						 <input type="hidden" name="imageFilename" value="${dto.imageFilename}">
					</c:if>
			        <button type="submit" class="btn">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/store/list';">${mode=='update'?'수정취소':'등록취소'}</button>

			      </td>
			    </tr>
			  </table>
			</form>
    </div>
    
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "${pageContext.request.contextPath}/resources/se/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			// alert(" Ok !!!");
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
	
function submitContents(elClickedObj) {
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
	
	try {
		// elClickedObj.form.submit();
		return check();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>    
    
</div>