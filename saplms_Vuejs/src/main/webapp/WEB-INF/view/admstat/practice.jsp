<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!-- JSTL prefix로 삽입 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<title>율아 연습 - VueNotice.jsp</title>

<!-- CDN : sweetAlert -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<!-- CDN : CDN모음집 -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!--
		현재 진행상황
		1. Controller : AdminController.java // admin폴더 생성하여 Controller 기재. 
		2. jsp : view - admstat - practice.jsp
		** Controller에서 차후 기능들 가져와야할 때 Controller에서 Service @Autowired하는 것 잊지 말것
		
		1. Body부분 CSS 적용하여 큰 틀은 대략 완성
		2. v-model, v-html, v-if 사용할 태그들 따로 기재해놨으니 검색해서 직접 처리 해볼 것
		3. ? 검색하면 궁금증들 나옴 ㅠ 그거좀물어보자
 -->


<style>

	<!-- formData 시작 -->
	
		.searchTable 	{
							margin-top : "10px";
							width : "100%";
							cellpadding : "5";
							cellspacing : "0";
							border : "1";  
							align : "left";
							style : "collapse"; 
							border: "1px";
						}
		.searchTr		{
							border : 0px;
							border-color :blue;
						}
		.searchTd 		{
							width : "50";
							height :"25";
							font-size : 100%;
							text-align: left;
							padding-right: 25px;	
						}				
		.inputText		{
							width : 300px;
							height : 29px;					 
						}
	
	<!-- formData 종료 -->
				
	<!-- Modal 시작 -->
		.layerType2		{
							width :600px;
						}
	
	<!-- Modal 종료 -->
</style>

<script type="text/javascript">

	var pageSize = 10;
	var pageNumSize = 5;
	
	$(function() {
		init();
	});
	
	function btnEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault(); // 기본 클릭 동작을 막는 것을 할 수 있다.
			
			var btnId = $(this).attr('id');
			
			switch(btnId) {
				/* searchBar에 있는 검색 */
				case 'btnSearch' :	// 검색
					listSearch();	
					break;
					
				/* 글 편집 작동 */
				// 1. 게시글 클릭 후 저장버튼
				case 'btnSave';	
					fileSave(); // fileSave();
					break;
				// 2.게시글 클릭 후 삭제버튼
				case 'btnDelete';
					noFilePopup.actino = "D";
					fileSave(); // fileSave();
					break;
				
				/*	신규등록 클릭 후 뜨는 모달창의 저장	*/
				// 1. 저장
				case 'btnSaveFile';
					fileUpload();
					break;
				// 2. 삭제
				case 'btnDeleteFile';
					$("#action").val("D");
					fileUpload();
					break;
					
				/* 모달 닫기 */
				// 1. 게시글 클릭시 뜨는 모달 닫기
				case 'btnClose';
					modalClose();
					break;
				// 2. 파일업로드시 모달 닫기
				case 'btnCloseFile';
					break;();
			
			}	// switch문 닫기
		}); // a[namt='btn'] 닫기
	} // function 닫기
	
	function init() {
		boardList = new Vue({
								el : "#boardList"
								data : {
											itemList : [],
											
								}
			
		})
	}
</script>

</head>

<body>

