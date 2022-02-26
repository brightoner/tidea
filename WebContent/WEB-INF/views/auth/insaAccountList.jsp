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
// 		$('#PARAM_GB').val('${param.USR_GB}');
		
		
		// 컴포넌트 호출
		fn_buttonCompoSetting();
		fn_searchCompoSetting();
		fn_inputNdetailCompoSetting();
		fn_gridCompoSetting();
		
		
		// 검색조건 유지
		if('${param.searchYn}' != 'Y'){return}
		$('#SEARCH_EMP_ID').val('${param.SEARCH_EMP_ID}');
		$('#SEARCH_USR_NM').val('${param.SEARCH_USR_NM}');
	});
	// 그리드 설정
	var colsNm = ['ID', '이름','패스워드']; //예) var colsNm = ['학년도', '학기',var colsNm = ['학년도', '학기', '성명', '학번', '시작일시'];
	var cols = ['EMP_ID', 'USR_NM', 'USR_PWD']; //예) var cols = ['COL1', 'COL2', 'COL3', 'COL4', 'COL5'];
	var key = ['KEY']; //예) var key = ['SN', 'HAKBEON'];
	
	// 버튼영역 설정
	function fn_buttonCompoSetting(){
		
	}
	
	// 검색영역 설정
	function fn_searchCompoSetting(){
		fn_compoInputbox('M', 'S', 'search_1_1', 'SEARCH_EMP_ID', 'SEARCH_EMP_ID', '', '관리자 ID', '', '30');
		fn_compoInputbox('M', 'S', 'search_1_2', 'SEARCH_USR_NM', 'SEARCH_USR_NM', '', '성명', '', '30');
	}
	
			
	function fn_gridCompoSetting(){
		fn_compoGrid('M', 'grid', cols, colsNm, key);
		fn_gridColgroupSetting('grid', ['*', '*', '*']); // colgroup 설정
		fn_gridAlignSetting('grid', ['center', 'center', 'center']); // 그리드 데이터 정렬 설정(종류:left, center, right)
	}
	
	// 입력 및 상세영역 설정
	function fn_inputNdetailCompoSetting(){
		
		fn_compoInputboxReadOnly('M', 'I', 'inputNdetail_1_1', 'EMP_ID', 'EMP_ID', 'Y', '아이디', '', '30');
		fn_compoInputbox('M', 'I', 'inputNdetail_1_2', 'USR_NM', 'USR_NM', 'Y', '이름', '', '30');
		fn_compoPwdbox('M', 'I', 'inputNdetail_2_1', 'NEW_PWD', 'NEW_PWD', '', '비밀번호', '', '30');
		fn_compoPwdbox('M', 'I', 'inputNdetail_2_1', 'NEW_PWD_CFM', 'NEW_PWD_CFM', '', '비밀번호확인', '', '30');
	}
	// 조회 버튼
	function fn_search(){
		// 조회시 공백 제거
 		$('#SEARCH_EMP_ID').val($('#SEARCH_EMP_ID').val().replace(/\s/gi,''));
 		$('#SEARCH_USR_NM').val($('#SEARCH_USR_NM').val().replace(/\s/gi,''));
		
		var url = "/auth/insaAccountList.do";
		goSearch(url);
	}
	
	// 페이징 조회
	function pageCall(pageNo) {
		var url = "/auth/insaAccountList.do";
		goPageCall(url, pageNo);
	}
	
	// 삭제 버튼
	function fn_delete(){
// 		if($('input[name=USR_PWD]').val() != ''){
// 			if(!chk_pwd('D')) {
// 				return; //비밀번호확인 체크
// 			}
// 		} 
// 		else {
// 			alert('비밀번호를 입력하세요.')
// 			return false;
// 		}
		if(!detailDeleteCheck()){return false;} // 삭제할 대상이 존재하는지 체크
		var result = confirm(gb_delMsg);
		if(result){
			form.action = "/auth/deleteinsaAccountList.do";
			goSubmit(form);
		}
	}
	
	// 저장 버튼
	function fn_save(){
		if(!inputNdetailRequiredCheck()){return false;} // 저장 필수 입력 체크
		
		if($('#NEW_PWD').val() != '' && $('#NEW_PWD_CFM').val() == ''){
			$('#NEW_PWD_CFM').focus();
			alert('비밀번호 확인을 입력하세요.');
			return;
		}else if($('#NEW_PWD').val() == '' && $('#NEW_PWD_CFM').val() != ''){
			$('#NEW_PWD').focus();
			alert('새 비밀번호를 입력하세요.');
			return;
		}
		
		if($('#NEW_PWD').val() != '' && $('#NEW_PWD_CFM').val() != ''){
			if($('#NEW_PWD').val() != $('#NEW_PWD_CFM').val()){
				$('#NEW_PWD_CFM').focus();
				alert('새 비밀번호와 확인이 서로 다릅니다. 다시 입력해 주세요.');
				return;
			}
		}
		
// 		if($('#updateYn').val() == 'Y' && ($('input[name=NEW_PWD]').val() != '' || $('input[name=NEW_PWD_CFM]').val() != '')){
// 			if(!chk_pwd('PU')) return; //비밀번호수정시 확인 체크
// 		} else 
		if($('#updateYn').val() !='Y' && $('input[name=EMP_ID]').val() != '') {
			if(!dup_pwd()) return;// 아이디 중복확인
			if($('input[name=NEW_PWD]').val() != $('input[name=NEW_PWD_CFM]').val()){
				alert('새 비밀번호와 확인이 서로 다릅니다. 다시 입력해 주세요.');
				$('input[name=NEW_PWD]').val('');
				$('input[name=NEW_PWD_CFM]').val('');
				return false;
			}
		}
		
		var result = confirm(gb_saveMsg);
		if(result){
			form.action = "/auth/saveinsaAccountList.do";
			goSubmit(form);
		}
	}
	
	// 그리드에서 상세보기를 위한 row onclick 이벤트
	function fn_gridDetailOnclick(obj, trId){
		// 조회시 비밀번호 필수입력 변경
		$('tr[id^="grid"]').on("click", function(){newUpchk(false);});
		// 선택한 row 키값 셋팅
		$('input[name=KEY]').val($('#' + trId).find('input[name^=KEY]').val());
		$.ajax({
			url : '/auth/insaAccountListDetail.do',
			data : {KEY:$('input[name=KEY]').val(), USR_GB:$('input[name=PARAM_GB]').val()},   //전송파라미터
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				var d = result.detailMap;
				$('input[name=EMP_ID]').val(d.EMP_ID);
				$('input[name=USR_NM]').val(d.USR_NM);
				$('input[name=USR_DT]').val(d.USR_DT);
				$('input[name=USR_GEN]').val(d.USR_GEN);
				$('input[name=USR_DEPT]').val(d.USR_DEPT);
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
			complete : function(result) { // success, error 실행 후 최종적으로 실행
				
			}
		});
	
		
	}
	
	
	// 한글입력방지
	
	$(document.body).on('blur', '#EMP_ID', function(e) { 
		if (!(e.keyCode >=37 && e.keyCode<=40)) {
			var v = $('#EMP_ID').val();
			$('#EMP_ID').val(v.replace(/[^a-z0-9]/gi,''));
		}
	});
	$(document.body).on('keyup', '#EMP_ID', function(e) { 
		if (!(e.keyCode >=37 && e.keyCode<=40)) {
			var v = $('#EMP_ID').val();
			$('#EMP_ID').val(v.replace(/[^a-z0-9]/gi,''));
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
				<button type="button" id="newBtn"><span></span><c:out value="${ssITEM6 }" /></button><!-- 신규버튼 function 구현 필요 없음 -->
				<button type="button" id="delBtn" onclick="javascript:fn_delete();return false;"><span></span><c:out value="${ssITEM7 }" /></button><!-- 삭제버튼 -->
				<button type="button" id="saveBtn" onclick="javascript:fn_save();return false;"><span></span><c:out value="${ssITEM8 }" /></button><!-- 저장버튼 -->
			</div>
			<!-- 상단버튼 영역 END -->
			
			<!-- 조회조건 영역 -->
			<div id="searchDivBox" class="search_box relative">
				<span class="required_input absolute"><span class="required"></span>항목은 필수 입력 항목입니다.</span>
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
					<div id="search_3_2"></div>
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
						<div id="inputNdetail_1_3"></div>
						<div id="inputNdetail_1_4"></div>
					</div>
					<div class="row clear">
						<div id="inputNdetail_2_1"></div>
						<div id="inputNdetail_2_2"></div>
						<div id="inputNdetail_2_3"></div>
					</div>
					<div class="row clear">
						<div id="inputNdetail_3_1"></div>
						<div id="inputNdetail_3_2"></div>
						<div id="inputNdetail_3_3"></div>
					</div>
					<div class="row clear">
						<div id="inputNdetail_4_1"></div>
						<div id="inputNdetail_4_2"></div>
					</div>
					<div class="row clear">
						<div id="inputNdetail_5_1"></div>
						<div id="inputNdetail_5_2"></div>
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
			url : '/auth/chkPwdinsaAccountList.do',
			data : {USER_ID:$('input[name=EMP_ID]').val(), USER_PWD:$('input[name=USR_PWD]').val()},   //전송파라미터
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
				
				if($('input[name=NEW_PWD]').val() != '' || $('input[name=NEW_PWD_CFM]').val() != ''){
					if($('input[name=NEW_PWD]').val() != $('input[name=NEW_PWD_CFM]').val()){
						alert('새 비밀번호와 확인이 서로 다릅니다. 다시 입력해 주세요');
						$('input[name=USR_PWD]').val('');
						$('input[name=NEW_PWD]').val('');
						$('input[name=NEW_PWD_CFM]').val('');
						chkResult = false;
					} else {
						$('input[name=USR_PWD]').val($('input[name=NEW_PWD]').val());
					}
				} else {
					alert('새 비밀번호를 입력해 주세요');
					chkResult = false;
				}
			} else if (flag == 'D') {
				
			}
			
		} else {
			alert('비밀번호가 다릅니다.');
			$('input[name=USR_PWD]').val('');
		}
		return chkResult;
	}
	
	// 아이디중복 확인
	function dup_pwd() {
		var chkResult = true;
		$.ajax({
			url : '/auth/selectinsaAccountListDupl.do',
			data : {EMP_ID:$('input[name=EMP_ID]').val()},   //전송파라미터
			type : 'POST',
			dataType : 'json',
			async 	: false,
			success : function(result) {
				var d = result.dupChk;
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
		
		if(!chkResult){
			alert('중복된 아이디가 있습니다.');
		}
		return chkResult;
	}
	
	// 관리자 신규등록시 비밀번호 필수입력 변경 함수
	function newUpchk(flag){
		if (flag == true) {
			$('#inputNdetail_3_1 > p').prepend('<span class="required"></span>');
			$('#inputNdetail_3_2 > p').prepend('<span class="required"></span>');
			$('#EMP_ID').attr('readonly', false);
			$('#EMP_ID').removeClass("disabled_input");
			$('#USR_PWD').attr('readonly', true);
			$('#USR_PWD').addClass('disabled_input');
			$('#NEW_PWD').val('');
			$('#NEW_PWD_CFM').val('');
		} else if (flag == false){
			$('#inputNdetail_3_1 > p > span').remove();
			$('#inputNdetail_3_2 > p > span').remove();
			$('#EMP_ID').attr('readonly', true);
			$('#EMP_ID').addClass('disabled_input');
			$('#USR_PWD').attr('readonly', false);
			$('#USR_PWD').removeClass("disabled_input");
			$('#NEW_PWD').val('');
			$('#NEW_PWD_CFM').val('');
		}
	}
	// 관리자 신규등록시 비밀번호 필수입력 변경
	$('#newBtn').on("click", function(){ newUpchk(true);});
	
	// 라디오박스 체크 고정
	$('[value='+$('#PARAM_GB').val()+']').prop('checked', 'checked');
	
	</script>
	<input type="hidden" id="PARAM_GB" name="PARAM_GB" value='SUPER_MNGR'>
</body>
</html>