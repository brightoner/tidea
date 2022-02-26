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
		
		// 검색조건 유지
		$('input[id=SEARCH_COL1]').val('${param.SEARCH_COL1}');
		$('input[id=SEARCH_COL2]').val('${param.SEARCH_COL2}');
		$('input[id=SEARCH_COL3]').val('${param.SEARCH_COL3}');
		
	});
	
	// 버튼영역 설정
	function fn_buttonCompoSetting(){
		
	}
	
	// 검색영역 설정
	function fn_searchCompoSetting(){
		fn_compoInputbox('M', 'S', 'search_1_1', 'SEARCH_COL1', 'SEARCH_COL1', 'Y', 'COL1');
		fn_compoInputbox('M', 'S', 'search_1_2', 'SEARCH_COL2', 'SEARCH_COL2', '', 'COL2');
		fn_compoInputbox('M', 'S', 'search_1_3', 'SEARCH_COL3', 'SEARCH_COL3', '', 'COL3');
	}
	
	// 그리드 설정
	var cols = ['COL1', 'COL2', 'COL3'];
	var colsNm = ['컬럼1', '컬럼2', '컬럼3'];
	var key = ['SN'];
	function fn_gridCompoSetting(){
		fn_compoGrid('M', 'grid', cols, colsNm, key);
		fn_gridColgroupSetting('grid', ['10%', '20%', '*']); // colgroup 설정
		fn_gridAlignSetting('grid', ['left', 'center', 'right']); // 그리드 데이터 정렬 설정(종류:left, center, right)
		
	}
	
	// 입력 및 상세영역 설정
	function fn_inputNdetailCompoSetting(){
		fn_compoInputbox('M', 'I', 'inputNdetail_1_1', 'COL1', 'COL1', 'Y', '컬럼1');
		fn_compoInputbox('M', 'I', 'inputNdetail_1_2', 'COL1', 'COL1', '', '컬럼2');
		fn_compoInputbox('M', 'I', 'inputNdetail_1_3', 'COL1', 'COL1', '', '컬럼3');
	}
	
	// 조회
	function fn_search(){
		if(!searchRequiredCheck()){return false;} // 조회 필수 입력 체크
		form.action = "/sample/sampleScreen2.do";
		goSubmit(form);
	}
	
	// 페이징 조회
	function pageCall(pageNo) {
	    $("#curPage").val(pageNo);
		form.action = "/sample/sampleScreen2.do";
		goSubmit(form);
	}
	
	// 삭제 버튼
	function fn_delete(){
		if(!detailDeleteCheck()){return false;} // 삭제할 대상이 존재하는지 체크
		var result = confirm(gb_delMsg);
		if(result){
			
		}
	}
	
	// 저장 버튼
	function fn_save(){
		if(!inputNdetailRequiredCheck()){return false;} // 저장 필수 입력 체크
		var result = confirm(gb_saveMsg);
		if(result){
			
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
		
		// 선택한 row 키값 셋팅
		$('input[name=SN]').val($('#' + trId).find('input[name^=SN]').val());
		
		var params = {};
		params.SN = $('input[name=SN]').val();
		
		$.ajax({
			url : '/sample/sampleDetail.do',
			data : params,   //전송파라미터
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				var d = result.detailMap;
				$('input[name=COL1]').val(d.COL1);
				$('input[name=COL2]').val(d.COL2);
				$('input[name=COL3]').val(d.COL3);
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
		<input type="hidden" name="SN" />
		
		<!-- 컴포넌트 사용을 위한 include jsp -->
		<jsp:include flush="false" page="../common/commonComponent.jsp"></jsp:include>
		
		<div class="menu_name clear">
			샘플화면
			<div class="navi">
				<img width="15" class="home_icon" src="/resources/images/home.png">홈 > 샘플화면
			</div>
		</div>
		<c:out value=""  />
		<div class="box-blue-line clear relative">
			<!-- 상단버튼 영역 -->
			<div id="buttonDivBox" class="button_box">
				<button type="button" id="searchBtn" onclick="javascript:fn_search();return false;">조회</button>
				<button type="button" id="newBtn" onclick="javasciprt:fn_newForm();return false;">신규</button><!-- function 구현 필요 없음 -->
				<button type="button" id="delBtn" onclick="javascript:fn_delete();return false;">삭제</button>
				<button type="button" id="saveBtn" onclick="javascript:fn_save();return false;">저장</button>
				<button type="button" id="apprBtn" onclick="javascript:fn_approval();return false;">승인</button>
				<button type="button" id="excelDownBtn" onclick="javascript:fn_excelDownload();return false;">엑셀다운로드</button>
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
				<p class="title">샘플화면 <span id="modeSpan">등록</span></p>
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