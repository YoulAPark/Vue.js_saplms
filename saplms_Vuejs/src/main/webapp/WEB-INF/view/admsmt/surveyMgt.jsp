<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>설문관리</title>
	<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script>
	var pagesize = 5;
	var pagenumsize = 5;
	
	/** OnLoad event */ 
	$(function(){
		
		// 설문결과가 있는 강의 리스트
		fListSurveyLoad();
		
		// 버튼 클릭 이벤트
		fBtnClickEvent();
	
		// enterKey 눌렸을때 이벤트 방지
		enterKeyEvent();
		
	});

	function enterKeyEvent(){
		$(document).on("keydown", function (evt){
			if ((evt.keyCode || evt.which) === 13) {
			    evt.preventDefault();
			}
		});
	}

	/** 버튼 클릭 이벤트 */
	function fBtnClickEvent(){
		$('a[name=btn]').click(function(e){
			e.preventDefault();
			
			var btnId = $(this).attr('id');
			
			switch(btnId){
				case 'btnSearch':
					fListSurveyLoad();
					break;
				case 'btnCloseSelectSurvey':
					gfCloseModal();
					break;
			}
		});
	}
	
	// 설문결과가 있는 강의 리스트
	function fListSurveyLoad(clickpagenum){
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
				searchType : $("#searchType").val(),
				searchValue : $("#searchValue").val(),
				clickpagenum : clickpagenum,
				pagesize : pagesize
		};
		
		console.log(param);
		
		var searchcallback = function(returndata){
			console.log("returndata: " + returndata);
			
			searchcallbackprocess(returndata, clickpagenum);
		}
		
		callAjax("/manageA/surveyMgtList.do", "post", "text", true, param, searchcallback);	
		
	}
	
	function searchcallbackprocess(returndata, clickpagenum){
		$("#listSurveyLoad").empty().append(returndata);
		
		var totCnt = $("#listSurveyCnt").val();
		
		var pageNationHtml = getPaginationHtml(clickpagenum, totCnt, pagesize, pagenumsize, 'fListSurveyLoad');
		console.log("paginationHtml : " + pageNationHtml);
		
		$("#comnSurveyLoadPagination").empty().append(pageNationHtml);
		
		$("#hclickpagenum").val(clickpagenum);
	}
	
	// 강의당 학생들의 설문결과
	function fSelectSurvey(clickpagenum){
		
		clickpagenum = clickpagenum || 1;
		console.log(clickpagenum+"clickpagenum");
		
		var no = $("#selectSurveyNo").val();
		
		var param = {
				clickpagenum : clickpagenum,
				pagesize : pagesize,
				li_no : no
		};
		
		console.log(param);
		
		var selectsvcallback = function(returndata){
			console.log("returndata: " + returndata);
			
			selectsvcallbackprocess(returndata);
			
			gfModalPop("#layer1");
		}
		
		callAjax("/manageA/selectSurveyList.do", "post", "text", true, param, selectsvcallback);	
	}
	
	function selectsvcallbackprocess(returndata){
		$("#selectSurveyLoad").empty().append(returndata);
		
		var totCnt = $("#selectSurveyListCnt").val();
		var li_no = $("#selectSurveyNo").val();
		var clickpagenum=$("#clickpagenum").val();
		
		var pageNationHtml = getPaginationHtml(clickpagenum, totCnt, pagesize, pagenumsize, 'fSelectSurvey');
		console.log("paginationHtml : " + pageNationHtml);
		
		$("#comnSelectSurveyListPagination").empty().append(pageNationHtml);
		
		$("#hclickpagenum").val(clickpagenum);
	}

</script>	
</head>

<body>
<form id="myForm" name="myForm" action=""  method="">
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
							<span class="btn_nav bold">설문관리</span>
						<a href="../manageA/surveyMgt.do" class="btn_set refresh">새로고침</a>
					</p>

					<p class="conTitle">
						<span>설문 관리</span>
					</p>
					
					<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
									align="left" style="collapse; border: 1px #50bcdf;">
						<tr style="border: 0px; border-color: blue">
							<td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
							<td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
								<select id="searchType" name="searchType" style="width: 150px;">
									<option value="teacherNm">강사</option>
									<option value="lecNm">과목</option>
								</select>
								<input type="text" style="width: 300px; height: 25px;" id="searchValue" name="searchValue" >
								<a class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							</td> 
						</tr>
					</table>
	
					<div class="divSurveyCompleteList">
						<table class="col">
						<caption>설문조사 완료된 강의목록</caption>
						<colgroup>
							<col width="6%">
							<col width="17%">
							<col width="20%">
							<col width="20%">
							<col width="10%">
							<col width="15%">
							<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">분류</th>
								<th scope="col">과목</th>
								<th scope="col">강사</th>
								<th scope="col">강의시작일</th>
								<th scope="col">강의종료일</th>
								<th scope="col">총평점(객관식)</th>
								<th scope="col">참여인원</th>
							</tr>
						</thead>
						<tbody id="listSurveyLoad"></tbody>
						</table>
					</div>
					<div class="paging_area"  id="comnSurveyLoadPagination"></div>
					</div> 
					<!--// content -->

			<h3 class="hidden">풋터 영역</h3>
			<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
			</li>
		</ul>
	</div>
	</div>

	<!-- 강의당 학생들 설문결과 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>과목 설문결과</strong>
			</dt>
			<dd class="content">
				<!-- s :  -->
				<table class="row">
					<tr>
						<th scope="row">학생명</th>
						<th scope="row">설문총점</th>
						<th scope="row">설문답</th>
					</tr>
				<tbody id="selectSurveyLoad"></tbody>
				</table>
				<div class="paging_area"  id="comnSelectSurveyListPagination"></div>
	
				<!-- e : 모달창 닫기  -->
				<div class="btn_areaC mt30">
					<a class="btnType gray"  id="btnCloseSelectSurvey" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<!-- 모달창 우상단 x버튼 -->
		<a class="closePop"><span class="hidden">닫기</span></a>
	</div>
</form>
</body>
</html>