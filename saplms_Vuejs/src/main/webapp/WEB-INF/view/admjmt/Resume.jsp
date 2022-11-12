<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>이력서관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	
	//과정명 목록 페이지 설정
	var pageSizeLmResume = 5; // 페이지 갯수
	var pageBlockSizeLmResume = 5;
	
	//과정 참가자 목록 페이지 설정
	var pageSizeUserResume = 5; 
	var pageBlockSizeUserResume = 5;

	/* OnLoad event */
	$(function() {

		// 이력서 과정명 목록 조회
		ResumeLmList();
		//fListResumeUser();
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
				Resume_search();
				break;
			case 'btnClose' :
				gfCloseModal();
				break;
			}
		});
	}
	
	// 검색기능
	function Resume_search(currentPage) {
        
		currentPage = currentPage || 1;
		
        var param = {
        		  searchvalue : $("#searchvalue").val()	
              ,   currentPage : currentPage
              ,   pageSize : pageSizeLmResume
        }
        //swal(JSON.stringify(param));
        var resultCallback = function(data) {
        	callbacklmresult(data, currentPage); 
        };
        
        callAjax("/careerA/resumeLmList.do", "post", "text", true, param, resultCallback);
        
  } 
	

// 이력서 과정명 목록조회	
function ResumeLmList(currentPage) {
	currentPage = currentPage || 1;
	var searchvalue = $('#searchvalue');
	
	var param = {
				searchvalue : searchvalue.val()
            ,   currentPage : currentPage
            ,   pageSize : pageSizeLmResume		
	};
	
	var searchcallback = function(data) {
		
		
		callbacklmresult(data, currentPage);
	}
	
	callAjax("/careerA/resumeLmList.do","post","text",true,param, searchcallback)
	
}

//이력서 과정명 목록조회 콜백함수
function callbacklmresult(data, currentPage) {
	$("#listResume").empty().append(data);
	
	var totalcnt = $("#ResumeLmListCnt").val();
	
	var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSizeLmResume, pageBlockSizeUserResume, 'ResumeLmList');
	console.log("paginationHtml : " + paginationHtml);
	
	$("#divResumePagination").empty().append(paginationHtml);
	
	$("#currentPageLmResume").val(currentPage);
	
}

/* 이력서 과정명 수강자 목록조회  */
function fListResumeUser(currentPage, li_no, li_nm ) {
	
	currentPage = currentPage || 1;
	
	
	//이력서 과정 정보 설정
	
	var param = {
			li_no : li_no
		,	currentPage : currentPage
		,	pageSize : pageSizeUserResume
	}
	
	var resultCallback = function(data) {
		console.log(data);
		fListResumeUserResult(data,currentPage);
	};
	
	callAjax("/careerA/resumeUserList.do","post","text",true,param,resultCallback);
}

/* 이력서 과정명 수강자 콜백 목록조회 함수  */
function fListResumeUserResult(data, currentPage) {
	
	console.log("fListResumeUserResult : " + data)
	//데이터 삭제후 tbody추가
	$('#listResume2').empty().append(data);
	
	var UserListCnt = $("#UserListCnt").val();
	
	console.log("UserListCnt : " + UserListCnt);
	
	// 페이지 네비게이션 생성
	var paginationHtml = getPaginationHtml(currentPage, UserListCnt, pageSizeUserResume, pageBlockSizeUserResume, 'fListResumeUser');
	$("#divResumePagination2").empty().append( paginationHtml );
	
	// 현재 페이지 설정
	$("#currentPageUserResume").val(currentPage);
	
}

//이력서 모달창 폼 셋팅
function fn_forminit(object) {
	
	if(object == null || object =="") {
		$("#name").val("");
		$("#hp").val("");
		$("#loc").val("");
		$("#user_dept").val("");
		$("#li_nm").val("");
		$("#li_no").val("");
		$("#sum").val("");
		$("#em_nm").val("");
		$("#em_date").val("");
		$("#att_ori").val("");
		$("#resumecont").val("");
		$("#em_du").val("");

	} else {
		$("#name").val(object.name);
		$("#hp").val(object.hp);
		$("#loc").val(object.loc);
		$("#user_dept").val(object.user_dept);
		$("#li_nm").val(object.li_nm);
		$("#li_nm").val(object.li_no);
		$("#sum").val(object.sum);
		$("#em_nm").val(object.em_nm);
		$("#em_date").val(object.em_date);
		$("#att_ori").val(object.att_ori);
		$("#resumecont").val(object.resumecont);
		$("#em_du").val(object.em_du);
	}
	
}

