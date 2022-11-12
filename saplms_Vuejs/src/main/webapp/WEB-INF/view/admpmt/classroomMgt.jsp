<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자_강의실 등록&조회 및 장비(비품)상세조회</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>

<script type="text/javascript">

	var pagesize = 5;
	var pagenumsize = 5;

	/** OnLoad event */ 
	$(function() {
		//(검색 시)강의실 목록 조회
		fClassroomList();
		
		//버튼 이벤트
		fRegisterButtonClickEvent();
	
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnSearch' :
					fClassroomList();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnSave' :
					insertClassroom();
					alert("강의실 등록 완료!");
					break;
				case 'btnSaveEquip' :
					insertEquip();
					alert("장비 등록 완료!");
					break;
			}
		});
	}
	
	/*강의실 등록 모달*/
	function fPopModal(){
		$("#action").val("I");
		
		fn_forminit();
		
		gfModalPop("#layer1");
	}
	/*장비 등록 모달*/
	function fPopModalEquip(){
		$("#action").val("I");
		
		fn_forminitEquip();
		
		gfModalPop("#layer2");
	}
	
	/*FORM 초기화*/
	function fn_forminit(object) {
		
		if (object == null || object=="") {
			$("#li_no").val("");
			$("#ci_nm").val("");
			$("#ci_size").val("");
			$("#ci_number").val("");
			$("#ci_note").val("");
			
			$("#btnDelete").hide();
			
			$("#ci_nm").focus();
		} else {
			$("#li_no").val(object.li_no);
			$("#ci_nm").val(object.ci_nm);
			$("#ci_size").val(object.ci_size);
			$("#ci_number").val(object.ci_number);
			$("#ci_note").val(object.ci_note);
			
			$("#btnDelete").hide();
		}
	}
	
	function fn_forminitEquip(object) {
		
		if (object == null || object=="") {
			$("#ce_no").val("");
			$("#ce_nm").val("");
			$("#ce_ea").val("");
			$("#ce_note").val("");
			
			$("#btnDelete").hide();
			
			$("#ci_nm").focus();
		} else {
			$("#ce_no").val(object.ce_no);
			$("#ce_nm").val(object.ce_nm);
			$("#ce_ea").val(object.ce_ea);
			$("#ce_note").val(object.ce_note);
			
			$("#btnDelete").show();
		}
	}
	

	/** (검색 시)강의실 목록 조회*/
	function fClassroomList(clickpagenum){
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
			searchvalue : $("#searchvalue").val(),
			clickpagenum : clickpagenum,
			pagesize : pagesize
		};
		
		var searchcallback = function(returndata){
			
			console.log("returndata : " + returndata);
			
			searchcallbackprocess(returndata, clickpagenum);
			
		}
			
		callAjax("/admpmt/classroomList.do", "post", "text", true, param, searchcallback);

	}
	
	function searchcallbackprocess(returndata, clickpagenum){
		
		$("#classroomList").empty().append(returndata);
		
		var totalcnt = $("#searchlistcnt").val();
		
		var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fClassroomList');
		console.log("paginationHtml : " + paginationHtml);
		

		$("#comnclassroomListPagination").empty().append( paginationHtml );
		
		$("#hclickpagenum").val(clickpagenum);
		
		$("#classEquipList").hide();
	}	
	
	//강의실명 클릭시 장비목록 조회
	function classEquipList(li_no){
		
		$("#classEquipList").show();
		$("#insertEqBtn").show();
		
		$("#li_no").val(li_no);
		
		var param = {
				li_no : li_no
		};
		
		var equipListcallback = function(returndata){
			$("#classEquipList").empty().append(returndata);
		}
		
		callAjax("/admpmt/classEquipList.do", "post", "text", true, param, equipListcallback);
	}
	
	//강의실 등록
	function insertClassroom(){
	
		var param = {
				li_no : $("#li_no").val(),
				ci_nm : $("#ci_nm").val(),
				ci_size : $("#ci_size").val(),
				ci_number : $("#ci_number").val(),
				ci_note : $("#ci_note").val(),
				action : $("#action").val()
		};
		
		var savecallback = function(data){
			
			gfCloseModal();
			
			var savepageno = 1;
			
			if($("#action").val() == "U"){
				savepageno = $("#hclickpagenum").val();
			}
			
			fClassroomList(savepageno);
		};
		
		callAjax("/admpmt/insertClassroom.do", "post", "json", true, param, savecallback);
	};
	function updateClassroom(li_no){
		
		var param = { li_no : li_no };
		
		var selectonecallback = function(returnmap){
			$("#action").val("U");
			fn_forminit(returnmap.result);
			gfModalPop("#layer1");
		}
		
		callAjax("/admpmt/searchoneClassroom.co", "post", "json", true, param, selectonecallback);
	};
	function deleteClassroom(li_no){
		$("#action").val("D");
		$("#li_no").val(li_no);
		insertClassroom();
		alert("강의실 삭제 완료!");
		$("#classEquipList").hide();
		$("#insertEqBtn").hide();
	};
	
	
	//장비 등록
	function insertEquip(){
		
		var saveroomno = $("#li_no").val();
		
		var param = {
				li_no : $("#li_no").val(),
				ce_no : $("#ce_no").val(),
				ce_nm : $("#ce_nm").val(),
				ce_ea : $("#ce_ea").val(),
				ce_note : $("#ce_note").val(),
				action : $("#action").val()
		};
		
		var savecallback = function(data){
			
			gfCloseModal();
			
			classEquipList(saveroomno);
		};
		
		callAjax("/admpmt/insertEquip.do", "post", "json", true, param, savecallback);
	};
	function updateEquip(li_no, ce_no){
		
		var param = { li_no : li_no, ce_no : ce_no };
		
		var selectonecallback = function(returnmap){
			$("#action").val("U");
			fn_forminitEquip(returnmap.result);
			
			gfModalPop("#layer2");
		}
		
		callAjax("/admpmt/searchoneEquip.do", "post", "json", true, param, selectonecallback);
	};
	function deleteEquip(li_no, ce_no){
		$("#action").val("D");
		$("#li_no").val(li_no);
		$("#ce_no").val(ce_no);
		insertEquip();
		alert("장비 삭제 완료!");
	};
	

