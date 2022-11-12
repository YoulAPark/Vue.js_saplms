<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>  <!-- 유저타입이 A가 아니면 기본페이로 -->
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
 
<script type="text/javascript">
    
    var pagesize = 5;
    var pagenumsize = 5;
	var today = new Date();   

	var year = today.getFullYear(); // 년도
	var month = today.getMonth() + 1;  // 월
	var date = today.getDate();  // 날짜 
    
	/** OnLoad event */ 
	$(function() {
	
		// 게시판 조회
		fListnotice();
		
		fRegisterButtonClickEvent();
		
		sortnotice();
		
		$("#searchvalue").keydown(function (key) {
	        if (key.keyCode == 13) {
	            $("#btnSearch").click();
	        }
    });
	$("#searchvalue").focus();
	
	});
    
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			
			switch (btnId) {
				case 'btnSearch' : // 검색 버튼
					fListnotice();
					break;
				case 'btnSave' :  // 수정버튼
					titlenone();
					break;					
				case 'btnInsert' :  //신규 등록 버튼
					titlenone();
					break;
				case 'btnClose' : // 목록보기 버튼
					gfCloseModal();
					break;	
				case 'btnDelete' : // 삭제 버튼
					$("#action").val("D"); // action html에 input타입에서 컨트롤러로 보내주고있음
					fsaveNotice();
					break;		
			}
		});
	}
	
	function titlenone(){  // 제목이 없으면 alert문 있으면 저장수정하라
		   var id =    $("#title").val() ;
		   if(id == null || id == ""){
		      alert("제목이 없어요");
		   } else{
			   
			   fsaveNotice();
		   }
		   
		}
	
	function fListnotice(clickpagenum) {
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
				searchtype : $("#searchtype").val() ,
				searchvalue : $("#searchvalue").val() ,
				sortflag : $("#sortflag").val(),
				clickpagenum : clickpagenum,
				pagesize : pagesize
		};
		
		var searchcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			searchcallbackprocess(returndata,clickpagenum);
			
		}
		
		callAjax("/supportA/listNotice.do", "post", "text", true, param, searchcallback);
		
		
	}
	
	function searchcallbackprocess(returndata,clickpagenum) {
		
		$("#listNotice").empty().append(returndata);
		
		var totalcnt = $("#searchlistcnt").val();
		
		var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fListnotice');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnfileuploadPagination").empty().append( paginationHtml );
		
		$("#hclickpagenum").val(clickpagenum);
	}
	
	function fPopModal() {		// 신규등록 버트에 모달
		$("#action").val("I");
		
		fn_forminit();
		
		gfModalPop("#layer1");
	}  
	
	function fn_forminit(object) {
				
		if (object == null || object=="") {
			$("#title").val(""); // 제목 텍스트
			$("#cont").val(""); // 내용 텍스트
			$("#noticeNo").text("");
			$("#btnDelete").hide(); // 삭제버튼
			$("#btnSave").hide();  // 수정버튼
			$("#noticeWriter").text($("#swriter").val()); // 작성자 텍스트
			$("#btnInsert").show();
			$("#noticeDate").text(year + '-' + month + '-' + date); // 오늘날짜 텍스트
			$("#noticeTitle").show(); // 제목  텍스트 
			
			$("#title").focus();
		} else {
			$("#title").val(object.bd_title); // 제목 텍스트
			$("#cont").val(object.bd_contents); // 내용 텍스트
			$("#noticeNo").text(object.bd_no); // 번호 텍스트
			$("#noticeWriter").text(object.name); // 작성자 텍스트
			$("#noticeCnt").text(object.bd_cnt); // 조회수 텍스트
			$("#noticeDate").text(object.bd_date); // 등록일 텍스트
			$("#btnSave").show();  // 수정버튼
			$("#btnDelete").show(); // 삭제버튼
			$("#btnInsert").hide(); // 등록버튼
			$("#noticeTitle").hide(); // 제목
			
			$("#bd_no").val(object.bd_no);
		}

		
	}
	
	//단건조회 함수
	function fselectone(bd_no) {
		
		var param = {
				bd_no : bd_no
		}
	
	
		var searchcb = function( selectonersn ) {
			console.log(JSON.stringify(selectonersn));
			//console.log(JSON.stringify(selectonersn.searchone));
			
			$("#action").val("U");			
			fn_forminit(selectonersn.searchone);
			
			gfModalPop("#layer1");
		
	}
		
	callAjax("/supportA/selectNotice.do", "post", "json", true, param, searchcb);
	}
	
	// 업데이트(등록,수정) 하는  메소드
	function fsaveNotice() {
		
		var param = {
				bd_no : $("#bd_no").val(),
				title : $("#title").val(),
				cont : $("#cont").val(),
				action : $("#action").val()
		};
		
		var savecallback= function(rtn) {
			console.log(JSON.stringify(rtn));
			
			alert("저장 하시겠습니까?");
			
			gfCloseModal();
			
			var savepageno = 1;
			
			if($("#action").val() == "U") {
				savepageno = $("#hclickpagenum").val();
			}
			
			fListnotice(savepageno);
			
		}
		callAjax("/supportA/saveNotice.do", "post", "json", true,  $("#myForm").serialize(), savecallback);
	}
	
    //             오름차순   내림차순 
     function sortnotice() {
    	   
    	      $("#noticesort").click(function(e) {
    	    	  
    	    	  e.preventDefault();  // 이벤트 동시 방지 기능
    	    	  
    	    	  //console.log("sortflag : " + $("#sortflag").val());
    	    	  
    	    	  if($("#sortflag").val() == "1") { 
    	    		  //console.log("11111111111111111111111111111");
    	    		  
    	    		   //화살표 이미지 변경
    	    		  /* $("#noticesort").empty().append("<img src='/images/2.png' style='width:20px; height:20px'>"); */
    	    		  $("#noticesort").empty().append("▼");
        	    	  $("#sortflag").val("2");
        	    	  
        	    	  console.log("sortflag after : " + $("#sortflag").val());
        	    	  
        	    	  fListnotice();
        	    	  	  
   	    	  
    	    	  } else if($("#sortflag").val() == "2"){
    	    		  //console.log("22222222222222222222222222222");
    	    		//화살표 이미지 변경
    	    	     /*  $("#noticesort").empty().append("<img src='/images/3.png' style='width:20px; height:20px'>"); */
    	    	     $("#noticesort").empty().append("▲");
        	    	  $("#sortflag").val("3");
        	    	  	
        	    	  console.log("sortflag after : " + $("#sortflag").val());
        	    	  
        	    	  fListnotice();
        	    	  
    	    	  	} else if($("#sortflag").val() == "3"){
    	    	  		//console.log("3333333333333333333333333333");
    	    	  	//화살표 이미지 변경
    	    	  	  /* $("#noticesort").empty().append("<img src='/images/1.png' style='width:20px; height:20px'>"); */
    	    	  	  $("#noticesort").empty().append("◈");
          	    	  $("#sortflag").val("1");
          	    		
          	    	  console.log("sortflag after : " + $("#sortflag").val());
          	    	
          	    	  fListnotice();
    	    	  }
    	      });
    
    	}
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="bd_no" name="bd_no"  value="" />
	<input type="hidden" id="swriter" value="${loginId}">
	<input type="hidden" id="sortflag" value="1">
	
	
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
		                        class="btn_nav bold">기준정보</span> <span class="btn_nav bold">공지사항</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
		                  </p>
		
		                  <p class="conTitle" style="height:100px;">
		                     <span style="line-height:100px">공지사항</span> <span class="fr">
		                     
		                     <select id="searchtype" name="searchtype" style="width: 150px;" v-model="searchKey">
			                     <option value="" >전체</option>
			                     <option value="title">제목</option>
			                     <option value="contents">내용</option>
		                  	</select>
		                   
		                  <input type="text" id="searchvalue" name="searchvalue" style="width: 180px; height: 28px;margin:10px 10px;">
		                  	<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a><br>
		                      <a class="btnType blue" style= "float:right" href="javascript:fPopModal();" name="modal"><span>신규등록</span></a>
		                     </span>
		                  </p>
	                           
						<div class="divNoticeList">
							<table class="col" id="dateDay">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="35%">
									<col width="20%">
									<col width="20%">
									<col width="15%">
								</colgroup>
								
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col" id="date1">등록일<a href="javascript:sortnotice();" style="float:right;">
										<div id="noticesort">◈</div></th>
										<th scope="col">조회수</th>
									</tr>
								</thead>
								<tbody id="listNotice"></tbody>
							</table>
						</div>
									<!--// 공지사항 테이블 페이지 네비게이션 -->
						<div class="paging_area"  id="comnfileuploadPagination"> </div>
						
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
 
  	<!-- 모달팝업 -->
<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				
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
							<th> <strong id="noticeNo"></strong> <strong id="noticeTitle">제목</strong></th>
							<td><input type="text" class="inputTxt p100" name="title" id="title" /></td>
						</tr>
							<th><strong>작성자</strong></th>
							
							<td style="display:flex; justify-content:space-between; line-height:27px;">
							 	<strong><span id="noticeWriter"></span></strong>
							 	<span>
								<strong>등록일 :<span id="noticeDate"></span></strong>           
								<strong>조회수 :<span id="noticeCnt"></span></strong>
								</span>							
							</td>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td>
							     <textarea class="inputTxt p100"	name="cont" id="cont" > </textarea>
						   </td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30" style="display:flex; justify-content:space-between;">
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>목록보기</span></a> 
					<span>
					<a href="" class="btnType blue" id="btnInsert" name="btn"><span>등록</span></a>
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>수정</span></a>
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
					</span> 
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div> 

	<!--// 모달팝업 -->
</form>
</body>
</html>