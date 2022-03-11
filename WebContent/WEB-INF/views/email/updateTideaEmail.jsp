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
		javascript:history.back();
	}
	
	
	// 저장 버튼
	function fn_save(){
		
		// 이메일 계정 필수값 입력
		if($('#EMAIL_ADDR').val() == null || $('#EMAIL_ADDR').val() == ''){
			alert('이메일 주소를 입력해 주세요.');
			form.EMAIL_ADDR.focus();
			return false;
		}
		
		// 이메일 계정 필수값 입력
		if($('#PASSWORD').val() == null || $('#PASSWORD').val() == ''){
			alert('이메일 비밀번호를 입력해 주세요.');
			form.PASSWORD.focus();
			return false;
		}
		
		// 접수완료 메일 제목 필수값 입력
		if($('#APPLY_TITLE').val() == null || $('#APPLY_TITLE').val() == ''){
			alert('접수완료 메일 제목을 입력해 주세요.');
			form.APPLY_TITLE.focus();
			return false;
		}
		
		// 접수완료 메일 내용 필수값 입력
		if($('#APPLY_CONTENT').val() == null || $('#APPLY_CONTENT').val() == ''){
			alert('접수완료 메일 내용을 입력해 주세요.');
			form.APPLY_CONTENT.focus();
			return false;
		}
		
		// 심사보완완료 메일 제목 필수값 입력
		if($('#RECEIPT_TITLE').val() == null || $('#RECEIPT_TITLE').val() == ''){
			alert('심사보완완료 메일 제목을 입력해 주세요.');
			form.RECEIPT_TITLE.focus();
			return false;
		}

		// 심사보완완료 메일 내용 필수값 입력
		if($('#RECEIPT_CONTENT').val() == null || $('#RECEIPT_CONTENT').val() == ''){
			alert('심사보완완료 메일 내용을 입력해 주세요.');
			form.RECEIPT_CONTENT.focus();
			return false;
		}

		//"저장하시겠습니까?" 메시지
		var result = confirm(gb_saveMsg);
		if(result){
			form.action = "/email/updateTideaEmail.do";
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
			</div>
			<!-- 상단버튼 영역 END -->
			
			<!-- 조회조건 영역 -->
<!-- 			<div id="searchDivBox" style="padding: 7px 10px; margin: 28px;"> -->
<!--  				<span class="required_input absolute"><span class="required"></span>항목은 필수 입력 항목입니다.</span> -->
<!-- 			</div> -->
			<!-- 조회조건영역 END -->
			
			<!-- 그리드 영역 -->
			<div id="grid"></div>
			<!-- 그리드 영역 END -->

			<!-- 티디아 이메일 계정 부분-->
			<div id="inputNdetailDivBox" class="inputNdetail">
				<p class="title"><span>이메일 정보 관리</span><span class="required_input absolute"><span class="required"></span>항목은 필수 입력 항목입니다.</span></p>
				<div class="inputNdetail_box">
					<div class="row clear">
						<div id="inputNdetail_1_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>이메일 주소</p>
							<div class="right">
								<input type="text" id="EMAIL_ADDR" name="EMAIL_ADDR" value="${tideaEmailInfo.EMAIL_ADDR}" maxlength="30" style="ime-mode:active">
							</div>
						</div>	
						
						<div id="inputNdetail_1_2" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>이메일 비밀번호</p>
							<div class="right">
								<input type="password" id="PASSWORD" name="PASSWORD" value="${tideaEmailInfo.PASSWORD}" maxlength="30" style="ime-mode:active">
							</div>
						</div>					
					</div>
				</div>
			</div>
			
			<!-- 접수완료메일 부분 (접수자가 받는메일) -->
			<div id="inputNdetailDivBox" class="inputNdetail">
				<p class="title"><span>접수 완료 메일</span></p>
				<div class="inputNdetail_box">
					<!-- 1라인 -->
					<div class="row clear">
						<div id="inputNdetail_2_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>접수완료메일 제목</p>
							<div class="right">
								<input type="text" id="APPLY_TITLE" name="APPLY_TITLE" value="${tideaEmailInfo.APPLY_TITLE}" maxlength="30" style="ime-mode:active">
							</div>
						</div>				
					</div>
					<!-- 2라인 -->
					<div class="row clear">
						<div id="inputNdetail_3_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>접수완료메일 내용</p>
							<div class="right">
<%-- 								<input type="text" id="APPLY_CONTENT" name="APPLY_CONTENT" value="${tideaEmailInfo.APPLY_CONTENT}" maxlength="30" style="ime-mode:active"> --%>
								<textarea id="APPLY_CONTENT" name="APPLY_CONTENT" cols="50" rows="20">${tideaEmailInfo.APPLY_CONTENT}</textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 심사완료메일 부분 (신청자가 받는메일) -->
			<div id="inputNdetailDivBox" class="inputNdetail">
				<p class="title"><span>심사 완료 메일</span></p>
				<div class="inputNdetail_box">
					<!-- 1라인 -->
					<div class="row clear">
						<div id="inputNdetail_4_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>심사완료메일 제목</p>
							<div class="right">
								<input type="text" id="RECEIPT_TITLE" name="RECEIPT_TITLE" value="${tideaEmailInfo.RECEIPT_TITLE}" maxlength="30" style="ime-mode:active">
							</div>
						</div>				
					</div>
					<!-- 2라인 -->
					<div class="row clear">
						<div id="inputNdetail_4_2" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>심사완료메일 내용</p>
							<div class="right">
<%-- 								<input type="text" id="RECEIPT_CONTENT" name="RECEIPT_CONTENT" value="${tideaEmailInfo.RECEIPT_CONTENT}" maxlength="30" style="ime-mode:active"> --%>
								<textarea id="RECEIPT_CONTENT" name="RECEIPT_CONTENT" cols="50" rows="20">${tideaEmailInfo.RECEIPT_CONTENT}</textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>	
	</form>
</body>
</html>