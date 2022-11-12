<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>insert title here</title>

<script src='CTX_PATH/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>
<body>
<style>
span.blue {
    color: white;
    background: #4C8FFB;
    border: 1px #3079ED solid;
    box-shadow: inset 0 1px 0 #80B0FB;
    width: 106px;
    height: 36px;
}

.blue {
	width: 106px;
    height: 36px;
}
</style>
<script>
//페이징 설정 
var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수

$(function(){//온로드 되면 실행

		getExamList();
	
});
	
	$('a').click(function(e) {
		  e.preventDefault();
	});
	
	//검색기능
	function searchGo(){
		
		getExamList();
	}
	
	//시험지 목록 리스트 불러오기
	function getExamList(currentPage){
	
		currentPage = currentPage || 1;
		var search= $("#search").val();//검색하는 내용
		
		
		var param = {
				currentPage : currentPage,
				search : search,
				pageSize : pageSize
				
		}
		
		

		
		var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
			examListResult(data, currentPage); 
		}
	
		callAjax("/manageA/testList.do","post","text", true, param, resultCallback);// 시험지 리스트 가져오는거
	
	}
	
	
 	//받아온 시험지 리스트 넣어주고 페이징 처리	
 	function examListResult(data, currentPage){
		 
		console.log(data);
		 
		 // 기존 tbocy 비우고
		 $('#examList').empty();
		 //가져온 list html을 넣어준다
		 $('#examList').append(data);
	
		 
		 // 리스트의 총 개수
		 var totalCnt = $("#totcnt").val();
		 
		 //페이징 처리한 html
	     var pagingnavi = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlock, 'getExamList');
		 
	     console.log("pagingnavi : " + pagingnavi);
		 // 비운다음에 다시 append 
	     $("#pagingnavi").empty().append(pagingnavi); 
	 }
	
 
 	//시험지 보기버튼 클릭시
 	//시험지에 대한 정보 나옴
 	function detailTestData(testNumber, testName,userOrNot){
 		
 		
 		$("#testNo").val(testNumber);
 		$("#testNo").attr("readonly", true); //시험번호는 수정불가
 		$("#testName").val(testName);
 		$("#useOrNot").val(userOrNot);
 		$("#insertBtn123").hide(); //등록버튼 숨김
 		$("#updateBtn123").show(); //수정버튼 보임
 		gfModalPop("#test");
 		
 	}
 	
 	//시험지 등록버튼 클릭시 모달창 띄우기
 	function testInsert(){
 		
 		//시험지 번호 가장 높은숫자로 자동 등록
 		var param={}
 		var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
 			
 			var testNo=$("#testNo").val(data.testMaxNum);
 	 		$("#testNo").attr("readonly", true); //수정 못하게함
 	 		$("#testName").val("");
 	 		$("#useOrNot").val("");
 	 		$("#insertBtn123").show(); //등록버튼 숨김
 	 		$("#updateBtn123").hide(); //수정버튼 보임
 	 		gfModalPop("#test");
 			
		}
 		callAjax("/manageA/testMaxNumber.do","post","json", true, param, resultCallback); //시험지 시험번호 가장 높은숫자+1 로 가져오기
 		
 	}
 	
 	
 	//시험지 등록버튼 눌렀을때 처리 함수
 	function insertTestData(){
 		var testNo=$("#testNo").val();
 		var testName=$("#testName").val();
 		var useOrNot=$("#useOrNot").val();

 		var testArray=[testNo,testName,useOrNot];
 		for(var i=0; i<testArray.length; i++){
			if(testArray[i]=="" || testArray[i]==null){
				alert("시험명과 사용여부를 입력해주세요");
				return;
			}
		}
 		
 		if(useOrNot=='Y' || useOrNot=='N'){
 			//good
 		}else{
 			alert("사용여부에 사용할거면 대문자 Y 사용 안할거면 대문자 N을 입력해주세요 ");
 			return;
 			
 		}
 		
 		
 		var param = {
 				testNo : testNo,
 				testName : testName,
 				useOrNot : useOrNot
				
		}

		
		var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
 			getExamList();//등록후 시험지 리스트 출력
 			detailExamData(testNo);// 시험지에 해당하는 문제들 출력
 			$("#selectedNum").html("");// 선택된 시험지 번호 
 			$("#examNum").val("");// 선택한 시험지 번호 초기화
 			gfCloseModal("#test");
 			alert("등록되었습니다");
		}
		
		
		callAjax("/manageA/insertTest.do","post","text", true, param, resultCallback);// 시험지 리스트 가져오는거
 
 	}
 	
 	
 	//시험지 삭제버튼 클릭시 실행되는 함수
 	function deleteTestData(testNo){
 		
 		var param = {
 				examNo : testNo
		}
 		
 		
 		var resultCallback = function(data){  
 			getExamList();//삭제후 시험지 리스트 출력
 			detailExamData();// 시험지에 해당하는 문제들 출력
 			$("#selectedNum").html("");// 선택된 시험지 번호
 			$("#examNum").val("");// 선택한 시험지 번호 초기화
			alert("삭제되었습니다.");
		}
 		
 		callAjax("/manageA/testDelete.do","post","text", true, param, resultCallback);
 		
 	}
 	
 	//시험지 정보 수정 update
 	function updateTestData(){
 		var testNo=$("#testNo").val();
 		var testName=$("#testName").val();
 		var useOrNot=$("#useOrNot").val();

 		var testArray=[testNo,testName,useOrNot];
 		for(var i=0; i<testArray.length; i++){
			if(testArray[i]=="" || testArray[i]==null){
				alert("시험명과 사용여부를 입력해주세요");
				return;
			}
		}
 		
 		if(useOrNot=='Y' || useOrNot=='N'){
 			//good
 		}else{
 			alert("사용여부에 사용할거면 대문자 Y 사용 안할거면 대문자 N을 입력해주세요 ");
 			return;
 			
 		}
 		
 		
 		var param = {
 				testNo : testNo,
 				testName : testName,
 				useOrNot : useOrNot
				
		}
 		
 		var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
 			getExamList();//수정후 시험지 리스트 출력
 			detailExamData();// 시험지에 해당하는 문제들 출력
 			$("#selectedNum").html("");// 선택된 시험지 번호 
 			$("#examNum").val("");// 선택한 시험지 번호 초기화
 			gfCloseModal("#test");
 			alert("수정되었습니다");
		}
		
		
		callAjax("/manageA/updateTest.do","post","text", true, param, resultCallback);// 시험지 리스트 가져오는거
 		
 		
 	}
 
 
 	//시험지번호 클릭시 시험문제들 출력
 	function detailExamData(examNo){
 		//시험지의 시험문제 번호들과 시험문제 총 개수를 담을 변수 초기화 
 		questionNumber=[];
 		questionTotal=0;
 		$("#selectedNum").html(examNo);// 선택된 시험지 번호
 		var param = {
 				examNo : examNo
		}
 		
 		$("#examNum").val(examNo);
 		
 		var resultCallback = function(data){  // 받아온 문제 리스트를 출력 
			examDetail(data); 
		}
 		
		
		callAjax("/manageA/examQuestionList.do","post","text", true, param, resultCallback);

 		
 	}
 	
 	 //받아온 리스트 넣어주고 페이징 처리	해주는 콜백함수
 	 function examDetail(data){
 			 
 			 console.log(data);
 			 
 			 // 기존 tbocy 비우고
 			 $('#questionList').empty();
 			 //가져온 list html을 넣어준다
 			 $('#questionList').append(data);
 		
 			
 		 }
 	 
 	 
 	
 	//보기
 	//문제 클릭하면 문제 정보가 모달창에 들어감
 	function questionDetailInfo(examNo,questionNo, question, answer, select1,select2,select3,select4,score){
 		
 		

 		/* alert(questionNo+"   "+ question+"   "+answer+"   "+ select1+"   "+select2+"   "+select3+"   "+select4+"   "+score); */
 		$("#questionNo").val(questionNo);
 		$("#questionNo").attr("readonly",true); 
 		$("#question").val(question);
 		$("#answer").val(answer);
 		$("#select1").val(select1);
 		$("#select2").val(select2);
 		$("#select3").val(select3);
 		$("#select4").val(select4);
 		$("#score").val(score);
 		$("#examNum").val(examNo);
 		$("#insertBtn").hide();// 등록버튼 숨기기
 		$("#updateBtn").show();//수정버튼 보이기
 		
 		gfModalPop("#exam");
 		
 	}
 	
 	//특정 문제 수정
 	function updateQuestion(){
 		
		var flag=true; //보기중에 답이 있으면 true 없으면 false
 		
 	
 		// 문제번호는 변경하지 못하게 텍스트 박스 readonly 처리
		$("#questionNo").attr("readonly",true); 
 		//모달창에 해당 문제 내용 넣어줌
 		var examNo=$("#examNum").val();
 		var questionNo=$("#questionNo").val();
 		var question=$("#question").val();
 		var answer=$("#answer").val();
 		var select1=$("#select1").val();
 		var select2=$("#select2").val();
 		var select3=$("#select3").val();
 		var select4=$("#select4").val();
 		var score=$("#score").val();
 		
 		

 		//수정할 문제에 대한 정보를 배열에 넣어서 for 돌려 검사하기 위해 배열에 넣음 
 		var questionArray=[ questionNo,question,answer,select1,select2,select3,select4,score];
 		
 		//문제 수정시 하나라도 빠진게 있으면 등록 안됨
 		for(var i=3; i< 7; i++){
 			if(questionArray[2]==questionArray[i]){
 				flag=false;
 			}
 		}
 		
 		if(flag){//보기중에 답이 있으면 true 없으면 false
 			alert("보기중에 답이 없습니다.");
			return;
 		}
 		
 		
 		
 		
 		var param = {
 				examNo : examNo,
 				questionNo : questionNo,
 				question : question,
 				answer : answer,
 				select1 : select1,
 				select2 : select2,
 				select3 : select3,
 				select4 : select4,
 				score : score
		}
 		
 		//문제 수정후 실행되는 함수
 		 var resultCallback2 = function(data){  // 데이터를 이 함수로 넘깁시다. 
 			gfCloseModal("#exam"); //팝업창 닫기
 			var examNo=$("#examNum").val(); //hidden에 있는 examNum을 통해 examNo를 구함
 			detailExamData(examNo);// 시험지에 해당하는 문제들 출력
 			$("#selectedNum").html(examNo);// 선택된 시험지 번호
 			alert("수정되었습니다"); 
 			
		}
		
 		//문제 수정 ajax
		callAjax("/manageA/questionUpdate.do","post","text", true, param, resultCallback2);
 		 
 	}
 	
 	
 	//특정문제 삭제
 	function questionDelete(examNo, questionNo){
 		var param = {
 				examNo : examNo,
 				questionNo : questionNo
		}
 		

 		
 		var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
 		
 			var examNo=$("#examNum").val();
 			detailExamData(examNo);
 			alert("삭제되었습니다"); 
		}
		
		callAjax("/manageA/questionDeleteGo.do","post","text", true, param, resultCallback);
 		
 	}
 	
 	//등록버튼 클릭
 	//새로운 문제 등록 모달창 띄우기
 	function questionInsert(){
 		//시험지의 문제 등록 버튼을 눌렀는데 선택한 시험지가 없다면 return
 		if($("#examNum").val()=="" || $("#examNum").val()==null){
 			alert("등록할 시험지를 선택해주세요..")
 			return;
 		}
 		
 		var examNo=$("#examNum").val();
 		
 		var param={
 				examNo:examNo
 				
 		}
 	
	
		
		function resultCallback(data){
			
			//문제번호를 넣어줌
			$("#questionNo").val(data.questionMaxNum);
			
			$("#questionNo").attr("readonly",true);  //문제번호 등록 못하게 readonly
	 			if(examNo!=""){//등록할 문제의 시험지를 선택한 경우
	 			//전부 빈걸로 초기화
	 				var question=$("#question").val("");
	 				var answer=$("#answer").val("");
	 				var select1=$("#select1").val("");
	 				var select2=$("#select2").val("");
	 				var select3=$("#select3").val("");
	 				var select4=$("#select4").val("");
	 				var score=$("#score").val("");
	 				$("#insertBtn").show(); //등록버튼 보임
	 				$("#updateBtn").hide(); //수정버튼 숨김
	 		
	 				gfModalPop("#exam");
	 			}else{// 등록할 문제의 시험지를 선택하지 않은 경우
	 				alert("문제를 등록할 시험지를 선택해주세요.")
	 			}
		}

		
		//기존에 있는 문제중 가장 높은 문제번호에서 +1
		callAjax("/manageA/questionMaxNumber.do","post","json", true, param, resultCallback); //시험지 시험번호 가장 높은숫자+1 로 가져오기
		
 	}
 	
 
 	//특정 문제 등록 처리하는 함수
 	function insertQuestion(){
 		var flag=true; //보기중에 답이 있으면 true 없으면 false
 		
 		////넣어줄 값 가져옴
 		var examNo=$("#examNum").val();//시험지번호
 		var questionNo=$("#questionNo").val();
 		var question=$("#question").val();
 		var answer=$("#answer").val();
 		var select1=$("#select1").val();
 		var select2=$("#select2").val();
 		var select3=$("#select3").val();
 		var select4=$("#select4").val();
 		var score=$("#score").val();
 		
 		
 		
 		//등록할 문제에 대한 정보를 배열에 넣어서 for 돌려 검사하기 위해 배열에 넣음 
 		var questionArray=[ questionNo,question,answer,select1,select2,select3,select4,score];
 		
 		//문제 등록시 하나라도 빠진게 있으면 등록 안됨
 		for(var i=3; i< 7; i++){
 			if(questionArray[2]==questionArray[i]){
 				flag=false;
 			}
 		}
 		
 		if(flag){//보기중에 답이 있으면 true 없으면 false
 			alert("보기중에 답이 없습니다.");
			return;
 		}
 		
 		
 		//문제 등록하는데 빠진 정보가 있으면 return
 		for(var i=0; i< questionArray.length; i++){
 			if(questionArray[i]==null || questionArray[i]=="" ){
 				alert("모든 항목을 빠짐없이 입력해주세요");
 				return;
 			}
 		}
 		
 		//등록할 문제 정보들을 param에 넣어줌
 		var param = {
 				examNo : examNo,
 				questionNo : questionNo,
 				question : question,
 				answer :answer,
 				select1: select1,
 				select2: select2,
 				select3: select3,
 				select4: select4,
 				score : score
		}
 		
 		//문제 등록이 완료되면 실행되는 함수
 		var resultCallback = function(data){ // 데이터를 이 함수로 넘깁시다. 
 			gfCloseModal("#exam");//팝업창 닫음
 			detailExamData(examNo); //등록 완료후  문제리스트 불러옴
 			questionNumber.push(examNo);// 등록된 문제번호 넣어줌
 			questionTotal+=1; //문제수 total 1 증가함
 			alert("등록 되었습니다"); 
 			
		}
		
 		//문제등록 ajax
		callAjax("/manageA/questionInsert.do","post","text", true, param, resultCallback);
 		
 	}
 	
 	
 	

 	
