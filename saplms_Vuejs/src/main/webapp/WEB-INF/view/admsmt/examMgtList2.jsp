<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


				
		<!-- 갯수가 0인 경우  -->
		<c:if test="${questionCnt eq 0 }">
			<tr>
				<td colspan="5">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		

		<!-- 갯수가 있는 경우  -->
		<c:if test="${questionCnt > 0 }">
			 
			<c:forEach items="${questionList}" var="list" >
				<tr>
					    <td>${list.qst_cd}</td>
					    <td>${list.qst_contents}</td>
					    <td>${list.qst_answer}</td>
					    <td>${list.score}</td>
					    <td>
					    <a href="javascript:questionDetailInfo(${list.test_cd},${list.qst_cd},'${list.qst_contents}','${list.qst_answer}','${list.view1}','${list.view2}','${list.view3}','${list.view4}',${list.score})" ><span class="blue">보기</span></a>
					    <a href="javascript:questionDelete(${list.test_cd},${list.qst_cd})"><span class="blue">삭제</span></a>
						</td>
				</tr>
			
			</c:forEach>	 
			
		</c:if>
		
		<!-- 이거 중간에 있으면 table 안먹힘  -->

       











