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
		fn_gridCompoSetting();
		fn_inputNdetailCompoSetting();
		
		// 검색조건 유지(예:$('#SEARCH_GRADE').val('${param.SEARCH_GRADE}');)
		$('#SEARCH_CODE_NM').val('${param.SEARCH_CODE_NM}');
		
	});
	
	// 검색영역 설정
	function fn_searchCompoSetting(){
		fn_compoInputbox('M', 'S', 'search_1_1', 'SEARCH_CODE_NM', 'SEARCH_CODE_NM', '', '코드구분명');
	}
	
	// 그리드 설정(체크박스가 필요한 경우 cols[] 와 colsNm에 0번째에 빈값 셋팅)
	var cols = ['CODE_SE', 'CODE_NM', 'CODE_DC', 'WRTER', 'RGSDE', 'UPDDE']; //예) var cols = ['COL1', 'COL2', 'COL3'];
	var colsNm = ['코드구분', '코드구분명', '설명', '작성자', '최초 등록일', '최근 수정일']; //예) var colsNm = ['컬럼한글명1', '컬럼한글명2', '컬럼한글명3'];
	var key = ['CODE_SE']; //예) var key = ['SN', 'HAKBEON'];
	function fn_gridCompoSetting(){
		fn_compoGrid('M', 'grid', cols, colsNm, key);
		fn_gridColgroupSetting('grid', ['10%', '20%', '*', '15%', '15%', '15%']); // colgroup 설정
		fn_gridAlignSetting('grid', ['center', 'left', 'left', 'center', 'center', 'center']); // 그리드 데이터 정렬 설정(종류:left, center, right)
	}
	
	// 입력 및 상세영역 설정
	function fn_inputNdetailCompoSetting(){
		fn_compoInputbox('M', 'I', 'inputNdetail_1_1', 'CODE_SE', 'CODE_SE', 'Y', '코드구분');
		fn_compoInputbox('M', 'I', 'inputNdetail_1_2', 'CODE_NM', 'CODE_NM', 'Y', '코드구분명');
		fn_compoInputbox('M', 'I', 'inputNdetail_1_3', 'CODE_DC', 'CODE_DC', '', '설명');
	}
	
	// 조회 버튼
	function fn_search(){
		var url = "/auth/prOrgCdMng.do";
		goSearch(url);
	}
	
	// 페이징 조회
	function pageCall(pageNo) {
		var url = "/auth/prOrgCdMng.do";
		goPageCall(url, pageNo);
	}
	
	// 삭제 버튼
	function fn_delete(){
		if(!detailDeleteCheck()){return false;} // 삭제할 대상이 존재하는지 체크
		var result = confirm(gb_delMsg + "\n삭제 시 공통상세코드도 삭제 됩니다.");
		if(result){
			form.action = "/auth/deletePrOrgCdMng.do";
			goSubmit(form);
		}
	}
	
	// 저장 버튼
	function fn_save(){
		if(!inputNdetailRequiredCheck()){return false;} // 저장 필수 입력 체크
		var result = confirm(gb_saveMsg);
		if(result){
			form.action = "/auth/savePrOrgCdMng.do";
			goSubmit(form);
		}
	}
	
	// 그리드에서 상세보기를 위한 row onclick 이벤트
	function fn_gridDetailOnclick(obj, trId){
		
		//pageLoadingShow();
		
		// 선택한 row 키값 셋팅
		$('input[name=CODE_SE]').val($('#' + trId).find('input[name^=CODE_SE]').val());
		$.ajax({
			url : '/auth/prOrgMngDetail.do',
			data : {CODE_SE:$('input[name=CODE_SE]').val()},   //전송파라미터
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				var d = result.detailMap;
				$('#CODE_SE').val(d.CODE_SE);
				$('#CODE_NM').val(d.CODE_NM);
				$('#CODE_DC').val(d.CODE_DC);
				
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
			complete : function(result) { // success, error 실행 후 최종적으로 실행
				//setTimeout(function(){ pageLoadingHide(); }, 100);
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
					</div>
				</div>
			</div>
			<!-- 입력 및 상세영역 END -->
		</div>
	</form>
</body>
</html>