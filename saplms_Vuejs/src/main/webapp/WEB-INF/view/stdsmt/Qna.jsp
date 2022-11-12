<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>QNA</title>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">

	var pagesize = 10;
	var pagenumsize = 5;
	
	/** OnLoad event */ 
	$(function() {
	
		// 게시판 조회
		fQnaList();
		
		fRegisterButtonClickEvent();
	});
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnSearch' :
					fQnaList();
					break;
				case 'btnSave' :
					fsavefileupload();
					break;	
				case 'btnDelete' :
					$("#action").val("D");
					fsavefileupload();
					break;	
				case 'btnSavefile' :
					fsaveQna();
					break;
				case 'btnDeletefile' :
					$("#action").val("D");
					fsaveQna();
					break;		
				case 'btnSavecomment' :
					fsaveComment();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnClosefile' :
					gfCloseModal();
					break;
				case 'btnDeletecomment' :
					$("#action").val("D");
					fsaveComment();
					break;
			}
		});
	}
	function fQnaList(clickpagenum) {
		
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
		
		callAjax("/commuD/qnaList.do", "post", "text", true, param, searchcallback);
		
	}
	function fcommentList(bd_no) {
		
		var param = {
				bd_no : bd_no
		};
		
		var searchcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			searchcallbackprocess2(returndata)
		}
		
		callAjax("/commuD/commentList.do", "post", "text", true, param, searchcallback);
	}
	function searchcallbackprocess(returndata,clickpagenum) {
			
		$("#qnaList").empty().append(returndata);
		
		var totalcnt = $("#searchlistcnt").val();
		
		var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fQnaList');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnfileuploadPagination").empty().append( paginationHtml );
		
		$("#hclickpagenum").val(clickpagenum);
			
	}
	function searchcallbackprocess2(returndata) {
		
		$("#commentList").empty().append(returndata);
				 
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
			$("#bd_no").val("");
			$("#title").focus();
		} else {
			$("#title").val(object.bd_title);
			$("#cont").val(object.bd_contents);
			$("#btnDelete").show();
			$("#bd_no").val(object.bd_no);
		}
	}
	function fPopModalfile() {
        $("#action").val("I");
		
		fn_forminitfile();
		
		gfModalPop("#layer2");
		
	}
	function fn_forminitfile(object) {
			$("#qnano").val(object.bd_no);
			$("#qnatitle").val(object.bd_title);
			$("#qnacontents").val(object.bd_contents);
			$("#qnaname").val(object.name);
			$("#btnDeletefile").show();	
	}
	function fselectone(bd_no) {
		
		var param = { bd_no : bd_no };
		
		var selectonecallback = function(selectonersn) {
			console.log(JSON.stringify(selectonersn));
			//console.log(JSON.stringify(selectonersn.searchone));
			
			$("#bd_no").val(bd_no);	
			
			$("#action").val("U");			
			fn_forminitfile(selectonersn.qna);
			
			fcommentList(bd_no);
			
			gfModalPop("#layer2");
		}
		
		callAjax("/commuD/selectQna.do", "post", "json", true, param, selectonecallback);
	}
	function fsavefileupload() {
		
		var param = {
				bd_no : $("#bd_no").val(),
				title : $("#title").val(),
				cont : $("#cont").val(),
				action : $("#action").val()
		};
		
		var title = $("#title").val();
		
		if(title.length < 1){
			swal("제목을 입력하세요.").then(function() {
				$('#title').focus();
			  });
			return false;
		}
		
		var savecallback= function(rtn) {
			console.log(JSON.stringify(rtn));
			
			alert("저장 되었습니다.");
			
			gfCloseModal();
			
			var savepageno = 1;
			
			if($("#action").val() == "U") {
				savepageno = $("#hclickpagenum").val();
			}
			
			fQnaList(savepageno);
			
		}
		
		callAjax("/commuD/uploadQna.do", "post", "json", true, $("#myForm").serialize(), savecallback);
	}
	function fsaveQna() {
		
		var param = {
				qnano : $("#bd_no").val(),
				qnatitle : $("#qnatitle").val(),
				qnacontents : $("#qnacontents").val(),
				action : $("#action").val()
		};
		
		var qnatitle = $("#qnatitle").val();
		
		if(qnatitle.length < 1){
			swal("제목을 입력하세요.").then(function() {
				$('#qnatitle').focus();
			  });
			return false;
		}
		
		var savecallback= function(rtn) {
			console.log(JSON.stringify(rtn));
			
			alert("저장 되었습니다.");
			
			gfCloseModal();
			
			var savepageno = 1;
			
			if($("#action").val() == "U") {
				savepageno = $("#hclickpagenum").val();
			}
			
			fQnaList(savepageno);
			
		}
		
		callAjax("/commuD/uploadQna.do", "post", "json", true, param, savecallback);
	}
	function fsaveComment() {
		
		var param = {
				qnano : $("#bd_no").val(),
				cm_no : $("#cm_no").val(),
				contents : $("#contents").val(),
				action : $("#action").val()
		};
		
		var savecallback= function(rtn) {
			console.log(JSON.stringify(rtn));
			
			$("#contents").val("");
			
			alert("저장 되었습니다.");
			
			fcommentList($("#bd_no").val());
			
		}
		
		callAjax("/commuD/insertComment.do", "post", "json", true, param, savecallback);
	}
	function fdeleteComment(cm_no) {
		
		var param = { cm_no : cm_no };	
		
		
		var savecallback= function(rtn) {
			console.log(JSON.stringify(rtn));
			
			alert("삭제했습니다.");
			
			
			fcommentList($("#bd_no").val());
			//gfCloseModal();
			
			//var savepageno = 1;
			
			//if($("#action").val() == "U") {
			//	savepageno = $("#hclickpagenum").val();
			//}
			
			//fQnaList(savepageno);
			
		}
		
		callAjax("/commuD/deleteComment.do", "post", "json", true, param, savecallback);
	}