</script>

<body>
	<form>
		<input type="hidden" id="hclickpagenum" name="hclickpagenum" value=""/>
		<input type="hidden" id="action" name="action" value=""/>
		<input type="hidden" id="li_no" name="li_no" value=""/>
		<input type="hidden" id="ce_no" name="ce_no" value=""/>
	</form>
		<div id="wrap_area">
		<!-- 모달 배경 -->
		<div id="mask"></div>
		
		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
		
		<div id="container">
			<ul>
				<li class="lnb">
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
				</li>
				<li class="contents">
					<div class="content">
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">물품관리</span>
							<span class="btn_nav bold">강의실&장비관리</span>
							<a href="../manageF/classMgt.do" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle">
							<span>강의실&장비관리</span>
						</p>
						<table style="margin: 10px" width="100%" cellpadding="5" cellspacing="0" border="1" style="collapse; border: 1px #50bcdf;">
							<tr style="border: 0px; border-color: blue">
								<td><span>강의실명</span></td>
								<td align="center"><input type="text" placeholder="강의실명" id="searchvalue" name="searchvalue" style="width: 720px; height: 25px;"></td>
								<td><a class="btnType blue" id="btnSearch" name="btn"><span>검 색</span></a></td>
								<td>
									<span class="fr"><a class="btnType blue" href="javascript:fPopModal();" name="modal"><span>등록</span></a></span>
								</td>
							</tr>
						</table>
						<div class="divclassroomList">
							<table class="col" style="margin: 10px">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
									<col width="35%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">강의실명</th>
										<th scope="col">크기</th>
										<th scope="col">자리수</th>
										<th scope="col">비고</th>
										<th scope="col" colspan="2"></th>
									</tr>
								</thead>
								<tbody id="classroomList"></tbody>
							</table>
						</div>
						<div class="paging_area" id="comnclassroomListPagination"></div>
						
						<div style="padding: 20px; display: flex; flex-wrap: wrap; justify-content: flex-end">							
							<div>
								<a class="btnType blue" href="javascript:fPopModalEquip();" id="insertEqBtn" name="modal" style="display:none"><span>장비 등록</span></a>
							</div>
							<table class="col" style="margin: 10px">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="10%">
									<col width="30%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">장비명</th>
										<th scope="col">갯수</th>
										<th scope="col">비고</th>
										<th scope="col" colspan="2"></th>
									</tr>
								</thead>
								<tbody id="classEquipList"></tbody>
							</table>
						</div>		
					</div>
					<h3 class="hidden">푸터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>				
				</li>
			</ul>
		</div>
		
		<!-- 강의실 등록 FORM -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>강의실 등록</strong>
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
								<th scope="row">강의실명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="ci_nm" id="ci_nm" /></td>
							</tr>
							<tr>
								<th scope="row">크기<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="ci_size" id="ci_size" /></td>
							</tr>
							<tr>
								<th scope="row">자리수<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="ci_number" id="ci_number" /></td>
							</tr>
							<tr>
								<th scope="row">비고<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="ci_note" id="ci_note" /></td>
							</tr>
						</tbody>
					</table>

					<!-- 강의실 저장/취소 버튼 -->
					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		
		<!-- 장비 등록 FORM -->
		<div id="layer2" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>장비 등록</strong>
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
								<th scope="row">장비명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="ce_nm" id="ce_nm" /></td>
							</tr>
							<tr>
								<th scope="row">개수<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="ce_ea" id="ce_ea" /></td>
							</tr>
							<tr>
								<th scope="row">비고<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="ce_note" id="ce_note" /></td>
							</tr>
						</tbody>
					</table>
	
					<!-- 장비 저장/수정/삭제 버튼 -->
					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveEquip" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</div>
</body>
</html>