<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick.css" />
<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick-theme.css" />
<script type="text/javascript" src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script>
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

.slick-items{
	width: 100%;
}

.slider-image{
	background-repeat: no-repeat;
	background-position: center;
	background-size: contain;
	height: 450px;
	border: 1px solid silver;
	border-radius: 20px;
}
.menu-title, .collapsed{
	color : black !important;
}
</style>

<script type="text/javascript">
function deleteBoard(num) {
	<c:if test="${sessionScope.seller.sellerId==dto.sellerId || sessionScope.member.userId=='admin'}">
	if(confirm("게시물을 삭제 하시겠습니까 ?")) {
		var q = "num=" +${dto.productNum} + "&${query}";
		var url="${pageContext.request.contextPath}/store/delete?"+q;
		location.href=url;
	}
	</c:if>
	<c:if test="${sessionScope.seller.sellerId!=dto.sellerId && sessionScope.member.userId!='admin'}">
		alert("게시글을 삭제할 수 없습니다.");
	</c:if>
}



function updateBoard(num){
	<c:if test="${sessionScope.seller.sellerId==dto.sellerId}">
		var q="num="+${dto.productNum}+"&page=${page}";
		var url="${pageContext.request.contextPath}/store/update?"+q;
		location.href=url;
	</c:if>
	<c:if test="${sessionScope.seller.sellerId!=dto.sellerId}">
		alert("게시글을 수정할 수 없습니다.");
	</c:if>
}


function cartOk(num) {
	<c:if test="${not empty sessionScope.member.userId || sessionScope.member.userId=='admin'}">
	console.log(num);
	if(confirm("상품을 장바구니에 추가하시겠습니까 ?")) {
		var q = "num=" +${dto.productNum} + "&${query}";
		var quantity = $("#totalBuyQty").text();
		if(quantity==0){
			alert("수량을 선택해주세요.");
			return;
		}
		var url="${pageContext.request.contextPath}/store/customer/cart?"+q+"&quantity="+quantity;
		location.href=url;
		alert("상품이 장바구니에 추가되었습니다.");
	}
	</c:if>
	<c:if test="${empty sessionScope.member.userId && sessionScope.member.userId!='admin'}">
		alert("장바구니를 추가하려면 로그인을 해야합니다");
	</c:if>
}

$(document).ready(function () {


	$('.slick-items').slick({
		autoplay : true,
		dots: true,
		speed : 300 /* 이미지가 슬라이딩시 걸리는 시간 */,
		infinite: true,
		autoplaySpeed: 3000 /* 이미지가 다른 이미지로 넘어 갈때의 텀 */,
		arrows: true,
		slidesToShow: 1,
		slidesToScroll: 1,
		fade: false
	});

});
</script>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}
</script>


<script type="text/javascript">
$(function(){
	$(".buyAdd").click(function(){
		var totalBuyQty = parseInt($("#totalBuyQty").text());
		var totalBuyAmt = parseInt($("#totalBuyAmt").text());
		
		var title=$(".my-3").text();
		var code=$(this).attr("data-code");
		var price=parseInt($(this).attr("data-price"));
		var qty=1;
		
		var t="#buyTr"+code;
		if($(t).length) { // 해당 코드가 존재하면
			// qty=$(t).children().children("input[name=quantity]").val();
			qty=$(t+" input[name=quantity]").val();
			if(! qty) qty=0;
			if(qty>${dto.stock}){
				qty=qty-1;
				$(t+" input[name=quantity]").val(qty);
				$(t+" .productPrice").text(qty*price);
				$("#totalBuyQty").text(qty);
				$("#totalBuyAmt").text(qty*price);
				alert("재고 초과");
				return;
			}
			pty=parseInt(qty)+1;
			
			$(t+" input[name=quantity]").val(pty);
			$(t+" .productPrice").text(pty*price);
			if(pty>=${dto.stock}){
				return;
			}
			totalBuyQty=totalBuyQty+1;
			totalBuyAmt=totalBuyAmt+price;
			$("#totalBuyQty").text(totalBuyQty);
			$("#totalBuyAmt").text(totalBuyAmt);
		
			return;
		}
		
		var $tr, $td, $input;
		
		var vprice = "<span class='productPrice'>"+price+"</span>원 <span class='buyCancel' data-code='"+code+"' data-price='"+price+"'>×</span>";
	    $tr=$("<tr height='40' style='border-bottom: 1px solid #cccccc;' id='buyTr"+code+"'>");
	    $td=$("<td>", {width:"200", style:"text-align: center;", html:title});
	    $tr.append($td);
	    $td=$("<td width='180' style='text-align: right;'>");
	    $input=$("<input>", {type:"text", name:"quantity", class:"boxTF", style:"width: 30%;", value:qty, readonly:"readonly"});
	    $td.append($input);
	    $input=$("<input>", {type:"button", class:"btn btnPlus", value:"+"});
	    $td.append($input);
	    $input=$("<input>", {type:"button", class:"btn btnMinus", value:"-"});
	    $td.append($input);
	    $input=$("<input>", {type:"hidden", name:"code", value:code});
	    $td.append($input);
	    $tr.append($td);
	    $td=$("<td>", {width:"200", style:"text-align: right; padding-right: 5px;", html:vprice});
	    $tr.append($td);
	    
	    $("#buyList").append($tr);
		
		totalBuyQty=totalBuyQty+1;
		totalBuyAmt=totalBuyAmt+price;
		$("#totalBuyQty").text(totalBuyQty);
		$("#totalBuyAmt").text(totalBuyAmt);
	    
	});
});

