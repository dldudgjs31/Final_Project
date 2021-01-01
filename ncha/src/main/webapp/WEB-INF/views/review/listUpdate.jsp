<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
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
.btn{
	font-family: 'Jua', sans-serif;
}
</style>
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
</script>

        <form name="updateForm">
		<table class="table updateTable">
			<tr height='30'> 
				 <td align='left' >
				 	<span style='font-weight: bold;' >리뷰쓰기</span>
				 	<p> 주문한 상품 : <input type="text" name="orderDetail" value="${dto.orderDetail}" id="orderDetail" readonly="readonly" style="width:70%;"> </p>
					 <input type="hidden" name="productNum"  value="${dto.productNum}" id="productNum1">
					 <input type="hidden" name="orderNum" value="${dto.orderNum}" id="orderNum">
					 <input type="hidden" name="reviewNum" value="${dto.reviewNum}" id="reviewNum123">
					
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
					<input type="hidden" name="score" id="score" class="score">
			   </td>
			</tr>
			<tr>
			   	<td style='padding:5px 5px 0px;'>
					<textarea name="content" class='boxTA' style='width:99%; height: 70px;' id="content">${dto.content}</textarea>
			    </td>
			</tr>
		</table>
		</form>  
