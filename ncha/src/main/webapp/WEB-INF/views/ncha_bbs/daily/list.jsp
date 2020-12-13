<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="body-container" style="width: 700px;">
    <div>
        일상글 리스트입니다.
       <br><br> 
       <div>
	       	<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
				<tr height="40">
					<td align="right" width="100">
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/daily/created';">글올리기</button>
					</td>
					<td align="center">
						<form name="searchForm" action="${pageContext.request.contextPath}/daily/list" method="post">
							<select name="condition" class="selectField">
								<option value="all">모두</option>
								<option value="food" >음식</option>
								<option value="furn" >가구</option>
								<option value="elec">전자제품</option>
								<option value="book">도서</option>
							</select>
							<input type="text" name="keyword" value="${keyword}" class="boxTF">
							<button type="button" class="btn" onclick="searchList()">검색</button>
						</form>
					</td>
					<td align="left" width="100">
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/daily/list';">새로고침</button>
					</td>
					<td>
						<button type="button" class="btn" onclick="">관심 일상 보기</button>
					</td>
				</tr>
			</table>		
       </div>
       
       <div>
       		<div>
		       	<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
					<tr height="35">
						<td align="left" width="50%">
							${dataCount}개 (${page}/${total_page} 페이지)
						</td>
						<td align="right">
							&nbsp;
						</td>
					</tr>
				</table>
       		</div>
       </div>
        <p> <a href="${pageContext.request.contextPath}/daily/article"> 글보기</a></p>
    </div>
</div>