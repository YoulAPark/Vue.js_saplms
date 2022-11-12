<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
			 			   
							<c:if test="${searchlistcnt eq 0 }">
								<tr>
									<td colspan="6">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${searchlistcnt > 0 }">
								<c:forEach items="${listjobInfo}" var="list">
									<tr>
										<td><a href="javascript:fselectone(${list.em_no})">${list.em_no}</a></td>
										<td><a href="javascript:fselectone(${list.em_no})">${list.name}</a></td>
										<td>${list.em_date}</td>
										<td>${list.em_redate}</td>
										<td>${list.em_nm}</td>
										<td>${list.em_du}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="searchlistcnt" name="searchlistcnt" value ="${searchlistcnt}"/>