// 이력서 출력 모달 실행
function fResumeOutput(userID, li_no) {
	
	console.log(userID,li_no);
	
	var param = { loginID : userID ,
					li_no : li_no		
	};
	
	var selectusercallback = function(searchoner) {
		console.log(JSON.stringify(searchoner));
		//console.log("받은 거" + JSON.stringify(searchoner.searchoner));
		$("#action").val("U");
		fn_forminit(searchoner.searchoner);
		
		// 모달 팝업
		gfModalPop("#layer1");
	}
	
	callAjax("/careerA/resumeOutput.do","post","json",true,param,selectusercallback);
}

	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="currentPageLmResume" value="1">
	<input type="hidden" id="currentPageUserResume" value="1">

	
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
								class="btn_nav bold">취업관리</span> 
								<span class="btn_nav bold">이력서 관리</span> <a href="../careerA/resume.do" class="btn_set refresh">새로고침</a>
						</p>

							<p class="conTitle">
								   <input type="text" style="width: 200px; height: 25px;" id="label" name="label" placeholder="  과정명" disabled/ >		
	     	                       <input type="text" style="width: 300px; height: 25px;" id="searchvalue" name="searchvalue">                    
		                           
		                           <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							</p>
							
							<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">

								<tr style="border: 0px; border-color: blue">
									<td width="50" height="25"
										style="font-size: 100%; text-align: left; padding-right: 25px;">
									</td>
								</tr>
							</table>
                         
                        
						<div class="divResumRstList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="12%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">과정명</th>
										<th scope="col">기간</th>
										<th scope="col">대상자수</th>
									</tr>
								</thead>
								<tbody id="listResume"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="divResumePagination"> </div>
						
						<br/> <br/>
						  
						<div class="divResumRstList2">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="12%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">학생명</th>
										<th scope="col">점수</th>
										<th scope="col">상태(jsp단)</th>
									</tr>
								</thead>
								<tbody id="listResume2"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="divResumePagination2"> </div>
						
					</div> <!--// content -->
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 모달팝업 -->
	
	<div id="layer1" class="layerPop layerType1" style="width: 600px;">
		<dl>
			<dt>
				<strong>이력서 관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
						<col width="*">
						
					</colgroup>
<!--  사용자 성명 연락처 거주지역 학과 강의번호 강의명 재직구분 답안지 합계점수 회사명 입사일 퇴사일 재직여부 파일번호 논리경로 -->
					<tbody>
						<tr>
							<th scope="row">성명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="name" id="name" readonly/></td>
							<th scope="row">연락처 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="hp" id="hp" readonly/></td>
							<th scope="row">거주지역 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="loc" id="loc" readonly/></td>
						</tr>
						<tr>
							<th scope="row">학과 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="user_dept" id="user_dept" readonly/></td>
							<th scope="row">강의명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="li_nm" id="li_nm" readonly/></td>
							<th scope="row">시험점수 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="sum" id="sum" readonly/></td>
							
						</tr>
						<tr>
				
							<th scope="row">회사명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="em_nm" id="em_nm" readonly/></td>
							<th scope="row">입사및퇴사 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="em_date" id="em_date" readonly/></td>
							<th scope="row">재직구분 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="em_du" id="em_du" readonly/></td>
						</tr>
						<!--  
						<tr>
							<th scope="row"> 이력서 첨부<span class="font_red">*</span></th>
							<td><input type="file" class="inputTxt p100" name="att_ori" id="att_ori" /></td>
							<th scope="row" rowspan="2"> 지원내용<span class="font_red">*</span></th>
							<td rowspan="2"><textarea class="inputTxt p100" name="resumecont" id="resumecont"></textarea></td>
						</tr>
						-->
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!--// 모달팝업 -->
</form>
</body>
</html>