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
<title>Job Korea :: 수강목록관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
    
	// 강의목록 페이징 설정
	var pageSizeComnGrpCod = 5;
	var pageBlockSizeComnGrpCod = 5;
	
	// 수강학생 페이징 설정
	var pageSizeComnDtlCod = 5;
	var pageBlockSizeComnDtlCod = 10;
	
	
	/** OnLoad event */ 
	$(function() {
	
		// 강의목록 조회
		fListLecList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	                                 

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveGrpCod' :
					fSaveGrpCod();
					break;
				case 'btnDeleteGrpCod' :
					fDeleteGrpCod();
					break;
				case 'btnSaveDtlCod' :
					fSaveDtlCod();
					break;
				case 'btnDeleteDtlCod' :
					fDeleteDtlCod();
					break;
				case 'btnSearchGrpcod':
					board_search();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	
	
	// 검색기능
	function board_search(currentPage) {
        
        var sname = $('#sname');
        var searchKey = document.getElementById("searchKey");
		var oname = searchKey.options[searchKey.selectedIndex].value;
		
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage);     
		
        var param = {
        		  sname : sname.val()
        	  ,	  oname : oname
              ,   currentPage : currentPage
              ,   pageSize : pageSizeComnGrpCod
        }
        //swal(JSON.stringify(param));
        var resultCallback = function(data) {
        	flistGrpCodResult(data, currentPage); 
        };
        
        callAjax("/manageA/listLecList.do", "post", "text", true, param, resultCallback);
        
  } 

	
	
	
	
	
	
	/** 강의목록 조회 */
	function fListLecList(currentPage) {
		
		currentPage = currentPage || 1;
		
		var sname = $('#sname');
        var searchKey = document.getElementById("searchKey");
		var oname = searchKey.options[searchKey.selectedIndex].value;
		
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
					sname : sname.val()
				,	oname : oname
				,	currentPage : currentPage
				,	pageSize : pageSizeComnGrpCod
		}
		
		var resultCallback = function(data) {
			flistGrpCodResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/manageA/listLecList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 강의목록 조회 콜백 함수 */
	function flistGrpCodResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listComnGrpCod').empty();
		
		// 신규 목록 생성
		$("#listComnGrpCod").append(data);
		
		// 총 개수 추출
		
		var totalCntComnGrpCod = $("#totalCntComnGrpCod").val();
		
		
		//swal(totalCntComnGrpCod);
		
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntComnGrpCod, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListLecList');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageComnGrpCod").val(currentPage);
	}
	

	


	
	
	/** 학생선택 모달 실행 */
	function fPopModalComnDtlCod(loginID) {
		
	
			// 학생선택 단건 조회
			fSelectDtlCod(loginID);
	}
	
	/** 학생선택 단건 조회 */
	function fSelectDtlCod(loginID,li_no) {

		var paramMap = {
					loginID: loginID
					,li_no  : li_no
		};
		
		var resultCallback = function(data) {
			fSelectDtlCodResult(data);
		};
		   
		callAjax("/manageA/selectLecPersonList.do", "post", "json", true, paramMap, resultCallback);
	}
	
	
	/** 학생선택 단건 조회 콜백 함수*/
	function fSelectDtlCodResult(data) {

	
			// 모달 팝업
			gfModalPop("#layer1");
			
			// 그룹코드 폼 데이터 설정
			fInitFormDtlCod(data.selectAdmsmtLecPersonList);
			
		
	}
	/** 폼 데이터 */
	function fInitFormDtlCod(object) {
		
		$("#userLoginID").val(object.loginID);
		$("#userPASSWORD").val(object.password);
		$("#userName").val(object.name);
		$("#userSex").val(object.sex);
		$("#userHp").val(object.hp);
		$("#userRegdate").val(object.regdate);
		$("#userLoc").val(object.loc);
		$("#userBirthday").val(object.birthday);		
		$("#userEmail").val(object.email);
		
	/* 	$("#user_type").val(object.user_type);
		 */
	
		if(object.user_type=='C'){
			$("#user_type").val('학생');
		}else{
			$("#user_type").val('강사');	
		}
	
		

		
	}
	
	/* 휴학신청 yn */
	function modifySb_Yn(li_no, loginID, sb_yn, li_nm) {
	/* 	var sb_yn2=$('#sb_yn2').val();
		var li_no=$('#li_no').val();
		var loginID=$('#loginID').val();
		 */
		console.log(loginID);
		 console.log(li_no);
		 console.log(sb_yn);
		 
		if(sb_yn == 'Y'){
			sb_yn = 'N'
		}else{
			sb_yn = 'Y'
		}
		var param = {
				loginID :loginID
	              ,li_no:li_no
	              ,sb_yn:sb_yn
	};
		var resultCallback = function(data) {
			if(sb_yn == 'N'){
				alert("휴학 취소 완료"); 
				fListLecPersonList(1, li_no);
				
				
			}else{
				alert("휴학 신청 완료");
				fListLecPersonList(1, li_no);
			
			}
			 
		};
		callAjax("/manageA/updateSb_yn.do", "post", "text", true, param, resultCallback);
	}
	
	
	   
	
	/** 수강학생 목록 조회 */
	function fListLecPersonList(currentPage, li_no) {
		$("#li_no").val(li_no);
		currentPage = currentPage || 1;
		
		var param = {
					li_no : li_no
				,	currentPage : currentPage
				,	pageSize : pageSizeComnDtlCod
		}
		
		var resultCallback = function(data) {
			flistDtlCodResult(data, currentPage);
		};
		
		callAjax("/manageA/listLecPersonList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 상세코드 조회 콜백 함수 */
	function flistDtlCodResult(data, currentPage) {
		
		// 기존 목록 삭제
		$('#listComnDtlCod').empty(); 
		
		var $data = $( $(data).html() );
		// 신규 목록 생성
		$("#listComnDtlCod").append(data);
		
	
		
		
		
		
		var totalCntComnDtlCod = $("#totalCntComnDtlCod").val();
			
	
		
		// 페이지 네비게이션 생성
		var li_no = $("#li_no").val();
		var grp_cod_nm = $("#tmpGrpCodNm").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCntComnDtlCod, pageSizeComnDtlCod, pageBlockSizeComnDtlCod, 'fListLecPersonList',[li_no]);
		$("#comnDtlCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageComnDtlCod").val(currentPage);
	
	
	}
	


	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageComnGrpCod" value="1">
	<input type="hidden" id="currentPageComnDtlCod" value="1">
	<input type="hidden" id="tmpGrpCod" value="">
	<input type="hidden" id="tmpGrpCodNm" value="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" id="li_no" value="">
	
	
	
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">수강 목록 관리</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>수강 목록 관리</span> 
						</p>
						
						
						<tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                      <select id="searchKey" name="searchKey" style="width: 250px;" v-model="searchKey">
									<option value="li_no" >강의번호</option>
									<option value="li_nm" >강의명</option>
									<option value="loginID" >교수번호</option>
									<option value="name" >교수명</option>
									<option value="li_no2" >강의실</option>
									
							</select> 
							 
     	                       <input type="text" style="width: 600px; height: 25px;" id="sname" name="sname">                    
	                           <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
                           </td> 
                             
                        </tr>
                        <br> 
                        <br>
                        <h5 style="font-size:25px;">강의목록</h5>
                        <br>
                        
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="10%">
									<col width="15%">
									<col width="20%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의 번호</th>
										<th scope="col">강의명</th>
										<th scope="col">담당교수</th>
										<th scope="col">교수번호</th>
										<th scope="col">강의실</th>
										<th scope="col">수강인원</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="listComnGrpCod"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="comnGrpCodPagination"> </div>
						
						
						
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                  
                     </table> 
                     	<br>
                     	<br>
                     	
						<h5 style="font-size:25px;">수강학생</h5>
						<br>
                     	
						<div class="divComDtlCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
									
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">학번</th>
										<th scope="col">학생명</th>
										<th scope="col">학과</th>
										<th scope="col">과목</th>
										<th scope="col">개강일</th>
										<th scope="col">종강일</th>
										<th scope="col">휴학신청</th>
										
									</tr>
								</thead>
								<tbody id="listComnDtlCod">
									<tr>
										<td colspan="12">강의를 선택해 주세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="comnDtlCodPagination"> </div>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType1" style="width: 800px; height: 300px;">
		<dl>
			<dt>
				<strong>학생 상세 인적 정보</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row" >
					<caption>caption</caption>
					<colgroup>
						<col width="100px">
						<col width="100px">
						<col width="100px">
						<col width="100px">
					</colgroup>

					<tbody>
						<tr>
					 		<th scope="row">회원번호 </th>
							<td><input type="text" class="inputTxt p100" name="loginID" id="userLoginID" readonly/></td>
							<th scope="row">비밀번호 </th>
							<td><input type="text" class="inputTxt p100" name="PASSWORD" id="userPASSWORD" readonly/></td>

						</tr>
						<tr>
							<th scope="row">이름 </th>
							<td><input type="text" class="inputTxt p100" name="loginID" id="userName" readonly/></td>
							<th scope="row">성별</th>
							<td><input type="text" class="inputTxt p100" name="PASSWORD" id="userSex" readonly /></td>

						</tr>						
						<tr>
							<th scope="row">연락처 </th>
							<td><input type="text" class="inputTxt p100" name="loginID" id="userHp" readonly/></td>
							<th scope="row">가입등록일자 </th>
							<td><input type="text" class="inputTxt p100" name="PASSWORD" id="userRegdate" readonly/></td>

						</tr>
						<tr>
							<th scope="row">거주지역 </th>
							<td><input type="text" class="inputTxt p100" name="loginID" id="userLoc" readonly/></td>
							<th scope="row">생년월일</th>
							<td><input type="text" class="inputTxt p100" name="PASSWORD" id="userBirthday" readonly/></td>
							

						</tr>
						<tr>
							<th scope="row">회원구분</th>
							<td><input type="text" class="inputTxt p100" name="PASSWORD" id="user_type" readonly/></td>
							<th scope="row">이메일</th>
							<td><input type="text" class="inputTxt p100" name="PASSWORD" id="userEmail" readonly/></td>

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