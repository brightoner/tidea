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
		fn_buttonCompoSetting();
		fn_searchCompoSetting();
		fn_gridCompoSetting();
		fn_inputNdetailCompoSetting();
		
		// 검색조건 유지(예:$('#SEARCH_GRADE').val('${param.SEARCH_GRADE}');)
		
	});
	
	// 버튼영역 설정
	function fn_buttonCompoSetting(){
		
	}
	
	// 검색영역 설정
	function fn_searchCompoSetting(){

	}
	
	// 그리드 설정(체크박스가 필요한 경우 cols[] 와 colsNm에 0번째에 빈값 셋팅)
	var cols = []; //예) var cols = ['COL1', 'COL2', 'COL3'];
	var colsNm = []; //예) var colsNm = ['컬럼한글명1', '컬럼한글명2', '컬럼한글명3'];
	var key = []; //예) var key = ['SN', 'HAKBEON'];
	function fn_gridCompoSetting(){
		fn_compoGrid('M', 'grid', cols, colsNm, key);
		fn_gridColgroupSetting('grid', ['10%', '30%', '15%', '15%', '*']); // colgroup 설정
		fn_gridAlignSetting('grid', ['center', 'center', 'center', 'center', 'center']); // 그리드 데이터 정렬 설정(종류:left, center, right)
	}
	
	// 입력 및 상세영역 설정
	function fn_inputNdetailCompoSetting(){

	}
	
	// 조회 버튼
	function fn_search(){
		$("#curPage").val(1);
		if(!searchRequiredCheck()){return false;} // 조회 필수 입력 체크
		form.action = "url 작성";
		goSubmit(form);
	}
	
	// 페이징 조회
	function pageCall(pageNo) {
	    $("#curPage").val(pageNo);
		form.action = "url 작성";
		goSubmit(form);
	}
	
	// 삭제 버튼
	function fn_delete(){
		if(!detailDeleteCheck()){return false;} // 삭제할 대상이 존재하는지 체크
		var result = confirm(gb_delMsg);
		if(result){
			form.action = "url 작성";
			goSubmit(form);
		}
	}
	
	// 저장 버튼
	function fn_save(){
		if(!inputNdetailRequiredCheck()){return false;} // 저장 필수 입력 체크
		var result = confirm(gb_saveMsg);
		if(result){
			form.action = "url 작성";
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
		
	}
</script>
<title>티디아 우선심사 시스템</title>
</head>
<body>
	<form name="form" method="post">
		<!-- KEY 컴포넌트가 없는 경우 hidden 생성 -->
		
		<!-- 컴포넌트 사용을 위한 include jsp -->
		<jsp:include flush="false" page="../common/commonComponent.jsp"></jsp:include>
		
		<div class="menu_name clear">
			화면명
			<div class="navi">
				<img width="15" class="home_icon" src="/resources/images/home.png">홈 > 메뉴명 > 화면명
			</div>
		</div>
		<c:out value=""  />
		<div class="box-blue-line clear relative">
			<!-- 상단버튼 영역 -->
			<div id="buttonDivBox" class="button_box">
				<button type="button" id="searchBtn" onclick="javascript:fn_search();return false;"><c:out value="${ssITEM5 }" /></button><!-- 조회버튼 -->
				<button type="button" id="newBtn" onclick="javasciprt:fn_newForm();return false;"><c:out value="${ssITEM6 }" /></button><!-- 신규버튼 function 구현 필요 없음 -->
				<button type="button" id="delBtn" onclick="javascript:fn_delete();return false;"><c:out value="${ssITEM7 }" /></button><!-- 삭제버튼 -->
				<button type="button" id="saveBtn" onclick="javascript:fn_save();return false;"><c:out value="${ssITEM8 }" /></button><!-- 저장버튼 -->
				<button type="button" id="apprBtn" onclick="javascript:fn_approval();return false;"><c:out value="${ssITEM9 }" /></button><!-- 승인버튼 -->
				<button type="button" id="excelDownBtn" onclick="javascript:fn_excelDownload();return false;"><c:out value="${ssITEM10 }" /></button><!-- 엑셀다운로드버튼 -->
			</div>
			<!-- 상단버튼 영역 END -->
			
			<!-- 조회조건 영역 -->
			<div id="searchDivBox" class="search_box relative">
				<p class="required_input absolute"><span class="required"></span>항목은 필수 입력 항목입니다.</p>
				<div class="row clear">
					<div id="search_1_1"></div>
					<div id="search_1_2"></div>
					<div id="search_1_3"></div>
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