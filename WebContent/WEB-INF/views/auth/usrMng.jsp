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
		fn_gridCompoSetting();
		
		// 검색조건 유지
		if('${param.searchYn}' != 'Y'){return}
		$('#SEARCH_USR_NM').val('${param.SEARCH_USR_NM}');
	});
	// 그리드 설정
// 	var colsNm = ['', 'ID', '이름','비밀번호', '권한', '연간회원']; //예) var colsNm = ['학년도', '학기',var colsNm = ['학년도', '학기', '성명', '학번', '시작일시'];
	var colsNm = ['', 'ID', '이름', '권한', '연간회원', '연간회원등록날짜']; //예) var colsNm = ['학년도', '학기',var colsNm = ['학년도', '학기', '성명', '학번', '시작일시'];
// 	var cols = ['', 'USER_ID', 'USER_NM', 'USER_PWD', 'AUTH_NM', 'ANNUAL_USER']; //예) var cols = ['COL1', 'COL2', 'COL3', 'COL4', 'COL5'];
	var cols = ['', 'USER_ID', 'USER_NM', 'AUTH_NM', 'ANNUAL_USER', 'ANNUAL_USER_START_DT']; //예) var cols = ['COL1', 'COL2', 'COL3', 'COL4', 'COL5'];
	var key = ['USER_ID']; //예) var key = ['SN', 'HAKBEON'];
	
	
	// 검색영역 설정
	function fn_searchCompoSetting(){
		fn_compoInputbox('M', 'S', 'search_2_2', 'SEARCH_USR_NM', 'SEARCH_USR_NM', '', '성명', '', '30');
	}
	
			
	function fn_gridCompoSetting(){
		fn_compoGrid('M', 'grid', cols, colsNm, key);
		fn_gridColgroupSetting('grid', ['*', '*', '*', '*']); // colgroup 설정
		fn_gridAlignSetting('grid', ['center', 'center', 'center', 'center', 'center', 'center']); // 그리드 데이터 정렬 설정(종류:left, center, right)
	}
	
	// 입력 및 상세영역 설정
	function fn_inputNdetailCompoSetting(){
			fn_compoInputbox('M', 'I', 'inputNdetail_1_1', 'INSERT_USER_ID', 'INSERT_USER_ID', '', 'ID', '', '30');
			fn_compoInputbox('M', 'I', 'inputNdetail_1_2', 'USER_NM', 'USER_NM', '', '이름', '', '30');
			fn_compoSelIn_AUTH('M', 'I', 'inputNdetail_2_1', 'AUTH_CD', 'AUTH_CD', '', '권한', '', '30');
			fn_compoInputbox('M', 'I', 'inputNdetail_2_2', 'INSER_USER_EMAIL', 'INSER_USER_EMAIL', '', '이메일', '', '30');
			fn_compoInputbox('M', 'I', 'inputNdetail_3_1', 'MOBILE', 'MOBILE', '', '휴대전화', '', '30');
			fn_compoInputbox('M', 'I', 'inputNdetail_3_2', 'OFFICE_NM', 'OFFICE_NM', '', '기업명', '', '30');
			fn_compoRadioYn('M', 'I', 'inputNdetail_4_1', 'ANNUAL_USER', 'ANNUAL_USER', '', '연간회원');
			fn_compoDateInputbox('M', 'I', 'inputNdetail_4_2', 'ANNUAL_USER_START_DT', 'ANNUAL_USER_START_DT', '', '연간회원등록날짜', '', '30');
			fn_compoInputbox('M', 'I', 'inputNdetail_5_1', 'OFFICE_REG_NO', 'OFFICE_REG_NO', '', '사업자등록번호', '', '30');
			
			
	}
	// 조회 버튼
	function fn_search(){
		var url = "/auth/usrMng.do";
		goSearch(url);
	}
	
	// 페이징 조회
	function pageCall(pageNo) {
		var url = "/auth/usrMng.do";
		goPageCall(url, pageNo);
	}
	
	// 삭제 버튼
	function fn_delete(){
		if(!detailDeleteCheck()){return false;} // 삭제할 대상이 존재하는지 체크
		var result = confirm(gb_delMsg);
		if(result){
			form.action = "/auth/deleteUsrMng.do";
			goSubmit(form);
		}
	}
	
	// 저장 버튼
	function fn_save(){
		// 아이디 필수값 체크
		if($('#INSERT_USER_ID').val() == null || $('#INSERT_USER_ID').val() == ''){
			alert('아이디를 입력해 주세요.');
			form.INSERT_USER_ID.focus();
			return false;
		}
		
		
		if(!chk_pwd('PU')) return; //비밀번호수정시 확인 체크
		
		if($('#USER_PWD').val() != '' && $('#USER_PWD_CFM').val() == ''){
			$('#USER_PWD_CFM').focus();
			alert('비밀번호 확인을 입력하세요.');
			return;
		}else if($('#USER_PWD').val() == '' && $('#USER_PWD_CFM').val() != ''){
			$('#USER_PWD').focus();
			alert('새 비밀번호를 입력하세요.');
			return;
		}
		
		if($('#USER_PWD').val() != '' && $('#USER_PWD_CFM').val() != ''){
			if($('#USER_PWD').val() != $('#USER_PWD_CFM').val()){
				$('#USER_PWD_CFM').focus();
				alert('새 비밀번호와 확인이 서로 다릅니다. 다시 입력해 주세요!!.');		// 신규입력 시
				return;
			}
		}
		
		if($('#updateYn').val() == 'Y' && ($('input[name=USER_PWD]').val() != '' || $('input[name=USER_PWD_CFM]').val() != '')){
			if(!chk_pwd('PU')) return; //비밀번호수정시 확인 체크
		} else 
		if($('#updateYn').val() !='Y' && $('input[name=USER_ID]').val() != '') {
			if(!dup_pwd()) return;// 아이디 중복확인
			if($('input[name=USER_PWD]').val() != $('input[name=USER_PWD_CFM]').val()){
				alert('새 비밀번호와 확인이 서로 다릅니다. 다시 입력해 주세요@@.');
				$('input[name=USER_PWD]').val('');
				$('input[name=USER_PWD_CFM]').val('');
				return false;
			}
		}
		
		var result = confirm(gb_saveMsg);
		if(result){
			form.action = "/auth/saveUsrMng.do";
			goSubmit(form);
		}
	}
	
	// 승인 버튼
	function fn_approval(){
		
	}
	
	// 엑셀다운로드 버튼
	function fn_excelDownload(){
		
	}

	
	// 그리드에서 상세보기를 위한 row onclick 이벤트
	function fn_gridDetailOnclick(obj, trId){
		// 조회시 비밀번호 필수입력 변경
		$('tr[id^="grid"]').on("click", function(){newUpchk(false);});
		// 선택한 row 키값 셋팅
		$('input[name=USER_ID]').val($('#' + trId).find('input[name^=USER_ID]').val());
		$.ajax({
			url : '/auth/usrMngDetail.do',
			data : {USER_ID:$('input[name=USER_ID]').val()},   //전송파라미터
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				var d = result.detailMap;
				$('input[name=INSERT_USER_ID]').val(d.USER_ID);
				$('input[name=USER_NM]').val(d.USER_NM);
				$('#AUTH_CD').val(d.AUTH_CD);
				$('input[name=INSER_USER_EMAIL]').val(d.EMAIL);
				$('input[name=USER_PWD]').val(d.USER_PWD);
				$('input[name=MOBILE]').val(d.MOBILE);
				$('input[name=OFFICE_NM]').val(d.OFFICE_NM);
				$('input[name=OFFICE_REG_NO]').val(d.OFFICE_REG_NO);
				$('#ANNUAL_USER_START_DT').val(d.ANNUAL_USER_START_DT);
				if(d.ANNUAL_USER == 'Y'){
					$('#ANNUAL_USER1').prop('checked', true);
					$('#ANNUAL_USER2').prop('checked', false);
				}else{
					$('#ANNUAL_USER2').prop('checked', true);
					$('#ANNUAL_USER1').prop('checked', false);
				}
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
			complete : function(result) { // success, error 실행 후 최종적으로 실행
				
			}
		});
	
		
	}
	
	// 한글입력방지
	
	$(document.body).on('blur', '#USR_ID', function(e) { 
		if (!(e.keyCode >=37 && e.keyCode<=40)) {
			var v = $('#USR_ID').val();
			$('#USR_ID').val(v.replace(/[^a-z0-9]/gi,''));
		}
	});
	$(document.body).on('keyup', '#USR_ID', function(e) { 
		if (!(e.keyCode >=37 && e.keyCode<=40)) {
			var v = $('#USR_ID').val();
			$('#USR_ID').val(v.replace(/[^a-z0-9]/gi,''));
		}
	});
	
	
