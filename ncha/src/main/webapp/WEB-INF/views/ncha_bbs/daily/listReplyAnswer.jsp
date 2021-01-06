<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="vo" items="${listReplyAnswer}">
    <div class='answer' style='padding: 0px 10px;'>
        <div style='clear:both; padding: 10px 0px;'>
            <div style='float: left; width: 5%;'>└</div>
            <div style='float: left; width:95%;'>
                <div style='float: left;'><b>${vo.userId}</b></div>
                <div style='float: right;'>
                    <span>${vo.created_date}</span> |
                    <c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}">
                    	<span class='deleteReplyAnswer btn-danger' style='cursor: pointer;' data-daily_replyNum='${vo.daily_replyNum}' data-answer='${vo.answer}'>삭제</span>
                    </c:if>
                    <c:if test="${sessionScope.member.userId!=vo.userId && sessionScope.member.userId!='admin'}">
                    	<span class="notifyReply">신고</span>
                    </c:if>
                </div>
            </div>
        </div>
        <div style='clear:both; padding: 5px 5px 5px 5%; border-bottom: 1px solid #ccc;'>
            ${vo.content}
        </div>
    </div>			            
</c:forEach>