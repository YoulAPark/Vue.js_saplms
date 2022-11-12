<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						    
	<c:if test="${totalCntAdmsmtLecList eq 0 }">
		<tr>
			<td colspan="9">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	 
	<c:if test="${totalCntAdmsmtLecList > 0 }">
		<c:set var="nRow" value="${pageSize*(currentPageComnGrpCod-1)}" />
		<c:forEach items="${admsmtLecListMgtModel}" var="list">
			<tr>
				<td>${list.li_no}</td>
				<td><a href="javascript:fListLecPersonList(1,'${list.li_no}')" id="li_nmClick">${list.li_nm}</a></td>
				<td>${list.name}</td>
				<td>${list.loginID}</td>
				<td>${list.li_no2}</td>
				<td>${list.li_ap}</td>
				<td></td>
			
			</tr>
			<c:set var="nRow" value="${nRow + 1}" />
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="totalCntComnGrpCod" name="totalCntComnGrpCod" value ="${totalCntAdmsmtLecList}"/>