</script>
<title>티디아 우선심사 시스템</title>
</head>
<body>
	<form name="form" method="post">
		<!-- KEY 컴포넌트가 없는 경우 hidden 생성 -->
<!-- 		<input type="hidden" name="KEY" /> -->
		
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
				<button type="button" id="searchBtn" onclick="javascript:fn_search();return false;"><span></span><c:out value="${ssITEM5 }" /></button><!-- 조회버튼 -->
				
				
<%-- 				<button type="button" id="newBtn"><span></span><c:out value="${ssITEM6 }" /></button><!-- 신규버튼 function 구현 필요 없음 --> --%>
				
				
				<button type="button" id="delBtn" onclick="javascript:fn_delete();return false;"><span></span><c:out value="${ssITEM7 }" /></button><!-- 삭제버튼 -->
				<button type="button" id="saveBtn" onclick="javascript:fn_save();return false;"><span></span><c:out value="${ssITEM8 }" /></button><!-- 저장버튼 -->
			</div>
			<!-- 상단버튼 영역 END -->
			
			<!-- 조회조건 영역 -->
			<div id="searchDivBox" class="search_box relative">
				
				<div class="row clear">
					<div id="search_1_1"></div>
					<div id="search_1_2"></div>
					<div id="search_1_3"></div>
				</div>
				<div class="row clear">
					<div id="search_2_1"></div>
					<div id="search_2_2"></div>
					<div id="search_2_3"></div>
				</div>
				<div class="row clear">
					<div id="search_3_1"></div>
