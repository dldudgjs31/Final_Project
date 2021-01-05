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
.btn {
font-family: 'Jua', sans-serif;
}
.img-fluid{
	background-repeat: no-repeat;
	background-position: center;
	background-size: contain;
	border: 1px solid silver;
	border-radius: 20px;	
}
#profile{
	width: 100%;
	display: flex;
	align-items: flex-end;
}
#profile_image{
	width:50px; 
	height:50px; 
	border-radius:50%; 
	border:1px solid silver; 
	background-repeat: no-repeat;
	background-position: center;
	background-size: contain;
}
p{
	margin-bottom: 0.5rem;
}
</style>

<script type="text/javascript">
<c:if test="${order=='fail'}">
$(function(){
	alert("재고보다 많은양의 상품은 구매할 수 없습니다.");
});
	</c:if>

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

	if(confirm("상품을 장바구니에 추가하시겠습니까 ?")) {
		var q = "num=" +${dto.productNum} + "&${query}";
		var quantity = $("#totalBuyQty").text();
		var optionDetail = $("select option:selected").text();
		var options = optionDetail.split("[");
		var option = options[0];
		var optionNum = $('input[name=optionNum]').val();
		if(quantity==0){
			alert("수량을 선택해주세요.");
			return;
		}
		var url="${pageContext.request.contextPath}/store/customer/cart?"+q+"&quantity="+quantity+"&order_option="+option+"&optionNum="+optionNum;
		location.href=url;
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
		var buyOption = parseInt($("select option:selected").val())
		
		var optionDetail = $("select option:selected").text();
		var options = optionDetail.split("[");
		var optionStock = options[1].split(":");
		
		var option = "[옵션 : "+options[0]+"]";
		var optionNum = parseInt($("select option:selected").val());
		var title=$(".my-3").text();
		var code=$(this).attr("data-code");
		var price=parseInt($(this).attr("data-price"));
		var qty=1;
		
		
		$('input[name=optionNum]').attr('value',optionNum);
		$('input[name=order_option]').attr('value',options[0]);
		
		
	    
		var t="#buyTr"+code;
		if($(t).length) { // 해당 코드가 존재하면
			// qty=$(t).children().children("input[name=quantity]").val();
			qty=$(t+" input[name=quantity]").val();
			if(! qty) qty=0;
			if(qty>parseInt(optionStock[1].split("]")[0])){
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
			totalBuyQty=totalBuyQty+1;
			totalBuyAmt=totalBuyAmt+price;
			$("#totalBuyQty").text(totalBuyQty);
			$("#totalBuyAmt").text(totalBuyAmt);
		
			return;
		}
		
		var $tr, $td, $input;
		
		var vprice = "<span class='productPrice'>"+price+"</span>원 <span class='buyCancel' data-code='"+code+"' data-price='"+price+"'>×</span>";
	    $tr=$("<tr height='40' style='border-bottom: 1px solid #cccccc;' id='buyTr"+code+"'>");
	    $td=$("<td>", {width:"200", style:"text-align: center; width:45%;", html:title});
	    $opt = $("<p>",{html:option});
	    $td.append($opt);
	    
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
		var optionDetail = $("select option:selected").text();
		var options = optionDetail.split("[");
		var optionStock = options[1].split(":");
		
		
		
		if(qty>parseInt(optionStock[1].split("]")[0])-1){
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

    <div class="col-md-7">
        <div class="slick-items" style="height: 450px;">
		<c:forEach var="vo" items="${list1}">
			<c:if test="${vo.productNum == dto.productNum}">
			      <div  class="slider-image" style="background-image: url('${pageContext.request.contextPath}/uploads/product/${vo.imageFilename}');"></div>
			</c:if>  
		</c:forEach>
    </div>
    

    
    </div>

    <div class="col-md-5">
      <h3 class="my-3">${dto.productName}</h3>
			<p>
			<div id="profile">
	            <div id="profile_image" style="background-image: url('${pageContext.request.contextPath}/uploads/member/${dto.profile_imagefilename}');"></div>
	            <div> ${dto.sellerName}</div>
            </div>
			</p>
			<p>조회수 : ${dto.hitCount} | 평점 : <span style="color:#FFCD28;">${dto.score}</span></p>
			<p>재고 : 
			<c:if test="${dto.stock=='0'}">
				<span style="color:red;">품절</span>
			</c:if>
			<c:if test="${dto.stock>0}">
				${dto.stock}
			</c:if>
			
			</p>
			<p style="color:silver;">정가 :<del><fmt:formatNumber type="currency" value="${dto.price}" />원</del></p>
			<p>세일가 : <fmt:formatNumber  type="currency"  value="${dto.price - dto.discount_rate}"/>원</p>
            <select class="custom-select" id="single_select">
            	<c:forEach var="option" items="${optionList}">
            		<c:choose>
            			<c:when test="${option.opt_stock==0}">
			                <option value="${option.optionNum}" disabled>${option.opt_detail} [재고 : 품절]</option>
            			</c:when>
            			
            			<c:otherwise>
			                <option value="${option.optionNum}">${option.opt_detail} [재고 :${option.opt_stock}]</option>
            			</c:otherwise>
            		</c:choose>
            	</c:forEach>
            </select>
            <br> <br>
			
			<button type="button" class="buyAdd btn btn-primary" data-code="100" data-price="${dto.price-dto.discount_rate}"><i class="fas fa-plus-square"></i>&nbsp;리스트 추가</button>
			<button type="button" class="btn btn-primary" onclick="cartOk(${dto.productNum});"><i class="fas fa-cart-plus"></i></button>
				<button type="button" class="btn btn-info productLike" onclick="likeOk(${dto.productNum});"><i id="likeIcon" class="far fa-heart"></i></button>&nbsp;&nbsp;<span style="color:#FF6464;"><i class="fas fa-heart"></i> &nbsp;${dto.likeCount}</span><Br>
			
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
			          <input type="hidden" name="optionNum" >
			          <input type="hidden" name="categoryName" value="${dto.categoryName}" >
			          <input type="hidden" name="order_option" >
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
    	<div class="img-fluid" style="width:300px; height: 200px; background-image: url('${pageContext.request.contextPath}/uploads/product/${vo.imageFilename}');"></div>
            <%-- <img class="img-fluid" src="${pageContext.request.contextPath}/uploads/product/${vo.imageFilename}" alt="" style="width: 300px; height: 200px;" > --%>
    </div>
    </c:if> 
    </c:forEach>


  </div>
  <!-- /.row -->

    
 <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingOne">
      <h4 class="panel-title text-center">
          	제품 상세 정보
      </h4>
          	<hr>
    </div>
      <div class="panel-body">
					${dto.detail}
      </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingTwo">
      <h4 class="panel-title text-center">
        <a class="collapsed menu-title" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          	고객 리뷰
        </a>
      </h4>
      <hr>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
      <div class="panel-body">
    <div>

		<div id="listReview"></div>
    
    </div>


      </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingThree">
      <h4 class="panel-title text-center">
        <a class="collapsed menu-title" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree" id="qna">
          Q&A
        </a>
      </h4>
      <hr>
    </div>
    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
      <div class="panel-body">
    <div>

		<div id="listQna"></div>
    <br>
    </div>



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
				<c:if test="${sessionScope.seller.sellerId == dto.sellerId}">
					<button type="button" class="btn btn-primary" onclick="updateBoard('${dto.productNum}');">수정</button>
					<button type="button" class="btn btn-danger"onclick="deleteBoard('${dto.productNum}');">삭제</button>
				</c:if>
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
	listQnaPage(1);
	
	<c:if test="${not empty sessionScope.member.userId}">
	likePage();
	</c:if>
});

function listPage(page) {
	var url = "${pageContext.request.contextPath}/review/listReview";
	//var query = "productNum=${dto.productNum}&pageNo="+page;
	var query = "productNum=${dto.productNum}&page="+page;
	
	var fn = function(data){
		$("#listReview").html(data);
	};
	
	ajaxFun(url, "get", "html", query, fn);
}
function listQnaPage(page) {
	var url = "${pageContext.request.contextPath}/qna/listQna";
	//var query = "productNum=${dto.productNum}&pageNo="+page;
	var query = "productNum=${dto.productNum}&page="+page;
	
	var fn = function(data){
		$("#listQna").html(data);
	};
	
	ajaxFun(url, "get", "html", query, fn);
}

function likePage(){
	var url="${pageContext.request.contextPath}/store/updateLikepage";	
	var query="productNum="+${productNum};
	var fn = function(data) {
		var check=data.check;
		if(check==1) {
			$("#likeIcon").attr("class","fas fa-heart");
		} else if(check==0) {
			$("#likeIcon").attr("class","far fa-heart");
		}
	};
	ajaxFun(url, "post", "json", query, fn);
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
function likeOk(num){

	var url="${pageContext.request.contextPath}/store/updateLike";	
	var query="productNum="+num;
	var fn = function(data) {
		var state=data.state;
		if(state==="true") {
			alert("찜하기 완료!")
			$("#likeIcon").attr("class","fas fa-heart");
		} else if(state==="deltrue") {
			alert("찜하기 취소 완료!");
			$("#likeIcon").attr("class","far fa-heart");
		}else if(state==="false"){
			alert("찜하기 등록에 실패했습니다.");
		}
	};
	ajaxFun(url, "post", "json", query, fn);
}
</script>



