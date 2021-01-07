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
    }

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



$(function(){
	$("body").on("click",".optionAdd",function(){
		var optionDetail =  $("#optionDetail").val();
		var option_stock =  $("#option_stock").val();
		if(! optionDetail){
			alert("옵션을 입력해주세요.");
			$("#optionDetail").focus();
			return;
		}
		if(! option_stock || option_stock==0 || option_stock<=0){
			alert("재고를  입력해주세요.");
			$("#option_stock").focus();
			return;
		}

		var url = "${pageContext.request.contextPath}/store/option";
		var query = "optionDetail="+optionDetail+"&option_stock="+option_stock;
	    var fn = function(data){
	    	var $tr, $td, $button;
	    	$tr = $("<tr>");
	    	$td = $("<td>",{html:optionDetail});
	    	$tr.append($td);
	    	$td = $("<td>",{html:option_stock});
	    	$tr.append($td);
	    	$td =$("<td>");
	    	$button = $("<button>",{class:"btn btn-danger optionDelete",html:"삭제"});
	    	$td.append($button);
	    	$tr.append($td);
	    	
	    	$("#optionlist").append($tr);
	    }
	    ajaxFun(url,"post","json",query,fn);
	});
});


//옵션 버튼 클릭시 목록 추가시키는 버튼
$(function(){
	$("body").on("click",".optionbtn",function(){
    		var b=false;
    		$(".option").each(function(){
    			if(! $(this).val()) {
    				b=true;
    				alert("옵션을 입력해주세요.");
    				return;
    			}
    		});
    		$(".optionstock").each(function(){
    			if(! $(this).val()) {
    				b=true;
    				alert("재고을 입력해주세요.");
    				return;
    			}
    		});
    		if(b) {
    			return false;
    		}
    	
    		var $tr = $(this).closest("tr").clone(true); // 이벤트도 복제
    		$tr.find("input").val("");
    		$("#optionbody").append($tr);
    		
    		
	});
	//옵션 리스트 삭제 버튼
	$("body").on("click",".optiondelete",function(){
		if($("#optionbody").children().length==1){
			alert("옵션은 1개이상 작성해야합니다.");
			return;
		}
		$(this).parent().parent().remove();
		
		
		
	});
	
});



<c:if test="${mode == 'update'}">
function deleteOption(optionNum) {
			var url="${pageContext.request.contextPath}/store/deleteOption";
			$.post(url, {optionNum:optionNum}, function(data){
			}, "json");
	}		
</c:if>
//수정시 이미지 삭제
$(function(){
	$("body").on("click",".imagedelete",function(){
		$(this).parent().parent().remove();
	});
}); 
function deleteFile(main_imageFileNum) {
		var url="${pageContext.request.contextPath}/store/deleteFile";
		$.post(url, {main_imageFileNum:main_imageFileNum}, function(data){
		}, "json");
}

//재고 합산 
$(function(){
	$("body").on("blur",".optionstock",function(){
		var stock=0;
		for(var i=0;i<$("#optionbody").children().length; i++){
			stock = stock + parseInt($("#optionbody").children().eq(i).children().eq(1).children().eq(1).val());
		}
		
		$("input[name=stock]").val(stock);
	});
}); 


</script>


