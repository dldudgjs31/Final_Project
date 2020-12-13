<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="body-container" style="width: 700px;">
    <div>
       글올리기 선택 페이지입니다.
       <br><br><br>
      <p><a href="${pageContext.request.contextPath}/daily/created">일상글</a>  </p>
      <br>
      <p><a href="${pageContext.request.contextPath}/used/write">중고글</a>  </p>
    </div>
</div>