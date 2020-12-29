<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function deleteEvent() {
<c:if test="${sessionScope.seller.sellerId=='admin' || sessionScope.seller.sellerId==dto.sellerId}">
	var q = "eventNum=${dto.eventNum}&${query}";
    var url = "${pageContext.request.contextPath}/event/delete?" + q;

    if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
  	  location.href=url;
</c:if>    
<c:if test="${sessionScope.seller.sellerId!='admin' && sessionScope.seller.sellerId!=dto.sellerId}">
  alert("게시물을 삭제할 수  없습니다.");
</c:if>
}

function updateEvent() {
<c:if test="${sessionScope.seller.sellerId==dto.sellerId}">
	var q = "eventNum=${dto.eventNum}&page=${page}";
    var url = "${pageContext.request.contextPath}/event/update?" + q;

    location.href=url;
</c:if>

<c:if test="${sessionScope.seller.sellerId!=dto.sellerId}">
   alert("게시물을 수정할 수  없습니다.");
</c:if>
}
</script>

<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><i class="far fa-image"></i>진행중인 이벤트</h3>
    </div>
    
    <div>
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="center">
				   ${dto.subject}
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">
			       주최 : ${dto.sellerId}
			    </td>
			</tr>
			
			<tr>
			  <td colspan="2" align="left" style="padding: 10px 5px;">
			      <img src="${pageContext.request.contextPath}/uploads/event/${dto.imageFilename}" style="max-width:100%; height:auto; resize:both;">
			   </td>
			</tr>			
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="50">
			      ${dto.content}
			   </td>
			</tr>
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
				진행 기간 : <span style="font-style: italic;"> ${dto.start_date}~ ${dto.end_date} </span>  
				</td>
			</tr>
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       이전글 :
			         <c:if test="${not empty preReadDto}">
			              <a href="${pageContext.request.contextPath}/event/article?${query}&eventNum=${preReadDto.eventNum}">${preReadDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       다음글 :
			         <c:if test="${not empty nextReadDto}">
			              <a href="${pageContext.request.contextPath}/event/article?${query}&eventNum=${nextReadDto.eventNum}">${nextReadDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			    <td width="300" align="left">
			       <c:if test="${sessionScope.seller.sellerId==dto.sellerId}">				    
			          <button type="button" class="btn" onclick="updateEvent();">수정</button>
			       </c:if>
			       <c:if test="${sessionScope.seller.sellerId=='admin' || sessionScope.seller.sellerId==dto.sellerId}">				    
			          <button type="button" class="btn" onclick="deleteEvent();">삭제</button>
			       </c:if>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/event/list?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
    </div>
    
</div>