<!-- 					<div id="search_3_2"></div> -->
				</div>
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
					<div class="row clear">
						<div id="inputNdetail_1_1"></div>
						<div id="inputNdetail_1_2"></div>
						
					</div>
					<div class="row clear">
						<div id="inputNdetail_2_1"></div>
						<div id="inputNdetail_2_2"></div>
					</div>
					<div class="row clear">		
						<div id="inputNdetail_3_1"></div>
						<div id="inputNdetail_3_2"></div>
					</div>
					<div class="row clear">
						<div id="inputNdetail_4_1"></div>
						<div id="inputNdetail_4_2"></div>
					</div>
					<div class="row clear">
						<div id="inputNdetail_5_1"></div>
<!-- 						<div id="inputNdetail_5_2"></div> -->
					</div>
				</div>
			</div>
			<!-- 입력 및 상세영역 END -->

			<!-- 주석 영역 -->
			<div id="cmtDivBox" class="inputNdetail">
				<p class="title"><c:out value="${ssITEM109 }" /></p>
				<div id="cmtDivBox2" class="inputNdetail_box advice_box">
					<c:if test="${not empty ssCMT_ITEM26 }"><b><c:out value="${ssCMT_ITEM26 }" /></b><br /></c:if>
					<c:if test="${not empty ssCMT_ITEM27 }"><b><c:out value="${ssCMT_ITEM27 }" /></b><br /></c:if>
					<c:if test="${not empty ssCMT_ITEM110 }"><b><c:out value="${ssCMT_ITEM110 }" /></b><br /></c:if>
					<c:if test="${not empty ssCMT_ITEM111 }"><b><c:out value="${ssCMT_ITEM111 }" /></b><br /></c:if>
					<c:if test="${not empty ssCMT_ITEM112 }"><b><c:out value="${ssCMT_ITEM112 }" /></b><br /></c:if>
				</div>
			</div>
			<!-- 주석 영역 END -->
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
	
	// 비밀번호 확인
	function chk_pwd(flag) {
		var chkResult = true;
		$.ajax({
			url : '/auth/chkPwdUsrMng.do',
			data : {USER_ID:$('input[name=INSERT_USER_ID]').val()},   //전송파라미터
			type : 'POST',
			dataType : 'json',
			async 	: false,
			success : function(result) {
				var d = result.pwdChk;
				if(d == "OK"){
					chkResult = true;
				} else {
					chkResult = false;
				}
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
				chkResult = false;
			},
			complete : function(result) { // success, error 실행 후 최종적으로 실행
				
			}
		});
		
		if(chkResult){
			
			if (flag == 'PU') {
				
				if($('input[name=USER_PWD]').val() != '' || $('input[name=USER_PWD_CFM]').val() != ''){
					if($('input[name=USER_PWD]').val() != $('input[name=USER_PWD_CFM]').val()){
						alert('새 비밀번호와 확인이 서로 다릅니다. 다시 입력해 주세요');
						$('input[name=USER_PWD]').val('');
						$('input[name=USER_PWD]').val('');
						$('input[name=USER_PWD_CFM]').val('');
						chkResult = false;
					}
				} else {
					chkResult = true;
				}
			} else if (flag == 'D') {
				
			}
			
		} else {
			alert('비밀번호가 다릅니다.');
			$('input[name=USER_PWD]').val('');
		}
		return chkResult;
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
			$('#INSERT_USER_ID').attr('readonly', true);	// 수정일경우 아이디 변경 못하게
			$('#inputNdetail_3_2');
			$('#inputNdetail_3_3');	
			$('#USER_ID').attr('readonly', true);
			$('#USER_ID').addClass('disabled_input');
			$('#USER_PWD').removeClass("disabled_input");
			$('#USER_PWD').val('');
			$('#USER_PWD_CFM').val('');
			$('#USER_NM').val('').attr('readonly', true);
			$('#inputNdetail_1_3 > p').prepend('<span class="required"></span>');
			$('#INSER_USER_EMAIL').val('').attr('readonly', true);
			$('#MOBILE').val('').attr('readonly', true);
			$('#OFFICE_NM').val('').attr('readonly', true);
			$('#OFFICE_REG_NO').val('').attr('readonly', true);
// 			$('#inputNdetail_4_1 > p').prepend('<span class="required"></span>');
		}
	}
	// 라디오박스 체크 고정
	$('[value='+$('#PARAM_GB').val()+']').prop('checked', 'checked');
	
	</script>
	<input type="hidden" id="PARAM_GB" name="PARAM_GB" value='${param.USR_GB}'>
</body>
</html>