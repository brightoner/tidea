<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$(document).ready(function() {
		
		// 컴포넌트 호출
		fn_searchCompoSetting();
		fn_inputNdetailCompoSetting();
		
	});
	
	// 검색영역 설정
	function fn_searchCompoSetting(){
		fn_compoInputbox('M', 'S', 'search_2_2', 'SEARCH_USR_NM', 'SEARCH_USR_NM', '', '성명', '', '30');
	}
	
	
	// 입력 및 상세영역 설정
	function fn_inputNdetailCompoSetting(){
			fn_compoInputbox('M', 'I', 'inputNdetail_1_1', 'INSER_USER_NM', 'INSER_USER_NM', '', '이름', '', '30');	
			fn_compoInputbox('M', 'I', 'inputNdetail_1_2', 'INSER_USER_EMAIL', 'INSER_USER_EMAIL', '', '이메일', '', '30');
		
			fn_compoInputbox('M', 'I', 'inputNdetail_2_1', 'INSER_USER_ID', 'INSER_USER_ID', '', 'ID', '', '30');
			fn_compoInputbox('M', 'I', 'inputNdetail_2_2', 'USER_NM', 'USER_NM', '', '이름', '', '30');	
			fn_compoInputbox('M', 'I', 'inputNdetail_3_1', 'EMAIL', 'EMAIL', '', '이메일', '', '30');
			
	}
	
	// 목록으로 돌아가기
	function fn_goList(){
		javascript:history.back();
	}
	
	// 아이디찾기
	function fn_idFind(){
		
		var email_val = $('#INSER_USER_EMAIL').val();
		var user_nm_val = $('#INSER_USER_NM').val();
		
		$.ajax({
			url : '/regist/idFind.do',
			data : {INSER_USER_EMAIL:email_val, INSER_USER_NM:user_nm_val},   //전송파라미터
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				var d = result.idFind;
				var e = result.USER_ID;
				console.log(d);
				if(d == "OK"){
					alert("아이디는 " + e + " 입니다.");
				}else{
					alert("회원님이 기입하신 정보가 일치하지 않습니다.");
					form.USER_NM.focus();
					return false;
				}
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
			complete : function(result) { // success, error 실행 후 최종적으로 실행
				
			}
		});
	}
	
	
	// 비밀번호 찾기
	function fn_pwFind(){
		
		var userId_val = $('#INSER_USER_ID').val();
		var email_val = $('#EMAIL').val();
		var userNmm_val = $('#USER_NM').val();
		
		$.ajax({
			url : '/regist/passFind.do',
			data : {INSER_USER_ID:userId_val,EMAIL:email_val, USER_NM:userNmm_val},   //전송파라미터
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				var d = result.pwFind;
				console.log(d);
				if(d == "OK"){
					alert("임시 비밀번호를  " + email_val +"로 전송 했습니다.");
				}else{
					alert("회원님이 기입하신 정보가 일치하지 않습니다.");
					form.EMAIL.focus();
					return false;
				}
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
			complete : function(result) { // success, error 실행 후 최종적으로 실행
				
			}
		});
	}
	
