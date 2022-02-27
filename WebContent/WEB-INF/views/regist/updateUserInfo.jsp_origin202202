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
	
	
	// 비밀번호변경
	function fn_pwChange(){
		form.action = "/regist/updatePw1.do";
		goSubmit(form);
	}
			
	// 목록으로 돌아가기
// 	function fn_goList(){
// 		javascript:history.back();
// 	}
	
	
	// 저장 버튼
	function fn_save(){
		

		var nmVal = $("#USER_NM").val(); 
		var nmReg = /^[가-힣]{2,5}$/; // 검증에 사용할 정규식 변수 regExp에 저장 
		if (nmVal.match(nmReg) == null || nmVal.match(nmReg) == '' || nmVal == null || nmVal == '') { 
			alert('이름 형식에 맞춰 입력해 주세요.'); 
			$('#USER_NM').val('');
			$('#USER_NM').focus();
			return;
		} 
		
		//생년월일 필수값체크, 정규식 체크  - 형식 : 0000-00-00
// 		var mpVal = $("#BIRTH").val(); 
// 		var birthReg = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/; // 검증에 사용할 정규식 변수 regExp에 저장 
// 		if (mpVal.match(birthReg) == null || mpVal.match(birthReg) == '' || mpVal == null || mpVal == '') { 
// 			alert('생년월일 형식에 맞춰 입력해 주세요.'); 
// 			$('#BIRTH').val('');
// 			$('#BIRTH').focus();
// 			return;
// 		}
		
		//이메일  필수값체크, 정규식 체크 - 형식 :aaa@bbb.ccc
		var emailVal = $("#EMAIL").val(); 
		var emailReg = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/; 
		if (emailVal.match(emailReg) == null || emailVal.match(emailReg) == '' || emailVal == null || emailVal == '') { 
			alert('이메일 형식에 맞춰 입력해 주세요.'); 
			$('#EMAIL').val('');
			$('#EMAIL').focus();
			return;
		}
		
		// 핸드폰번호 필수값체크, 정규식 체크 - 형식 : 000-0000-0000
		var mpVal = $("#MOBILE").val(); 
		var mpReg = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/; // 검증에 사용할 정규식 변수 regExp에 저장 
		if (mpVal.match(mpReg) == null || mpVal.match(mpReg) == '' || mpVal == null || mpVal == '') { 
			alert('휴대전화번호 형식에 맞춰 입력해 주세요.'); 
			$('#MOBILE').val('');
			$('#MOBILE').focus();
			return;
		}
		
		//"저장하시겠습니까?" 메시지
		var result = confirm(gb_saveMsg);
		if(result){
			form.action = "/regist/updateUserInfo.do";
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
<%
	//현재 날짜 받아오기
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
	String today = sf.format(now);
	sf = new SimpleDateFormat("yyyy-MM-dd");
	today = sf.format(now);
%>

	<form name="form" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
		<!-- KEY 컴포넌트가 없는 경우 hidden 생성 -->
		<input type="hidden" name="KEY" />
		
		<!-- 컴포넌트 사용을 위한 include jsp -->
		<jsp:include flush="false" page="../common/commonComponent.jsp"></jsp:include>
		
		<div class="title_name relative">
			<!-- 각종 특강 등록 -->
			
			<c:out value="${SS_ACTIVE_SUB_MENU_NM }" />
			<div class="navi absolute">
				<span><a href=""><img width="15" class="home_icon" src="/resources/images/home.png"></a></span>>
				<span><a href=""><c:out value="${SS_ACTIVE_TOP_MENU_NM }" /></a></span> > 
				<span><a href=""><c:out value="${SS_ACTIVE_SUB_MENU_NM }" /></a></span>
			</div>
		</div>
		
		<div class="box-blue-line clear relative">
			<!-- 상단버튼 영역 -->
			<div id="buttonDivBox" class="button_box">
				<button type="button" id="saveBtn" onclick="javascript:fn_save();return false;"><span></span>저장</button><!-- 저장버튼 -->
				<button type="button" id="saveBtn" onclick="javascript:fn_pwChange();return false;"><span></span>비밀번호변경</button><!-- 비밀번호변경 -->
<!-- 				<button type="button" id="goListBtn" onclick="javascript:fn_goList();return false;"><span></span>목록</button>목록	 -->
			</div>
			<!-- 상단버튼 영역 END -->
			
			<!-- 조회조건 영역 -->
			<div id="searchDivBox" style="padding: 7px 10px; margin: 28px;">
 				<span class="required_input absolute"><span class="required"></span>항목은 필수 입력 항목입니다.</span>
			</div>
			<!-- 조회조건영역 END -->
			
			<!-- 그리드 영역 -->
			<div id="grid"></div>
			<!-- 그리드 영역 END -->

			<!-- 입력 및 상세영역 -->
			<div id="inputNdetailDivBox" class="inputNdetail">
				<p class="title"><span>회원정보 수정</span></p>
				<div class="inputNdetail_box">
					<!-- 1라인 -->
					<div class="row clear">
						<div id="inputNdetail_1_1" class="col clear">
							<p class="left">ID</p>
							<div class="right">
								<input type="text" id="USER_ID" name="USER_ID" value="${UserInfo.USER_ID}" maxlength="30" style="ime-mode:active" readonly="readonly">
							</div>
						</div>						
					</div>
					
					<!-- 2라인 -->
					<div class="row clear">
						<div id="inputNdetail_2_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>이름</p>
							<div class="right">
								<input type="text" id="USER_NM" name="USER_NM" value="${UserInfo.USER_NM}" maxlength="30" style="ime-mode:active" placeholder="한글 2~5자리">
							</div>
						</div>
						
					</div>
					
					<!-- 3라인 -->
					<div class="row clear">
						<div id="inputNdetail_3_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>이메일</p>
							<div class="right">
								<input type="text" id="EMAIL" name="EMAIL" value="${UserInfo.EMAIL}" maxlength="30" style="ime-mode:active">
							</div>
						</div>
						<div id="inputNdetail_3_2" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>휴대전화</p>
							<div class="right">
								<input type="text" id="MOBILE" name="MOBILE" value="${UserInfo.MOBILE}" maxlength="30" style="ime-mode:active" placeholder="000-0000-0000">
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div id="inputNdetailDivBox" class="inputNdetail">
				<div class="inputNdetail_box">
					<!-- 4라인 -->
					<div class="row clear">
						<div id="inputNdetail_4_1" class="col clear">
							<p class="left">기업명</p>
							<div class="right">
								<input type="text" id="OFFICE_NM" name="OFFICE_NM" value="${UserInfo.OFFICE_NM}" maxlength="30" style="ime-mode:active">
							</div>
						</div>
						<div id="inputNdetail_4_2" class="col clear">
							<p class="left">기업전화번호</p>
							<div class="right">
								<input type="text" id="OFFICE_PHONE" name="OFFICE_PHONE" value="${UserInfo.OFFICE_PHONE}" maxlength="30" style="ime-mode:active" placeholder="000-000-0000">
							</div>
						</div>
					</div>
					<!-- 5라인 -->
					<div class="row clear">
						<div id="inputNdetail_5_1" class="col clear">
							<p class="left">사업자등록번호</p>
							<div class="right">
								<input type="text" id="OFFICE_REG_NO" name="OFFICE_REG_NO" value="${UserInfo.OFFICE_REG_NO}" maxlength="30" style="ime-mode:active">
							</div>
						</div>
					</div>
				
				</div>
			</div>
		</div>	
	</form>
</body>
</html>