<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
	<script type="text/javascript">
	// 버튼영역 설정
	function fn_buttonCompoSetting(){
		
	}
	// 검색영역 설정
	function fn_searchCompoSetting(){
		//인사 검색영역
		fn_compoInputbox('M', 'S', 'search_1_1', 'SEARCH_EMP_ID', 'SEARCH_EMP_ID', '', '사번', '', '');
// 		fn_compoInputbox('M', 'S', 'search_1_2', 'SEARCH_DEPART', 'SEARCH_DEPART', '', '부서', '', '');
		fn_compoSelApprDepart('M', 'S', 'search_1_2', 'SEARCH_DEPART', 'SEARCH_DEPART', '', '부서', '', '');
		fn_compoInputbox('M', 'S', 'search_1_3', 'SEARCH_POSITION_USER', 'SEARCH_POSITION_USER', '', '직위(급)', '', '');
		
		fn_compoInputbox('M', 'S', 'search_2_1', 'SEARCH_EMP_NM', 'SEARCH_EMP_NM', '', '이름', '', '');
		fn_compoInputbox('M', 'S', 'search_2_2', 'SEARCH_CELL_PH_NO', 'SEARCH_CELL_PH_NO', '', '핸드폰번호', '', '');
		fn_compoSelApprStat('M', 'S', 'search_2_3', 'SEARCH_CNFIRM_AT', 'SEARCH_CNFIRM_AT', '', '승인상태');
	}
	$(document).ready(function() {
		fn_searchCompoSetting();
	
		//검색조건 유지 
	});
	</script>
</head>
<div>
			<div class="box-blue-line clear relative">
			<!-- 상단버튼 영역 -->
			<div id="buttonDivBox" class="button_box">
				<button type="button" id="searchBtn" onclick="javascript:fn_search();return false;"><span></span><c:out value="${ssITEM5 }" /></button><!-- 조회버튼 -->
<%-- 				<button type="button" id="apprBtn"><span></span><c:out value="${ssITEM9 }" /></button><!-- 승인버튼 --> --%>
<%-- 				<button type="button" id="excelDownBtn" onclick="javascript:fn_excelDownload();return false;"><span></span><c:out value="${ssITEM10 }" /></button><!-- 엑셀다운로드버튼 --> --%>
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
			</div>
			<!-- 조회조건영역 END -->

</div>
</html>