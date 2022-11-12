<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:if test="${studentListCnt eq 0 }">
		<tr>
			<td colspan="6">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	<c:if test="${studentListCnt > 0 }">
		<c:forEach items="${studentList}" var="list">
			<tr>
				<td>${list.name}</td>
				<td>${list.status_yn}</td>
				<td>${list.loginID}</td>
				<td>${list.password}</td>
				<td>${list.hp}</td>
				<td>${list.classes}</td>
				<td>${list.regdate}</td>
				
			</tr>
		</c:forEach>
	</c:if>
	<input type="hidden" id="studentListCnt" name="studentListCnt" value ="${studentListCnt}"/>
</body>
</html>