<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!-- 설문을 해야하는 강의 리스트  -->
	<c:if test = "${surveyLecListCnt eq 0}">
		<tr>	
			<td colspan="12">설문조사는 수강 완료 강의에 한해서 가능합니다.</td>
		</tr>
	</c:if>
	<c:if test = "${surveyLecListCnt > 0}">
		<c:forEach items="${surveyLecList}" var="list">
			<tr>
				<td><a href="javascript:fSelectSurveyLec(${list.lecNo},${list.surveyConfirm})">${list.lecNm}</a></td>
				<td>${list.teacherNm}</td>
				<td>${list.lecSdate}</td>
				<td>${list.lecEdate}</td>
				<td>${list.studentNm}</td>
			</tr>
			<input type="hidden" id="selectLecNo" name="selectLecNo" value="${list.lecNo}">
	 		<input type="hidden" id="surveyConfirm" name="surveyConfirm" value="${list.surveyConfirm}"> 
		</c:forEach>
	</c:if>
	<input type="hidden" id="surveyLecListCnt" name="surveyLecListCnt" value="${surveyLecListCnt}">
