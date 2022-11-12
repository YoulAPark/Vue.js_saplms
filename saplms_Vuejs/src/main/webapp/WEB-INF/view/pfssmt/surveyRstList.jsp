<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${SurveyRstCnt eq 0 }">
								<tr>
									<td colspan="7">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${SurveyRstCnt > 0 }">
								<c:forEach items="${surveyRstList}" var="list">
									<tr>
										<td>${list.li_no}</td>
										<td>${list.li_nm}</td>
										<td>${list.tname}</td>
										<td>${list.loginID}</td>
										<td>${list.name}</td>
										<td>${list.ci_nm}</td>
										<td>${list.sv_cj}</td>
										
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="SurveyRstCnt" name="SurveyRstCnt" value ="${SurveyRstCnt}"/>