</script>
<title>티디아 우선심사 시스템</title>
</head>
<body>
	<form name="form" method="post">
		<!-- KEY 컴포넌트가 없는 경우 hidden 생성 -->
		
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
				<button type="button" id="goListBtn" onclick="javascript:fn_goList();return false;"><span></span>목록</button><!-- 목록	 -->
			</div>
			<!-- 상단버튼 영역 END -->
			
			<!-- 조회조건 영역 -->
			<div id="searchDivBox" class="search_box relative">
				
			</div>
			<!-- 조회조건영역 END -->
			
			<!-- 그리드 영역 -->
			<div id="grid"></div>
			<!-- 그리드 영역 END -->

			<!-- 입력 및 상세영역 -->
			<div id="inputNdetailDivBox" class="inputNdetail">
				<p class="title"><span id="modeSpan"></span></p>
				
				<div class="inputNdetail_box">
					<!-- 1라인 -->
					<div>아이디 찾기</div>
					<div class="row clear">
						<div id="inputNdetail_1_1"></div>
						<div id="inputNdetail_1_2"></div>
						<button type="button" onclick="javascript:fn_idFind();" style="margin-top: 5px;"><b>이이디 찾기</b></button>
					</div>
				</div>
				
				<div class="inputNdetail_box">
					<!-- 2라인 -->
					<div>비밀번호 찾기</div>
					<div class="row clear">
						<div id="inputNdetail_2_1"></div>
						<div id="inputNdetail_2_2"></div>
						<div id="inputNdetail_3_1"></div>
						<button type="button" onclick="javascript:fn_pwFind();" style="margin-top: 5px;"><b>비밀번호 찾기</b></button>
					</div>
				</div>
			</div>
			<!-- 입력 및 상세영역 END -->

		</div>
	</form>
	<script type="text/javascript">
	
	//구분 라디오버튼 3개
	function fn_compoRadioGB(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label, userGb){
		var chk1 = '';
		var chk2 = '';
		var chk3 = '';
		var chktrue = ' checked="true" ';
		if(mpGubun == 'M'){
			$('#' + divId).attr('class', 'col clear');
			var tagStr = '<p class="left">';
			if(requiredYn == 'Y'){
				tagStr += requiredSpan;
			}
				tagStr += label;
				tagStr += '</p>';
				tagStr += '<div class="right">';
					tagStr += '<div class="yorn" style="color:#FFF; font-size: 12px;"> ';
						if (userGb == 'GM_INSA_M') {
							chk2 = chktrue;
						} else if (userGb == 'SUPER_MNGR') {
							chk3 = chktrue;
						} else {
							chk1 = chktrue;
						}
						tagStr += '<input type="radio" id="USR_GB" name="USR_GB" value="STDNT" '+chk1+' > <span>학생</span>';
						tagStr += '<input type="radio" id="USR_GB" name="USR_GB" value="HR" '+chk2+' > <span>인사</span>';
						tagStr += '<input type="radio" id="USR_GB" name="USR_GB" value="SUPER_MNGR" '+chk3+' > <span>관리자</span>';
					tagStr += '</div>';
				tagStr += '</div>';
				
			$('#' + divId).html(tagStr);
			
		}else if(mpGubun == 'P'){
			
		}
	}
	
	// 패스워드 입력 컴포넌트
	function fn_compoPwdbox(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label, width, length){
		
		if(mpGubun == 'M'){
			if(width == undefined || width == ''){
				$('#' + divId).attr('class', 'col clear');
			}else{
				$('#' + divId).attr('class', 'col col1'); // 3칸전용
			}
			var tagStr = '<p class="left">';
			if(requiredYn == 'Y'){
				tagStr += requiredSpan;
			}
				tagStr += label;
				tagStr += '</p>';
				tagStr += '<div class="right">';
					tagStr += '<input type="password" id="'+tagId+'" name="'+tagName+'" value="" maxlength="'+length+'"/> ';
				tagStr += '</div>';
				
			$('#' + divId).html(tagStr);
			
		}else if(mpGubun == 'P'){
			
		}
		
	}
	
	
	
	// 관리자 신규등록시 비밀번호 필수입력 변경 함수
	function newUpchk(flag){
		if (flag == true) {
			$('#USER_ID').attr('readonly', false);
			$('#USER_ID').removeClass("disabled_input");
			$('#USER_PWD').addClass('disabled_input');
			$('#USER_PWD').val('');
			$('#USER_PWD_CFM').val('');
		} else if (flag == false){
			$('#INSERT_USER_ID').attr('readonly', false);	// 수정일경우 아이디 변경 못하게
			$('#inputNdetail_3_2');
			$('#inputNdetail_3_3');	
			$('#USER_ID').attr('readonly', false);
			$('#USER_ID').addClass('disabled_input');
			$('#USER_PWD').removeClass("disabled_input");
			$('#USER_PWD').val('');
			$('#USER_PWD_CFM').val('');
			$('#USER_NM').val('').attr('readonly', false);
			$('#inputNdetail_1_3 > p').prepend('<span class="required"></span>');
			$('#INSER_USER_EMAIL').val('').attr('readonly', false);
			$('#MOBILE').val('').attr('readonly', false);
			$('#OFFICE_NM').val('').attr('readonly', false);
			$('#inputNdetail_4_1 > p').prepend('<span class="required"></span>');
		}
	}
	
	// 라디오박스 체크 고정
	$('[value='+$('#PARAM_GB').val()+']').prop('checked', 'checked');
	
	</script>
	<input type="hidden" id="PARAM_GB" name="PARAM_GB" value='${param.USR_GB}'>
</body>
</html>