$(function(){
	$("body").on("click", ".buyCancel", function(){
		var code=$(this).attr("data-code");
		var price=parseInt($(this).attr("data-price"));
		var t="#buyTr"+code;
		var qty=$(t+" input[name=quantity]").val();
		if(! qty) qty=0;
		
		$(t).remove();
		
		var totalBuyQty = parseInt($("#totalBuyQty").text());
		var totalBuyAmt = parseInt($("#totalBuyAmt").text());
		totalBuyQty=totalBuyQty-parseInt(qty);
		totalBuyAmt=totalBuyAmt-(price*parseInt(qty));
		$("#totalBuyQty").text(totalBuyQty);
		$("#totalBuyAmt").text(totalBuyAmt);
	});
});

$(function(){
	$("body").on("click", ".btnPlus", function(){
		var code=$(this).siblings("input[name=code]").val();
		var price=parseInt($(this).parent().next().children(".buyCancel").attr("data-price"));
		var qty=parseInt($(this).parent().children("input[name=quantity]").val());
		var productPrice=parseInt($(this).parent().next().children(".productPrice").text());
		var totalBuyQty = parseInt($("#totalBuyQty").text());
		var totalBuyAmt = parseInt($("#totalBuyAmt").text());

		if(qty>${dto.stock}){
			return;
		}
		qty=qty+1;
		productPrice=productPrice+price;
		$(this).parent().children("input[name=quantity]").val(qty);
		$(this).parent().next().children(".productPrice").text(productPrice);
		
		totalBuyQty=totalBuyQty+1;
		totalBuyAmt=totalBuyAmt+price;
		$("#totalBuyQty").text(totalBuyQty);
		$("#totalBuyAmt").text(totalBuyAmt);
	});

	$("body").on("click", ".btnMinus", function(){
		var code=$(this).siblings("input[name=code]").val();
		var price=parseInt($(this).parent().next().children(".buyCancel").attr("data-price"));
		var qty=parseInt($(this).parent().children("input[name=quantity]").val());
		var productPrice=parseInt($(this).parent().next().children(".productPrice").text());
		var totalBuyQty = parseInt($("#totalBuyQty").text());
		var totalBuyAmt = parseInt($("#totalBuyAmt").text());
		if(qty<=0)
			return;
		
		qty=qty-1;
		productPrice=productPrice-price;
		$(this).parent().children("input[name=quantity]").val(qty);
		$(this).parent().next().children(".productPrice").text(productPrice);
		
		totalBuyQty=totalBuyQty-1;
		totalBuyAmt=totalBuyAmt-price;
		$("#totalBuyQty").text(totalBuyQty);
		$("#totalBuyAmt").text(totalBuyAmt);
	});
});
$(function(){
	$("body").on("click",".cancel",function(){
		var code=$(".buyCancel").attr("data-code");
		var price=parseInt($(".buyCancel").attr("data-price"));
		var t="#buyTr"+code;
		var qty=$(t+" input[name=quantity]").val();
		if(! qty) qty=0;
		
		$(t).remove();
		
		$("#totalBuyQty").text(0);
		$("#totalBuyAmt").text(0);
	});
});

