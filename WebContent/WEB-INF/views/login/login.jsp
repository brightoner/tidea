<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/resources/css/reset.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/test.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="/resources/fontawesome/css/all.css">
<link rel="shortcut icon"    href="/resources/images/favicon.ico">
<link rel="icon"    href="/resources/images/favicon.ico">
<script src="/js/jquery-1.10.2.js"></script>
<script src="/js/common.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$(document).ready(function() {
		var errorCode = '${loginErrorCode}';
		if(errorCode == ''){
			errorCode = '${param.loginErrorCode}';
		}
		if(errorCode == 'ID_ERROR'){
			alert('아이디가 존재하지 않습니다.');
		}else if(errorCode == 'PW_ERROR'){
			alert('비밀번호 5회 실패로 10분후 로그인이 가능합니다.');
		}
// 		else if(errorCode = "pwdCnt_ERROR"){
// 			alert('비밀번호 5회 실패로 10분후 로그인이 가능합니다.');
// 		}
		else if(errorCode == 'SS_ERROR'){
			alert('세션이 종료되었습니다.');
		}else if(errorCode == 'CONFIRM_ERROR'){
			alert('미승인상태입니다.');
		}
	});
	function fn_login(){
		var loginId = $('#USER_ID').val();
		var loginPw = $('#USER_PWD').val();
		
		if(loginId == ''){
			alert('아이디를 입력하세요.');
			return;
		}
		
		if(loginPw == ''){
			alert('비밀번호를 입력하세요.');
			return;
		}
		
		//*********** 사용여부 확인 ajax필요 ex) 사용여부가 N 이면 alert 띄우기 **********************
// 		$.ajax({
// 			url : '/login/useAtCheck.do',
// 			data : {USER_ID:loginId, USER_PWD:loginPw},   //전송파라미터
// 			type : 'POST',
// 			dataType : 'json',
// 			success : function(result) {
// 				var d = result.useAtCheck;
// 				console.log(d);
// 				if(d == "OK"){
// 					return true;
// 				}else{
// 					alert("회원가입승인 대기중 입니다..");
// 					return false;
// 				}
// 			},
// 			error : function() { // Ajax 전송 에러 발생시 실행
// 				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
// 			},
// 			complete : function(result) { // success, error 실행 후 최종적으로 실행
				
// 			}
// 		});
		//*******************************************************************************
		
		$('#form').attr('action', '/login/goLogin.do');
		$('#form').submit();
		pageLoadingShow();
	}
	
	
	//회원가입
	function fn_regist(){
		$('#form').attr('action', '/regist/regist.do');
		$('#form').submit();
	}
	//아이디 비밀번호 찾기
	function fn_idPwFind(){
		$('#form').attr('action', '/regist/idPwFind.do');
		$('#form').submit();
	}
	
	
	function fn_down(){
		location.href="/commonSh/pdfdownload.do";
	}
	
	function enterkey() {
        if (window.event.keyCode == 13) {
 
             // 엔터키가 눌렸을 때 실행할 내용
             fn_login();
        }
}


</script>
<title>티디아 우선심사 시스템</title>
<style>
	html{
		background:#213152;
	}
</style>

</head>
<body class="login_page">
	<div class="login_header boxshadow">
		<div class="login_logo">
<!-- 			<a href=""><img src="/resources/images/ras_logo.png"></a> -->
			<a href=""><img src="/resources/images/tidea_logo.png"></a>
			<p><b>티디아 <span>우선심사시스템</span>에 오신것을 환영합니다.</b></p>
		</div>
		
	</div>
	<div class="login_body">
		<div class="login_box relative">
			<form id="form" name="form" method="post">
				<input type="text" id="USER_ID" name="USER_ID" placeholder="아이디" class="login_id" value=""><i class="fas fa-user absolute"></i>
				<input type="password" id="USER_PWD" name="USER_PWD" placeholder="비밀번호" onkeyup="enterkey();" class="login_pw" value=""><i class="fas fa-unlock-alt absolute"></i><br>
			</form>
			<button type="button" class="clear login_button" onclick="javascript:fn_login();"><b>로 그 인</b></button>
			
			<!-- 202111 -->
			<button type="button" class="clear login_button" onclick="javascript:fn_regist();" style="margin-top: 5px;"><b>회원가입</b></button>
			<button type="button" class="clear login_button" onclick="javascript:fn_idPwFind();" style="margin-top: 5px;"><b>아이디/비밀번호 찾기</b></button>
			
			
		</div>
	</div>
	<div class="footer login_footer">
<!-- 		<div class="foot_text"> -->
		<div>
			<p>
				<font color="white">
					상호명 : (주)티디아   |   대표 : 이상호   |   사업자등록번호 : 877-81-02483<br>
					주소 : 대전시 유성구 갑천로 361-39, 201호 | Tel: 042-934-2021   |   Fax: 042-862-7562   |   <a href="mailto:tidea@tidea.co.kr" target="_blank"><font color="white">tidea@tidea.co.kr</font></a><br>
				</font>
			</p>
			<p class="copy">
				<font color="white">copyrights 2021 TIDEA . All rights reserved. </font>
			</p>
		</div>
	</div>
</body>
</html>