<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:forEach items="${equiplist}" var="list">
		<tr>
			<td>${list.ce_no}</td>
			<td>${list.ce_nm}</td>
			<td>${list.ce_ea}</td>
			<td>${list.ce_note}</td>
			<td><a href="javascript:updateEquip('${list.li_no}', '${list.ce_no }');" class="btnType gray"><span>수정</span></a></td>
			<td><a href="javascript:deleteEquip('${list.li_no}', '${list.ce_no }');" class="btnType gray"><span>삭제</span></a></td>
		</tr>
	</c:forEach>
