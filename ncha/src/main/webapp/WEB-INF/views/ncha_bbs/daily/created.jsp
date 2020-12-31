 <%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick.css" />
<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick-theme.css" />
<script type="text/javascript" src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script>

<style type="text/css">
.profile_photo img{
	height: 200px;
	width: 200px;
.body-container{
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	width: 70%;
}


.Ulist .usedUrl:hover{
color:red;
border: 1px solid #777;
	cursor:pointer;
}

.Ulist .usedList{
	display: none;
}
</style>

<script type="text/javascript">
$(function(){
	$(".usedUrl").click(function(){
		var isHidden = $(this).next().is(":hidden");
		if(isHidden){
			//$(".usedList").hide();
			$(this).next().show();			//.next()두번쓰면 다음다음꺼 나옴
		} else{
			$(this).next().hide();				
		}
		
	});
});


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
		$("#tb").append($tr);
		
		
	});
});

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

/*
$(function(){
	
	$("form img[name=imagemain]").change(function(){
		if(! $(this).val()) return;
		
		var b=false;
		$("form img[name=imagemain]").each(function(){
			if(! $(this).val()) {
				b=true;
				return;
			}
		});
		if(b) {
			return false;
		}
	
		var $tr = $(this).closest("div").clone(true); // 이벤트도 복제
		$tr.find("img").val("");
		$("#main_img").append($tr);
	});
});
*/
  <c:if test="${mode=='update'}">
  function deleteFile(daily_imageFilenum) {
		var url="${pageContext.request.contextPath}/daily/deleteFile";
		$.post(url, {daily_imageFilenum:daily_imageFilenum}, function(data){
			$("#"+daily_imageFilenum).remove();
		}, "json");
  }
</c:if>



</script>

<script type="text/javascript">

function sendOk() {
	var f = document.dailyForm;

	var str = f.subject.value;
    if(!str) {
        alert("제목을 입력하세요! ");
        f.subject.focus();
        
        return;
    }

	str = f.content.value;
    if(!str) {
        alert("내용을 입력하세요! ");
        f.content.focus();
        return;
    }
    
    str = f.categoryNum.value;
    if(!str) {
        alert("카테고리를 설정하세요! ");
        f.categoryNum.focus();
        return;
    }
    
    var mode="${mode}";
    if(mode=="created"){
    var count = $("input:checkbox[name=usedUrl]:checked").length
    if(count > 1){
	   alert("중고글은 1개 이상 체크 할 수 없습니다!")
	   return;
  	  }
    var check = $('.mainImage .mainImage2 input:first').val();
    if(check == null || check == ""){
    	alert("1개 이상의 이미지를 선택해주세요!(created)")
    	return;
    	}
    } else if(mode=="update") {
	   var count = $("input:checkbox[name=usedUrl]:checked").length
	   console.log(count);
	    if(count > 1){
		   alert("중고글은 1개 이상 체크 할 수 없습니다!")
		   return;
	   	}   
	   var check = $('.mainImage .mainImage2 input:first').val();
	   var check2 = $('.saveImage .saveImage2 :first').html();
	   console.log(check2);
	   console.log(check);
	   if(check == null || check == "" && check2 == null || check2 =="" ){
		  alert("1개 이상의 이미지를 선택해주세요!(update)")
		  	return;
	   }
    }
   
   
    
	f.action="${pageContext.request.contextPath}/daily/${mode}";

    f.submit();
}

</script>

<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><i class="far fa-clipboard"></i>일&nbsp;상&nbsp;글&nbsp;쓰&nbsp;기 </h3>
    </div>
    
    <div>
		<form name="dailyForm" method="post" enctype="multipart/form-data">
   		 
			<div style="height: 450px;">
			<div style="margin-bottom: 20px; margin-top: 30px; margin-left: 30px;">
			<!--  이부분 업데이트일시에 올렸던 파일 가져오는 부분인데 짜다가 포기
			<c:if test="${mode=='update'}">
				<c:forEach var="vo" items="${list1}">
					<c:if test="${vo.dailyNum == dto.dailyNum}">
						 <label style="font-weight: 900; font-size: 50;">첨부된사진</label>
					      <div  class="profile_photo" style="background-image: url('${pageContext.request.contextPath}/uploads/daily/${vo.imageFilename}');"></div>
					</c:if>  
				</c:forEach>
			</c:if>
			 -->
				 <label style="font-weight: 900; font-size: 50;">메인 사진</label>
				 <div class="profile_photo" id="main_img">

				 </div>	 
			 </div>
			 </div>
			<table  class="created" style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;"> 
			  <tbody id="tb">
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.subject}">
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
			        <textarea name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
			      </td>
			  </tr> 
			   
			  <tr align="center" style="border-bottom: 1px solid #cccccc;">
			  	  <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top" class="usedUrl">내 중고글 목록(클릭)
			  	  </td>
			  	  <td class="usedList" style="display: none;">
		      		 <c:forEach var="vo" items="${list}">
				  		 <img alt="" src="${pageContext.request.contextPath}/uploads/used/${vo.imageFilename}" width="150" height="150" border="0">
				  		 <input type="checkbox" name="usedUrl" value="${vo.usedNum}">
 	     				${vo.usedNum}
		     		  </c:forEach>
			      </td>
			  </tr>
	  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
					<td width="100" bgcolor="#eeeeee" style="text-align: center;">카테고리</td>
					<td style="padding-left:10px;">
						<select class="selectField" id="categoryNum" name="categoryNum">
							<option value="${dto.categoryNum}"  >::카테고리 선택::</option>
							<option value="1" ${dto.categoryNum=="1"?"selected='selected'":""}>의류</option>
							<option value="2" ${dto.categoryNum=="2"?"selected='selected'":""}>가구</option>
							<option value="3" ${dto.categoryNum=="3"?"selected='selected'":""}>전자제품</option>
							<option value="4" ${dto.categoryNum=="4"?"selected='selected'":""}>도서</option>
							<option value="5" ${dto.categoryNum=="5"?"selected='selected'":""}>기타</option>
						</select>
					</td>
			  </tr>
				
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;" class="mainImage">
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">메&nbsp;&nbsp;&nbsp;&nbsp;인</td>
			      <td style="padding-left:10px;" class="mainImage2"> 
			          <input type="file" id="image" name="upload" class="boxTF" onchange="preWatchphoto(event);" multiple size="53" style="width: 95%; height: 25px; multiple">
			      </td>
			  	</tr>
			  	
              </tbody>  
				<c:if test="${mode=='update'}">
				   <c:forEach var="vo" items="${listFile}">
						  <tr id="${vo.daily_imageFilenum}" height="40" style="border-bottom: 1px solid #cccccc;" class="saveImage"> 
						      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨부된파일</td>
						      <td style="padding-left:10px;" class="saveImage2"> 
								<a href="javascript:deleteFile('${vo.daily_imageFilenum}');"><i class="far fa-trash-alt"></i></a> 
								${vo.imageFilename}
						      </td>
						  </tr>
				   </c:forEach>
				</c:if>
			</table>
			
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/daily/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			         <c:if test="${mode=='update'}">
			         	 <input type="hidden" name="dailyNum" value="${dto.dailyNum}">
			        	 <input type="hidden" name="page" value="${page}">
			        	 <input type="hidden" name="imageFilename" value="${vo.imageFilename}">
			        </c:if>
			      </td>
			    </tr>
			</table>		
		</form>
	
    </div>
</div>



