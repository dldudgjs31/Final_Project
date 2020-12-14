<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(function(){
	  $("body").on("change", "input[name=upload]", function(){
		  if(! $(this).val()) {
			  return;	
		  }
		
		  var b=false;
		  $("input[name=upload]").each(function(){
			  if(! $(this).val()) {
				  b=true;
			  	  return false;
			  }
		  });
		
		  if(b) return;

		  var $tr, $td, $input;
		
	      $tr=$("<tr align='left' height='40' style='border-bottom: 1px solid #cccccc;'>");
	      $td=$("<td>", {width:"100", bgcolor:"#eeeeee", style:"text-align: center;", html:"첨&nbsp;&nbsp;&nbsp;&nbsp;부"});
	      $tr.append($td);
	      $td=$("<td style='padding-left:10px;'>");
	      $input=$("<input>", {type:"file", name:"upload", class:"boxTF", style:"width: 95%; height: 25px;"});
	      $td.append($input);
	      $tr.append($td);
	    
	      $("#tb").append($tr);
	  });
});

<c:if test="${mode=='update'}">
function deleteFile(fileNum) {
		var url="${pageContext.request.contextPath}/used/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$("#f"+fileNum).remove();
		}, "json");
}
</c:if>


function sendOk(){
	var f = document.usedForm;
	
	var str = f.subject.value;
	if(!str){
		alert("제목을 입력하세요.");
		f.subject.focus();
		return;
	}
	
	str = f.content.value;
	if(!str){
		alert("내용을 입력하세요.");
		f.content.focus();
		return;
	}
	
	f.action="${pageContext.request.contextPath}/used/${mode}";
	f.submit();
}

function state(s){
	var f = document.usedForm;
	f.productCondition.value=s;
}

function payMethod(s){
	var f = document.usedForm;
	f.dealingMode.value=s;
}
</script>

<div class = "body-containter" style="width:700px;">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard"></i>중고거래 글쓰기</h3>
	</div>

	<div>
		<form name="usedForm" method="post" enctype="multipart/form-data">	
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
				<td style="padding-left:10px;">
					${sessionScope.member.userName}
				</td>
			</tr>
			
			<tbody>
			<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
      			<td width="100" bgcolor="#eeeeee" style="text-align: center;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
     			 <td style="padding-left:10px;"> 
          			<input type="file" name="upload" multiple="multiple" class="boxTF" size="53" style="width: 95%; height: 25px;">
       			</td>
  			</tr>
			<c:if test="${mode=='update'}">
				   <c:forEach var="vo" items="${listFile}">
						  <tr id="${dto.used_imageFileNum}" height="40" style="border-bottom: 1px solid #cccccc;"> 
						      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨부된파일</td>
						      <td style="padding-left:10px;"> 
								<a href="javascript:deleteFile('${dto.used_imageFileNum}');"><i class="far fa-trash-alt"></i></a> 
								${dto.imageFilename}
						      </td>
						  </tr>
				  </c:forEach>
			</c:if>
			</tbody>
			
			<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td style="padding-left:10px;">
					<input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="">
				</td>
			</tr>


			<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">카테고리</td>
				<td style="padding-left:10px;">
					<select class="selectField" id="categoryNum" name="categoryNum">
						<option value="">::카테고리 선택::</option>
						<option value="1" ${dto.categoryNum=="1"?"selected='selected'":""}>의류</option>
						<option value="2" ${dto.categoryNum=="2"?"selected='selected'":""}>가구</option>
						<option value="3" ${dto.categoryNum=="3"?"selected='selected'":""}>전자제품</option>
						<option value="4" ${dto.categoryNum=="4"?"selected='selected'":""}>도서</option>
						<option value="5" ${dto.categoryNum=="5"?"selected='selected'":""}>기타</option>
					</select>
				</td>
			</tr>

			<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">가&nbsp;&nbsp;&nbsp;&nbsp;격</td>
				<td style="padding-left:10px;">
					<input type="text" name="price" maxlength="100" class="boxTF" style="width: 95%;" value="">
				</td>
			</tr>
			
			<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">상품&nbsp;&nbsp;상태</td>
				<td style="padding-left:10px;">
					<button type="button" onclick="state('New')">미개봉</button>
					<button type="button" onclick="state('almostNew')">거의새것</button>
					<button type="button" onclick="state('used')">사용감 있음</button>
					<input type="hidden" name="productCondition" value="1">
				</td>
			</tr>

			<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">결제&nbsp;&nbsp;방법</td>
				<td style="padding-left:10px;">
					<button type="button" onclick="payMethod('cash')">현금</button>
					<button type="button" onclick="payMethod('account')">계좌이체</button>
					<input type="hidden" name="dealingMode" value="1">
				</td>
			</tr>
			
			<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">거래&nbsp;&nbsp;지역</td>
				<td style="padding-left:10px;">
					<select class="selectField" id="location" name="location">
						<option value="">::거래지역 선택::</option>
						<option value="seoul" ${dto.location=="seoul"?"selected='selected'":""}>서울</option>
						<option value="incheon" ${dto.location=="incheon"?"selected='selected'":""}>인천</option>
						<option value="gyeonggi" ${dto.location=="gyeonggi"?"selected='selected'":""}>경기</option>
					</select>
				</td>
			</tr>	
			
			<tr align="left" style="border-bottom: 1px solid #cccccc;">
				<td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
				<td valign="top" style="padding:5px 0px 5px 10px;"> 
					<textarea name="content" rows="12" class="boxTA" style="width: 95%;"></textarea>
				</td>
			</tr>			
		</table>

		<table style="width: 100%; border-spacing: 0px;">
			<tr height="45">
				<td align="center" >
					<button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/used/list';">${mode=='update'?'수정취소':'등록취소'}</button>
				</td>
			</tr>
		</table>
		</form>
	</div>

</div>
