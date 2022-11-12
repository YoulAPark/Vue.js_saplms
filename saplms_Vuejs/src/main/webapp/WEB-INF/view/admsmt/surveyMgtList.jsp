<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 설문 결과가 있는 강의 리스트  -->
	<c:if test="${listSurveyCnt eq 0}">
		<tr>
			<td colspan="12">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	<c:if test="${listSurveyCnt > 0}">
		<c:forEach items="${listSurvey}" var="list">
			<tr>
				<td>${list.li_typeNm}</td>
				<td><a href="javascript:fSelectSurvey()">${list.lecNm}</a></td>
				<td>${list.teacherNm}</td>
				<td>${list.lecSdate}</td>
				<td>${list.lecEdate}</td>
				<td>${list.svSum}</td>
				<td>${list.svAttendCnt}</td>
			</tr>
			<input type="hidden" id="selectSurveyNo" name="selectSurveyNo" value="${list.lecNo}"/>
		</c:forEach>
	</c:if>
	<input type="hidden" id="listSurveyCnt" name="listSurveyCnt" value ="${listSurveyCnt}"/>

