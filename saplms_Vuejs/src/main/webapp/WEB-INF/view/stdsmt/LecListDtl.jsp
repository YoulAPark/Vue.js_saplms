<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${LecListCnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${LecListCnt > 0 }">
								<c:forEach items="${StdSmtLecList}" var="list">
									<tr>
										<td><a href="javascript:fselectone('${list.li_no}')">${list.li_nm}</a></td>
										<td>${list.name}</td>
										<td>${list.li_date}</td>
										<td>${list.li_redate}</td>
										<td>${list.ci_nm}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="LecListCnt" name="LecListCnt" value ="${LecListCnt}"/>