4<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						  
							<c:if test="${ResumeLmListCnt eq 0 }">
								<tr>
									<td colspan="4">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${ResumeLmListCnt > 0 }">
								<c:forEach items="${ResumeLmList}" var="list">
									<tr>
										<td><a href="javascript:fListResumeUser(1, '${list.li_no}', '${list.li_nm}')">${list.li_nm}</a></td>
										<td><span>${list.li_date} ~ ${list.li_redate} </span> </td>
										<td>${list.li_ap}</td>
										
										
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="ResumeLmListCnt" name="ResumeLmListCnt" value ="${ResumeLmListCnt}"/>