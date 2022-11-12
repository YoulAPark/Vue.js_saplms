<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>강사_수강인원/강의목록</title>


<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>

<script type="text/javascript">

	var pagesize = 5;
	var pagenumsize = 5;

	/** OnLoad event */ 
	$(function() {
		//(검색 시)강의목록 조회
		fLectureList();
		
		//버튼 이벤트
		fRegisterButtonClickEvent();
	
		comcombo("lectype", "leccom", "1", "");
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnSearch' :
					fLectureList();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnSave' :
					writeLec();
					alert("등록 완료!");
					break;
				case 'btnUpdate' :
					$("#action").val("U");
					gfModalPop("#layer1");
					detail_init();
					break;
				case 'btnDelete' :
					$("#action").val("D");
					writeLec();
					detail_init();
					alert("삭제 완료!");
					break;
			}
		});
	}
	
	/*(게시글)등록 모달*/
	function fPopModal(){
		$("#action").val("I");
		
		fn_forminit();
		
		gfModalPop("#layer1");
		
		classroomNum();
	}
	
	/*FORM 초기화*/
	function fn_forminit(object) {
		
		if (object == null || object=="") {
			$("#li_no").val("");
			$("#li_nm").val("");
			$("#sdate2").val("");
			$("#edate2").val("");
			$("#cont").val("");
			$("#li_type").val("");
			$("#garden").val("");
			$("#li_ap").val("");
			$("#btnDelete").hide();
			
			$("#li_nm").focus();
		} else {
			$("#li_no").val(object.li_no);
			$("#li_nm").val(object.li_nm);
			$("#sdate2").val(object.li_date);
			$("#edate2").val(object.li_redate);
			$("#cont").val(object.li_contents);
			$("#li_type").val(object.li_type);
			$("#garden").val(object.li_garden);
			$("#li_ap").val(object.li_ap);
			$("#btnDelete").show();
		}
	}
	
	/*상세내용 초기화(수정, 삭제 직후)*/
	function detail_init(){
		$("#pfssmt_lecture").html("");
		$("#pfssmt_teacher").html("");
		$("#pfssmt_date").html("");
		$("#pfssmt_redate").html("");
		$("#pfssmt_contents").html("");
		$(".btn_onoff").css("display", "none");
	};
	
	/** (검색 시)강의목록 조회*/
	function fLectureList(clickpagenum){
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
			searchtype : $("#searchtype").val(),
			searchvalue : $("#searchvalue").val(),
			sdate : $("#sdate").val(),
			edate : $("#edate").val(),
			clickpagenum : clickpagenum,
			pagesize : pagesize
		};
		
		var searchcallback = function(returndata){
			console.log("returndata : " + returndata);
			
			searchcallbackprocess(returndata, clickpagenum);
			
		}
			
		callAjax("/pfssmt/lectureList.do", "post", "text", true, param, searchcallback);

	}
	
	function searchcallbackprocess(returndata, clickpagenum){
		
		$("#lectureList").empty().append(returndata);
		
		var totalcnt = $("#searchlistcnt").val();
		
		var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fLectureList');

		$("#comnlectureListPagination").empty().append( paginationHtml );
		
		$("#hclickpagenum").val(clickpagenum);
	}	
	
	//과목명 클릭시 디테일 내용 출력
	function lectureDetail(li_no){
		
		var param = {
				li_no : li_no
		};
		
		var detailcallback = function(data){
			
			$("#pfssmt_lecture").html(data.vo.li_nm);
			$("#pfssmt_teacher").html(data.vo.name);
			$("#pfssmt_date").html(data.vo.li_date);
			$("#pfssmt_redate").html(data.vo.li_redate);
			$("#pfssmt_contents").html(data.vo.li_contents);

			fn_forminit(data.vo);	//수정, 삭제 기능시 필요한 parameter 저장
			
			var sessionLoginID = '<%=(String)session.getAttribute("loginId")%>';
			var selectedLoginID = data.vo.loginID;
			console.log("세션 아이디 : " + sessionLoginID + ", 선택한 게시글 아이디 : " + selectedLoginID);
			
			if(sessionLoginID !== selectedLoginID){
				$(".btn_onoff").css("display", "none");
			}else if(sessionLoginID == selectedLoginID){
				$(".btn_onoff").css("display", "inline");
			}
		}
		
		callAjax("/pfssmt/lectureDetail.do", "post", "json", true, param, detailcallback);
	}
	
	//강의(게시글) 등록
	function writeLec(){
		
		var param = {
				li_no : $("#li_no").val(),
				li_nm : $("#li_nm").val(),
				sdate : $("#sdate2").val(),
				edate : $("#edate2").val(),
				li_type : $("#leccom").val(),
				cont : $("#cont").val(),
				li_garden : $("#garden").val(),
				li_no2 : $("#classroomNum").val(),
				action : $("#action").val()
		};
		
		var savecallback = function(data){
			
			gfCloseModal();
			
			var savepageno = 1;
			
			if($("#action").val() == "U"){
				savepageno = $("#hclickpagenum").val();
			}
			
			fLectureList(savepageno);
		};
		
		callAjax("/pfssmt/writeLec.do", "post", "json", true, param, savecallback);
	};
	
	
	
	//datepicker 날짜선택 및 유효성(날짜선택제한)로직
	$(function(){
		$.datepicker.setDefaults({
			dateFormat : "yy-mm-dd",
			beforeShow : function(){
				$(this).datepicker("setDate","today");
			}
		});
		
		
		$('.datepicker').datepicker();
		
		$('#sdate').datepicker("option", "maxDate", $("#edate").val());
		$('#sdate').datepicker("option", "onClose", function(selectedDate){
			$("#edate").datepicker("option", "minDate", selectedDate);
		});
		$('#edate').datepicker("option", "minDate", $('#sdate').val());
		$('#edate').datepicker("option", "onClose", function(selectedDate){
			$("#sdate").datepicker("option", "maxDate", selectedDate);
		});
		
		$('#sdate2').datepicker("option", "maxDate", $("#edate2").val());
		$('#sdate2').datepicker("option", "onClose", function(selectedDate){
			$("#edate2").datepicker("option", "minDate", selectedDate);
		});
		$('#edate2').datepicker("option", "minDate", $('#sdate2').val());
		$('#edate2').datepicker("option", "onClose", function(selectedDate){
			$("#sdate2").datepicker("option", "maxDate", selectedDate);
		});
	});
	
	
	function classroomNum(){
		 
		 var param = {};
		 
		 var classroomcallback = function(returnlist) {
			 
			 $("#classroomNum").empty();
			 
			 let optionHtml = "";
			 
			 $.each(returnlist, function(index, value){
				 
				 optionHtml = "<option value=" + value.li_no + ">" + value.ci_nm + " : " + value.lec_cnt + "/2</option>";
				 
				 $("#classroomNum").append(optionHtml);
			 });
		 }
		 
		callAjax("/pfssmt/classroomNum.do", "post", "json", true, param, classroomcallback);
	}
	

