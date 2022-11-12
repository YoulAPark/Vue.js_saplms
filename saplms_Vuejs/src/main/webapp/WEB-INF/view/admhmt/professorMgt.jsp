<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>강사관리</title>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
	
	var pagesize = 15;
	var pagenumsize = 5;
	
	/** OnLoad event */ 
	$(function() {
	
		comcombo("areacd", "address", "sel", "");
		comcombo("Class", "cclass", "sel", "");
		
		// 게시판 조회
		fProfessorList();
		
		fRegisterButtonClickEvent();
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearch' :
					fProfessorList();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
				case 'btnCloseLsmCod' :
					gfCloseModal();
					break;
				case 'btnRegisterCom' :
					CompleteRegister();
					break;
			}
		});
	}
	
	function fProfessorList(clickpagenum) {
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
				professorName : $("#professorName").val(),
				startDate : $("#startDate").val(),
				endDate : $("#endDate").val(),
				clickpagenum : clickpagenum,
				pagesize : pagesize
		};
		
		var searchcallback = function(returndata) {
			console.log("returndata : " + returndata);
			
			searchcallbackprocess(returndata,clickpagenum);
			
		}
		
		callAjax("/peopleA/professorList.do", "post", "text", true, param, searchcallback);
		
		
	}
	function searchcallbackprocess(returndata,clickpagenum) {
			
			$("#listProfessor").empty().append(returndata);
			
			var totalcnt = $("#searchlistcnt").val();
			
			var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fProfessorList');
			console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			$("#comnfileuploadPagination").empty().append( paginationHtml );
			
		}
	
	function fRegister() {
		$("#action").val("I");
		gfModalPop("#layer1");
	}
	
	function RegisterVal(){
		  
		var user_type = $('D').val();
		var loginID = $('#loginID').val();
		var password = $('#password').val();
		var passwordOk = $('#passwordOk').val();
		var name = $('#name').val();
		var sex = $('#sex').val();
		var user_email = $('#email').val();
		var address = $('#address').val();
		var tel1 = $('#tel1').val();
		var tel2 = $('#tel2').val();
		var tel3 = $('#tel3').val();
		var cclass = $('#cclass').val();
		
		if(loginID.length < 1){
			swal("아이디를 입력하세요.").then(function() {
				$('#loginID').focus();
			  });
			return false;
		}
		
		if(password.length < 1){
			swal("비밀번호를 입력하세요.").then(function() {
				$('#password').focus();
			  });
			return false;
		}
		
		if(passwordOk.length < 1){
			swal("비밀번호 확인을 입력하세요.").then(function() {
				$('#passwordOk').focus();
			  });
			return false;
		}
		
		if(password != passwordOk){
			swal("비밀번호가 맞지 않습니다.").then(function() {
				$('#password').focus();
			  });
			return false;
		}
		
		if(name.length < 1){
			swal("이름을 입력하세요.").then(function() {
				$('#name').focus();
			  });
			return false;
		}
		
		if(user_email.length < 1){
			swal("이메일을 입력하세요.").then(function() {
				$('#email').focus();
			  });
			return false;
		}
		
		if(address.length < 1){
			swal("거주지역을 선택하세요.").then(function() {
				$('#address').focus();
			  });
			return false;
		}
		
		if(tel1.length < 1){
			swal("전화번호를 입력하세요.").then(function() {
				$('#tel1').focus();
			  });
			return false;
		}
		
		if(tel2.length < 1){
			swal("전화번호를 입력하세요.").then(function() {
				$('#tel2').focus();
			  });
			return false;
		}
		
		if(tel3.length < 1){
			swal("전화번호를 입력하세요.").then(function() {
				$('#tel3').focus();
			  });
			return false;
		}
		
		return true;
		
	}
	
	function loginIdCheck(){
		
		var data = {"loginID" : $("#loginID").val()};
		
		var idRules =  /^[a-z0-9]{6,20}$/g ;
		var id = $("#loginID").val();

		/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
		$.ajax({
			url : '/check_loginID.do',
			type : 'post',
			data : data,
			dataType : 'text',
			async : true,
			success : function(data) {
				if($("#loginID").val()==""){
					console.log("입력 아이디 없음");
					swal("아이디를 입력해주세요.").then(function(){
						$("#loginID").focus();
					});
					$("#ckIdcheckreg").val("0");
				}
				 else if (data==1){
					console.log("아이디 있음");
					swal("중복된 아이디가 존재합니다.").then(function(){
						$("#loginID").focus();
					});
					console.log(data);
					$("#ckIdcheckreg").val("0");
				} else if(!idRules.test($("#loginID").val())){
					swal('아이디는 숫자,영문자 조합으로 6~20자리를 사용해야 합니다.').then(function(){
						$("#loginID").focus();
					});
					$("#ckIdcheckreg").val("0");
					return false;
				} else if(data == 0){
					console.log("아이디 없음");
					swal("사용할 수 있는 아이디 입니다.");
					$("#ckIdcheckreg").val("1");
				}
			}
		});
	}
	
	function loginIdCheckComplete(){
		
		var data = {"loginID" : $("#loginID").val()}
		
		var idRules =  /^[a-z0-9]{6,20}$/g ;
		var id = $("#registerId").val();

		/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
		$.ajax({
			url : '/check_loginID.do',
			type : 'post',
			data : data,
			dataType : 'text',
			async : false,
			success : function(data) {
				if (data == 1){
					$("#ckIdcheckreg").val("0");
					console.log("아이디 있음");
					return false;
				} else if(!idRules.test($("#registerId").val())){
					$("#ckIdcheckreg").val("0");
					return false;
				}
			}
		});
	}
	
	function emailCheck(){
		var data = {"user_email" : $("#email").val()};

		$.ajax({
			url : '/check_email.do',
			type : 'post',
			data : data,
			dataType : 'text',
			async : false,
			success : function(data) {
				if(data == 1){
					$("#ckEmailcheckreg").val("0");
					console.log("이메일 있음");
					console.log(data);
					return false;
				} else {
					$("#ckEmailcheckreg").val("1");
					console.log(data);
					console.log("이메일 없음");
				}
				
			}
		});
	}
	
	function CompleteRegister() {
		
		var param = $("#RegisterForm").serialize();
		/*패스워드 정규식*/
		var passwordRules = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	 	var password = $("#password").val();
	 	/*이메일 정규식*/
		var emailRules = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var email = $("#email").val();
		
		/*전화번호 정규식*/
		var tel1Rules = /^\d{2,3}$/;
		var tel2Rules = /^\d{3,4}$/;
		var tel3Rules = /^\d{4}$/;
		
		var tel1 = $("#tel1").val();
		var tel2 = $("#tel2").val();
		var tel3 = $("#tel3").val();
		//console.log(div_cd);
		/* validation 체크 */
		if(!RegisterVal()){
			return;
		}
			
		loginIdCheckComplete();
		emailCheck();
				 
		if (RegisterForm.ckIdcheckreg.value == "0"){
			swal("아이디 중복확인을 진행해주세요.").then(function() {
				$("#loginID").focus();
			  });
		} else if(!passwordRules.test($("#password").val())){
			swal('비밀 번호는 숫자,영문자,특수문자 조합으로 8~15자리를 사용해야 합니다.').then(function() {
				$("#password").focus();
			  });
			return false;
		} else if(!emailRules.test($("#email").val())){
			swal("이메일 형식을 확인해주세요.").then(function() {
				$("#email").focus();
			  });
		} else if(RegisterForm.ckEmailcheckreg.value =="0"){
			swal("중복된 이메일이 존재합니다. 다시 입력해주세요.").then(function() {
				$("#email").focus();
			  });
		} else if(!tel1Rules.test($("#tel1").val())){
			swal("전화번호를 확인해주세요.").then(function() {
				$("#tel1").focus();
			  });
		} else if(!tel2Rules.test($("#tel2").val())){
			swal("전화번호를 확인해주세요.").then(function() {
				$("#tel2").focus();
			  });
		} else if(!tel3Rules.test($("#tel3").val())){
			swal("전화번호를 확인해주세요.").then(function() {
				$("#tel3").focus();
			  });
		}
		else{
		
			var resultCallback = function(data) {
			fSaveRegister(data);
			}
		
		callAjax("/peopleA/pfsregister.do", "post", "json", true, param, resultCallback);
		}

	}
	
	function fSaveRegister(data) {

		if (data.result == "SUCCESS") {
			alert(data.resultMsg);
			gfCloseModal();
			fProfessorList();
		} else {
			alert(data.resultMsg);
			return false;
		}
	}
	
