<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType ne 'D'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>강의 피드백</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	//페이징처리 변수 선언
	var pagesize = 5; //한페이지당 몇개
	var pagenumsize = 5; //페이지네비게이션 번호몇개
	
	var li_date = 0; //강의 시작일
	var li_redate = 0; //강의 종료일

	/* OnLoad event */
	$(function() {

		// 목록 데이터
		surveyRstList();
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();

	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
			
			var btnId = $(this).attr('id');
			
			switch(btnId) {
			case 'btnSearch' :
				surveyRstList();
				break;
			}
		});
	}
	

// 설문 결과 조회	
function surveyRstList(clickpagenum) {
	clickpagenum = clickpagenum || 1;
	
	var param = {
			searchvalue : $("#searchvalue").val() ,
			clickpagenum : clickpagenum,
			pagesize : pagesize,
			li_date : $("#li_date").val(),
			li_redate : $("#li_redate").val(),
			
	};
	
	var searchcallback = function(returndata) {
		console.log("returndata : " + returndata);
		
		searchcallbackprocess(returndata, clickpagenum);
	}
	
	callAjax("/manageD/surveyRstList.do","post","text",true,param, searchcallback)
	
}

// 설문 결과 콜백함수
function searchcallbackprocess(returndata, clickpagenum) {
	$("#listsurveyRst").empty().append(returndata);
	
	var totalcnt = $("#SurveyRstCnt").val();
	
	var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'surveyRstList');
	console.log("paginationHtml : " + paginationHtml);
	
	$("#divsurveyRstPagination").empty().append(paginationHtml);
	
	$("#hclickpagenum").val(clickpagenum);
	
}


	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">학습관리</span> 
								<span class="btn_nav bold">설문 결과</span> <a href="../manageD/surveyRst.do" class="btn_set refresh">새로고침</a>
						</p>

							<p class="conTitle">
								
								   <input type="text" style="width: 50px; height: 25px;" id="SVY" name="SVY" placeholder=" 과정명 " disabled/ >		
									 
								
	     	                       <input type="text" style="width: 300px; height: 25px;" id="searchvalue" name="searchvalue">                    
		                           <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
		                           
		                           <input type="date" id="li_date" name="li_date">
		                           <input type="date" id="li_redate" name="li_redate">
							</p>
							
							<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">

								<tr style="border: 0px; border-color: blue">
									<td width="50" height="25"
										style="font-size: 100%; text-align: left; padding-right: 25px;">
									</td>
								</tr>
							</table>
                         
                        <h1>평점 결과</h1>
						<div class="divsurveyRstList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="12%">
									<col width="12%">
									<col width="12%">
									<col width="12%">
									<col width="12%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">강의명</th>
										<th scope="col">담당교수</th>
										<th scope="col">학생ID</th>
										<th scope="col">학생 명</th>
										<th scope="col">강의실</th>
										<th scope="col">점수</th>
									</tr>
								</thead>
								<tbody id="listsurveyRst"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="divsurveyRstPagination"> </div>
						
					</div> <!--// content -->
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!--// 모달팝업 -->
</form>
</body>
</html>