</script>
<style>
	.commentbox {	
		margin-top: 10px;
		border: 1px solid;
		border-color: rgb(187, 194, 205);
		background-color: white;
	}
	.commentbox h5 {
		background-color: rgb(187, 194, 205);
		margin-bottom: 1px;
		padding-left: 5px;
	}
	.commentbox a {
		display: inline-block;
		border: 1px solid;
		padding: 4px;
		float: right;
		color: black;
		background-color: white;
	}
	.commentList table {
		border: 1px solid;
		border-color: rgb(187, 194, 205);
		width: 100%;
		margin-bottom: 5px;
	}
	.commentList table td {
		padding: 5px;
		word-break:break-all;
	}
</style>
</head>
<body>
	<form id="myForm" action=""  method="">
		<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
		<input type="hidden" id="action" name="action"  value="" />
		<input type="hidden" id="bd_no" name="bd_no"  value="" />
		
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
							<span class="btn_nav bold">커뮤니티</span>
							<span class="btn_nav bold">Q&A</span> 
							<a href="../commuD/qna.do" class="btn_set refresh">새로고침</a>
							</p>
							<p class="conTitle">
								<span>Q&A</span>
								<span class="fr">
									<a class="btnType blue" href="javascript:fPopModal();" name="modal"><span>질문하기</span></a>
								</span>
							</p>
							<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
								<tr style="border: 0px; border-color: blue;">
	                           		<td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px; padding-bottom:10px; ">
		     	                    	<select id="searchtype" name="searchtype" style="width: 150px;" v-model="searchKey">
								    		<option value="title" >제목</option>
											<option value="writer" >작성자</option>
								    	</select> 
			     	                	<input type="text" style="width: 300px; height: 25px;" id="searchvalue" name="searchvalue">                    
				                    	<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
	                           		</td> 
	                           </tr>
							</table>
							<div class="divComDtlCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="60%">
									<col width="15%">
									<col width="15%">
								</colgroup>
								
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">작성일</th>
									</tr>
								</thead>
								<tbody id="qnaList"></tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="comnfileuploadPagination"> </div>
					</div>
						
					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
		
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>질문하기</strong>
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
								<th scope="row">제목<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="title" id="title" /></td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td>
								     <textarea class="inputTxt p100"	name="cont" id="cont" > </textarea>
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
		<div id="layer2" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>글 상세보기</strong>
				</dt>
				<dd class="content">
					<table class="row" style="margin-bottom:20px;">
						<colgroup>
							<col width="100px">
							<col width="*">
						</colgroup>
			 			<tbody>
			 				<input type="hidden" name="qnano" id="qnano"/>
			  				<tr>
			  					<th>제목</th>
			  					<td><input type="text" class="inputTxt p100" name="qnatitle" id="qnatitle" /></td>
							</tr>
							<tr>
								<th>작성자</th>
								<td><input type="text" class="inputTxt p100" name="qnaname" id="qnaname" /></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><input type="text" class="inputTxt p100" name="qnacontents" id="qnacontents" style="height:100px;"/></td>
							</tr>
						 </tbody>
					 </table>
					 <div id="commentList" class="commentList"></div>
					 <div class="commentbox">
 						<h5>답변 작성</h5>
 						<div>
    				    	<form>
         			    		<div class="form-group">
                      			<textarea id="contents" name="contents" class="form-control" rows="3"></textarea>
                      			</div>
                      			<a href="" id="btnSavecomment" name="btn"><span>작성</span></a>
                      		</form>
                     	</div>
                     </div>
                     <div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSavefile" name="btn"><span>저장</span></a> 
						<a href="" class="btnType blue" id="btnDeletefile" name="btn"><span>삭제</span></a> 
						<a href=""	class="btnType gray"  id="btnClosefile" name="btn"><span>취소</span></a>
					 </div>
				 </dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
</body>
</html>