</script>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myNotice" action="" method="">
	
	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<input type="hidden" id="examNum" value="" />
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
						<p class="conTitle">
							<span>시험문제관리 </span> 
						</p>
						
					
						
						
					<!--검색창  -->
					<table align="left">
                        <tr style="border: 0px; border-color: blue">
                          <td  height="25" style="font-size: 100%">
                           		시험명&nbsp&nbsp
                           </td>
                           <td>&nbsp<input type="text" style="width: 590px;height: 25px" id="search" name="search">&nbsp&nbsp</td>                     
 						   <td><a href="javascript:searchGo()" class="btnType blue"  id="searchBtn" name="btn"><span>검  색</span></a></td> 
                                                         </tr>
                     </table>    
						<p>&nbsp</p>
						<p>&nbsp</p>
						<p>&nbsp</p>
						
						<span style="float:right;"><a href="javascript:testInsert()" class="btnType blue"  id="searchBtn" name="btn"><span>등 록</span></a></span>
						<div class="noticeListTable">
							<table class="col">
								<colgroup>
						                   <col width="90px">
						                   <col width="90px">
						                   <col width="90px">
						                   <col width="90px"> 
					            </colgroup>
								<thead>
									<tr>
							              <th scope="col">시험번호</th>
							              <th scope="col">시험명</th>
							              <th scope="col">사용여부</th>
							              <th scope="col">상세보기 및 삭제</th>
							              
									</tr>
								</thead>
								<tbody id="examList"></tbody>
							</table>
							
							
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
							</div>
										
						</div>
						
						
						<p>&nbsp</p>
						<p>&nbsp</p>
						<p>&nbsp</p>
						
						<span style="float:right;"><h5>시험번호  <span id="selectedNum"></span></h5><a href="javascript:questionInsert()" class="btnType blue"  id="searchBtn" name="btn"><span>등 록</span></a></span>
						<div style="width:100%; height:250px; overflow:auto">

							<table class="col">
								<colgroup>
						                   <col width="10px">
						                   <col width="150px">
						                   <col width="70px">
						                   <col width="10px">
						                   <col width="100px">
						                    
					            </colgroup>
								<thead>
									<tr>
							              <th scope="col">번호</th>
							              <th scope="col">문제</th>
							              <th scope="col">답</th>
							              <th scope="col">점수</th>
							              <th scope="col">상세보기 및 삭제</th>
							              
									</tr>
								</thead>
								<tbody id="questionList"></tbody>
							</table>
							
						</div>	
						

		
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>


	<!-- 시험지 등록 모달팝업  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<div id="test" class="layerPop layerType2" style="width: 350px;">

		<dl>
			<dt>
				<strong>시험지 등록</strong>
			</dt>
			<div class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					

					<tbody>
						
						<tr>
							<th scope="row">시험번호 <span class="font_red">*</span></th>
							<td >
							<input type="text" class="testNo" name="testNo" id="testNo"  />
							</td>
						</tr>
						<tr>	
							<th scope="row" >시험명<span class="font_red">*</span></th>
							<td >
							<input type="text" class="testName" name="testName" id="testName" />
							</td>
						</tr>
						<tr>	
							<th scope="row">사용여부<span class="font_red">*</span></th>
							<td>
								<input type="text" class="useOrNot" name="useOrNot" id="useOrNot" />	
							</td>
						</tr>
						
							<td colspan=10 align="center">
						
								<span id="insertBtn123"><a href="javascript:insertTestData()"	class="btnType gray"   name="btn"><span>등 록</span></a></span>
								<span id="updateBtn123"><a href="javascript:updateTestData()"	class="btnType gray"   name="btn"><span>수 정</span></a></span>
								<span id="closeBtn123"><a href="javascript:gfCloseModal()"	class="btnType gray"   name="btn"><span>닫 기</span></a></span>
								
							</td>
							
						
					</tbody>
				</table>
				
			</div>

		</dl>
		
	</div>








	<!-- 문제 등록 모달팝업 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<div id="exam" class="layerPop layerType2" style="width: 1400px;">

		<dl>
			<dt>
				<strong>시험문제관리</strong>
			</dt>
			<div class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					

					<tbody>
						
						<tr>
							<th scope="row">문제번호 <span class="font_red">*</span></th>
							<td >
							<input type="text" class="questionNo" name="questionNo" id="questionNo"  />
							</td>
							<th scope="row" >문제 <span class="font_red">*</span></th>
							<td colspan=5 >
							<input type="text" class="question" name="question" id="question"  size=50/>
							</td>
							<th scope="row">정답<span class="font_red">*</span></th>
							<td>
								<input type="text" class="answer" name="answer" id="answer" />	
							</td>
						</tr>
						<tr>
							<th scope="row">보기1<span class="font_red">*</span></th>
							<td>
								<input type="text" class="select1" name="select1" id="select1" />	
							</td>
							<th scope="row">보기2<span class="font_red">*</span></th>
							<td>
								<input type="text" class="select2" name="select2" id="select2" />	
							</td>
							<th scope="row">보기3<span class="font_red">*</span></th>
							<td>
								<input type="text" class="select3" name="select3" id="select3" />	
							</td>
							<th scope="row">보기4<span class="font_red">*</span></th>
							<td>
								<input type="text" class="select4" name="select4" id="select4" />	
							</td>
							<th scope="row">점수<span class="font_red">*</span></th>
							<td>
								<input type="text" class="score" name="score" id="score" />	
							</td>
							</tr>
							<td colspan=10 align="center">
							
								<span id="insertBtn"><a href="javascript:insertQuestion()"	class="btnType gray"   name="btn"><span>등 록</span></a></span>
								<span id="updateBtn"><a href="javascript:updateQuestion()"	class="btnType gray"   name="btn"><span>수 정</span></a></span>
								<span id="closeBtn"><a href="javascript:gfCloseModal()"	class="btnType gray"   name="btn"><span>닫 기</span></a></span>
								
							</td>
							
						
					</tbody>
				</table>
				
				

				
			</div>

		</dl>
		
	</div>
	
	


</form>


</body>
</html>
