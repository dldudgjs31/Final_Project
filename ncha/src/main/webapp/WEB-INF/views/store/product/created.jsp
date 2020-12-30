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
    
    function preWatchphoto(event){
    	for (var image of event.target.files) {
    			var reader = new FileReader();
    			reader.onload = function(event){
    				var img =document.createElement("div");
    				img.setAttribute("style","width:200px;height:200px;background-image:url('"+event.target.result+"')");
    				img.setAttribute("id","preImage");
    				//img.setAttribute("src",event.target.result);
    				document.querySelector("div#main_img").appendChild(img);
    			}
    			reader.readAsDataURL(image);
    		}
    }

      <c:if test="${mode=='update'}">
      function deleteFile(main_imageFileNum) {
    		var url="${pageContext.request.contextPath}/store/deleteFile";
    		$.post(url, {main_imageFileNum:main_imageFileNum}, function(data){
    			$("#"+main_imageFileNum).remove();
    		}, "json");
      }
    </c:if>
    
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

</script>


<script type="text/javascript">
function ajaxFun(url, method, dataType, query, fn) {
	   $.ajax({
	      type:method,
	      url:url,
	      data:query,
	      dataType:dataType,
	      success:function(data){
	         fn(data);
	      },
	      error:function(e) {
	         console.log(e.responseText);
	      }
	   });
	}

	$(function(){
	   $("#btnCreateTableDialog").click(function(){
	      $("#dialog-createObject").dialog({
	         modal:true,
	         height: 300,
	         width : 700,
	         title: "상품 옵션 설정",
	         buttons : {
	            "등록하기": function(){
	               createOption();
	            },
	            "닫 기": function(){
	               $(this).dialog("close");   
	            }
	         },
	         close : function(event, ui){
	            $("#tableName").val("");
	            $("#seqCreate").prop("checked",true);
	         }
	      });
	   });
	   function createOption(){
	      var optionDetail=$("#optionDetail").val().trim();
	      if(! optionDetail){
	         $("#optionDetail").focus();
	         return false;
	      }
	   
	      
	      var option_stock=$("#option_stock").val();
	      if(option_stock == 0 || option_stock < 0){
		         $("#option_stock").focus();
		         return false;
	      }
	      
	      var url = "${pageContext.request.contextPath}/store/customer/option";
	      var query = "optionDetail="+optionDetail+"&option_stock="+option_stock;
	      
	      //실행후 넘어오는 데이터
	      var fn = function(data){
	         
	            alert("테이블(시퀀스)이 작성되었습니다.");
	      }
	      ajaxFun(url,"post","json",query,fn);
	   }
	});

	$(function(){
	   $(".btnObjectDelete").click(function(){
	      var objectName = $(this).attr("data-objectName");
	      var $tr = $(this).closest("tr");
	      var objectType = $tr.find("td").eq(1).text();
	      
	      if(! confirm("객체를 삭제하시겠습니까??")){
	    	  return false;
	      }
	      var url = "${pageContext.request.contextPath}/bm/drop";
	      var query = "objectName="+objectName+"&objectType="+objectType;
	      var fn = function(data) {
	    	  var state = data.state;
	    	  if(state=="true"){
	    		  alert("객체가 삭제되었습니다.");
	    		  $tr.remove();
	    	  }else{
	    		  alert("객체 삭제가 실패했습니다.");
	    	  }
	      };
	      	ajaxFun(url,"post","json",query,fn);
	      
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
</script>
       <div id="dialog-createObject" style="display: none;height: 300px;">
       <table class="table">
       <thead>
       		<tr>
	       		<th width="40%"><small>옵션</small></th>
	       		<th width="40%"><small>재고</small></th>
	       		<th width="20%"><small>등록하기</small></th>
       		</tr>
       </thead>
       <tr>
       		<td width="40%"><input class="form-control" type="text" id="optionDetail"   placeholder="등록할  옵션을 입력하세요"></td>
       		<td width="40%"><input class="form-control" type="number" id="option_stock" placeholder="재고량을 입력하세요."></td>
       		<td width="20%"><button class="btn btn-primary optionAdd"><small>등록하기</small></button></td>
       </tr>
       <tbody id="optionlist">

       </tbody>
       </table>
   </div>


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
				  	<tr>
				  		<td>제품 이미지</td>
				  		<td>
				  			<input type="file" id="image" name="upload"  multiple="multiple"  class="form-control  mainimg" onchange="preWatchphoto(event);" multiple size="53" style="width: 50%;multiple">
				  		</td>
				  	</tr>
				  </tbody>
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
				  <c:forEach var="dto1" items="${optionList}">
				  	<tr>
				  		<td> 제품 옵션 &nbsp; 
				  			<button type="button" class="btn btn-primary optionbtn"><i class="fas fa-plus-circle"></i></button> 
				  			<button type="button" class="btn btn-danger optiondelete"><i class="fas fa-minus-circle"></i></button> 
				  		
				  		</td>
				  		<td class="row">
				  			&nbsp;옵션명 :&nbsp; <input type="text" name="optionDetail" maxlength="100"class="form-control option"  style="width: 26%;"  value="${dto1.optionDetail}">&nbsp;
				  			재고 :&nbsp; <input type="number" name="option_stock" maxlength="100" class="form-control optionstock"  style="width: 10%;"  value="${dto1.option_stock}">
				  			
				  		</td>
				  	</tr>
				  </c:forEach>
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
				  		<input type="number" name="stock" maxlength="100" class="form-control" style="width: 50%;" value="${dto.stock}">
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
						 <input type="hidden" name="imageFilename" value="${dto.imageFilename}">
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