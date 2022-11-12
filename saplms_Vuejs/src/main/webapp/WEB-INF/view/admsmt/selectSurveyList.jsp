<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 강의당 학생들의 설문결과  -->
	<c:forEach items="${selectSurveyList}" var="list">
		<tr>
			<td>${list.studentNm}</td>
			<td>${list.eachSum}</td>
			<td>${list.svAnswer}</td>
		</tr>
	</c:forEach>
	
	<input type="hidden" id="selectSurveyListCnt" name="selectSurveyListCnt" value="${selectSurveyListCnt}"/>
	<input type="hidden" id="clickpagenum" name="clickpagenum" value="${clickpagenum}"/>


