<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
	<c:choose>
		<c:when test="${not empty sum_score }">
			<tr>
				<td colspan="2" style="text-align:center;">점수 : <input type="text" id="sum_score" value="${sum_score } 점" style="width:60px; font-size:12pt; text-align: center;" readonly></td>
				<td colspan="3" style="text-align:center;">정답<input type="checkbox" style="accent-color:blue;" checked><span> / </span>선택한 답<input type="checkbox" style="accent-color:red" checked>
			</tr>
			<c:forEach items="${quelist}" var="list" varStatus="qnum">
				<tr>
					<td>${qnum.count }. </td>
					<td colspan="4">${list.qst_contents}</td>
				</tr>
				<tr id="qnum${qnum.index }">
					<c:choose>
						<c:when test="${list.ss_answer eq list.qst_answer }">
							<td></td>
							<td><input type="checkbox" id="qst_cd${qnum.index }" value="${list.view1 }"> ${list.view1 }</td>
							<td><input type="checkbox" id="qst_cd${qnum.index }" value="${list.view2 }"> ${list.view2 }</td>
							<td><input type="checkbox" id="qst_cd${qnum.index }" value="${list.view3 }"> ${list.view3 }</td>
							<td><input type="checkbox" id="qst_cd${qnum.index }" value="${list.view4 }"> ${list.view4 }</td>
						</c:when>
						<c:otherwise>
							<td></td>
							<td><input type="checkbox" id="qst_cd${qnum.index }" value="${list.view1 }"> ${list.view1 }</td>
							<td><input type="checkbox" id="qst_cd${qnum.index }" value="${list.view2 }"> ${list.view2 }</td>
							<td><input type="checkbox" id="qst_cd${qnum.index }" value="${list.view3 }"> ${list.view3 }</td>
							<td><input type="checkbox" id="qst_cd${qnum.index }" value="${list.view4 }"> ${list.view4 }</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<input type="hidden" id="qst_answer${qnum.index }" value="${list.qst_answer }">
				<input type="hidden" id="ss_answer${qnum.index }" value="${list.ss_answer }">
				<input type="hidden" id="count" value="${list.count }">
			</c:forEach>
		</c:when>
		<c:otherwise>				   
			<c:forEach items="${quelist}" var="list" varStatus="qnum">
				<tr>
					<td>${qnum.count }. </td>
					<td colspan="4">${list.qst_contents}</td>
				</tr>
				<tr id="qnum${qnum.index }">
					<td></td>
					<td><input type="radio" id="qst_cd" name="qst_radio${qnum.index }" value="${list.view1 }"> ${list.view1 }</td>
					<td><input type="radio" id="qst_cd" name="qst_radio${qnum.index }" value="${list.view2 }"> ${list.view2 }</td>
					<td><input type="radio" id="qst_cd" name="qst_radio${qnum.index }" value="${list.view3 }"> ${list.view3 }</td>
					<td><input type="radio" id="qst_cd" name="qst_radio${qnum.index }" value="${list.view4 }"> ${list.view4 }</td>
				</tr>
				<input type="hidden" id="qst_cd${qnum.index }" value="${list.qst_cd }">
				<input type="hidden" id="score${qnum.index }" value="${list.score }">
				<input type="hidden" id="count" value="${list.count }">
			</c:forEach>
		</c:otherwise>	
	</c:choose>

	
	
	