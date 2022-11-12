<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						    
							<c:if test="${searchlistcnt eq 0 }">
								<tr>
									<td colspan="3">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${searchlistcnt > 0 }">
								<c:forEach items="${searchenroll}" var="list"> <!-- Conrtroller에 있는 리스트 레퍼런스 -->
									<tr>
										<td><a href="javascript:fselectone(${list.ln_no})">${list.li_nm}</a></td>
										<td>${list.in_date}</td>
										<td>${list.name}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="searchlistcnt" name="searchlistcnt" value ="${searchlistcnt}"/>