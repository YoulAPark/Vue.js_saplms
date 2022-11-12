<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 공지사항  </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
       
<script type="text/javascript">
//페이징 설정 
var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수

/* onload 이벤트  */
$(function(){
	// 공지사항 리스트 뿌리기 함수 
	selectNoticeList();
	
	// 버튼 이벤트 등록 (저장, 수정, 삭제, 모달창 닫기)
	fButtonClickEvent();
	

	
	
});
	/* 공지사항 리스트 불러오기  */
	function selectNoticeList(currentPage){
	
		currentPage = currentPage || 1;   // or		
		var title;
		var content;
		var search= $("#search").val();//검색하는 내용
		
		//검색이 글제목인지 글내용인지 확인
		var selectedCategory=$("#searchCategory").val();
		if(selectedCategory=="title"){
				title=search; //글제목 검색			
		}else{
			content=search; //글내용 검색
		}
	
		
		var param = {
				title : title , 
				content : content,
				currentPage : currentPage ,
				pageSize : pageSize , 
				
		}

		
		var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
			noticeListResult(data, currentPage); 
		}
		
		callAjax("/supportC/noticeList.do","post","text", true, param, resultCallback);
		
	}
	
	
	 /* 공지사항 리스트 data를 콜백함수를 통해 뿌려봅시당   */
	 function noticeListResult(data, currentPage){
		 
		 console.log(data);
		 
		 // 기존 tbocy 비우고
		 $('#noticeList').empty();
		 //가져온 list html을 넣어준다
		 $('#noticeList').append(data);
	
		 
		 // 리스트의 총 개수를 추출합니다. 
		 //var totalCnt = $data.find("#totalCnt").text();
		 var totalCnt = $("#totcnt").val();  // qnaRealList() 에서보낸값 
		 
		
	     var pagingnavi = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlock, 'selectNoticeList');
		 
	     console.log("pagingnavi : " + pagingnavi);
		 // 비운다음에 다시 append 
	     $("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 
		 
		 // 현재 페이지 설정 
	     $("#currentPage").val(currentPage);
		 
	 }
	
	 
	
	 //검색 버튼 눌렀을때 이벤트 처리
	 function searchGo(){
		 selectNoticeList();
	 }
	 
	 
	 /* 공지사항 모달창(팝업) 실행  */
	 function goNoticeModal(noticeNo) {
		 
			//모달 팝업 모양 오픈! (빈거) _ 있는 함수 쓰는거임. 
			gfModalPop("#notice");
		
	 }
	 
	 
	 /*공지사항 상세 조회*/
	 function goDetailModal(noticeNo){
		 
		 var param = {noticeNo : noticeNo};
		
		
		 /*  공지사항 상세 조회 -> 콜백함수   */
		 function fdetailResult(data){
				console.log(data);
			 //alert("공지사항 상세 조회  33");
			 if(data.resultMsg == "SUCCESS"){
				 
				// 모달에 정보 넣기 
				frealPopModal(data.result);
			 
				//모달 띄우기 
				 gfModalPop("#notice");
				 
			 }else{
				 alert(data.resultMsg);
			 }
		 } 
		 
		 
		 function resultCallback7(data){

			 console.log(data);
			 fdetailResult(data);
		 };
		 
		 callAjax("/supportC/detailNotice.do", "post", "json", true, param, resultCallback7);
		 
		 
		 //alert("공지사항 상세 조회  22");
	 }
	 
	
	 
	 /* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
	 function frealPopModal(object){
		 
		 if(object == "" || object == null || object == undefined){
			
			 $("#noticeTitle").val("");
			 $("#noticeContent").val("");
			 
			 
		 }else{
			 
			 $("#noticeTitle").val(object.bd_title);
			 $("#noticeContent").val(object.bd_contents);
	
			 
		 }
	 }
	 
	 
	
</script>
	

</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myNotice" action="" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" id="tmpList" value="">
	<input type="hidden" id="tmpListNum" value="">
	<input type="hidden" id="swriter" value="${loginID}"> 

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
						<p class="conTitle">
							<span>공지 사항 </span> 
						</p>
						
					<!--검색창  -->
					<table align="left">
                        <tr style="border: 0px; border-color: blue">
                          <td  height="25" style="font-size: 100%">
                           		<select id="searchCategory">
                           			<option value="title">글제목</option> 
                           			<option value="content">글내용</option> 
                           		</select>
                           </td>
                           <td>&nbsp<input type="text" style="width: 120px;height: 25px" id="search" name="search"></td>                     
 						   <td>&nbsp<a href="javascript:searchGo()" class="btnType blue"  id="searchBtn" name="btn"><span>검  색</span></a></td> 
                          </tr>
                     </table>    
						<p>&nbsp</p>
						<p>&nbsp</p>
						<p>&nbsp</p>
						
						<div class="noticeListTable">
							<table class="col">
								<colgroup>
						                   <col width="180px">
						                   <col width="90px">
						                    <col width="90px">
					            </colgroup>
								<thead>
									<tr>
							              <th scope="col">제목</th>
							              <th scope="col">작성일</th>
							              <th scope="col">작성자</th>
									</tr>
								</thead>
								<tbody id="noticeList"></tbody>
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


	<!-- 모달팝업 -->
	<div id="notice" class="layerPop layerType2" style="width: 600px;">

		<dl>
			<dt>
				<strong>공지사항</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					

					<tbody>
						
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="noticeTitle" id="noticeTitle" readonly/></td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="noticeContent" id="noticeContent" readonly>
								</textarea>
							</td>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:gfCloseModal()"	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	


</form>


</body>
</html>
