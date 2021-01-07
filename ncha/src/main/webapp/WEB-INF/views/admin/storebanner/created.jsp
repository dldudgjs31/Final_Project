<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<style type="text/css">
#preImage{
	background-position: center;
	background-repeat: no-repeat;
	background-size: contain;
	border: 1px solid silver;
	border-radius: 20px;
	margin: 10px;
}
#main_img{
	width: 100%;
	display: flex;
}
#updateImage {
	background-position: center;
	background-repeat: no-repeat;
	background-size: contain;
	border: 1px solid silver;
	border-radius: 20px;
}
</style>

<script type="text/javascript">


function check() {
    var f = document.bannerForm;
    var mode="${mode}";
    if(mode=="created"||mode=="update" && f.upload.value!="") {
		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
			alert('1개 이상의 이미지 파일을 선택해주세요.');
			f.upload.focus();
			return;
		}
	}
    
	f.action="${pageContext.request.contextPath}/admin/storebanner/${mode}";
	f.submit();
};
    //업로드한 이미지 미리보기
    function preWatchphoto(event){
    	for (var image of event.target.files) {
    			var reader = new FileReader();
    			reader.onload = function(event){
    				var img =document.createElement("div");
    				img.setAttribute("style","width:200px;height:200px;background-image:url('"+event.target.result+"')");
    				img.setAttribute("id","preImage");
    				//img.setAttribute("src",event.target.result);
    				var $button = $("<button>",{class:"btn btn-danger ImageDelete"});
    				$icon = $("<i>",{class:"fas fa-minus-circle"})
    				$button.append($icon);
    				$(img).append($button);
    				document.querySelector("div#main_img").appendChild(img);
    			}
    			reader.readAsDataURL(image);
    		}
    };

  //업로드한 이미지 삭제
    $(function(){
    	$("body").on("click",".ImageDelete",function(){	
    		var imageIndex = $(this).parent().index();
    		if(!confirm("이미지를 삭제하시겠습니까?")){
    			return;
    		}
    		$(this).parent().remove();
    		$("#boardBody1").children().eq(imageIndex).remove();
    	});
    }); 
    
$(function(){
    	
    	$(".mainimg").change(function(){
    		if(! $(this).val()) return;
    		
    		var b=false;
    		$(".mainimg").each(function(){
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
    		$("#boardBody1").append($tr);
    		
    	});
});

//수정시 이미지 삭제
$(function(){
	$("body").on("click",".imagedelete",function(){
		$(this).parent().parent().remove();
	});
}); 
function deleteFile(fileNum) {
		var url="${pageContext.request.contextPath}/admin/storebanner/delete";
		$.post(url, {fileNum:fileNum}, function(data){
			$("#file"+fileNum).remove();
		}, "json");
}
</script>


<br>
<div class="row body-title">
   <h3 style="font-family: 'Jua', sans-serif;"><i class="fas fa-store"></i>&nbsp;&nbsp;배&nbsp;너&nbsp;&nbsp;관&nbsp;리</h3>
</div>
   
    				
<div class="profile_photo" id="main_img">

</div>	 
		<div>
			<form name="bannerForm" method="post" onsubmit="return submitContents(this);" enctype="multipart/form-data">
			  <table class="table text-center">
				  <tbody id="boardBody1">
				  
				  	<tr>
				  		<td>배너 이미지</td>
				  		<td>
				  			<input type="file" id="image" name="upload"  multiple="multiple"  class="form-control  mainimg" onchange="preWatchphoto(event);" multiple size="53" style="width: 50%;multiple">
				  		</td>
				  	</tr>
				  	
				  </tbody>
				  <tbody id = "boardBody2">
				  <c:if test="${mode == 'update'}">
				  <c:forEach var="dto" items="${list}">
				  	<tr id="file${dto.fileNum}">
				  		<td>배너 이미지
				  		</td>
				  		<td style="display: flex; align-items: center;" >
				  		<div id="updateImage" style="width: 100px; height: 100px; background-image: url('${pageContext.request.contextPath}/uploads/storebanner/${dto.serverFilename}');"></div>
				  			<button class="btn btn-danger ImageDelete" onclick="javascript:deleteFile(${dto.fileNum})">삭제</button>${dto.serverFilename}
				  		</td>
				  	</tr>
				  	</c:forEach>
				  	</c:if>
				  </tbody>
			  </table>
			 <table class="table text-center">
			     <tr> 
			      <td>
			        <button type="submit" class="btn btn-primary" style="font-family: 'Jua', sans-serif;" onclick="javascript:location.href='${pageContext.request.contextPath}/store/main';">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="btn btn-primary" style="font-family: 'Jua', sans-serif;">다시입력</button>
			        <button type="button" class="btn btn-danger" style="font-family: 'Jua', sans-serif;" onclick="javascript:location.href='${pageContext.request.contextPath}/store/main';">${mode=='update'?'수정취소':'등록취소'}</button>

			      </td>
			    </tr>
			  </table>
			  </form>
    
</div>