<!-- form Data 시작 -->
<form id="boardForm">

	<div id="mask"></div>
	<div id="wrap_area">
		
		<!-- header 영역 -->
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include> <!-- header.jsp 영역을 jsp:include를 사용해서 출력한다 -->
	
		<!-- 컨텐츠 영역 -->
		<div id="container">
			
			<!-- lnb영역 : 레이아웃 중 제일 왼쪽에 있는 Navibar를 말한다. -->
			<!-- 
				1. <ul> : 목록을 만드는 태그
					=> unordered list의 약자
					=> 순서가 필요 없는 목록을 의미한다
			 -->
			<ul>
				
				<li class="lnb">
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!-- jsp:include를 통해 lnbMenu.jsp를 레이아웃 좌측에 정렬한다 -->
				</li>
				
				<!-- class="contents"의 유무 : 상단 학습관리, 게시판 부분에 흰바탕이 생성된다-->
				<li class="contents">
				
					<!-- Contents 영역 시작 -->
					<div class="content"> <!-- class="content" : Content 영역에 흰바탕이 생성된다  -->
					<!-- 그렇다면 class="content"로 지정한 것들은 받아온 템플릿의 태그인건가? 아니면 Style을 따로 지정한건가? -->
						
						<!-- Main이동, 학습관리, 게시판, 새로고침 시작 -->
						<p class="location"> <!-- class="location" : 태그가 의미하는건 뭐지? -->
							<!-- a href 태그보다 더 좋은 방향은 없을까? onclick이벤트라던지 아니면 button을 눌러서 이동시키는 방향으로 -->
							<a href="../dashboard/dashboard.do" class="btn_set home">Main</a> <!-- Main으로 이동하는 아이콘을 출력한다 -->
								<!-- 
									2. <span> : div 태그처럼 특별한 기능을 가지고 있지 않고 CSS와 함께 쓰인다
									=> div태그와의 차이점은 개행이 되지 않는다는 점이다
								-->
								<span class="btn_nav bold">학습관리</span>	<!-- 학습관리로 이동 // btn을 굵게 표시함 -->
								<span class="btn_nav bold">게시판</span> <!-- 게시판으로 이동 -->
							<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a> <!-- 새로고침 아이콘 출력 -->
						</p>
						<!-- Main이동, 학습관리, 게시판, 새로고침 종료 -->
						
						<!-- 게시판 container 시작-->
						<p class="conTitle">
							<span>게시판</span> <!-- 말 그대로 게시판 -->
								<span class="fr"> <!-- class="fr"의 역할은? -->
								<a href="javascript:addModal();" class="btnType blue" name="modal"><span>신규등록</span></a> <!-- addModal() -->
								<a href="javascript:addModalFile();" class="btnType blue"  name="modal"><span>신규등록(파일)</span></a> <!-- addModalFile() -->
							</span>
						</p>
						<!-- 게시판 container 종료-->
						
						<!-- searchBar 시작 -->
						<div id="searchArea">
							<table id="searchTable">
								<tr class="searchTr"> <!-- 해당 부분이 왜 필요한지 모르겠음. 위에 style 확인 -->
									<td id="searchTd">
										
										<!-- 첫번째 selectBox -->
										<select id="sampleCom"></select> <!-- v-model : samplecom이 들어갈 자리 -->
										
										<!-- 두번째 selectBox -->
										<select id="searchType">  <!-- v-model : searchKey이 들어갈 자리 -->
											<option value="">전체</option>	<!-- option Value가 뭐지? -->
											<option value="">순번</option>
											<option value="">제목</option>
											<option value="">작성자</option>
										</select>
										
										<!-- 검색어를 입력할 수 있는 input text 자리 -->
										<input type="text" class="inputText">
										
										<!-- 검색 버튼 -->
										<a class="btnType blue"><span>검색</span></a>
									</td>
								</tr>
							</table>
						</div>
						<!-- searchBar 종료 -->
						
						<!-- 테이블 시작 -->
						<div id="boardList">
							<table class="col">
								<caption>캡션이뭐야</caption>	<!-- 3. caption : 테이블을 정의할 때 사용한다. 표 설명 -->
									
									<!-- 각 열들의 너비 조정 시작-->
									<colgroup>	<!-- 4. colgroup : 하나 이상의 열을 그룹으로 묶을 때 사용한다. 각 행/셀의 스타일을 반복하지 않고, 컬럼 전체에 다른 스타일을 적용할 수 있다 -->
										<col width="10%">	<!-- 화면을 줄였을 때 비율에 맞게 줄여주기 위해 사용 -->
										<col width="40%">
										<col width="25%">
										<col width="25%">
									</colgroup>
									<!-- 각 열들의 너비 조정 종료 -->
									
									<!-- 4개의 열 Naming 시작-->
									<thead>	<!-- 5. thead : 헤더 콘텐츠를 하나의 그룹으로 묶을 때 / 순서 : caption -> colgroup -> thead / 반드시 하나 이상의 tr요소를 포함해야 한다-->
										<tr>
											<th scope="col">No</th> <!-- col width 위에 명시한 순서대로 퍼센테이지 작동 -->
											<th scope="col">제목</th>
											<th scope="col">작성자</th>
											<th scope="col">작성일자</th>
										</tr>
									</thead>
									<!-- 4개의 열 Naming 종료 -->
									
									<!-- 4개의 열에 맞게 행 출력 // v-model, v-for 사용 -->
									<tbody> <!-- v-model : listfileupload && v-for : listItem 들어갈 자리 -->
										<tr>
											<td>1</td> <!-- listItem의 출력 값들을 담아줘야한다 -->
											<td>2</td>
											<td>3</td>
											<td>4</td>
										</tr>									
									</tbody>
									<!-- 4개의 열에 맞게 행 출력 종료 -->
									
							</table>
							
							<!-- Paging Navigation 시작 -->
							<div>이곳은 Paging 작성해야 할 공간</div> <!-- v-html : pagenavi 들어갈 공간 -->
							<!-- Paging Navigation 종료 -->
						</div>
						<!-- 테이블 종료 -->						
					</div>
					<!-- Contents 영역 종료 -->
					
					<!-- Footer 삽입 -->
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>		
		</div>	
	</div>
</form>
<!-- form Data 종료 -->

