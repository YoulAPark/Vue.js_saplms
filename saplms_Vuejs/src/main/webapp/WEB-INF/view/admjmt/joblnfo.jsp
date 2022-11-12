<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>취업정보</title>

<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
 
<script type="text/javascript">

	var pagesize = 7;  // 페이지 보여지는것
	var pagenumsize = 5; // 페이징 처리 5개
	
	/** OnLoad event */ // OnLoad(시작하자마자)
	$(function() {
		
		// 게시판 조회
		fListjoninfo();
		
		fRegisterButtonClickEvent(); // 버튼이벤트
		
		sortjobinfo(); // 오름차순내림차순 액션
		
		$("#searchvalue").keydown(function (key) { // 빈text 키값을 입력하면
	        if (key.keyCode == 13) { // 13 엔터키
	            $("#btnSearch").click(); // 검색버튼 클릭시 
	        }
    });
		$("#searchvalue").focus(); // OnLoad시 빈text에 포커스 
	
	});
	
	function fListjoninfo(clickpagenum) { // 리스트 재조회 액션
		
		clickpagenum = clickpagenum || 1; // 클릭페이지넘버가  또는 어느하나가 1이면 보여줘라
		
		var param = {
				searchtype : $("#searchtype").val() ,  // 셀렉터박스
				searchvalue : $("#searchvalue").val() , // 화면  텍스트
				datepicker1 : $("#datepicker1").val() , // 취업일 시작년도 텍스트
				datepicker2 : $("#datepicker2").val() , // 취업일 라스트년도 텍스트
				sortflag : $("#sortflag").val(), // 메퍼에 오름차순내림차순 비교하는 일종의 서치타입
				clickpagenum : clickpagenum, // 클릭넘버페이지
				pagesize : pagesize // 보여지는 페이즈 레코드 수
		};
		
		var searchcallback = function(returndata) {  // returndata 사용자가 정하는 임의변수
			console.log("returndata : " + returndata);
			
			searchcallbackprocess(returndata,clickpagenum); // 페이징 처리
			
		}
		
		callAjax("/careerA/listjobInfoMgt.do", "post", "text", true, param, searchcallback);
				
	}
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) { // a 태그에 name이 btn값이 클릭액션시
			e.preventDefault(); // 중복액션방지

			var btnId = $(this).attr('id');
			
			switch (btnId) {
				case 'btnSearch' : // 검색 버튼
					fListjoninfo(); // 페이지 재조회
					break;
				case 'btnDelete' : // 삭제 버튼
					$("#action").val("D"); // 모달 닫기
					fsavejoninfo(); // 페이지 재조회
					break;
				case 'btnSave' : // 수정 버튼
					fsavejoninfo(); // 모달 닫기
					break;
				case 'btnInsert' : // 등록 버튼
					fsavejoninfo(); // 모달 닫기
					break;
				case 'btnClose' : // 목록보기 버튼
					gfCloseModal(); // 모달 닫기
					break;	
					
					
				
			}
		});
	}
	 //   페이징 처리 
	function searchcallbackprocess(returndata,clickpagenum) {
		
		$("#listjobInfo").empty().append(returndata); // tbody 리스트 . 초기화 . returndata가 추가
		
		var totalcnt = $("#searchlistcnt").val(); // searchlistcnt(controller에서받은걸)는 list.jsp에 있는 총 페이지를 totalcnt에 넣고
		
		var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fListjoninfo');
		// (클릭한 넘버페이지, 총갯수페이지, 보여지는레코드수, 네비갯수넘버, 페이지재조회)
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnfileuploadPagination").empty().append( paginationHtml );
		
		$("#hclickpagenum").val(clickpagenum);
	}
	
    $(function() {
        $("#datepicker1, #datepicker2").datepicker({ 
        	// datepicker1,datepicker2 text에id인데 이것이 화면에 보여줄떄  연도-월-일로 보여지게  아래있는 - 를 . 으로 바꾸면 연도.월.일 로 바뀜
            dateFormat: 'yy-mm-dd'
    
        	
           
        });
        
    });
     //             오름차순   내림차순 
     function sortjobinfo() {
    	   
    	      $("#jobinfosort").click(function(e) {
    	    	  
    	    	  e.preventDefault();  // 이벤트 동시 방지 기능
    	    	  
    	    	  //console.log("sortflag : " + $("#sortflag").val());
    	    	  
    	    	  if($("#sortflag").val() == "1") { // sortflag.val()값이 1번이미지와 같다면 아래 와 같이 실행해라
    	    		 //console.log("11111111111111111111111111111");
    	    		  
    	    		   //화살표 이미지 변경
    	    		  /* $("#jobinfosort").empty().append("<img src='/images/2.png' style='width:20px; height:20px'>");  */
    	    		  $("#jobinfosort").empty().append("▼"); 
    	    		   // (들어갈위치 id).초기화.(여기에있는데이터)를 들어갈위치id에 추가
        	    	  $("#sortflag").val("2");
        	    	  
        	    	  //console.log("sortflag after : " + $("#sortflag").val());
        	    	  
        	    	  fListjoninfo(); // 리스트 조회
        	    	  	  
   	    	  
    	    	  } else if($("#sortflag").val() == "2"){
    	    		 // console.log("22222222222222222222222222222");
    	    		//화살표 이미지 변경
    	    	      /* $("#jobinfosort").empty().append("<img src='/images/3.png' style='width:20px; height:20px'>"); */
    	    	      $("#jobinfosort").empty().append("▲"); 
        	    	  $("#sortflag").val("3");
        	    	  	
        	    	  //console.log("sortflag after : " + $("#sortflag").val());
        	    	  
        	    	  fListjoninfo(); // 리스트 조회
        	    	  
    	    	  	} else if($("#sortflag").val() == "3"){
    	    	  		//console.log("3333333333333333333333333333");
    	    	  	//화살표 이미지 변경
    	    	  	 /*  $("#jobinfosort").empty().append("<img src='/images/1.png' style='width:20px; height:20px'>"); */
    	    	  	 $("#jobinfosort").empty().append("◆"); 
          	    	  $("#sortflag").val("1");
          	    		
          	    	  //console.log("sortflag after : " + $("#sortflag").val());
          	    	
          	    	fListjoninfo(); // 리스트 조회
    	    	  }
    	      });
    
    	}
	     function fPopModal() {		// 신규등록 버트에 모달
	 		$("#action").val("I");
	 		
	 		fn_forminit();
	 		
	 		gfModalPop("#layer1");
	 		
	 	}  
	     
	     function fn_forminit(object) {
				
	 		if (object == null || object=="") {
	 			$("#joninfoWriter").val(""); // 작성자id 텍스트
	 			$("#joninfoNo").val(""); // 입사일 텍스트
	 			$("#joninfopd").val(""); // 퇴사일 텍스트
	 			$("#comname").val(""); // 업체명 텍스트
	 			$("#typeyu").val(""); // 재직여부 텍스트
	 			$("#btnSave").hide();  // 수정버튼
	 			$("#btnDelete").hide(); // 삭제버튼
	 			$("#btnInsert").show(); // 저장(등록)버튼
	 			
	 		} else {
	 			$("#joninfoWriter").val(object.loginID); // 작성자id 텍스트
	 			$("#joninfoNo").val(object.em_date); // 입사일 텍스트
	 			$("#joninfopd").val(object.em_redate); // 퇴사일 텍스트
	 			$("#comname").val(object.em_nm); // 업체명 텍스트
	 			$("#typeyu").val(object.em_du); // 재직여부 텍스트
	 			$("#btnDelete").show(); // 삭제버튼
	 			$("#btnSave").show();  // 수정버튼
	 			$("#btnInsert").hide(); // 저장(등록)버튼
	 			$("#joninfoWriter").focus();
	 			
	 			$("#em_no").val(object.em_no); // 번호 텍스트
	 		}

	 		
	 	}
	     
	   //단건조회 함수
	 	function fselectone(em_no) {
	 		
	 		var param = {
	 				em_no : em_no // 강의코드넘버로 한 레코드 검색
	 		}
	 	
	 	
	 		var searchcb = function( selectonersn ) { // selectonersn은 사용자가 임의로 정하는 변수명
	 			console.log(JSON.stringify(selectonersn));
	 			//console.log(JSON.stringify(selectonersn.searchone));
	 			
	 			$("#action").val("U");	 
	 			fn_forminit(selectonersn.searchone); // 변수명.serchone 키값이다
	 			
	 			gfModalPop("#layer1"); // 모달 액션
	 		
	 	}
	 		
	 	callAjax("/careerA/selectJobinfo.do", "post", "json", true, param, searchcb);
	   }
	     
	  // 업데이트(등록,수정) 하는  메소드
	 	function fsavejoninfo() {
	 		
	 		var param = {
	 				em_no : $("#em_no").val(),
	 				joninfoWriter : $("#joninfoWriter").val(), // 작성자id 텍스트
	 				joninfoNo : $("#joninfoNo").val() , // 입사일 텍스트
	 				joninfopd : $("#joninfopd").val() , // 퇴사일 텍스트
	 				comname : $("#comname").val() , // 업체명 텍스트
	 				typeyu : $("#typeyu").val() , // 재직여부 텍스트
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
	 			
	 			fListjoninfo(savepageno);
	 			
	 		}
	 		callAjax("/careerA/savejobInfo.do", "post", "json", true,  $("#myForm").serialize(), savecallback);
	 	}
