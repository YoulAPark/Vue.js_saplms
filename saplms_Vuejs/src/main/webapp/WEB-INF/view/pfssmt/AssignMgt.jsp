<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType ne 'D'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>과제 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
    
    var pagesize = 5;
    var pagenumsize = 5;
    var domEleArray = [$('#upfile').clone()];
    
	/** OnLoad event */ 
	$(function() {
		comcombo("GRADE", "samplecom", "all", "");
		
		// 게시판 조회
		fListassignMgt();
		
		fRegisterButtonClickEvent();
	});
    
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			
			switch (btnId) {
				case 'btnSearch' :
					fListassignMgt();
					break;
				case 'btnSave' :
					fsavefileupload();
					break;	
				case 'btnDelete' :
					$("#action").val("D");
					fsavefileupload();
					break;	
				case 'btnSavefile' :
					fsaveAssignMgtatt();
					break;		
				case 'btnDeletefile' :
					$("#action").val("D");
					fsaveAssignMgtatt();
					break;		
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnClosefile' :
					gfCloseModal();
					break;
			}
		});
	}
	
	function fListassignMgt(clickpagenum) {
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
				searchtype : $("#searchtype").val() ,
				searchvalue : $("#searchvalue").val() ,
				clickpagenum : clickpagenum,
				pagesize : pagesize
		};
		
		var searchcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			searchcallbackprocess(returndata,clickpagenum);
			
		}
		
		callAjax("/manageD/listAssignMgt.do", "post", "text", true, param, searchcallback);
		
		
	}
	
	function searchcallbackprocess(returndata,clickpagenum) {
		
		$("#listassignMgt").empty().append(returndata);
		
		var totalcnt = $("#searchlistcnt").val();
		
		var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fListassignMgt');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnfileuploadPagination").empty().append( paginationHtml );
		
		$("#hclickpagenum").val(clickpagenum);
	}
	
	function fPopModal() {		
		$("#action").val("I");
		
		fn_forminit();
		
		gfModalPop("#layer1");
	}  
	
	function fn_forminit(object) {
		
		if (object == null || object=="") {
			$("#title").val("");
			$("#cont").val("");
			$("#btnDelete").hide();
			$("#as_no").val("");
			
			$("#title").focus();
		} else {
			$("#title").val(object.bd_title);
			$("#cont").val(object.bd_contents);
			$("#btnDelete").show();
			
			$("#as_no").val(object.as_no);
		}

		
	}
	
	function fsavefileupload() {
		
		var param = {
				as_no : $("#as_no").val(),
				title : $("#title").val(),
				cont : $("#cont").val(),
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
			
			fListassignMgt(savepageno);
			
		}
		
		//callAjax("/admsst/saveFileupload.do", "post", "json", true, param, savecallback);
		callAjax("/admsst/saveFileupload.do", "post", "json", true,  $("#myForm").serialize(), savecallback);
	}
	
	function fPopModalfile() {
        $("#action").val("I");
		
		fn_forminitfile();
		
		gfModalPop("#layer2");
		
	}
	
	function fn_forminitfile(object) {
		
		if (object == null || object=="") {
			$("#linm").val("");
			$("#contents").val("");
			$("#btnDeletefile").hide();
			$("#as_no").val("");
			$("#upfile").val("");					
			$("#title").focus();
		} else {
			//console.log("!!!!!!!!!!!!!!!!!!!!" + JSON.stringify(object));
			$("#linm").val(object.li_nm);
			$("#contents").val(object.as_contents);
			$("#btnDeletefile").show();
			$("#as_no").val(object.as_no);
			
			var fileyn = "";
			var inhtml = "";
			
			if (object.att_ori == null || object.att_ori =="") {
				$("#filedownloaddiv").empty();
				$("#filepewviewdiv").empty();
			} else {
				inhtml = "<a href='javascript:download()'>" + object.att_ori + "("  + object.att_size+ ")</a>"; 
				$("#filedownloaddiv").empty().append(inhtml);
				
				var inputhtml = "";
				var orifile = object.att_ori;
				var orifilearr = orifile.split(".");
				
				if(orifilearr[1] == "jpg" || orifilearr[1] == "png" || orifilearr[1] == "gif") {
					inputhtml = "<img src='" + object.att_nli + "' />"
				} 
				
				$("#filepewviewdiv").empty().append(inputhtml);
			}		
			
		}

		
	}	
	
	function fselectonefile(no) {
		
		var param = { as_no : no };
		
		var selectonecallback = function(selectonersn) {
			console.log(JSON.stringify(selectonersn));
			//console.log(JSON.stringify(selectonersn.searchone));
			
			$("#action").val("U");			
			fn_forminitfile(selectonersn.searchone);
			
			gfModalPop("#layer2");
		}
		
		callAjax("/manageD/selectAssignMgt.do", "post", "json", true, param, selectonecallback);
	}
	
	function fsaveAssignMgtatt() {
		
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
			}
			
			fListassignMgt(savepageno);
			
		}
		
		callAjaxFileUploadSetFormData("/manageD/saveAssignMgtatt.do", "post", "json", true, dataWithFile, savecallback);
	}
	
	function download() {
		
		var params = "<input type='hidden' name='as_no' value='"+ $("#as_no").val() +"' />";

		jQuery(
				"<form action='/manageD/downloadfile.do' method='post'>"
						+ params + "</form>").appendTo('body').submit().remove();
	}
	
	function fpreview(event) {
		var image = event.target;
		  
		 if(image.files[0]){
			  alert(window.URL.createObjectURL(image.files[0]) + " : " + $("#upfile").val() );
			   var imgpath =  window.URL.createObjectURL(image.files[0]);
			  
			   var inputhtml = "";
			   
			   var orifile = $("#upfile").val();
			   var orifilearr = orifile.split(".");
				
			   if(orifilearr[1] == "jpg" || orifilearr[1] == "png" || orifilearr[1] == "gif") {
				   inputhtml = "<img src='" + imgpath + "' />"
			   } 
			   
			   $("#filepewviewdiv").empty().append(inputhtml);
		 }
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="as_no" name="as_no"  value="" />
	
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">과제 관리</span> <a href="../manageD/assignMgt.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>제출 과제 목록</span> 
						</p>
						<table style="margin: 10px 0px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
	                        <tr style="border: 0px; border-color: blue">
	                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
		     	                    <select id="searchtype" name="searchtype" style="width: 150px;" v-model="searchKey">
											<option value="linm" >강의명</option>
											<option value="stdnm" >학생명</option>
									</select> 
								
	     	                       <input type="text" style="width: 300px; height: 25px;" id="searchvalue" name="searchvalue">                    
		                           <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
	                           </td> 
	                           
	                        </tr>
                        </table> 
						<div class="divfileuploadList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="30%">
									<col width="30%">
									<col width="45%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의명</th>
										<th scope="col">학생명</th>
										<th scope="col">작성일</th>
									</tr>
								</thead>
								<tbody id="listassignMgt"></tbody>
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

	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>과제 상세보기</strong>
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
							<th scope="row">과목명</th>
							<td><input type="text" class="inputTxt p100" name="linm" id="linm" /></td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td>
							     <textarea class="inputTxt p100"	name="contents" id="contents" > </textarea>
						   </td>
						</tr>
						<tr>
							<th scope="row">파일</th>
							<td>
							     <input type="file" id="upfile" name="upfile"  onChange="fpreview(event)" />
						   </td>
						</tr>
						<tr>
							<th scope="row">파일 다운로드</th>
							<td>
							     <div id="filedownloaddiv"> </div>
						   </td>
						</tr>						
						<tr>
							<th scope="row">파일 미리보기</th>
							<td>
							     <div id="filepewviewdiv"> </div>
						   </td>
						</tr>								
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnDeletefile" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClosefile" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!--// 모달팝업 -->
</form>
</body>
</html>