<!-- Modal newBoard 시작 -->
	<div id="newBoard" class="layerPop layerType2">
		<dl>
			<dt>
				<string>Edit</string> <!-- Modal의 가장 상단 타이틀 제목 부분 -->
			</dt>	
			
			<dd class="content">
			
				<!-- Modal의 Content 내용 담는 부분 시작 -->
				<table class="row">
					<caption>modalLayer캡션</caption>
					
					<colgroup>
						<col width="120px">
						<col width="*"> <!-- 아스타의 의미가 뭐지? -->
					</colgroup>
					
					<tbody>
						<tr>
							<th scope="row">제목<span class="font_red">*</span></th> <!-- *를 붙인 이유는 제목은 필수로 표기해야 된다는 걸 강조하기 위해서ㅋㅋ -->
						</tr>
						<tr>
							<th scope="row">내용<span class="font_red">*</span></th>	<!-- 한마디로 표기되는건 제목* 내용* -->
							<td>
								<textarea class="inputText">여기 내용을 입력하는 곳으로 v-model 사용해야 한다</textarea> <!-- 내용을 기재하는 공간으로 v-model을 사용해야 한다 -->
							</td>
						</tr>
					</tbody>
				</table>
				<!-- Modal의 Content 내용 담는 부분 끝 -->
				
				<!-- 저장, 취소 버튼 시작 -->
					<div class="SaveCancleBtn">
						<a class="btnType blue"><span>저장</span></a>
						<a class="btnType blue"><span>삭제</span></a> <!-- v-show가 들어가져야 할 부분 -->
						<a class="btnType gray"><span>취소</span></a>
					</div>
				<!-- 저장, 취소 버튼 끝 -->
								
			</dd>
			<!-- Modal의 Content 내용 담는 부분  -->
			
			<a class="closeModal"><span class="hidden">닫기</span></a> <!-- 왜 hidden으로 처리를 한거지? span class를 명시해야 할 이유가 있을까 -->
			
		</dl>
	</div>

<!-- Modal newBoard 종료 -->

<!-- Modal newBoardFile 시작 -->
	<div id="newBoardFile" class="layerPop layerType2">
		<dl>
			<dt>
				<string>Edit(File)</string> <!-- Modal의 가장 상단 타이틀 제목 부분 -->
			</dt>	
			
			<dd class="content">
			
				<!-- Modal의 Content 내용 담는 부분 시작 -->
				<table class="row">
					<caption>modalLayer캡션</caption>
					
					<colgroup>
						<col width="120px">
						<col width="*"> <!-- 아스타의 의미가 뭐지? -->
					</colgroup>
					
					<tbody>
					
						<!-- 제목 시작 -->
						<tr>
							<th scope="row">제목<span class="font_red">*</span></th> <!-- *를 붙인 이유는 제목은 필수로 표기해야 된다는 걸 강조하기 위해서ㅋㅋ -->
						</tr>
						<!-- 제목 종료 -->
						
						<!-- 내용 시작 -->
						<tr>
							<th scope="row">내용<span class="font_red">*</span></th>	<!-- 한마디로 표기되는건 제목* 내용* -->
							<td>
								<textarea class="inputText">여기 내용을 입력하는 곳으로 v-model 사용해야 한다</textarea> <!-- 내용을 기재하는 공간으로 v-model을 사용해야 한다 -->
							</td>
						</tr>
						<!--  내용 종료 -->
						
						<!-- 파일업로드 시작 -->
						<tr>
							<th scope="row">파일<span class="font_red">*</span></th>
							<td>
								<input type="file" onChange="filePreviewChange(event)"/> <!-- 파일업로드. onChange이벤트 동작(파일을 input에 올릴 경우 filePreView가 동작을 한다) -->
							</td>
						</tr>
						<!-- 파일업로드 종료 -->
						
						<!-- 파일 다운로드 시작 -->
						<tr>
							<th scope="row">파일다운로드<span class="font_red">*</span></th>
							<td>
								<div id="fileDownload"></div> <!-- 클릭할 수 있는 이벤트 처리를 할 곳인가?ㅠ 에러나서 안보임 확인해볼 것 -->
							</td>
						</tr>
						<!-- 파일 다운로드 종료 -->
						
						<!-- 파일 미리보기 시작 -->
						<tr>
							<th scope="row">파일미리보기<span class="font_red">*</span></th>
							<td>
								<div id="filePreview"></div> <!-- 파일 미리보기 -->
							</td>
						</tr>
						<!-- 파일 미리보기 종료 -->
						
					</tbody>
				</table>
				<!-- Modal의 Content 내용 담는 부분 끝 -->
				
				<!-- 저장, 취소 버튼 시작 -->
					<div class="SaveCancleBtn">
						<a class="btnType blue"><span>저장</span></a>
						<a class="btnType blue"><span>삭제</span></a> <!-- v-show가 들어가져야 할 부분 -->
						<a class="btnType gray"><span>취소</span></a>
					</div>
				<!-- 저장, 취소 버튼 끝 -->
								
			</dd>
			<!-- Modal의 Content 내용 담는 부분  -->
			
			<a class="closeModal"><span class="hidden">닫기</span></a> <!-- 왜 hidden으로 처리를 한거지? span class를 명시해야 할 이유가 있을까 -->
			
		</dl>
	</div>
<!-- Modal newBoardFile 종료 -->


</body>
</html>