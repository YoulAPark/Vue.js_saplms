<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${UserListCnt eq 0 }">
								<tr>
									<td colspan="4">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${UserListCnt > 0 }">
								<c:forEach items="${resumeUserList}" var="list">
									<tr>
										<td><a href="javascript:fResumeOutput('${list.userID}','${list.li_no}')"> ${list.name}</a></td>
										<td>${list.ss_score } </td>
										
									<c:if test="${list.ss_score >= 80}">
										<td>합격</td>
									</c:if>
									<c:if test="${list.ss_score < 80}">
										<td>불합격</td>
									</c:if>
    	
										
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="UserListCnt" name="UserListCnt" value ="${UserListCnt}"/>