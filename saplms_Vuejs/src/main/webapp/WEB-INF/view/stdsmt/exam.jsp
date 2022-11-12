<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>학생 - 시험 응시</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

</head> 

<script type="text/javascript">

	var pagesize = 5;
	var pagenumsize = 5;

	/** OnLoad event */ 
	$(function() {
		//(검색 시)수강과정 목록 조회
		fExamLecList();
		
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
					fExamLecList();
					break;
				case 'btnClose' :
					gfCloseModal();
					$("#li_no").val("");
					$("#test_cd").val("");
					break;
				case 'btnSubmit' :
					for(var i = 0 ; i < $("input[id='count']").val() ; i++){
						if(!$("input[name='qst_radio"+i+"']").is("checked")){
							if(confirm("답을 선택하지 않은 문제가 있습니다. 제출하시겠습니까?")){
								insertAnswerPaper();
								$("#li_no").val("");
								$("#test_cd").val("");
								alert("제출 완료!");
								fExamLecList();
								break;
							}else{
								break;
							};
						}
					}
					break;
			}
		});
	}
	
	
	/*진행중 시험문제 모달*/
	function fPopModal(){
		
		fn_forminit();
		
		gfModalPop("#layer1");
	}
	/*완료 시험 문제 모달*/
	function fPopModalComplete(){
		
		fn_forminitComplete();
		
		gfModalPop("#layer2");
	}

	/** (검색 시)수강과정 목록 조회*/
	function fExamLecList(clickpagenum){
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
			searchtype : $("#searchtype").val(),
			clickpagenum : clickpagenum,
			pagesize : pagesize
		};
		
		var searchcallback = function(returndata){
			
			console.log("returndata : " + returndata);
			
			searchcallbackprocess(returndata, clickpagenum);
			
		}
			
		callAjax("/stdsmt/examLecList.do", "post", "text", true, param, searchcallback);

	}
	
	function searchcallbackprocess(returndata, clickpagenum){
		
		$("#examLecList").empty().append(returndata);
		
		var totalcnt = $("#searchlistcnt").val();
		
		var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fExamLecList');

		$("#comnexamLecListPagination").empty().append( paginationHtml );
		
		$("#hclickpagenum").val(clickpagenum);
	}
	
	/*시험지 SELECT 함수*/
	function selectOneExampaper(test_cd, li_no){
		
		$("#li_no").val(li_no);
		$("#test_cd").val(test_cd);
		
		var param = { test_cd : test_cd };
		
		var searchonecallback = function(quelist){
			
			$("#questionList").empty().append(quelist);	
			$("#btnSubmit").css("display", "inline-block");
		
			gfModalPop("#layer1");
		}
		
		callAjax("/stdsmt/selectoneExampaper.do", "post", "text", true, param, searchonecallback);		
	}
	
	function insertAnswerPaper(){
		
		var count = $("#count").val();
		var paramString = "";
		
		for(var i=0 ; i<count ; i++){
			 paramString +=
				 $("#qst_cd"+i).val() + "/" +
				 $("#qnum"+i).find("input[type=radio]:checked").val() + "/" + 
				 $("#score"+i).val() + "/"
		}
		
		var param = {
				li_no : $("#li_no").val(),
				test_cd : $("#test_cd").val(),
				paramString : paramString	//	문제번호/제출답/문제점수, 
		}
		
		var insertcallback = function(){	//Unexpected end of JSON input 에러 발생
			gfCloseModal();
		}
		
		callAjax("/stdsmt/insertAnswerPaper.do", "post", "text", true, param, insertcallback);
	}
	
	/*시험지 채점결과 SELECT*/
	function selectResultpaper(test_cd, li_no){
		
		var param = { 
						test_cd : test_cd,
						li_no : li_no
					};
		
		var resultpapercallback = function(data){
			
			$("#questionList").empty().append(data);	
			$("#btnSubmit").css("display", "none");
			
			gfModalPop("#layer1");
			resultExampaperCheckbox();
		}
		
		callAjax("/stdsmt/selectResultpaper.do", "post", "text", true, param, resultpapercallback);		
	}
	
	function resultExampaperCheckbox(){
		
		var count = $("#count").val();
	
		for(var i=0 ; i<count ; i++){
			
			var qst_answer = $("#qst_answer"+i).val();
			var ss_answer = $("#ss_answer"+i).val();
			
			if(qst_answer == ss_answer){
				$("input[id='qst_cd"+i+"']:input[value="+qst_answer+"]").prop("checked", true).css("accent-color", "blue");
				$("#qnum"+i).find('td').eq(0).html("O").css("color","blue");
			}else if(ss_answer === "undefined"){
				$("input[id='qst_cd"+i+"']:input[value="+qst_answer+"]").prop("checked", true).css("accent-color", "blue");
				$("#qnum"+i).find('td').eq(0).html("답을 선택하지 않음").css("color","red");
			}else if(qst_answer !== ss_answer){
				$("input[id='qst_cd"+i+"']:input[value="+qst_answer+"]").prop("checked", true).css("accent-color", "blue");
				$("input[id='qst_cd"+i+"']:input[value="+ss_answer+"]").prop("checked", true).css("accent-color", "red");
				$("#qnum"+i).find('td').eq(0).html("X").css("color","red");
			}		
		}
	}
	
</script>

<body>
	<form>
		<input type="hidden" id="hclickpagenum" name="hclickpagenum" value=""/>
		<input type="hidden" id="action" name="action" value=""/>
		<input type="hidden" id="li_no" name="li_no" value=""/>
		<input type="hidden" id="test_cd" name="test_cd" value=""/>
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
							<span class="btn_nav bold">시험 응시</span>
							<a href="../manageC/exam.do" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle">
							<span>시험 응시</span>
						</p>
						<table style="margin: 10px" width="100%" cellpadding="5" cellspacing="0" border="1" style="collapse; border: 1px #50bcdf;">
							<tr style="border: 0px; border-color: blue">
								<td>
									<select id="searchtype">
										<option value="undoneExam">진행중 시험</option>
										<option value="doneExam">지난 시험</option>
									</select>
								</td>
								<td style="float:right;"><a class="btnType blue" id="btnSearch" name="btn"><span>검 색</span></a></td>
							</tr>
						</table>
						<div class="divexamLecList">
							<table class="col" style="margin: 10px">
								<caption>caption</caption>
								<colgroup>
									<col width="40%">
									<col width="40%">
									<col width="20%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">과정명</th>
										<th scope="col">시험명</th>
										<th scope="col">상태</th>
									</tr>
								</thead>
								<tbody id="examLecList"></tbody>
							</table>
						</div>
						<div class="paging_area" id="comnexamLecListPagination"></div>
					</div>
					
					<h3 class="hidden">푸터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>				
				</li>
			</ul>
		</div>
		
		<!-- 진행중/채점완료 시험지 FORM -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>T E S T</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
						</colgroup>
						<tbody id="questionList"></tbody>
					</table>

					<!-- 제출/취소 버튼 -->
					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSubmit" name="btn"><span>제출</span></a>
						<a href="" class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</div>
</body>
</html>