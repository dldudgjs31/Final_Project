<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<div class="body-container" style="width: 700px;">
	<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
		<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
    		<td colspan="2" align="center">
	   			${dto.subject}
   			 </td>
		</tr>

		<tr height="35" style="border-bottom: 1px solid #cccccc;">
		    <td width="50%" align="left" style="padding-left: 5px;">
		       이름 : ${dto.userName}
		    </td>
		    <td width="50%" align="right" style="padding-right: 5px;">
		        ${dto.created_date} | 조회 ${dto.hitCount}
		    </td>
		</tr>


		<tr style="border-bottom: 1px solid #cccccc;">
		  <td colspan="2" align="left" style="padding-left: 5px;">
		     카테고리 : ${dto.categoryName}  
		  </td>
		</tr>
		<tr style="border-bottom: 1px solid #cccccc;">
		  <td colspan="2" align="left" style="padding-left: 5px;">
		     가격 : ￦ ${dto.price}  
		  </td>
		</tr>
		<tr style="border-bottom: 1px solid #cccccc;">
		  <td colspan="2" align="left" style="padding-left: 5px;">
		     상품상태 : ${dto.productCondition}  
		  </td>
		</tr>
		<tr style="border-bottom: 1px solid #cccccc;">
		 <td colspan="2" align="left" style="padding-left: 5px;">
		     결제방법 : ${dto.dealingMode}  
		  </td>
		</tr>
		<tr style="border-bottom: 1px solid #cccccc;">
		  <td colspan="2" align="left" style="padding-left: 5px;">
		     거래지역 : ${dto.location}  
		  </td>
		</tr>
		<tr style="border-bottom: 1px solid #cccccc;">
		  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
		      ${dto.content}
		   </td>
		</tr>
		
		
		<tr height="35" style="border-bottom: 1px solid #cccccc;">
		    <td colspan="2" align="left" style="padding-left: 5px;">
		       이전글 :
		        <c:if test="${not empty preReadDto}">
		            <a href="${pageContext.request.contextPath}/used/article?${query}&usedNum=${preReadDto.usedNum}">${preReadDto.subject}</a>
		        </c:if>
		    </td>
		</tr>
		
		<tr height="35" style="border-bottom: 1px solid #cccccc;">
		    <td colspan="2" align="left" style="padding-left: 5px;">
		       다음글 :
		        <c:if test="${not empty nextReadDto}">
		            <a href="${pageContext.request.contextPath}/used/article?${query}&usedNum=${nextReadDto.usedNum}">${nextReadDto.subject}</a>
		        </c:if>
		     </td>
		</tr>
</table>

<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
	<tr height="45">
    <td width="300" align="left">
        <c:if test="${sessionScope.member.userId==dto.userId}">
            <button type="button" class="btn" onclick="updateForm('${dto.usedNum}', '${pageNo}');">수정</button>
        </c:if>
        <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
            <button type="button" class="btn" onclick="deleteBoard('${dto.usedNum}', '${pageNo}');">삭제</button>
        </c:if>
    </td>

    <td align="right">
        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/used/list?${query}';">리스트</button>
    </td>
	</tr>
</table>
</div>