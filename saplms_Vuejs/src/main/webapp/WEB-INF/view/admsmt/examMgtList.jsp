<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


				
		<!-- 갯수가 0인 경우  -->
		<c:if test="${examCnt eq 0 }">
			<tr>
				<td colspan="4">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		

		<!-- 갯수가 있는 경우  -->
		<c:if test="${examCnt > 0 }">
			<c:set var="nRow" value="${pageSize*(currentPage-1)}" /> 
			<c:forEach items="${testList}" var="list">
				<tr>
					    <td><a href="javascript:detailExamData(${list.test_cd})">${list.test_cd}</a></td>
						<td>${list.test_nm}</td>
						<td>${list.useyn}</td>
						<td>
					    <a href="javascript:detailTestData(${list.test_cd},'${list.test_nm}','${list.useyn}' )" ><span class="blue">보기</span></a>
					    <a href="javascript:deleteTestData(${list.test_cd})"><span class="blue">삭제</span></a>
						</td>
				</tr>
				 <c:set var="nRow" value="${nRow + 1}" /> 
			</c:forEach>
		</c:if>
		
		<!-- 이거 중간에 있으면 table 안먹힘  -->

        <input type="hidden" id="totcnt" name="totcnt" value="${examCnt}"/>