</script>
</head>
<body>
	<form id="myForm" action=""  method="">
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
							<span class="btn_nav bold">인원관리</span>
							<span class="btn_nav bold">강사관리</span> 
							<a href="../peopleA/professorMgt.do" class="btn_set refresh">새로고침</a>
							</p>
							<p class="conTitle">
								<span>강사 관리</span>
								<span class="fr">
									<a class="btnType blue" href="javascript:fRegister();" name="modal"><span>강사 등록</span></a>
								</span>
							</p>
							<div style= margin-bottom:5px;>
								<p>가입일자: 
									<input type="date" id="startDate" name="startDate" style="width:100px;height:20px; text-align:center;"> ~
									<input type="date" id="endDate" name="endDate" style="width:100px;height:20px; text-align:center; margin-right:30px;">
								       강사명: 
									<input type="text" id="professorName" name="professorName" style="width:100px;height:20px; margin-right:10px;">
									<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검색</span></a>
								</p>
							</div>
							<div class="divComDtlCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="5%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강사명</th>
										<th scope="col">아이디</th>
										<th scope="col">비밀번호</th>
										<th scope="col">휴대전화</th>
										<th scope="col">담당반</th>
										<th scope="col">가입일자</th>
									</tr>
								</thead>
								<tbody id="listProfessor"></tbody>
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
	</form>	
		<div id="layer1" class="layerPosition layerPop layerType2" style="width: 600px;">
      		<form id="RegisterForm" action="" method="post">
	      		<input type="hidden" name="action" id="action" value=""/>
	      		<input type="hidden" name="ckIdcheckreg" id="ckIdcheckreg" value="0"/>
	      		<input type="hidden" name="ckEmailcheckreg" id="ckEmailcheckreg" value="0"/>	
				<dl>
					<dt style="text-align:center; padding:20px;">
						<strong style="font-size:120%;">강사 등록</strong>
					</dt>
					<dd class="content">
						<!-- s : 여기에 내용입력 -->
						<table class="row">
							<caption>caption</caption>
							<colgroup>
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
								<col width="120px">					
							</colgroup>
							<tbody>
								<tr class="hidden">
									<td><input type="text" name="del_cd" id="del_cd" /></td>
							 		<td><input type="text" name="user_type" id="user_type" /></td> 
									<td><input type="text" name="approval_cd" id="approval_cd" /></td>
								</tr>
								<tr>
									<th scope="row">아이디<span class="font_red">*</span></th>
									<td colspan="2"><input type="text" class="inputTxt p100"
										name="loginID" placeholder="숫자, 영문자 조합으로 6~20자리 "
										id="loginID" /></td>
									<td><input type="button" value="중복확인"
										onclick="loginIdCheck()" style="width: 130px; height: 20px;" /></td>
								</tr>
								<tr>
									<th scope="row">비밀번호 <span class="font_red">*</span></th>
									<td colspan="3"><input type="password" placeholder="숫자, 영문자, 특수문자 조합으로 8~15자리 " class="inputTxt p100"
										name="password" id="password" /></td>
								</tr>
								<tr>
									<th scope="row" style="padding: 0 0">비밀번호 확인<span class="font_red">*</span></th>
									<td colspan="3"><input type="password" class="inputTxt p100" name="password1" id="passwordOk" /></td>
								</tr>
								<tr>
									<th scope="row" id="name_th">이름 <span class="font_red">*</span></th>
									<td><input type="text" class="inputTxt p100" name="name" id="name" /></td>
									<th scope="row" id="sex">성별</th>
									<td id="rggender_td">
									<select name="sex" id="sex" style="width: 128px; height: 28px;">
											<option value="" selected="selected">선택</option>
											<option value="male">남자</option>
											<option value="female">여자</option>
									</select></td>
								</tr>
								<tr id="birthday1">
									<th scope="row">생년월일 <span class="font_red"></span></th>
									<td><input type="date" class="inputTxt p100" name="birthday" id="birthday" style="font-size: 15px" />
								</tr>
								<tr>
									<th scope="row">이메일<span class="font_red">*</span></th>
									<td colspan="3"><input type="text" class="inputTxt p100" name="email" id="email" /> 
								</tr>
								<tr>
									<th scope="row">거주지역<span class="font_red">*</span></th>
									<td>
										<select name="address" id="address"></select>
									</td>
								</tr>
								
								<tr>
	
									<th scope="row">전화번호<span class="font_red">*</span></th>
									<td colspan="3"><input class="inputTxt"
										style="width: 90px" maxlength="3" type="text" id="tel1"
										name="tel1"> - <input class="inputTxt"
										style="width: 90px" maxlength="4" type="text" id="tel2"
										name="tel2"> - <input class="inputTxt"
										style="width: 90px" maxlength="4" type="text" id="tel3"
										name="tel3"></td>
								</tr>
								<tr>
									<th scope="row">담당 반</th>
									<td>
										<select name="cclass" id="cclass"></select>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="btn_areaC mt30">
							<a href="" class="btnType blue" id="btnRegisterCom" name="btn"><span>등록</span></a> 
							<a href="" class="btnType gray" id="btnCloseLsmCod" name="btn"><span>취소</span></a>
						</div>
					</dd>
				</dl>
				<a href="" class="closePop"><span class="hidden">닫기</span></a>
			</form>	
		</div>
</body>
</html>