</script>

<body>
	<form>
		<input type="hidden" id="hclickpagenum" name="hclickpagenum" value=""/>
		<input type="hidden" id="action" name="action" value=""/>
		<input type="hidden" id="li_no" name="li_no" value=""/>
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
							<span class="btn_nav bold">학습관리</span>
							<span class="btn_nav bold">수강인원&강의목록</span>
							<a href="../manageD/lecInfo.do" class="btn_set refresh">새로고침</a>
						</p>
					
						<p class="conTitle">
							<span>강의 목록 게시판</span>
							<span class="fr"> 
								<a class="btnType blue" href="javascript:fPopModal();" name="modal"><span>등록</span></a>
							</span>
						</p>
					
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
							<tr style="border: 0px; border-color: blue">
								<td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
									<select id="searchtype" style="width: 150px;">
										<option value="title" selected>과목</option>
										<option value="teacher">강사</option>
									</select>
									<input type="text" placeholder="과목 또는 강사로 검색" id="searchvalue" name="searchvalue" style="width: 300px; height: 25px;">
									<span style="margin: 10px">날짜 : </span>
									<input type="text" class="datepicker" id="sdate" name="sdate" readonly style="width: 120px; height: 25px;">
									<span style="margin: 10px">~</span>
									<input type="text" class="datepicker" id="edate" name="edate" readonly style="width: 120px; height: 25px;">
									<a class="btnType blue" id="btnSearch" name="btn"><span>검 색</span></a>
								</td>
							</tr>
						</table>
						
						<div class="divlectureList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">분류</th>
										<th scope="col">과목</th>
										<th scope="col">강사명</th>
										<th scope="col">강의시작일</th>
										<th scope="col">강의종료일</th>
										<th scope="col">수강인원</th>
										<th scope="col">정원</th>
										<th scope="col">출석</th>
									</tr>
								</thead>
								<tbody id="lectureList"></tbody>
							</table>
						</div>
						<div class="paging_area"  id="comnlectureListPagination"></div>
						<div style="padding: 20px; display: flex; align-items: flex-end">
							<table align="center">
								<thead>
									<tr>
										<th>과목명</th>
										<th><textarea id="pfssmt_lecture" readonly style="resize:none; margin: 10px; width: 160px; height: 20px; text-align: center"></textarea></th>
										<th>강사</th>
										<th><textarea id="pfssmt_teacher" readonly style="resize:none; margin: 10px; width: 80px; height: 20px; text-align: center"></textarea></th>
										<th>강의기간</th>
										<th><textarea id="pfssmt_date" readonly style="resize:none; margin: 10px; width: 80px; height: 20px; text-align: center"></textarea></th>
										<th>~</th>
										<th><textarea id="pfssmt_redate" readonly style="resize:none; margin: 10px; width: 80px; height: 20px; text-align: center"></textarea></th>
									</tr>								
								</thead>
								<tbody>
									<tr>
										<th>강의내용</th>
										<th colspan="7"><textarea id="pfssmt_contents" readonly style="resize:none; margin: 10px; width: 560px; height: 200px;"></textarea></th>
									</tr>
									<tr>
										<th colspan="8" style="text-align: center;">
											<div class="btn_onoff" style="display: none">
												<a href="" class="btnType blue" id="btnUpdate" name="btn"><span>수정</span></a>
												<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
											</div>
										</th>
									</tr>	
								</tbody>
							</table>
						</div>		
					</div>
					<h3 class="hidden">푸터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>				
				</li>
			</ul>
		</div>
		
		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>강의 정보 신규등록</strong>
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
								<td><input type="text" class="inputTxt p100" name="li_nm" id="li_nm" /></td>
							</tr>
							<tr>
								<th scope="row">분류<span class="font_red">*</span></th>
								<td><select id="leccom"></select></td>
							</tr>
							<tr>
								<th scope="row">강의실<span class="font_red">*</span></th>
								<td><select id="classroomNum"></select>&emsp;강의실 당 최대 2개의 강의 개설 가능.</td>
							</tr>
							<tr>
								<th scope="row">정원<span class="font_red">*</span></th>
								<td>
									<input type="text" id="garden" style="width: 40px; height: 25px;"/>
								</td>
							</tr>
							<tr>
								<th scope="row">강의기간<span class="font_red">*</span></th>
								<td>
								  	<input type="text" class="datepicker" id="sdate2" name="sdate2" readonly style="width: 120px; height: 25px;">
								  	~
								  	<input type="text" class="datepicker" id="edate2" name="edate2" readonly style="width: 120px; height: 25px;">
							   </td>
							</tr>
							<tr>
								<th scope="row">강의내용 <span class="font_red">*</span></th>
								<td>
								     <textarea class="inputTxt p100"	name="cont" id="cont" > </textarea>
							   </td>
							</tr>
						</tbody>
					</table>
	
					<!-- e : 여기에 내용입력 -->
	
					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
						<a href="" class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</div>
</body>
</html>