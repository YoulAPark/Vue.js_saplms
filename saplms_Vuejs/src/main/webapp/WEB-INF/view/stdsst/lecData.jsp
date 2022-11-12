<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType ne 'C'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head> 
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 학습 자료 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
 
<script type="text/javascript">
    
	// 학습자료 페이징 설정
	var pageSizeLecDataCod = 5;
	var pageBlockSizeLecDataCod = 5;
	

	/** OnLoad event */ 
	$(function() {
	
		// 학습자료 조회
		fListLecDataCod();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	                                 

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				
				
				case 'btnSearchGrpcod':
					
					fListLecDataCod();
					break;
				
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	
	/* 파일다운 */
	function fFileDown(le_no,li_no) {

			
			var params =[ "<input type='hidden' name='le_no' value='"+ $("#le_no").val() +"' />",
			              "<input type='hidden' name='li_no' value='"+ $("#li_no").val() +"' />"]
			jQuery(
					"<form action='/supportC/downloadfile.do' method='post'>"
							+ params + "</form>").appendTo('body').submit().remove();
	}
	
	function failCallback(){
		
	}
	
	
	
	/**데이터설정 모달 데이터 */
	function fInitFormLecData(object) {
		
		
	
			$("#le_title").val(object.le_title);
			$("#le_contents").val(object.le_contents);
			$("#le_no").val(object.le_no);
			$("#li_no").val(object.li_no);
			
			
			if(object.att_ori == "" || object.att_ori == null){
				$("#att_ori").val('파일없음');
			}else{

				$("#att_ori").val(object.att_ori);	
				
			}
			
			
			
			
		}
	


	
	/** 학습자료 모달 실행 */
	function fPopModalLecDataCod(le_no,li_no) {

			// 학습자료 단건 조회
			fSelectLecData(le_no,li_no);
	}
	
	/** 학습자료 단건 조회 */
	function fSelectLecData(le_no,li_no) {
		
		var param = { le_no : le_no
					,li_no : li_no}; //
		
		var resultCallback = function(data) {
			fSelectGrpCodResult(data);
		};
		
		callAjax("/supportC/selectLecDataCod.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 학습자료 단건 조회 콜백 함수*/
	function fSelectGrpCodResult(data) {

		/* if (data.result == "SUCCESS") {
 */
			// 모달 팝업
			gfModalPop("#layer1");
			
			// 학습자료 폼 데이터 설정
			fInitFormLecData(data.selectLecDataModel);
			
	/* 	} else {
			swal(data.resultMsg);
		}	
	 */}
	/** 학습자료 조회 */
	function fListLecDataCod(currentPage) {
		
		currentPage = currentPage || 1;
		
		var sname = $('#sname');
        var searchKey = document.getElementById("searchKey");
		var oname = searchKey.options[searchKey.selectedIndex].value;
		
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
					sname : sname.val()
				,	oname : oname
				,	currentPage : currentPage
				,	pageSize : pageSizeLecDataCod
		}
		
		var resultCallback = function(data) {
			flistLecDataResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/supportC/listLecDataCod.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 학습자료 조회 콜백 함수 */
	function flistLecDataResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listLecDataCod').empty();
		
		// 신규 목록 생성
		$("#listLecDataCod").append(data);
		
		// 총 개수 추출
		
		var totalCntLecDataCod = $("#totalLecDataCod").val();
		
		
		//swal(totalCntLecDataCod);
		
		// 페이지 네비게이션 생성
		var le_nm = $("#le_nm").val();
		var le_title = $("#le_title").val();
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntLecDataCod, pageSizeLecDataCod, pageBlockSizeLecDataCod, 'fListLecDataCod');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#LecDataCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageLecDataCod").val(currentPage);
	}
	
	
	
	

</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageLecDataCod" value="1">
	<input type="hidden" id="currentPageComnDtlCod" value="1">
	<input type="hidden" id="tmpGrpCod" value="">
	<input type="hidden" id="tmpGrpCodNm" value="">
	<input type="hidden" name="action" id="action" value="">
	
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
								class="btn_nav bold">학습지원</span> <span class="btn_nav bold">학습자료
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						 		
						<br>
						<br>
					<p class="conTitle">
							<span>학습 자료</span> 
						</p>
						</p>
							<select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
								<option value="le_nm" >작성자</option>		
	 							<option value="le_title" >제목</option>
							</select> 
							
     	                       <input type="text" style="width: 300px; height: 25px;" id="sname" name="sname">                    
	                           <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
						<br>
						<br>
					
						
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="50%">
									<col width="25%">
									<col width="25%">
									
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col" >제목</th>
										<th scope="col">작성일</th>
										<th scope="col">작성자</th>
									 
									</tr>
								</thead>
							<tbody id="listLecDataCod"></tbody> 
										
										
							</table>
						</div>
	
						<div class="paging_area"  id="LecDataCodPagination"> </div>
						
						
						
						
						
						
					
	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>학습자료</strong>
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
					</colgroup>
  
					<tbody>
						<tr>
							<th scope="row">제목 <span class="font_red" ></span></th>
							<td style="width:350px;"><input type="text" class="inputTxt p100" name="le_title" id="le_title"  readonly /></td>
						
							
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red"></span></th>
							<td colspan="3"><input type="text" style="height:250px; width:100%;" class="inputTxt p100"
								name="le_contents" id="le_contents"  readonly/></td>
						</tr>
				
						<tr>
							<th scope="row">첨부파일 <span class="font_red"></span></th>
							<td  style="width:300px;"  ><a href="javascript:fFileDown();" ><input type="text" id="att_ori" name="att_ori" style="cursor:pointer"  width:100%;" class="inputTxt p100" readonly ></a>  </td>
							<td ><button style="margin-left:5px; width:90%; height:90%;"><a href="javascript:fFileDown()">다운로드</a></button></td>
							<input type="hidden" id="li_no"  value =""/>
							<input type="hidden" id="le_no"  value =""/>
							
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

			
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	
	<!--// 모달팝업 -->
</form>
</body>
</html>