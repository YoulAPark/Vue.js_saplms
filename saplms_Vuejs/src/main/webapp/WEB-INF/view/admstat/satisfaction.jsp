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
<title>Job Korea :: 만족도</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<!-- 차트 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript">
    
    
	
	

	
	
    
	// 강의목록 페이징 설정
	var pageSizeComnGrpCod = 5;
	var pageBlockSizeComnGrpCod = 5;
	
	// 수강학생 페이징 설정
	var pageSizeComnDtlCod = 5;
	var pageBlockSizeComnDtlCod = 10;
	
	
	/** OnLoad event */ 
	$(function() {
	
		// 강의목록 조회
		fsatisfactionList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		
		$('.datepicker').datepicker();
		  
		
			
		
	});
	                                 

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveGrpCod' :
					fSaveGrpCod();
					break;
				case 'btnDeleteGrpCod' :
					fDeleteGrpCod();
					break;
				case 'btnSaveDtlCod' :
					fSaveDtlCod();
					break;
				case 'btnDeleteDtlCod' :
					fDeleteDtlCod();
					break;
				case 'btnSearchGrpcod':
					fsatisfactionList();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	
	
	

	
	
	
	
	
	
	/** 강의목록 조회 */
	function fsatisfactionList(currentPage) {
		
		
		var sdate = $('#sdate');
		var edate = $('#edate');
        
		currentPage = currentPage || 1;
		
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
				sdate       :  sdate.val()
			    ,edate      :  edate.val()
			    ,currentPage : currentPage
				,	pageSize : pageSizeComnGrpCod
		}
		
		var resultCallback = function(data) {
			flistGrpCodResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/statistics/listSatisfaction.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 강의목록 조회 콜백 함수 */
	function flistGrpCodResult(data, currentPage) {
		
		
		
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listComnGrpCod').empty();
		
		// 신규 목록 생성
		$("#listComnGrpCod").append(data);
		
		// 총 개수 추출
		
		var totalCntComnGrpCod = $("#totalLecDataCod").val();
		
		
		//swal(totalCntComnGrpCod);
		
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntComnGrpCod, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fsatisfactionList');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageComnGrpCod").val(currentPage);
		
		
		
	}
	

	
	/* sv_sumcj,sv_avgcj,sv_maxcj,sv_mincj
	 */
	function drawgo(sv_sumcj,sv_avgcj,sv_maxcj,sv_mincj){
		//Load the Visualization API and the corechart package.
		google.charts.load('current', {'packages':['corechart']});
		
		$('#sv_sumcj').val(sv_sumcj)
		$('#sv_avgcj').val(sv_avgcj)
		$('#sv_maxcj').val(sv_maxcj)
		$('#sv_mincj').val(sv_mincj)
		
		
		
		
		// Set a callback to run when the Google Visualization API is loaded.
		 google.charts.load("current", {packages:['corechart']});
   		 google.charts.setOnLoadCallback(drawChart);
		
		// Callback that creates and populates a data table,
		// instantiates the pie chart, passes in the data and
		// draws it.
		function drawChart() {
			var sv_sumcj=Number($('#sv_sumcj').val())
			var sv_avgcj=Number($('#sv_avgcj').val())
			var sv_maxcj=Number($('#sv_maxcj').val())
			var sv_mincj=Number($('#sv_mincj').val())
			
			
	
		
		  // Create the data table.
		var data = google.visualization.arrayToDataTable([
                              ["Element", "Density", { role: "style" } ],
                              ["점수합계", sv_sumcj, "#b87333"],
                              ["평균점수", sv_avgcj, "silver"],
                              ["최고점수", sv_maxcj, "gold"],
                              ["최저점수", sv_mincj, "color: #e5e4e2"]
                            ]);

                            var view = new google.visualization.DataView(data);
                            view.setColumns([0, 1,
                                             { calc: "stringify",
                                               sourceColumn: 1,
                                               type: "string",
                                               role: "annotation" },
                                             2]);

                            var options = {
                              title: "만족도",
                              width: 1000,
                              height: 500,
                              bar: {groupWidth: "65%"},
                              legend: { position: "none" },
                            };
                            var chart = new google.visualization.ColumnChart(document.getElementById("chart_div"));
                            chart.draw(view, options);
                        
		}}
	
	
 
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageComnGrpCod" value="1">
	<input type="hidden" id="currentPageComnDtlCod" value="1">
	<input type="hidden" id="tmpGrpCod" value="">
	<input type="hidden" id="tmpGrpCodNm" value="">
	<input type="hidden" name="action" id="action" value="">

	<input type="hidden" id="sv_sumcj" value="">
					 				
	<input type="hidden" id="sv_avgcj" value="">
	
	<input type="hidden" id="sv_maxcj" value="">
	
	<input type="hidden" id="sv_mincj" value="">
					 				



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
								class="btn_nav bold">통계</span> <span class="btn_nav bold">만족도
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>만족도</span> 
						</p>
						
						
						<tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                    
     	                    
     	                    
							 <h5 style="font-size:20px;">개설기간</h5>     
     	                       <input type="text" style="width: 140px; height: 20px;" id="sdate" name="sdate" class="datepicker"> ~
     	                       <input type="text" style="width: 140px; height: 20px;" id="edate" name="edate" class="datepicker"> 
     	                                          
	                           <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn" style="margin-left:600px;"><span>검  색</span></a>
                           </td> 
                             
                        </tr>
                        <br> 
                        <br>
                        <h5 style="font-size:25px;">강의목록</h5>
                        <br>
                        
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="25%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">과정명</th>
										<th scope="col">기간</th>
										<th scope="col">대상자수</th>
										<th scope="col">총점수</th>
										<th scope="col">평균</th>
										<th scope="col">최대점수</th>
										<th scope="col">최소점수</th>
									</tr>
								</thead>
								<tbody id="listComnGrpCod"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="comnGrpCodPagination"> </div>
			
				
		
			
			 		<div id="chart_div"></div>
			
			
			
			
			
			
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>


</form>

			
</body>
</html>