function buyOk() {
	<c:if test="${not empty sessionScope.member.userId || sessionScope.member.userId=='admin'}">
	var f = document.buyForm;
	
	$("input[name=number_sales]").val($("#totalBuyQty").text());
	$("input[name=total_sales]").val($("#totalBuyAmt").text());
	console.log($("input[name=number_sales]").val($("#totalBuyQty").text()));
	if($("#totalBuyQty").text()>${dto.stock}){
		alert("재고보다 많은 수량은 구매할 수 없습니다.");
		return;
	}
	if($("#totalBuyQty").text()==0){
		alert("수량을 선택해주세요.");
		return;		
	}
	
 	f.action = "${pageContext.request.contextPath}/store/customer/main";

    f.submit();
	</c:if>

	<c:if test="${empty sessionScope.member.userId && sessionScope.member.userId!='admin'}">
		alert("구매를 하려면 로그인을 해야합니다");
		return;
	</c:if>
    
}
</script>
<!-- Page Content -->
<div class="container">

<Br><Br>
  <!-- Portfolio Item Row -->
  <div class="row">

    <div class="col-md-8">
        <div class="slick-items" style="height: 450px;">
		<c:forEach var="vo" items="${list1}">
			<c:if test="${vo.productNum == dto.productNum}">
			      <div  class="slider-image" style="background-image: url('${pageContext.request.contextPath}/uploads/product/${vo.imageFilename}');"></div>
			</c:if>  
		</c:forEach>
    </div>
    </div>

    <div class="col-md-4">
      <h3 class="my-3">${dto.productName}</h3>
			<p>판매자 : ${dto.sellerId}</p>
			<p>조회수 : ${dto.hitCount}</p>
			<p>재고 : ${dto.stock}</p>
			<p>정가 :<del><fmt:formatNumber type="currency" value="${dto.price}" />원</del></p>
			<p>세일가 : <fmt:formatNumber  type="currency"  value="${dto.price - dto.discount_rate}"/>원</p>
			<button type="button" class="buyAdd btn btn-primary" data-code="100" data-price="${dto.price-dto.discount_rate}"><i class="fas fa-plus-square"></i>&nbsp;리스트 추가</button>
	
			<button type="button" class="btn btn-primary" onclick="cartOk(${dto.productNum});"><i class="fas fa-cart-plus"></i></button><Br>
			<small class="text-danger"><Br>${message}</small>
			<form name="buyForm" method="post">
		    <table class="table" style="width: 100%; border-spacing: 0px; border-collapse: collapse; ">
		    	<tbody id="buyList">
		    	</tbody>
		    	<tfoot>
			    	<tr height="40" style="border-top: 1px solid #cccccc;">
			    		<td align="right" colspan="3">
			    		   <span>총수량 : </span><span id="totalBuyQty" >0</span>개 | 
			    		   <span style="font-weight: 700;">총 상품금액 : </span><span id="totalBuyAmt"  style="font-weight: 900; color: #2eb1d3; font-size: 17px;">0</span>
			    		   <span style="padding-right: 10px; font-weight: 700; color: #2eb1d3;">원</span>
					  <input type="hidden" name="price" value="${dto.price}">
			          <input type="hidden" name="sellerId" value="${dto.sellerId}">
			          <input type="hidden" name="productNum" value="${dto.productNum}">
			          <input type="hidden" name="productName" value="${dto.productName}">
			          <input type="hidden" name="discount_rate" value="${dto.discount_rate}">
			          <input type="hidden" name="number_sales">
			          <input type="hidden" name="total_sales" >
			          <input type="hidden" name="stock" value="${dto.stock}" >
			    		 </td>
			    	</tr>
			    	<tr height="40" style="border-top: 1px solid #cccccc;" >
			    			<td align="center" colspan="3">
			    			<button type="button" class="btn btn-primary" onclick="buyOk();">구매하기</button>
			    			<button type="button" class="btn btn-danger cancel">초기화</button>
			    			
			    			</td>
			    	</tr>
		    	</tfoot>
		    </table>
		    
			</form>
    </div>
  </div>
  <!-- /.row -->
  <!-- Related Projects Row -->

  <div class="row">
