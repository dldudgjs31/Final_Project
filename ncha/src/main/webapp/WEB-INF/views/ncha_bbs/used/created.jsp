<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<style type="text/css">
.imgs_wrap img{
	height:100px;
	width: 80px;
}
</style>


<script type="text/javascript">
var img_files=[];

$(document).ready(function(){
	$("#upload_img").on("change",handleImgFileSelect);
});


function handleImgFileSelect(e){
	img_files=[];
	$(".imgs_wrap").empty();
	
	var files=e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	
	
	filesArr.forEach(function(f){
		if(!f.type.match("image.*")){
			alert("확장자는 이미지 확장자만 가능합니다.");
		}
		
		img_files.push(f);
		
		var reader = new FileReader();
		reader.onload = function(e){
			var html = "<img src=\""+e.target.result+"\" />";
			$(".imgs_wrap").append(html);
			index++;
		}
	
		reader.readAsDataURL(f);
	});
}


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

function deleteFile(used_imageFileNum){
	var url="${pageContext.request.contextPath}/used/deleteFile";
	$.post(url, {used_imageFileNum:used_imageFileNum}, function(data){
		$("#file"+used_imageFileNum).remove();
	}, "json");
}

function goList(page){
	location.href = "${pageContext.request.contextPath}/used/list";
}

function goArticle(usedNum,page){
	location.href="${pageContext.request.contextPath}/used/article?page="+page+"&usedNum="+usedNum;
}
</script>


<div class = "body-containter" style="width:700px;">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard"></i>중고거래 글쓰기</h3>
	</div>

	<div>
		<form name="usedForm" method="post" enctype="multipart/form-data" style="margin:0 auto; width: 100%;" align = "center">	
		
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
				<td style="padding-left:10px;">
					${sessionScope.member.userName}
				</td>
			</tr>
			<c:if test="${mode=='update'}">
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
					<td width="100" bgcolor="#eeeeee" style="text-align: center;">거래 상태</td>
					<td style="padding-left:10px;">
				        <input type="radio" name="sold_check" value="0" ${dto.sold_check=="0" || not empty dto ?"checked='checked'":"" }> 거래 가능
					    <input type="radio" name="sold_check" value="1" ${dto.sold_check=="1"?"checked='checked'":"" }> 판매 완료
					</td>
				</tr>
			</c:if>
			</table>
			
			<div>
				<div class = "imgs_wrap">
				</div>
			</div>
			
			<table>
			<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
      			<td width="100" bgcolor="#eeeeee" style="text-align: center;">사&nbsp;&nbsp;&nbsp;&nbsp;진</td>
     			 <td style="padding-left:10px;"> 
          			<input type="file" name="upload" id="upload_img" onclick="fileUploadAction();" multiple="multiple" class="boxTF" size="53" style="width: 95%; height: 25px;">
       			</td>
  			</tr>
			<c:if test="${mode=='update'}">
				   <c:forEach var="vo" items="${imageList}">
						  <tr id="file${vo.used_imageFileNum}" height="40" style="border-bottom: 1px solid #cccccc;"> 
						      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨부된파일</td>
						      <td style="padding-left:10px;"> 
								<a href="javascript:deleteFile('${vo.used_imageFileNum}');"><i class="far fa-trash-alt"></i></a> 
								${vo.imageFilename}
						      </td>
						  </tr>
				  </c:forEach>
			</c:if>			
			
			
			<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td style="padding-left:10px;">
					<input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.subject}">
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
					<input type="text" name="price" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.price}">
				</td>
			</tr>
			
			<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">상품&nbsp;&nbsp;상태</td>
				<td style="padding-left:10px;">
				    <input type="radio" name="productCondition" value="미개봉" ${dto.productCondition=='미개봉' || not empty dto ?"checked='checked'":"" }> 미개봉
				    <input type="radio" name="productCondition" value="거의 새것" ${dto.productCondition=='거의 새것'?"checked='checked'":"" }> 거의 새것
				    <input type="radio" name="productCondition" value="사용감 있음" ${dto.productCondition=='사용감 있음'?"checked='checked'":"" }> 사용감 있음
				</td>
			</tr>

			<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">결제&nbsp;&nbsp;방법</td>
				
				<td style="padding-left:10px;">
				    <input type="radio" name="dealingMode" value="현금" ${dto.productCondition=='현금' || not empty dto ?"checked='checked'":"" }> 현금
				    <input type="radio" name="dealingMode" value="계좌이체" ${dto.productCondition=='계좌이체'?"checked='checked'":"" }> 계좌이체
				</td>
			
			</tr>
			
			<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">거래&nbsp;&nbsp;지역</td>
				<td style="padding-left:10px;">
					<select class="selectField" id="location" name="location">
						<option value="">::거래지역 선택::</option>
						<option value="서울" ${dto.location=="서울"?"selected='selected'":""}>서울</option>
						<option value="인천" ${dto.location=="인천"?"selected='selected'":""}>인천</option>
						<option value="경기" ${dto.location=="경기"?"selected='selected'":""}>경기</option>
					</select>
				</td>
			</tr>	
			
			<tr align="left" style="border-bottom: 1px solid #cccccc;">
				<td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
				<td valign="top" style="padding:5px 0px 5px 10px;"> 
					<textarea name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
				</td>
			</tr>
		</table>

		<table style="width: 100%; border-spacing: 0px;">
			<tr height="45">
				<td align="center" >
					<button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
					<button type="reset" class="btn">다시입력</button>
					<c:if test="${mode=='created'}">
						<button type="button" class="btn" onclick="goList('${page}')">등록취소</button>
					</c:if>
					<c:if test="${mode=='update'}">
						<button type="button" class="btn" onclick="goArticle('${usedNum}','${page}')">수정취소</button>
			         	 <input type="hidden" name="usedNum" value="${dto.usedNum}">
			        	 <input type="hidden" name="page" value="${page}">
			        </c:if>
				</td>
			</tr>
		</table>
		
		</form>
	</div>

</div>
