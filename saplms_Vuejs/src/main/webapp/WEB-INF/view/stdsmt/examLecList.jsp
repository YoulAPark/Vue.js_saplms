<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:if test="${searchlistcnt eq 0 }">
		<tr>
			<td colspan="8">진행중인 시험이 없습니다.</td>
		</tr>
	</c:if>
	<c:if test="${searchlistcnt > 0 }">
		<c:forEach items="${searchlist}" var="list">
			<tr>
				<td>${list.li_nm}</td>
				<td>
					<c:choose>
						<c:when test="${list.status == 0 }">
							<a href="javascript:selectOneExampaper('${list.test_cd}', '${list.li_no }')">${list.test_nm}</a>
						</c:when>
						<c:when test="${list.status > 0 }">
							<a href="javascript:selectResultpaper('${list.test_cd}', '${list.li_no }')">${list.test_nm}</a>
						</c:when>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${list.status == 0 }">
							미응시
						</c:when>
						<c:when test="${list.status > 0 }">
							응시완료
						</c:when>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
	</c:if>
							
	<input type="hidden" id="searchlistcnt" name="searchlistcnt" value ="${searchlistcnt}"/>