<br>
<div class="row body-title">
          <h3 style="font-family: 'Jua', sans-serif;"><i class="fas fa-store"></i>  ${mode=='update'?'판매글 수정하기':'판매글 올리기'} </h3>
    </div>
    
    <div class="row alert alert-info">
        <i class="glyphicon glyphicon-info-sign"></i> N차 신상의 판매회원이 되시면 회원님만의 스토어를 운영할 수 있습니다.
    </div>


    				<label style="font-weight: 900; font-size: 50;">스토어 메인에 노출될 이미지</label>
				 <div class="profile_photo" id="main_img">

				 </div>	 
    <div>
			<form name="boardForm" method="post" onsubmit="return submitContents(this);" enctype="multipart/form-data">
			  <table class="table text-center">
				  <tbody id="boardBody1">
				  <c:if test="${mode == 'created'}">
				  	<tr>
				  		<td>제품 이미지
				  		</td>
				  		<td>
				  			<input type="file" id="image" name="upload"  multiple="multiple"  class="form-control  mainimg" onchange="preWatchphoto(event);" multiple size="53" style="width: 50%;multiple">
				  		</td>
				  	</tr>
				  	</c:if>
				  </tbody>
				  
				  	 <c:if test="${mode == 'update'}">
				  	<c:forEach var="dto2" items="${listFile}">
				  	<tr>
				  		<td>제품 이미지
				  		</td>
				  		<td style="display: flex; align-items: center;" >
				  		<div id="updateImage" style="width: 100px; height: 100px; background-image: url('${pageContext.request.contextPath}/uploads/product/${dto2.imageFilename}');"></div>
				  			${dto2.imageFilename}
				  		</td>
				  	</tr>
				  	</c:forEach>
				  	</c:if>
				  <tbody id="optionbody">
				  <c:if test="${mode == 'created'}">
				  	<tr>
				  		<td> 제품 옵션 &nbsp; 
				  			<button type="button" class="btn btn-primary optionbtn"><i class="fas fa-plus-circle"></i></button> 
				  			<button type="button" class="btn btn-danger optiondelete"><i class="fas fa-minus-circle"></i></button> 
				  		
				  		</td>
				  		<td class="row">
				  			&nbsp;옵션명 :&nbsp; <input type="text" name="optionDetail" maxlength="100"class="form-control option"  style="width: 26%;"  value="${option.optionDetail}">&nbsp;
				  			재고 :&nbsp; <input type="number" name="option_stock" maxlength="100" class="form-control optionstock"  style="width: 10%;"  value="${option.option_stock}">
				  			
				  		</td>
				  	</tr>
				  </c:if>
				   <c:if test="${mode == 'update'}">	
				  <c:forEach var="dto1" items="${optionList}">
				  	<tr>
				  		<td> 제품 옵션 &nbsp; 
				  			<button type="button" class="btn btn-primary optionbtn"><i class="fas fa-plus-circle"></i></button> 
				  			<button type="button" class="btn btn-danger optiondelete" onclick="deleteOption('${dto1.optionNum}')"><i class="fas fa-minus-circle"></i></button> 
				  		
				  		</td>
				  		<td class="row">
				  			&nbsp;옵션명 :&nbsp; <input type="text" name="optionDetail" maxlength="100"class="form-control option"  style="width: 26%;"  value="${dto1.opt_detail}">&nbsp;
				  			재고 :&nbsp; <input type="number" name="option_stock" maxlength="100" class="form-control optionstock"  style="width: 10%;"  value="${dto1.opt_stock}">
				  			
				  		</td>
				  	</tr>
				  </c:forEach>
				  </c:if>
				  </tbody>
				  <tr>
				  	<td>상품명</td>
				  	<td>
				  		<input type="text" name="productName" maxlength="100" class="form-control"  style="width: 50%;"  value="${dto.productName}">
				  	</td>
				  </tr>
				  <tr>
				  	<td>제품 가격</td>
				  	<td>
				  		<input type="number" name="price" maxlength="100" class="form-control" style="width: 50%;"  value="${dto.price}">
				  	</td>
				  </tr>
				  <tr>
				  	<td>할인 가격</td>
				  	<td>
				  		<input type="number" name="discount_rate" maxlength="100" class="form-control" style="width: 50%;" value="${dto.discount_rate}">
				  	</td>
				  </tr>
				  <tr>
				  	<td>상품 재고</td>
				  	<td>
				  		<input type="text" name="stock" maxlength="100" class="form-control" style="width: 50%;" value="${dto.stock}" readonly="readonly">
				  	</td>
				  </tr>
				  <tr >
				      <td>제품 카테고리 선택</td>
				      <td class="text-left"> 
							<select name="categoryNum" class="selectField form-control" style="width: 50%;">
								<option value="1" >의류</option>
								<option value="2" >전자제품</option>
								<option value="3" >인테리어 가구</option>
								<option value="4" >생필품</option>
							</select>
				       </td>
				  </tr>	
				  <tr> 
				      <td>제품 상세페이지</td>
				      <td valign="top" style="padding:5px 0px 5px 10px;"> 
				        <textarea name="detail" id="content" class="form-control" style="width:98%; height: 270px;">${dto.detail}</textarea>
				      </td>
				  </tr>
			 				  			  
			  </table>
			 <table class="table text-center">
			     <tr > 
			      <td >
			      	<c:if test="${mode=='update'}">
						<input type="hidden" name="productNum" value="${dto.productNum}">
						<input type="hidden" name="page" value="${page}">
					</c:if>
			        <button type="submit" class="btn btn-primary" style="font-family: 'Jua', sans-serif;">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="btn btn-primary" style="font-family: 'Jua', sans-serif;">다시입력</button>
			        <button type="button" class="btn btn-danger" style="font-family: 'Jua', sans-serif;" onclick="javascript:location.href='${pageContext.request.contextPath}/store/list';">${mode=='update'?'수정취소':'등록취소'}</button>

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