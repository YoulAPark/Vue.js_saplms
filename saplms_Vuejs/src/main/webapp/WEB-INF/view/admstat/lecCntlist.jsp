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
								<c:forEach items="${searchlist}" var="list">
									<tr>										
										<td>${list.li_no}</td>
										<td>${list.li_nm}</td>
										<td>${list.li_date}</td>
										<td>${list.li_redate}</td>
										<td>${list.li_ap}</td>
										<td>${list.li_garden}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="searchlistcnt" name="searchlistcnt" value ="${searchlistcnt}"/>
							<input type="hidden" id="flinm" name="flinm" value ="${flinm}"/>							
							<input type="hidden" id="fliap" name="fliap" value ="${fliap}"/>							
							<input type="hidden" id="fligarden" name="fligarden" value ="${fligarden}"/>					
							