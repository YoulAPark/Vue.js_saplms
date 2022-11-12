<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalCntSatisfactopnList eq 0 }">
								<tr>
									<td colspan="7">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCntSatisfactopnList > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageLecDataCod-1)}" />
								<c:forEach items="${admstatSatisfactionModel}" var="list">
									<tr>
		  				 			  
										<td><a href="javascript:drawgo('${list.sv_sumcj}','${list.sv_avgcj}','${list.sv_maxcj}','${list.sv_mincj}')" >${list.li_nm}</a></td>
										<td>${list.li_date} ~
										${list.li_redate}</td>
					 					<td>${list.sv_count}</td>
					 					<td>${list.sv_sumcj}</td>
					 					<td>${list.sv_avgcj}</td>
					 					<td>${list.sv_maxcj}</td>
					 					<td>${list.sv_mincj}</td>
					 				
					 				
				 				
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalLecDataCod" name="totalLecDataCod" value ="${totalCntSatisfactopnList}"/>
			 				