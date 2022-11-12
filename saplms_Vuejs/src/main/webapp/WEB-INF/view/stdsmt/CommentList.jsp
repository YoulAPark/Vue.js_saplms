<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
	<c:if test="${searchlistcnt2 > 0 }">
		<c:forEach items="${commentList}" var="list">
			<table>
				<tr>
					<td style="background-color: rgb(187, 194, 205); font-weight: 900;">
						${list.name} 
						<a href="javascript:fdeleteComment(${list.cm_no})" style="float:right;">X</a>
					</td>
				</tr>
				<tr>
					<td>${list.cm_contents}</td>
				</tr>
			</table>	
		</c:forEach>
	</c:if>
	<input type="hidden" id="searchlistcnt2" name="searchlistcnt2" value ="${searchlistcnt2}"/>
</body>
</html>