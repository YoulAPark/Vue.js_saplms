<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>수강목록</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<script type="text/javascript">
// 페이징처리 변수 선언
	var pagesize = 5; //한페이지당 몇개
	var pagenumsize = 3; //페이지네비게이션 번호몇개

/* OnLoad event */
$(function() {
	
	// 목록 데이터
	fLecListDtl();
	// 버튼 이벤트 등록
	fRegisterButtonClickEvent();
	
});
	
// 버튼 이벤트 등록 
function fRegisterButtonClickEvent() {
	$('a[name=btn]').click(function(e) {
		e.preventDefault();

		var btnId = $(this).attr('id');
		
		switch (btnId) {
		case 'btnClose' : gfCloseModal();  // 모달닫기 
		fLecListDtl(); // 첫페이지 다시 로딩 
		
	}
});
}
/** 휴학신청 모달실행 */
function fPopModalComnGrpCod(li_no) {
	
	// 휴학 모달 팝업
	gfModalPop("#layer2");
	
}

	
	
/* 수강목록 조회 */
function fLecListDtl(clickpagenum) {
	
	clickpagenum = clickpagenum || 1; // 초기페이지 변수 1선언
	
	console.log("clickpagenum :" + clickpagenum);
	
	var param = {
			clickpagenum : clickpagenum,
			pagesize : pagesize,
	};
	console.log("param :" + param);
	
	var resultCallback = function(data) {
		flistLecListResult(data, clickpagenum);
	}
	
	callAjax("/manageC/lecListDtl.do","post","text",true,param,resultCallback);
}
/* 수강목록 조회 콜백 함수 */
function flistLecListResult(data, clickpagenum) {
	
	// tbody에 데이터 삽입
	$("#listlecture").empty().append(data);
	
	
	// 총 개수 추출
	var LecListCnt = $("#LecListCnt").val();
	
	// 페이지 네비게이션 
	var paginationHtml = getPaginationHtml(clickpagenum,LecListCnt,pagesize,pagenumsize,'fLecListDtl');
	
	console.log("LecListCnt : " + LecListCnt);
	console.log("페이지네이션 : " + paginationHtml);
	$("#LecListPagination").empty().append(paginationHtml);
	
	// 현재 페이지 설정
	$("#clickpagenum").val(clickpagenum);
}


function fPopModal() {		
	$("#action").val("I");
	
	fn_forminit();
	
	gfModalPop("#layer1");
}  

function fn_forminit(object) {
	console.log("fine thanks you");
	
	if (object == null || object=="") {
		$("#li_no").val("");
		$("#li_nm").val("");
		$("#name").val("");
		$("#li_date").val("");
		$("#li_redate").val("");
		$("#li_contents").val("");
		
	} else {
		$("#li_no").val(object.li_no);
		$("#li_nm").val(object.li_nm);
		$("#name").val(object.name);
		$("#li_date").val(object.li_date);
		$("#li_redate").val(object.li_redate);
		$("#li_contents").val(object.li_contents);
	}
	
	
}

function fselectone(li_no) {
	
	var param = { 
			li_no : li_no
	};
	
	var selectonecallback = function( selectonersn ) {
		//console.log(JSON.stringify(selectonersn));
		//console.log(JSON.stringify(selectonersn.searchone));
		console.log(param);
		console.log(selectonersn);
		$("#action").val("U");			
		fn_forminit(selectonersn.searchone);
		
		gfModalPop("#layer1");
	}
	
	callAjax("/manageC/selectLecList.do", "post", "json", true, param, selectonecallback);
}




</script>

</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="clickpagenum" value="1">
		<input type="hidden" id="action" name="action" value="" />



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
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">기준정보</span> <span
									class="btn_nav bold">학습관리 </span> <a
									href="../manageC/lecList.do" class="btn_set refresh">새로고침</a>
							</p>



							<div class="divStdSmtList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="6%">
										<col width="17%">
										<col width="20%">
										<col width="20%">
										<col width="10%">
										
										
									</colgroup>

									<thead>
										<tr>
											<th scope="col">과목명</th>
											<th scope="col">강사</th>
											<th scope="col">강의 시작일</th>
											<th scope="col">강의 종료일</th>
											<th scope="col">강의실</th>
										</tr>
									</thead>
									<tbody id="listlecture"></tbody>
								</table>
							</div>

							<div class="paging_area" id="LecListPagination"></div>

							<br /> <br /> 


						</div> <!--// content -->

						<div></div>
						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
			<!-- container -->
		</div>
		
			<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>글 편집</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">과목명 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="li_nm" id="li_nm" readonly/></td>
							
						</tr>
						<tr>
							<th scope="row">강사<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="name" id="name" readonly/></td>
						</tr>
						<tr>
							<th scope="row">강의시작일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p50" name="li_date" id="li_date" readonly></td>
							<th scope="row">강의마감일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p50" name="li_redate" id="li_redate" readonly></td>
						</tr>
						<tr>
							<th scope="row">강의내용<span class="font_red">*</span></th>
							<td colspan="6"><textarea class="inputTxt p100"	name="li_contents" id="li_contents" readonly> </textarea></td>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	

	</form>
</body>
</html>