<c:forEach var="vo" items="${list1}">
<c:if test="${vo.productNum == dto.productNum}">
    <div class="col-md-3 col-sm-6 mb-4">
      <a href="#">
            <img class="img-fluid" src="${pageContext.request.contextPath}/uploads/product/${vo.imageFilename}" alt="" style="width: 300px; height: 200px;" >
          </a>
    </div>
    </c:if> 
    </c:forEach>


  </div>
  <!-- /.row -->

    
 <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingOne">
      <h4 class="panel-title">
        <a class="menu-title" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          	제품 상세 정보
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
      <div class="panel-body">
    		<table class="table" >
			<tr>
				<td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
					${dto.detail}
				</td>
			</tr>
			</table>
      </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingTwo">
      <h4 class="panel-title">
        <a class="collapsed menu-title" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          	고객 리뷰
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
      <div class="panel-body">
    <div>
<!--         <form name="reviewForm">
		<table class="table">
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
		</form>     --> 
		<div id="listReview"></div>
    
    </div>

<table class="table">
<%-- 	<thead id='listReviewHeader'>
		<tr height='35'>
		    <td colspan='2'>
		       <div style='clear: both;'>
		           <div style='float: left;'><span>[리뷰 목록]</span></div>
		           <div style='float: right; text-align: right;'>전체평점 : <fmt:formatNumber value="${reviewScore}" pattern="0.0"/></div>
		       </div>
		    </td>
		</tr>
	</thead> --%>
	
	<tbody id='listReviewBody'>
		<c:forEach var="vo" items="${list}">
	    <tr height='35' style='background: #eeeeee;'>
	       <td width='50%' style='padding:5px 5px; border:1px solid #cccccc; border-right:none;'>
	           <span><b>${vo.userName}</b></span>
	        </td>
	       <td width='50%' style='padding:5px 5px; border:1px solid #cccccc; border-left:none;' align='right'>
	           <span><c:forEach var="score" items="${ratingOptions}" varStatus="status" begin="1" end="${vo.score}">★</c:forEach></span> |
	           <span>${vo.created_date}</span>
	        </td>
	    </tr>
	    <tr>
	        <td colspan='2' valign='top' style='padding:5px 5px;'>
	              ${vo.content}
	        </td>
	    </tr>
	</c:forEach>
	</tbody>
	
	<tfoot id='listReviewFooter'>
		<tr height='40' align="center">
            <td colspan='2' >
              ${paging}
            </td>
           </tr>
	</tfoot>
</table>
      </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingThree">
      <h4 class="panel-title">
        <a class="collapsed menu-title" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
          Q&A
        </a>
      </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
      <div class="panel-body">
      123
      </div>
    </div>
  </div>
</div>   
    <table class="table">
   			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					이전글 : 
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/store/article?${query}&num=${preReadDto.productNum}">${preReadDto.productName}</a>
					</c:if>
					
				</td>
			</tr>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/store/article?${query}&num=${nextReadDto.productNum}">${nextReadDto.productName}</a>
					</c:if>
				</td>
			</tr>
			<tr>

			</tr>
		</table> 



		

<%-- 			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					첨부 :
					<c:if test="${not empty dto.saveFilename}">
						<a href="${pageContext.request.contextPath}/bbs/downlaod?num=${dto.num}">${dto.originalFilename}</a>
					</c:if>
					
				</td>
			</tr>
 --%>


		<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
				<td width="300" align="left">
					<button type="button" class="btn btn-primary" onclick="updateBoard('${dto.productNum}');">수정</button>
					<button type="button" class="btn btn-danger"onclick="deleteBoard('${dto.productNum}');">삭제</button>
				</td>

				<td align="right">
					<button type="button"class="btn btn-primary" onclick="javascript:location.href='${pageContext.request.contextPath}/store/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
	</div>
	

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
	var query = "productNum=${dto.productNum}&pageNo="+page;
	
	var fn = function(data){
		$("#listReview").html(data);
	};
	
	ajaxFun(url, "get", "html", query, fn);
}

//리뷰 등록
$(function(){
	$(".btnSendReview").click(function(){
		var productNum="${dto.productNum}";
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