</script>
</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="em_no" name="em_no"  value="" />
	<input type="hidden" id="sortflag" value="1">
	<!-- 히든값들은 화면에는 보이지는 않지만 param값에 강제로 넣어 controller나 mapper(매퍼)에 값을 전달해주기 위함이다  -->
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
								class="btn_nav bold">취업관리</span> <span class="btn_nav bold">취업정보</span> 
								<a href="../careerA/jobInfoMgt.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle">
							<span>취업정보</span> <span class="fr"></span>
						</p>
						<p>						<!-- searchtype  -->
							<select id="searchtype" name="searchtype" style="width: 150px;" v-model="searchKey">
			                     <option value="" >전체</option>
			                     <option value="company">회사명</option>
			                     <option value="student">학생명</option>
		                  	</select>
						 <input type="text" style="margin:20px; width: 150px; height: 25px;" id="searchvalue" name="searchvalue">
						 <input type="text" style="margin:20px;width: 50px; height: 25px;" id="calendar" name="calendar" value="취업일">
						                <!--                      달력위치                                                 -->
							    <input type="text" style="margin:10px; width:150px; height:25px;"" id="datepicker1" autocomplete="off"> ~
    							<input type="text" style="margin:10px; width:150px; height:25px;" id="datepicker2" autocomplete="off">
					
						
						
						
		                           <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
		                           <a class="btnType blue" href="javascript:fPopModal();" name="modal"><span>신규등록</span></a>
	                	</p>      
                        
						<div class="divJobInfoList" style="overflow:auto; height:270px;">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
							</colgroup>
	
								<thead>
									<tr class="so1">
										<th scope="col">번호</th>
										<th scope="col">학생명</th>
										<th scope="col">입사일<a href="javascript:sortjobinfo();" style="float:right;">
										<div id="jobinfosort"><!-- <img src="/images/1.png" style="width:20px; height:20px"> -->◆</div></th>
										<th scope="col">퇴사일</th>
										<th scope="col">업체명</th>
										<th scope="col">재직여부</th>
									</tr>
								</thead>
								<tbody id="listjobInfo"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="comnfileuploadPagination"> </div>
					</div>
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
							<th scope="row">ID</th>
							<td>
								<input type="text" id="joninfoWriter" name="joninfoWriter" class="inputTxt p70">
							</td>
						</tr>
						<tr>
							<th scope="row"><strong>입사일</strong></th>
								<td>
									<input type="text" class="inputTxt p70" id="joninfoNo" name="joninfoNo" />	
								</td>
						</tr>
						<tr>
							<th scope="row">퇴사일</th>
								<td>
									<input type="text" class="inputTxt p70" id="joninfopd" name="joninfopd" />
								</td>
						</tr>
						<tr>
							<th scope="row">업체명</th>
							<td>
							 	<input type="text" class="inputTxt p70" id="comname" name="comname" />					
							</td>
						</tr>
						<tr>
							<th scope="row">재직여부</th>
							<td>
								<input type="text" class="inputTxt p30" id="typeyu" name="typeyu" />
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