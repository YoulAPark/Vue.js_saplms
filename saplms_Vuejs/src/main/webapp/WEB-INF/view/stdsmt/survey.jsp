<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>설문조사</title>
	<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
	
<script>

	var pagesize = 5;
	var pagenumsize = 5;

	/** OnLoad event */ 
	$(function(){
		
		// 학생이 설문조사에 참여해야 할 수강목록 리스트
		fSurveyLecList();

		// 버튼 클릭 이벤트
		fBtnClickEvent();
		
	});

	
	// 버튼 클릭 이벤트
	function fBtnClickEvent(){
		$('a[name=btn]').click(function(e){
			e.preventDefault();
			
			var btnId = $(this).attr('id');
			
			switch(btnId){
				case 'btnCloseSelectLec':
					gfCloseModal();
					break;
				case 'btnSaveSurvey':
					fsaveSurveyValueConfirm();
					break;
			}
		});
	}
	
	// 학생이 설문조사에 참여해야 할 수강목록 리스트
	function fSurveyLecList(clickpagenum){
		clickpagenum = clickpagenum || 1;
		var param = {
				clickpagenum : clickpagenum,
				pagesize : pagesize
		}
		console.log(param);
		
		var searchcallback = function(returndata){
			console.log("returndata: " + returndata);
			searchcallbackprocess(returndata, clickpagenum);
		}
		callAjax("/manageC/surveyList.do", "post", "text", true, param, searchcallback);
	}
	
	function searchcallbackprocess(returndata, clickpagenum){
		$("#surveyLecList").empty().append(returndata);
		
		var totCnt = $("#surveyLecListCnt").val();
		console.log("수강 과목중에서 강의 종료기간이 지난 과목 개수"+totCnt);
		
		var pageNationHtml = getPaginationHtml(clickpagenum, totCnt, pagesize, pagenumsize, 'fSurveyLecList');
		console.log("paginationHtml : " + pageNationHtml);
		
		$("#surveyLecListPagination").empty().append(pageNationHtml);
		$("#hclickpagenum").val(clickpagenum);
	}
	
	// 설문조사에 참여할 강의 선택
	function fSelectSurveyLec(lecNo, confirmNo){
		if(confirmNo == 1){
			alert("이미 설문완료한 강의입니다.");
		}else{
			alert("설문은 한 번 작성하면 수정할 수 없습니다.");

			var param = {
					lecNo : lecNo,
					confirmNo : confirmNo
			}
			console.log(param);
			
			var selectsvContentcallback = function(returndata){
				console.log("returndata : " + returndata);
				selectsvContentcallbackprocess(returndata);
				gfModalPop("#layer1");
			}
			callAjax("/manageC/surveyContentList.do", "post", "text", true, param, selectsvContentcallback);
		}
	}

	function selectsvContentcallbackprocess(returndata){
		$("#surveyContentList").empty().append(returndata);
		var totCnt = $("#surveyContentCnt").val();
		console.log(returndata);
		
		if(returndata != null){
			// comcombo(group_code, combo_name(select id), type(all-전체, sel-선택), selvalue)
			for(var i = 1; i < totCnt; i++){
				comcombo("svScore", "surveyScore"+i, "sel", "");
			}
		}
	}
	
	function fsaveSurveyValueConfirm(){
		var totCnt = $("#surveyContentCnt").val();
		var totSurveyScore;
		var lecNo = $("#lecNo").val();
		var confirmNo = $("#confirmNo").val();
		var essaySurvey = $("#essaySurvey").val();

		for(var i = 1; i < totCnt; i++){
			var surveyScore = $("#surveyScore"+i).val();
			
			if(surveyScore == null || surveyScore == ""){
				alert("객관식 설문에 대한 점수를 모두 선택해주세요!");
				var confirm = "NO";
				break;
			}
		}
		
		if(confirm != "NO"){
			if(essaySurvey == null || essaySurvey == ""){
				alert("주관식 답을 입력하여 주세요!");
			}else{
				fSaveSurvey(lecNo, confirmNo);
			}
		}
	}
	
	
	// 설문조사 결과 저장
	function fSaveSurvey(lecNo, confirmNo){
		var totCnt = $("#surveyContentCnt").val();
		var totSurveyScore = 0;

		for(var i = 1; i < totCnt; i++){
				totSurveyScore += parseInt($("#surveyScore"+i).val())*5;
		}
		
		var essaySurvey = $("#essaySurvey").val();
		console.log("essaySurvey"+essaySurvey);

		var param =	{
			li_no : lecNo,	
			loginId : $("#loginId").val(),
			totSurveyScore : totSurveyScore,
			essaySurvey : essaySurvey
		}
		console.log(param);
		
		var savecallback = function(returndata){
			console.log(JSON.stringify(returndata));
			alert("설문결과가 저장되었습니다.");
			
			gfCloseModal();
			fSurveyLecList();
		}
		callAjax("/manageC/saveSurvey.do", "post", "json", true, param, savecallback);
	}
</script>
</head>

<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="loginId" id="loginId" value="${loginId}">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum" value="">
	
	<!-- 모달 배경 -->
	<div id="mask"></div>
	
	<div id="wrap_area">
	
	<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
	
	<h2 class="hidden">컨텐츠 영역</h2>
	<div id="container">
		<ul>
			<li class="lnb">
				<!-- lnb 영역 -->
				<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
				<!--// lnb 영역 -->
			</li>
			<li class="contents">
				<!-- contents -->
				<h3 class="hidden">contents 영역</h3>
				<!-- content -->
				<div class="content">
					<p class="Location">
						<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">학습관리</span>
							<span class="btn_nav bold">설문조사 </span>
						<a href="../manageA/surveyMgt.do" class="btn_set refresh">새로고침</a>
					</p>

					<p class="conTitle">
						<span>설문조사</span>
					</p>
					
					<div class="divComGrpCodList">
						<table class="col">
						<caption>수강완료 강의목록</caption>
						<colgroup>
							<col width="20%">
							<col width="10%">
							<col width="15%">
							<col width="15%">
							<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">강의명</th>
								<th scope="col">강사</th>
								<th scope="col">강의시작일</th>
								<th scope="col">강의종료일</th>
								<th scope="col">수강생</th>
							</tr>
						</thead>
						<tbody id="surveyLecList"></tbody>
						</table>
					</div>
					<div class="paging_area" id="surveyLecListPagination"></div>
					</div> 
					<!--// content -->

			<h3 class="hidden">풋터 영역</h3>
			<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
			</li>
		</ul>
	</div>
	</div>

	<!-- 설문지 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>설문지</strong>
			</dt>
			<dd class="content">
				<!-- s :  -->
				<table class="row">
					<tr>
						<th scope="row">설문번호</th>
						<th scope="row">설문문항</th>
						<th scope="row">설문답(점수)</th>
					</tr>
				<tbody id="surveyContentList"></tbody>
				</table>
	
				<!-- e : 모달창 닫기  -->
				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnSaveSurvey" name="btn"><span>저장</span></a>
					<a href=""	class="btnType gray"  id="btnCloseSelectLec" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<!-- 모달창 우상단 x버튼 -->
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</form>
</body>
</html>