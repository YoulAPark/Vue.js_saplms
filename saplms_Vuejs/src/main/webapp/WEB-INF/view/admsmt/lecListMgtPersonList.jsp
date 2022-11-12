<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
			<c:if test="${totalCntAdmsmtLecPersonList eq 0 }">
				<tr>
					<td colspan="9">수강신청한 학생이 없습니다.</td>
				</tr>
			</c:if>
	 		
			<c:if test="${totalCntAdmsmtLecPersonList > 0 }">
				<c:set var="nRow" value="${pageSize*(currentPageComnDtlCod-1)}" />
				<c:forEach items="${admsmtLecPersonListMgtModel}" var="list">
					<tr>
						<td>${list.loginID}</td>
						<td><a href="javascript:fPopModalComnDtlCod('${list.loginID}','${list.li_no}')">${list.name}</td>
						<td>${list.user_dept}</td>
						<td>${list.li_nm}</td>										
						<td>${list.li_date}</td>										
						<td>${list.li_redate}</td>
						
						
						<td id="sb_yn">
						
					
						<c:choose> 
						    <c:when test="${list.sb_yn eq 'N'}">
						       <button  disabled="disabled"><a href="javascript:modifySb_Yn( '${list.li_no}', '${list.loginID}', '${list.sb_yn}','${list.li_nm }' )" style="text-decoration:none;">휴학신청</a></button>
						    </c:when>
						    <c:when test="${list.sb_yn eq 'Y'}">
						       <button  disabled="disabled"><a href="javascript:modifySb_Yn('${list.li_no}', '${list.loginID}', '${list.sb_yn}' ,'${list.li_nm }')" style="text-decoration:none;">휴학취소</a></button>
						    </c:when>
						</c:choose>
						
						 
						</td>
						
					</tr>
					<%-- <input type="hidden" id="sb_yn2" value='${list.sb_yn }'>
					<input type="hidden" id="li_no" value='${list.li_no }'>
					<input type="hidden" id="loginID" value='${list.loginID }'>
					 --%>
					<c:set var="nRow" value="${nRow + 1}" />
				</c:forEach>
			</c:if>
							
		<input type="hidden" id="totalCntComnDtlCod" name="totalCntComnDtlCod" value ="${totalCntAdmsmtLecPersonList}"/>