<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<style type="text/css">
.star {font-size:0; letter-spacing:-4px;}
.star a {
    font-size:22px;
    letter-spacing:0;
    display:inline-block;
    margin-left:3px;
    color:#cccccc;
    text-decoration:none;
}
.star a:first-child {margin-left:0;}
.star a.on {color:#F2CB61;}
</style>

<div class="body-container" style="width: 700px;">

<script type="text/javascript">
$(function(){
	   $( ".star a" ).click(function() {
	      var b=$(this).hasClass("on");
	       $(this).parent().children("a").removeClass("on");
	       $(this).addClass("on").prevAll("a").addClass("on");
	       if(b) {
	    	   $(this).removeClass("on");
	       }
	       var s=$(".star .on").length;
	       $("#score").val(s);
	   });
});

function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

function ajaxFun(url, method, dataType, query, fn) {
	$.ajax({
		type:method
		,url:url
		,data:query
		,dataType:dataType
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


//페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "${pageContext.request.contextPath}/review/listReview";
	//var query = "productNum=${dto.productNum}&pageNo="+page;
	var query = "productNum=3&pageNo="+page;
	
	var fn = function(data){
		$("#listReview").html(data);
	};
	
	ajaxFun(url, "get", "html", query, fn);
}

//리뷰 등록
$(function(){
	$(".btnSendReview").click(function(){
		//var productNum="${dto.productNum}";
		var productNum="3";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		var url="${pageContext.request.contextPath}/review/insertReview";
		var query=$("form[name=reviewForm]").serialize();
		query+="&productNum="+productNum;
		
		var fn = function(data){
			$tb.find("textarea").val("");
			$("form[name=reviewForm] input[name=score]").val("0");
			$( ".star a" ).removeClass("on");
			 
			var state=data.state;
			if(state==="true") {
				listPage(1);
			} else if(state==="false") {
				alert("리뷰을 추가 하지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", "json", query, fn);
	});
});

</script>

    <div>
        <form name="reviewForm">
		<table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
			<tr height='30'> 
				 <td align='left' >
				 	<span style='font-weight: bold;' >리뷰쓰기</span>
				 </td>
			</tr>
			<tr>
				<td>
		  			<p class="star">
		      			<a href="#">★</a>
		       			<a href="#">★</a>
		       			<a href="#">★</a>
		       			<a href="#">★</a>
		       			<a href="#">★</a>
		   			</p>
					<input type="hidden" name="score" id="score" value="0">
			   </td>
			</tr>
			<tr>
			   	<td style='padding:5px 5px 0px;'>
					<textarea name="content" class='boxTA' style='width:99%; height: 70px;'></textarea>
			    </td>
			</tr>
			<tr>
			   <td align='right'>
			        <button type='button' class='btn btnSendReview' style='padding:10px 20px;'>리뷰 등록</button>
			    </td>
			 </tr>
		</table>
		</form>     
		<div id="listReview"></div>
    
    </div>
</div>