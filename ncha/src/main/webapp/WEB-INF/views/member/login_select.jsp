<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<script type="text/javascript">
$(function(){
	//AJAX로 탭에 표시할 정보를 서버에서 받아온다,
	function loadTabContent($obj,url){
		$obj.load(url);
	}
	
	//실행과 동시에 처음탭에 출력
	var $obj = $("#tab-1");
	var url = "${pageContext.request.contextPath}/ncha/login_1";
	loadTabContent($obj,url);
	
	//탭이 변경될때 마다 탭의 내용을 ajax로 서버에서 다시 불러온다.
	$("a[data-toggle='tab']").on("shown.bs.tab",function(e){
		var tab=$(this).attr("aria-controls");
		var $obj = $("#tab-"+tab);
		var url;
		if(tab==="1"){
			url="${pageContext.request.contextPath}/ncha/login_1";
		} else if(tab==="2"){
			url="${pageContext.request.contextPath}/ncha/login_2";
		} 
		
		loadTabContent($obj, url);
	
	});
	
});
</script>

<style>
.body-container{
	width:100%;
	display: flex;
	justify-content: center;
}
.tab{
	width: 50%;
}
</style>
<div class="body-container">

<div class="tab" role="tabpanel">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a href="#tab-1" aria-controls="1" role="tab" data-toggle="tab">일반회원</a></li>
    <li role="presentation"><a href="#tab-2" aria-controls="2" role="tab" data-toggle="tab">판매회원</a></li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="tab-1"></div>
    <div role="tabpanel" class="tab-pane" id="tab-2"></div>
    <div role="tabpanel" class="tab-pane" id="tab-3"></div>
  </div>

</div>


</div>