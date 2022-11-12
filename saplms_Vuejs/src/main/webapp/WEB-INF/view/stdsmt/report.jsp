<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 과제제출  </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
	var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수
	var domEleArray = [$('#upfile').clone()];
	/* onload 이벤트  */
	$(function(){
		// 공지사항 리스트 뿌리기 함수 
		selectreportList();
		
		// 버튼 이벤트 등록 (저장, 수정, 삭제, 모달창 닫기)
		fButtonClickEvent();
	 	
		// 사용자가 수강중인 과목 목록출력  (select > option * 수강중인수업수)
		function appendOption(myLecList){
			console.log(JSON.stringify(myLecList));
			console.log(myLecList.nameset);
			$("#lecName").append("<option value=" + ${nameset.li_no} + "></option>");
			/* $("#lecName").append("<option value=" + ${list.li_no} + ">"+ ${list.li_nm} + "</option>"); */
		}
		
		
		
		
		
	 	/* 셀렉트박스 변경시 강사이름 변경 메서드 */
	 	
		 $("#lecName").change(
				 
				 function(){
		 
			 	console.log("Change proname!!");
			 	
			    var li_no = $(this).val();
			 	
			    $("#lino").val(li_no);
			    console.log(li_no);
			    $("option:selected", this).attr("value");		    
			    console.log("옵션 밸류 값 :",$("option:selected", this).attr("value"));
			    
			    // 과목명 선택시 과목코드 전달 -> select 강사정보 받기 request param 
			    // ajax 이용해서 해당강의 강사명 받아오기 - 
			    
				var param = { li_no : li_no };
			
			    
			    
				console.log("sequence 11111"+$("#proName2").val());
				
				var changepronamecallback = function( changeproname ) {
					
					console.log(JSON.stringify(changeproname));
					//console.log(JSON.stringify(selectonersn.searchone));
					
					console.log("sequence 2222"+$("#proName2").val("${list.proName}"));
					changeProname(changeproname.searchone);
				
				};	
				
			callAjax("/manageC/changeproname.do", "post", "json", true, param, changepronamecallback);
			console.log("sequence 333333"+$("#proName2").val("${list.proName}"));
			
		});
		
		// 강사 이름 변경함수 select change 이벤트 발생후 실행
		
			function changeProname(object){
				console.log("sequence 44444 " + object.proName );
				var proName = String(object.proName)
				$("#proName2").text(object.proName); // 강사이름 입력.
			}
		
		
			$(document).on("click",".popup",function(){ // ???? 왜 $(function{}) 에 넣었을땐 안되는지 .. ???? 
					
				var reportNo = $(this).attr("href");  // tr 태그엔 데이터를 저장할 val이 없기때문에 href로 대체사용 .
				console.log('List Click!!');
				
				console.log($(this).attr("href"));
				
		 		fselectonereport(reportNo);
		 		
		 	});
			
		 
		
	});
	
	
	/* 버튼 이벤트 등록 - 저장, 수정, 삭제  */
	function fButtonClickEvent(){
		$('a[name=btn]').click(function(e){
			e.preventDefault(); // ?? 
					
			var btnId = $(this).attr('id');
			switch(btnId){
				case 'btnCloseReport' : gfCloseModal();  // 모달닫기 
				selectreportList(); // 첫페이지 다시 로딩 
					break;
				case 'btnUpdateReport' : fUpdateReport();  // 수정하기
					break;
				case 'searchBtn' : selectreportList();  // 검색하기
					break;
				case 'btnModifyReport' :
					fsavefileupload()
					break;
				case 'btnSaveReport' :
					fsavefileuploadatt();
					break;
				case 'btnDeleteReport' :
					$("#action").val("D");
					fsavefileuploadatt();
					break;
			}
		});
	}
	
	/* 과제제출 리스트 불러오기  */
	function selectreportList(currentPage){
		
		currentPage = currentPage || 1;   // or		
		
		//alert("지금 현재 페이지를 찍어봅시다. " + currentPage);
		
		title = $("#title").val();
		from_date =$("#from_date").val();
		to_date =$("#to_date").val();
		
		
		
		var param = {
				
				title : title , 
				currentPage : currentPage ,
				pageSize : pageSize , 
				from_date:from_date,
				to_date:to_date
		}
		
		var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
			
			reportListResult(data, currentPage); 
		
		};
		
		
		callAjax("/manageC/reportList.do","post","text", true, param, resultCallback);
		
	}

	 /* 공지사항 리스트 data를 콜백함수를 통해 뿌려봅시당   */
	 function reportListResult(data, currentPage){
		 
		 /* console.log(data); */
		 
		 // 일단 기존 목록을 삭제합니다. (변경시 재부팅 용)
		 $('#reportList').empty();
		 
		 $('#reportList').append(data);
	
		 
		 // 리스트의 총 개수를 추출합니다. 
		 //var totalCnt = $data.find("#totalCnt").text();
		 var totalCnt = $("#totcnt").val();  // qnaRealList() 에서보낸값 
		 
		 // * 페이지 네비게이션 생성 (만들어져있는 함수를 사용한다 -common.js)
		 // function getPaginationHtml(currentPage, totalCount, pageRow, blockPage, pageFunc, exParams)
		 // 파라미터를 참조합시다. 
	     var list = $("#tmpList").val();
		 //var listnum = $("#tmpListNum").val();
	     var pagingnavi = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlock, 'selectreportList',[list]);
		 
	     console.log("pagingnavi : " + pagingnavi);
		 // 비운다음에 다시 append 
	     $("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 
		 
		 // 현재 페이지 설정 
	    $("#currentPage").val(currentPage);
		 
	 }
	 
 	
	  
	 /* 모달 팝업 - 내용 선택 */
	  
		function fselectonereport(reportNo) {
			
			var param = { reportNo : reportNo };
			
		
			var selectonecallback = function( selectonersn ) {
				console.log(JSON.stringify(selectonersn));
				//console.log(JSON.stringify(selectonersn.searchone));
				
				$("#action").val("U");			
				frealPopModal(selectonersn.searchone);
				console.log("modaltest");
				fn_forminitfile(selectonersn.searchone);
				gfModalPop("#ReportModal");
			}			
			callAjax("/manageC/selectreport.do", "post", "json", true, param, selectonecallback);
			
		}
	 
		/* 내용 수정 */
		function fsavefileupload() {
			
			var param = {
					reportNo : $("reportNo").val(),
					stdId : $("#stdId").val(),
					reportContent : $("#reportContent").val(),
					action : $("#action").val()
			};
			
			var savecallback= function(rtn) {
				console.log(JSON.stringify(rtn));
				
				alert("저장 되었습니다.");
				
				gfCloseModal();
				
				var savepageno = 1;
				
				if($("#action").val() == "U") {
					savepageno = $("#hclickpagenum").val();
				}
				
				selectreportList(savepageno);
				
			}
			
			//callAjax("/admsst/saveFileupload.do", "post", "json", true, param, savecallback);
			callAjax("/manageC/saveFileupload.do", "post", "json", true,  $("#myForm").serialize(), savecallback);
		}
	  
		/* 신규등록 모달 호출 */
		
		function fPopModalReport() {
	        $("#action").val("I");
			
			fn_forminitfile();
			
			gfModalPop("#ReportModal");
			
		}
		
		/* 신규등록 모달 초기화 및 출력 */
		
		function fn_forminitfile(object) {
			
			
			if (object == null || object=="") {
				
				/* 글쓰기 버튼 이벤트파트 */
				
				
				$("#stdNamebox").hide(); // 게시글 작성자박스 하이드
				$("#lecNamebox").show(); // 과목명 선택 셀렉트박스 
				$("#lecName").val("");
				$("#reportContent").val("");
				
				$("#btnSaveReport").show(); // 게시글 저장버튼 보이기
				
				$("#btnDeleteReport").hide(); // 삭제버튼 숨기기
				$("#btnModifyReport").hide(); // 삭수정튼 숨기기
				
				
				
				$("#reportNo").val("");
				
				$("#filepewviewbox").hide();
				$("#filedownloadbox").hide();
				
				$("#upfile").val("");
				$("#upfilebox").show();
				
				$("#reportContent").focus();
				console.log("글쓰기 클릭");
				
			} else {
				
				/* 게시글 클릭 /내용확인 부분 */
				
				//console.log("!!!!!!!!!!!!!!!!!!!!" + JSON.stringify(object));
				
				$("#stdNamebox").show(); // 게시글 작성자박스 하이드
				$("#lecNamebox").hide(); // 과목명 선택 셀렉트박스

				$("#reportNo").val(object.reportNo);
				$("#stdId").val(object.stdId);	     // 팝업창 작성자 id 히든값 -사용자비교용
				$("#proName1").text(object.proName); // 팝업창 강사명
				
				$("#stdName").val(object.stdName);
				$("#reportContent").val(object.reportContent);
				
				$("#btnDeleteReport").hide();		// 삭제버튼 숨기기
				$("#btnModifyReport").hide();		// 수정버튼 숨기기
				if($("#swriter").val()==$("#stdId").val()){ // 자신의 게시글 선택시 작동부분 
					console.log("login id:"+ $("#swriter").val() + "writer id :" + $("#stdId").val());
					/* alert("btn Test"); */
					
					/* $("#btnSaveReport").show(); */
					$("#btnDeleteReport").show();	// 내가쓴글일경우 삭제버튼 보이기
					$("#btnModifyReport").show();	// 내가쓴글일경우 수정버튼 보이기
				}
			
			
				$("#upfilebox").hide();
				$("#filepewviewbox").show();
				$("#filedownloadbox").show();
				$("#reportNo").val(object.reportNo);
				
				var fileyn = "";
				var inhtml = "";
			
				console.log("test1");
				
				if (object.att_ori == null || object.att_ori =="") {
					$("#filedownloaddiv").empty();
					$("#filepewviewdiv").empty();
					
					console.log("test2");
				} else {
					console.log("test3");
					inhtml = "<a href='javascript:download()'>" + object.att_ori + "("  + object.att_size+ ")</a>"; 
					$("#filedownloaddiv").empty().append(inhtml);
					
					
					
					var inputhtml = "";
					var orifile = object.att_ori;
					var orifilearr = orifile.split(".");
					
					if(orifilearr[1] == "jpg" || orifilearr[1] == "png" || orifilearr[1] == "gif") {
						inputhtml = "<img src='" + object.att_nli + "' style='max-height:400px; max-width:500px;'  />"
					} 
					
					$("#filepewviewdiv").empty().append(inputhtml);
				}		
			}
		
		

		}
		
		/* 파일 업로드 */
		
		function fsavefileuploadatt() {
			
			
			console.log("fsavefileuploadatt : " + $("#upfile").val());
			
			var frm = document.getElementById("myForm");
			frm.enctype = 'multipart/form-data';
			var dataWithFile = new FormData(frm);
			
			
			var savecallback= function(rtn) {
				console.log(JSON.stringify(rtn));
				
				alert("저장 되었습니다.");
				
				gfCloseModal();
				
				var savepageno = 1;
				
				if($("#action").val() == "U") {
					savepageno = $("#hclickpagenum").val();
					alert("업데이트완료");
				}
				selectreportList(savepageno);
				/* fListreportupload(savepageno); */
				
			}
			
			callAjaxFileUploadSetFormData("/manageC/saveFileuploadatt.do", "post", "json", true, dataWithFile, savecallback);
		}
		
		/* 파일 다운로드  */
		function download() {
			
			var params = "<input type='hidden' name='reportNo' value='"+ $("#reportNo").val() +"' />";

			jQuery(
					"<form action='/manageC/downloadfile.do' method='post'>"
							+ params + "</form>").appendTo('body').submit().remove();
		}
		
		 
		 /* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
		 
		 
		 function frealPopModal(object){
			 var writer = $("#swriter").val(); // session id
			 		 
			 
			 
			 if(object == "" || object == null || object == undefined){
				/*  var writer = $("#swriter").val(); */
				
				 //var Now = new Date();
				 
				 $("#loginId").val(writer);
				 $("#loginId").attr("readonly", true);
				 
				 $("#write_date").val();
				 
				 $("#stdName").text("");
				 
				 $("#reportContent").val("");
				 
				 
				 $("#btnDeleteReport").hide(); // 삭제버튼 숨기기
				 $("#btnUpdateReport").hide();
				 $("#btnSaveReport").show();
			
			 }else if(writer=$("#loginId").val()){
				 var test = test.val(wirter);
				 console.log(test);
				
				 console.log($("#loginId").val());
				 //alert("숫자찍어보세 : " + object.wno);// 페이징 처리가 제대로 안되서 
				 
				 
				 $("#loginId").val(object.loginId);
				 $("#loginId").attr("readonly", true); // 작성자 수정불가 
				 
				 $("#write_date").val(object.ReportRegdate);
				 $("#write_date").attr("readonly", true); // 처음 작성된 날짜 수정불가 
				 
				 $("#stdName").text(object.stdName);
				 
				 
				 $("#reportContent").parent().empty().append( '<textarea class="inputTxt p100"	name="reportContent" id="reportContent" > </textarea>' );
				 $("#reportContent").val(object.reportContent);
				
				//////object.ReportNo
				 
				 $("#ReportNo").val(object.ReportNo); // 중요한 num 값도 숨겨서 받아온다. 
				 
				 
				 $("#btnDeleteReport").show(); // 삭제버튼 보이기 
				 $("#btnSaveReport").hide();
				 $("#btnUpdateReport").css("display","");
				 //if문써서 로그인 아이디 == 작성자 아이디 일치시  --- 추가하기 
				 //$("#grp_cod").attr("readonly", false);  // false, true(읽기만)로 수정
			
				 
			 }else{
				 /* var test = test.val(wirter); */
				 console.log(test);
				
				 console.log($("#loginId").val());
				 //alert("숫자찍어보세 : " + object.wno);// 페이징 처리가 제대로 안되서 
				 $("#loginId").val(object.loginId);
				 $("#loginId").attr("readonly", true); // 작성자 수정불가 
				 
				 $("#write_date").val(object.ReportRegdate);
				 $("#write_date").attr("readonly", true); // 처음 작성된 날짜 수정불가 
				 
				 $("#stdName").text(object.stdName);
				 $("#reportContent").parent().empty().append( '<textarea class="inputTxt p100"	name="reportContent" id="reportContent" > </textarea>' );
				 $("#reportContent").val(object.reportContent);
				
				//////object.ReportNo
				 
				 $("#ReportNo").val(object.ReportNo); // 중요한 num 값도 숨겨서 받아온다. 
				 
				 
				 $("#btnDeleteReport").hide(); // 삭제버튼 보이기 
				 $("#btnSaveReport").hide();
				 $("#btnUpdateReport").css("display","");
				 //if문써서 로그인 아이디 == 작성자 아이디 일치시  --- 추가하기 
				 //$("#grp_cod").attr("readonly", false);  // false, true(읽기만)로 수정
			
				 
			 }
		 }
		
	 </script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myForm" action="" method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" id="tmpList" value=""> <!-- ★ 이거뭐임??? -->
	<input type="hidden" id="tmpListNum" value=""> <!-- 스크립트에서 값을 설정해서 넘길거임 / 임시 리스트 넘버 -->
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" id="swriter" value="${loginId}"> <!-- 작성자 session에서 java에서 넘어온값 -->
	<input type="hidden" id="reportNo" name="reportNo"  value="" />
	<input type="hidden" id="lino" name="lino"  value="" />
	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav bold">시스템 관리</a> 
								<span class="btn_nav bold">과제 목록</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>과제 목록</span> <span class="fr"> 
								<c:set var="nullNum" value=""></c:set>
								<a class="btnType blue" href="javascript:fPopModalReport();" name="modal">
								<span>글쓰기</span></a>
							</span>
						</p>
					<div class="divreportList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="15%">
						                   <col width="10%">
						                   <col width="40%">
						                   <col width="20%">
						                   <col width="15%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">과목명</th>
							              <th scope="col">작성자</th>
							              <th scope="col">내용</th>
							              <th scope="col">작성일</th>
							              <th scope="col">강사</th>
							              
									</tr>
								</thead>
								<tbody id="reportList"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
							</div>
											
						</div>

		
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 내용클릭 & 신규등록 팝업창 -->
	<div id="ReportModal" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>글 편집(파일)</strong>
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
						<tr id="stdNamebox">
							<input type="hidden" name="stdId" id="stdId" style="display:none"/>
							<th scope="row">작성자</th>
							<td><strong style="line-height : 30px;" name="stdName" id="stdName" ></strong>
							
							<span style="float:right; line-height:30px; border-left:2px solid;padding-left:5px;"><strong>강사명 :</strong><strong name="proName1" id="proName1"></strong></span>
							</td>
							
						</tr>
					
						<tr id="lecNamebox">
							<th scope="row">과목명 / 강사명 <span class="font_red">*</span></th>
							<td>
							 <select type="text" class="inputTxt p100" name="lecName" id="lecName" style="max-width:70%;" >
								<option value="" hidden disabled>선택</option>
								
								<c:forEach var="list" items="${leclist}">
									 <option value="${list.li_no}">${list.li_nm}</option>
								</c:forEach> 
								</select>
								
						
							<span style="float:right; line-height:30px;"><strong>강사명 :</strong><strong name="proName2" id="proName2">${list.proName}</strong></span>
							</td>
						</tr>
					
					
						
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td>
							     <textarea class="inputTxt p100"	name="reportContent" id="reportContent" ></textarea>
						   </td>
						</tr>
						<tr id="upfilebox">
							<th scope="row">파일 <span class="font_red">*</span></th>
							<td>
							     <input type="file" id="upfile" name="upfile"  onChange="fpreview(event)" />
						   </td>
						</tr>
						 <tr id="filedownloadbox">
							<th scope="row">파일 다운로드<span class="font_red">*</span></th>
							<td>
							     <div id="filedownloaddiv"> </div>
						   </td>
						</tr>				
						<tr id="filepewviewbox">
							<th scope="row">파일 미리보기<span class="font_red">*</span></th>
							<td>
							     <div id="filepewviewdiv"> </div>
						   </td>
						</tr>						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnModifyReport" name="btn"><span>수정</span></a>
					<a href="" class="btnType blue" id="btnSaveReport" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteReport" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseReport" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>	
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	


</form>

</body>
</html>
