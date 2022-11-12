<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>수강인원</title>
<!-- 캘린더 -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css"/>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<%-- <!-- chart import -->
<script type="text/javascript" src="${CTX_PATH}/js/apexcharts/apexcharts.js"></script>

<!-- chart import css-->
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/apexcharts/apexcharts.css">

<!-- font awesome css -->
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/js/statistics/css/font-awesome.min.css">

<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.js"></script> --%>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- sweet swal import -->
<script type="text/javascript">
	
	var pagesize = 5;
	var pagenumsize = 5;
	
	/** OnLoad event */ 
	$(function() {
		
		// 게시판 조회
		fListleccnt();
		
		admstatRegisterButtonClickEvent();
	});

	// 차트
	
	//console.log( 'value.li_nm:' + value.li_nm + ' / ' + 'value.li_ap:' + value.li_ap  + ' / ' + 'value.li_garden:' + value.li_garden ); 
	
	function drawgo(titlenm,titleap,titlegarden) {
		
	  //라이브러리 load
	  google.charts.load('current', {'packages':['corechart', 'bar']});
      google.charts.setOnLoadCallback(drawChart);
      
      function drawChart() {
    	  
        var data = [];
    	      
    	var Header= ['강의', '신청인원', '정원'];      
    	data.push(Header);      
    	
       for(i = 0; i < titlenm.length; i++) {
    	   var temp=[];
    	   temp.push(titlenm[i]);
    	   temp.push(titleap[i]);
    	   temp.push(titlegarden[i]);
    	   data.push(temp);   
       }
    
       var chartdata = new google.visualization.arrayToDataTable(data);
       
		// 옵션 세팅
        var options = {
           chart: {
            title: '수강인원차트'
          }
        };
		// 차트 그리기
        var chart = new google.charts.Bar(document.getElementById('chart_div'));

        chart.draw(chartdata, google.charts.Bar.convertOptions(options));
      }}

    	
	
	/** 버튼 이벤트 등록 */
	function admstatRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
			
			switch (btnId) {
				case 'btnSearch' :
					fListleccnt();
					break;				
			}
		});
	}
	
	
	
	// 목록 조회
	function fListleccnt(clickpagenum) {
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
				startdate : $("#startdate").val(),
				enddate : $("#enddate").val(),
				clickpagenum : clickpagenum,
				pagesize : pagesize
		};
		
		var searchcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			searchcallbackprocess(returndata,clickpagenum);
			
		}
		
		callAjax("/statistics/listLecCnt.do", "post", "text", true, param, searchcallback);
		
		
	}
	
	// 목록 콜백 함수
	function searchcallbackprocess(returndata,clickpagenum) {
		
		$("#listleccnt").empty().append(returndata);
		
		var totalcnt = $("#searchlistcnt").val();
		
		var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fListleccnt');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnleccntPagination").empty().append( paginationHtml );
		
		$("#hclickpagenum").val(clickpagenum);
		
		//if(totalcnt > 0) {
		//	drawgo($("#flinm").val(),$("#fliap").val(),$("#fligarden").val());
		//}
		
		fListlecchart(clickpagenum);
	}
	// 차트 목록 조회
	function fListlecchart(clickpagenum) {
		
		
		var param = {
				startdate : $("#startdate").val(),
				enddate : $("#enddate").val(),
				clickpagenum : clickpagenum,
				pagesize : pagesize
		};
		
		var searchcallback = function(returndata) {
			console.log("returndata : " + JSON.stringify(returndata) );
			
		//	searchcallbackprocess(returndata,clickpagenum);
			
			drawgocallbackprocess(returndata,clickpagenum);
			
		}
		
		callAjax("/statistics/listLecCntchart.do", "post", "json", true, param, searchcallback);
		
		
	}	
 	// 차트 목록 콜백 함수
	function drawgocallbackprocess(returndata,clickpagenum) {

		var flinmArray1 = new Array();
		var fliapArray1 = new Array();
		var fligardenArray1 = new Array();
 		
		$.each( returndata.searchlist, function( key, value ){ 
			console.log( 'key:' + key);
			console.log( 'value:' + JSON.stringify(value));
			
			flinmArray1.push(value.li_nm);
			fliapArray1.push(value.li_ap);
			fligardenArray1.push(value.li_garden);
			
			
		    console.log( 'value.li_nm:' + value.li_nm + ' / ' + 'value.li_ap:' + value.li_ap  + ' / ' + 'value.li_garden:' + value.li_garden ); 
		});
 		
 		
		drawgo(flinmArray1, fliapArray1 ,fligardenArray1);
		//fListlecchart();
	} 
	
</script>
</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="li_no" name="li_no"  value="" />
	<input type="hidden" id="titlenm" name="titlenm"  value="" />
	<input type="hidden" id="titleap" name="titleap"  value="" />
	<input type="hidden" id="titlegarden" name="titlegarden"  value="" />
	
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
								class="btn_nav bold">통계</span> <span class="btn_nav bold">수강인원</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>수강인원</span> <span class="fr">
							</span>
						</p>
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
	                        <tr style="border: 0px; border-color: blue">
	                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
	                           		<input type="text" style="width: 60px; height: 25px; border:none; font-weight:bold;" placeholder="개설기간 : " readonly>
	                           		&nbsp;
	     	                        <!-- 캘린더 -->
								    <input type="date" style="width: 100px; height: 25px;" placeholder="0000-00-00" id="startdate" name="startdate">&nbsp; ~ &nbsp;
								    <input type="date" style="width: 100px; height: 25px;" placeholder="0000-00-00" id="enddate" name="enddate">&nbsp;
		                           <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
	                           </td> 
	                           
	                        </tr>
                        </table> 
                        
						<div class="divleccntList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">과목명</th>
										<th scope="col">강의시작</th>
										<th scope="col">강의종료</th>
										<th scope="col">신청인원</th>
										<th scope="col">정원</th>
									</tr>
								</thead>
								<tbody id="listleccnt"></tbody>
								<tbody id="listlecchart"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="comnleccntPagination"> </div>
						
							 					    
						<!-- Column Chart -->
					 	<div id="chart_div" style="width: 1000px; height: 400px;"></div>

          		 

						
					</div> <!--// content -->
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</form>
</body>
</html>