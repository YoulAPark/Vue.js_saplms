<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!-- 설문 항목 -->
	<c:forEach items="${surveyContentList}" var="list">
		<c:if test="${list.surveyNo != 6}">
			<tr>
				<td>${list.surveyNo}</td>
				<td>${list.surveyContent}</td>
				<td>
				<select id="surveyScore${list.surveyNo}" style="width: 150px;"></select>
				</td>
			</tr>
		</c:if>
		<c:if test="${list.surveyNo == 6}">
			<tr>
				<td>${list.surveyNo}</td>
				<td>${list.surveyContent}</td>
				<td><textarea id="essaySurvey" placeholder="100자 이내로 기재해주세요." /></td>
			</tr>
		</c:if>
	</c:forEach>
	
	<input type="hidden" id="surveyContentCnt" name="surveyContentCnt" value="${surveyContentCnt}">
	<input type="hidden" id="lecNo" name="lecNo" value="${lecNo}">
	<input type="hidden" id="confirmNo" name="confirmNo" value="${confirmNo}">
