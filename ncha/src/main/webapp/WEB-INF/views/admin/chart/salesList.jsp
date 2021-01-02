<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>




<div class="body-container" style="width: 700px;">

	<ol class="breadcrumb">
	    <li class="breadcrumb-item">매출 분석</li>
	    <li class="breadcrumb-item active">매출 리스트</li>
	</ol>

    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-lg-3 mb-3">
         <div class="list-group">
          <a href="${pageContext.request.contextPath}/admin/chart/salesList" class="list-group-item">매출 리스트</a>	
          <a href="${pageContext.request.contextPath}/admin/chart/category" class="list-group-item">카테고리별 매출분석</a>
          <a href="${pageContext.request.contextPath}/admin/chart/store" class="list-group-item">스토어별 매출분석</a>
        </div>
      </div>
     </div>
    
    <div class="column">
   
   </div>
</div>
    