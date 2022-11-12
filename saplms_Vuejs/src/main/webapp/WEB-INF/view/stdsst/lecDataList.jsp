<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalLecDataCod eq 0 }">
								<tr>
									<td colspan="3">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalLecDataCod > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageLecDataCod-1)}" />
								<c:forEach items="${listLecDataModel}" var="list">
									<tr>
		  				 			  
										<td><a href="javascript:fPopModalLecDataCod( '${list.le_no}', '${list.li_no}');">${list.le_title}</a></td>
										<td>${list.le_date}</a></td>
										<td>${list.le_nm}</td>
					 				
				 				
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalLecDataCod" name="totalLecDataCod" value ="${totalLecDataCod}"/>
			 				