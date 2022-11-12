<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>파일업로드 샘플</title>
<!-- 캘린더 -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
    /* 캘린더 */
    
    var pagesize = 5;
    var pagenumsize = 5;
    
	/** OnLoad event */ 
	$(function() {
		//comcombo("GRADE", "samplecom", "all", "");
		
	   comcombo("lectype", "plectype", "sel", "");
	   
  		// 게시판 조회
		fListfileupload();
		
		fRegisterButtonClickEvent();
		
		$("#searchvalue").keydown(function (key) {
	        if (key.keyCode == 13) {
	            $("#btnSearch").click();
	        }
    });
	// 한번 더 클릭하는 수고를 덜기위해
	$("#searchvalue").focus(); 
	
	});
	
    
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			
			switch (btnId) {
				case 'btnSearch' :
					fListfileupload();
					break;
				case 'btnSave' :
					fsavefileupload();
					break;	
				case 'btnDelete' :
					$("#action").val("D");
					fdeletefileupload();
					break;		
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
	}
	
	function fListfileupload(clickpagenum) {
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
				searchtype : $("#searchtype").val() ,
				searchvalue : $("#searchvalue").val() ,
				startdate : $("#startdate").val(),
				enddate : $("#enddate").val(),
				clickpagenum : clickpagenum,
				pagesize : pagesize
		};
		
		var searchcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			searchcallbackprocess(returndata,clickpagenum);
			
		}
		
		callAjax("/supportD/listLecNotice.do", "post", "text", true, param, searchcallback);
		
		
	}
	
	function searchcallbackprocess(returndata,clickpagenum) {
		
		$("#listfileupload").empty().append(returndata);
		
		var totalcnt = $("#searchlistcnt").val();
		
		var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fListfileupload');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnfileuploadPagination").empty().append( paginationHtml );
		
		$("#hclickpagenum").val(clickpagenum);
	}
	
	/** 강의계획서 저장 validation */
	function fValidatelecnotice() {

		var chk = checkNotEmpty(
				[
						[ "titlenm", "과정명을 입력해 주세요." ]
					,	[ "plectype", "분류명을 입력해 주세요" ]
					,	[ "titlelino2", "강의실을 입력해 주세요." ]
					,	[ "titledate", "강의시작일을 입력해 주세요" ]
					,	[ "titleredate", "강의종료일을 입력해 주세요." ]
					,	[ "titlegarden", "정원을 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	function fPopModal(li_no) {		
		
		//신규 저장
		if (li_no == null || li_no == "") {
			$("#action").val("I");
			
			fn_forminit();
			
			gfModalPop("#layer1");
		//수정 저장
		} else {
			$("#action").val("U");
			
			fselectone(no);
		}

	}  
	
	function fn_forminit(object) {
		$("#li_no").focus();
		if (object == null || object=="") {
			$("#titlenm").val("");
			$("#plectype").val("");
			$("#titlename").val($("#user_name").val());
			$("#titlehp").val($("#user_hp").val());
			$("#titleemail").val($("#user_email").val());
			$("#titlelino2").val("");
			$("#titledate").val("");
			$("#titleredate").val("");
			$("#titleap").val("");
			$("#titlegarden").val("");
			$("#cont1").val("");
			$("#cont2").val("");
			$("#cont3").val("");
			$("#btnDelete").hide();
			$("#li_no").val("");
			
			$("#li_no").focus();
	
		} else {
			$("#titlenm").val(object.li_nm);
			$("#plectype").val(object.li_type);
			$("#titlename").val(object.name);
			$("#titlehp").val(object.hp);
			$("#titleemail").val(object.email);
			$("#titlelino2").val(object.li_no2);
			$("#titledate").val(object.li_date);
			$("#titleredate").val(object.li_redate);
			$("#titleap").val(object.li_ap);
			$("#titlegarden").val(object.li_garden);
			$("#cont1").val(object.li_target);
			$("#cont2").val(object.li_ad);
			$("#cont3").val(object.li_plan);			
			$("#btnDelete").show();	
			$("#li_no").val(object.li_no);
			
			$("#titlenm").focus();
		}

		
	}
	
	function fselectone(no) {
		
		var param = { li_no : no };
		
		var selectonecallback = function( selectonersn ) {
			console.log(JSON.stringify(selectonersn));
			//console.log(JSON.stringify(selectonersn.searchone));
			
			$("#action").val("U");			
			fn_forminit(selectonersn.searchone);
			
			gfModalPop("#layer1");
		}
		
		callAjax("/supportD/selectLecNotice.do", "post", "json", true, param, selectonecallback);
	}
	
	// 저장 버튼 
	function fsavefileupload() {
		
		// vaildation 체크
		if ( ! fValidatelecnotice() ) {
			return;
		}
		
		var param = {
				li_no : $("#li_no").val(),
				li_nm : $("#titlenm").val(),
				li_type : $("#plectype").val(),
				li_no2 : $("#titlelino2").val(),
				li_date : $("#titledate").val(),
				li_redate : $("#titleredate").val(),
				li_ap : $("#titleap").hide(),
				li_garden : $("#titlegarden").val(),
				li_target : $("#cont1").val(),
				li_plan : $("#cont2").val(),
				li_ad : $("#cont3").val(),
				action : $("#action").val()
		};
		
		var savecallback= function(rtn) {
			console.log(JSON.stringify(rtn));
			
			alert("저장 되었습니다.");
			
			gfCloseModal();
			
			var savepageno = 1;
			
			//목록 조회 페이지 번호
			if($("#action").val() == "U") {
				savepageno = $("#hclickpagenum").val();
			}
			
			fListfileupload(savepageno);
			
		}
		
		//callAjax("/admsst/saveFileupload.do", "post", "json", true, param, savecallback);
		callAjax("/supportD/saveLecNotice.do", "post", "json", true,  $("#myForm").serialize(), savecallback);
	}
	
	// 삭제 버튼
	function fdeletefileupload() {
				
		var savecallback= function(rtn) {
			console.log(JSON.stringify(rtn));
			
			alert("삭제되었습니다.");
			
			gfCloseModal();
			
			var savepageno = 1;
			
			//목록 조회 페이지 번호
			if($("#action").val() == "D") {
				savepageno = $("#hclickpagenum").val();
			}
			
			fListfileupload(savepageno);
			
		}
		
		//callAjax("/admsst/saveFileupload.do", "post", "json", true, param, savecallback);
		callAjax("/supportD/saveLecNotice.do", "post", "json", true,  $("#myForm").serialize(), savecallback);
	}
	
			
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="li_no" name="li_no"  value="" />
	<!-- 초기값 넣어주기 : LoginController, LoginInfoModel, LoginMapper 사용 -->
	<input type="hidden" id="user_email" name="user_email"  value="${sessionScope.email}" />
	<input type="hidden" id="user_hp" name="user_hp"  value="${sessionScope.hp}" />
	<input type="hidden" id="user_name" name="user_name"  value="${sessionScope.userNm}" />
	
	
	
	
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
								class="btn_nav bold">학습지원</span> <span class="btn_nav bold">강의계획서 및 공지</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>강의계획서 관리</span> <span class="fr"> 
							    <a	 class="btnType blue" href="javascript:fPopModal();" name="modal"><span>계획서 등록</span></a>
							</span>
						</p>
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
	                        <tr style="border: 0px; border-color: blue">
	                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
	                           		<!-- 분류 -->									
		     	                    <select id="searchtype" name="searchtype" style="width: 100px;" v-model="searchKey">
		     	                            <option value="" >전체</option>
											<option value="title" >과목</option>
											<option value="writer" >강사명</option>
									</select>
									<!-- 검색바  -->
	     	                       <input type="text" style="width: 200px; height: 25px;" placeholder="순번/과목/강사명만 입력해주세요." id="searchvalue" name="searchvalue">
	     	                       &nbsp;
	     	                       <input type="text" style="width: 60px; height: 25px; border:none; font-weight : bold ;" placeholder="강의기간 : " readonly>
	     	                       &nbsp;
	     	                       <!-- 캘린더 -->
								   <input type="date" style="width: 100px; height: 25px;" placeholder="0000-00-00" id="startdate" name="startdate">
								   <input type="date" style="width: 100px; height: 25px;" placeholder="0000-00-00" id="enddate" name="enddate">
		                           <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
	                           </td> 
	                           
	                        </tr>
                        </table> 
                        
						<div class="divfileuploadList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">분류</th>
										<th scope="col">과목명</th>
										<th scope="col">강사명</th>
										<th scope="col">강의시작일</th>
										<th scope="col">강의종료일</th>
										<th scope="col">신청인원</th>
										<th scope="col">정원</th>
									</tr>
								</thead>
								<tbody id="listfileupload"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="comnfileuploadPagination"> </div>
						
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 900px;">
		<dl>
			<dt>
				<strong>강의계획서</strong>
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
							<th scope="row">과정명 <span class="font_red">*</span></th>
							<td colspan='3'><input type="text" class="inputTxt p100" name="titlenm" id="titlenm" /></td>
							<th scope="row">분류 <span class="font_red">*</span></th>
							<td>
								<select id="plectype" name="plectype" style="width: 150px;">
								</select>
								
							</td>
						</tr>
						<tr>
							<th scope="row">강사명 <span class="font_red">*</span></th>
							<td colspan='3'><input type="text" class="inputTxt p100" name="titlename" id="titlename" readonly/></td>
							<th scope="row">연락처 <span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100" name="titlehp" id="titlehp" readonly/>
							</td>
						</tr>
						<tr>
							<th scope="row">이메일 <span class="font_red">*</span></th>
							<td colspan='3'><input type="text" class="inputTxt p100" name="titleemail" id="titleemail" readonly/></td>
							<th scope="row">강의실 <span class="font_red">*</span></th>
							<td>
							    <select id="titlelino2" name="titlelino2">
							             <option value="">선택</option>
						          <c:forEach items="${roominfolist}" var="list">
						                 <option value="${list.li_no}">${list.ci_nm}</option>
						          </c:forEach>
							    </select>
							</td>							
						</tr>
						<tr>
							<th scope="row">강의 시작일 <span class="font_red">*</span></th>
							<td><input type="date" class="inputTxt p100" name="titledate" id="titledate" /></td>
							<th scope="row">강의 종료일 <span class="font_red">*</span></th>
							<td><input type="date" class="inputTxt p100" name="titleredate" id="titleredate" /></td>
							
							<th scope="row">정원 <span class="font_red">*</span></th>
							<td><input type="hidden" class="inputTxt p100" name="titleap" id="titleap" />
							<input type="text" class="inputTxt p100" name="titlegarden" id="titlegarden" /></td>
						</tr>
						<tr>
							<th scope="row">수업목표</th>
							<td colspan='5'>
							     <textarea class="inputTxt p100"	name="cont1" id="cont1" ></textarea>
						   </td>
						</tr>
						<tr>
							<th scope="row">출석</th>
							<td colspan='5'>
							     <textarea class="inputTxt p100"	name="cont2" id="cont2" ></textarea>
						   </td>
						</tr>
						<tr>
							<th scope="row">강의계획</th>
							<td colspan='5'>
							     <textarea class="inputTxt p100"	name="cont3" id="cont3" ></textarea>
						   </td>
						</tr>							
					</tbody>

				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
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