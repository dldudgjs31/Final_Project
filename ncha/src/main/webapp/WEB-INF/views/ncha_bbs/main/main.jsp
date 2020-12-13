<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick.css" />
<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick-theme.css" />
<script type="text/javascript" src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script>

 <style type="text/css">
.body-container{
	display: grid;
	width: 100%;
	grid-template-colomns:repeat(4,25%);
	grid-template-rows:repeat(6,150px);
	grid-template-areas:
	"rank daily daily daily"
	"rank daily daily daily"
	"rank used used used"
	"rank used used used"
	"store store store store"
	"store store store store";
}
.user-rank{
	grid-area:rank;
}
.daily-content{
	grid-area:daily;

}
.used-content{
	grid-area:used;
}
.store-content{
	grid-area:store;
}
.slider-image{
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
	height: 450px;
}
.items{
	border-radius: 20px;
	border: 2px solid silver;
	width: 30%;
	height: 250px;
}
.store-items{
	border-radius: 20px;
	border: 2px solid silver;
	width: 20%;
	height: 250px;
}
.items-container{
	display: flex;
	justify-content: space-around;
	align-items: center;
}
.slick-items{
	width: 99%;
}

@media screen and (max-width: 768px) {
	.body-container{
		grid-template-colomns:repeat(4,25%);
		grid-template-rows:repeat(6,100px);
		grid-template-areas:
		"rank daily daily daily"
		"rank daily daily daily"
		"rank used used used"
		"rank used used used"
		"store store store store"
		"store store store store";
	}
	.items{
		height: 150px;
	}
	.store-items{
		height: 150px;
	}	
		
}
</style>  



    <div class="slick-items" style="height: 450px;">
        <div  class="slider-image" style="background-image: url('${pageContext.request.contextPath}/resources/img/storelogo.png');"></div>
        <div  class="slider-image" style="background-image: url('${pageContext.request.contextPath}/resources/img/storelogo.png');"></div>
        <div  class="slider-image" style="background-image: url('${pageContext.request.contextPath}/resources/img/storelogo.png');"></div>
        <div  class="slider-image" style="background-image: url('${pageContext.request.contextPath}/resources/img/storelogo.png');"></div>
    </div>
    
    <div class="body-container">
    	<div class="user-rank">
    		<h2>Best 유저</h2>
    		    <div class="slick-rank" style="height: 200px;">
    		    	<div>1</div>
    		    	<div>1</div>
    		    	<div>1</div>
   				</div>
    		
    	</div>
    	<div class="daily-content">
    	<h3 style="margin: 10px;">Daily 일상글</h3>
    		<div class="items-container">
	    		<div class="items" style="background-image: url('${pageContext.request.contextPath}/resources/img/storelogo.png"></div>
	    		<div class="items"></div>
	    		<div class="items"></div>
    		</div>
    	</div>
    	<div class="used-content">
    	<h3 style="margin: 10px;">N차 중고거래</h3>    	
    	    <div class="items-container">
	    		<div class="items" style="background-image: url('${pageContext.request.contextPath}/resources/img/storelogo.png"></div>
	    		<div class="items"></div>
	    		<div class="items"></div>   
	    	</div> 	
    	</div>
    	<div class="store-content">
    	<h3 style="margin: 10px;">N차 스토어 Best</h3>    	
    	    <div class="items-container">
	    		<div class="store-items" style="background-image: url('${pageContext.request.contextPath}/resources/img/storelogo.png"></div>
	    		<div class="store-items"></div>
	    		<div class="store-items"></div>   
	    		<div class="store-items"></div>   
	    	</div> 	
    	</div>
    
    </div>
    
    






<script type="text/javascript">



$(document).ready(function () {

	//alert('123');

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