<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:if test="${searchlistcnt eq 0 }">
		<tr>
			<td colspan="8">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	<c:if test="${searchlistcnt > 0 }">
		<c:forEach items="${searchlist}" var="list">
			<tr>
				<td>${list.li_no}</td>
				<td><a href="javascript:classEquipList(${list.li_no})">${list.ci_nm}</a></td>
				<td>${list.ci_size}</td>
				<td>${list.ci_number}</td>
				<td>${list.ci_note}</td>
				<td><a href="javascript:updateClassroom('${list.li_no}');" class="btnType gray"><span>수정</span></a></td>
				<td><a href="javascript:deleteClassroom('${list.li_no}');" class="btnType gray"><span>삭제</span></a></td>
			</tr>
		</c:forEach>
	</c:if>
							
	<input type="hidden" id="searchlistcnt" name="searchlistcnt" value ="${searchlistcnt}"/>
