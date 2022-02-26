<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	request.setCharacterEncoding("UTF-8");
%>


<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
	input::placeholder {
	  color: #66666673;
	  font-style: italic;
	}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		
		// 컴포넌트 호출
		fn_searchCompoSetting();
		
		// 검색조건 유지
		if('${param.searchYn}' != 'Y'){return}
		$('#ANNOUNCE_NO').val('${param.ANNOUNCE_NO}');
	});
	
	// 검색영역 설정
	function fn_searchCompoSetting(){
		fn_compoInputbox('M', 'S', 'search_2_2', 'SEARCH_USR_NM', 'SEARCH_USR_NM', '', '성명', '', '30');
	}
	
			
	// 목록으로 돌아가기
	function fn_goList(){
// 		javascript:history.back();
		form.action = "/sample/samplemain.do";
		goSubmit(form);
	}
	
	
	// 저장 버튼
	function fn_save(){
		
		// 비밀번호 필수값 체크, 정규식 체크	- 영문, 숫자, 특수문자를 조합한 9~20자리
		var pwVal = $("#USER_PWD").val(); 
		var pwReg = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{9,20}$/; // 검증에 사용할 정규식 변수 regExp에 저장 
		if (pwVal.match(pwReg) == null || pwVal.match(pwReg) == '' || pwVal == null || pwVal == '') { 
			alert('비밀번호 형식에 맞춰 입력해 주세요.'); 
			$('#USER_PWD').val('');
			$('#USER_PWD').focus();
			return;
		}	
		if($('#USER_PWD_CFM').val() == ''){
			alert('비밀번호 확인을 입력해 주세요!');
			$('#USER_PWD_CFM').focus();
			return false
		}
		
		if($('#USER_PWD').val() != '' && $('#USER_PWD_CFM').val() != ''){
			if($('#USER_PWD').val() != $('#USER_PWD_CFM').val()){
				$('#USER_PWD_CFM').focus();
				alert('새 비밀번호와 확인이 서로 다릅니다. 다시 입력해 주세요!.');		// 신규입력 시
				return;
			}
		}
		
		
		//"저장하시겠습니까?" 메시지
		var result = confirm(gb_saveMsg);
		if(result){
			form.action = "/regist/updatePw.do";
			goSubmit(form);
		}
	}
	
	
	// 승인 버튼
	function fn_approval(){
		
	}
	
</script>

<title>티디아 우선심사 시스템</title>
</head>
<body>
	<form name="form" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
		<!-- KEY 컴포넌트가 없는 경우 hidden 생성 -->
		<input type="hidden" name="KEY" />
		
		<!-- 컴포넌트 사용을 위한 include jsp -->
		<jsp:include flush="false" page="../common/commonComponent.jsp"></jsp:include>
		
		<div class="title_name relative">
			<!-- 각종 특강 등록 -->
			
			<c:out value="${SS_ACTIVE_SUB_MENU_NM }" />
<%-- 			<c:out value="회원정보 수정" /> --%>
			<div class="navi absolute">
				<span><a href=""><img width="15" class="home_icon" src="/resources/images/home.png"></a></span>>
				<span><a href=""><c:out value="${SS_ACTIVE_TOP_MENU_NM }" /></a></span> > 
<%-- 				<span><a href=""><c:out value="회원정보 수정" /></a></span> >  --%>
				<span><a href=""><c:out value="${SS_ACTIVE_SUB_MENU_NM }" /></a></span>
<%-- 				<span><a href=""><c:out value="회원정보 수정" /></a></span> --%>
			</div>
		</div>
		
		<div class="box-blue-line clear relative">
			<!-- 상단버튼 영역 -->
			<div id="buttonDivBox" class="button_box">
				<button type="button" id="saveBtn" onclick="javascript:fn_save();return false;"><span></span>저장</button><!-- 저장버튼 -->
				<button type="button" id="goListBtn" onclick="javascript:fn_goList();return false;"><span></span>다음에 변경하기</button><!-- 목록	 -->
			</div>
			<!-- 상단버튼 영역 END -->
			
			<!-- 조회조건 영역 -->
			<div id="searchDivBox" style="padding: 7px 10px; margin: 28px;">
			</div>
			<!-- 조회조건영역 END -->
			
			<!-- 그리드 영역 -->
			<div id="grid"></div>
			<!-- 그리드 영역 END -->

			<!-- 입력 및 상세영역 -->
			<div id="inputNdetailDivBox" class="inputNdetail">
				<p class="title"><span>비밀번호 수정</span></p>
				<div class="inputNdetail_box">
					
					<div class="row clear">
						<div id="inputNdetail_1_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>비밀번호</p>
							<div class="right">
								<input type="password" id="USER_PWD" name="USER_PWD" value="" maxlength="30" style="ime-mode:active" placeholder="영문, 숫자, 특수문자를 조합한 9~20자리">
							</div>
						</div>
						
						<div id="inputNdetail_1_2" class="col clear">
							<p class="left">비밀번호확인</p>
							<div class="right">
								<input type="password" id="USER_PWD_CFM" name="USER_PWD_CFM" value="" maxlength="30" style="ime-mode:active">
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</form>
</body>
</html>