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
		if('${param.searchYn}' != 'Y'){return}
		$('#SEARCH_INSTRCTR').val('${param.SEARCH_INSTRCTR}');
		$('#SEARCH_INSTRCTR_PST').val('${param.SEARCH_INSTRCTR_PST}');
		$('#SEARCH_MAJOR_REALM').val('${param.SEARCH_MAJOR_REALM}');
		$('#SEARCH_INTRST_REALM').val('${param.SEARCH_INTRST_REALM}');
	});
	
	// 버튼영역 설정
	function fn_buttonCompoSetting(){
		
	}
	
	// 검색영역 설정
	function fn_searchCompoSetting(){
		fn_compoInputbox('M', 'S', 'search_1_1', 'SEARCH_INSTRCTR', 'SEARCH_INSTRCTR', '', '${ssITEM26}');
		fn_compoInputbox('M', 'S', 'search_1_2', 'SEARCH_INSTRCTR_PST', 'SEARCH_INSTRCTR_PST', '', '${ssITEM27}');
		fn_compoInputbox('M', 'S', 'search_1_3', 'SEARCH_MAJOR_REALM', 'SEARCH_MAJOR_REALM', '', '${ssITEM111}');
		
		fn_compoInputbox('M', 'S', 'search_2_1', 'SEARCH_INTRST_REALM', 'SEARCH_INTRST_REALM', '', '${ssITEM112}');
	}
	
	// 그리드 설정
	var cols = ['INSTRCTR', 'INSTRCTR_PST', 'LAST_ACDMCR', 'MAJOR_REALM', 'INTRST_REALM']; //예) var cols = ['COL1', 'COL2', 'COL3', 'COL4', 'COL5'];
	var colsNm = ['${ssITEM26}', '${ssITEM27}', '${ssITEM110}', '${ssITEM111}', '${ssITEM112}']; //예) var colsNm = ['학년도', '학기',var colsNm = ['학년도', '학기', '성명', '학번', '시작일시'];
	var key = ['KEY']; //예) var key = ['SN', 'HAKBEON'];
	function fn_gridCompoSetting(){
		fn_compoGrid('M', 'grid', cols, colsNm, key);
		fn_gridColgroupSetting('grid', ['18%', '15%', '*', '21%', '23%']); // colgroup 설정
		fn_gridAlignSetting('grid', ['center', 'center', 'left', 'center', 'center']); // 그리드 데이터 정렬 설정(종류:left, center, right)
	}
	
	// 입력 및 상세영역 설정
	function fn_inputNdetailCompoSetting(){
		fn_compoInputbox('M', 'I', 'inputNdetail_1_1', 'INSTRCTR', 'INSTRCTR', '', '${ssITEM26}');
		fn_compoInputbox('M', 'I', 'inputNdetail_1_2', 'INSTRCTR_PST', 'INSTRCTR_PST', '', '${ssITEM27}');
		fn_compoInputbox('M', 'I', 'inputNdetail_1_3', 'LAST_ACDMCR', 'LAST_ACDMCR', '', '${ssITEM110}');
		
		fn_compoInputbox('M', 'I', 'inputNdetail_2_1', 'MAJOR_REALM', 'MAJOR_REALM', '', '${ssITEM111}');
		fn_compoInputbox('M', 'I', 'inputNdetail_2_2', 'INTRST_REALM', 'INTRST_REALM', '', '${ssITEM112}');
	}
	// 조회 버튼
	function fn_search(){
		var url = "/auth/instructorMng.do";
		goSearch(url);
	}
	
	// 페이징 조회
	function pageCall(pageNo) {
		var url = "/auth/instructorMng.do";
		goPageCall(url, pageNo);
	}
	
	// 삭제 버튼
	function fn_delete(){
		if(!detailDeleteCheck()){return false;} // 삭제할 대상이 존재하는지 체크
		var result = confirm(gb_delMsg);
		if(result){
			form.action = "/auth/deleteInstructorMng.do";
			goSubmit(form);
		}
	}
	
	// 저장 버튼
	function fn_save(){
		if(!inputNdetailRequiredCheck()){return false;} // 저장 필수 입력 체크
		var result = confirm(gb_saveMsg);
		if(result){
			form.action = "/auth/saveInstructorMng.do";
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
		
		// 선택한 row 키값 셋팅
		$('input[name=KEY]').val($('#' + trId).find('input[name^=KEY]').val());
		$.ajax({
			url : '/auth/instructorMngDetail.do',
			data : {KEY:$('input[name=KEY]').val()},   //전송파라미터
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				var d = result.detailMap;
				$('input[name=INSTRCTR]').val(d.INSTRCTR);
				$('input[name=INSTRCTR_PST]').val(d.INSTRCTR_PST);
				$('input[name=LAST_ACDMCR]').val(d.LAST_ACDMCR);
				$('input[name=MAJOR_REALM]').val(d.MAJOR_REALM);
				$('input[name=INTRST_REALM]').val(d.INTRST_REALM);
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
<!-- 		<input type="hidden" name="KEY" /> -->
		
		<!-- 컴포넌트 사용을 위한 include jsp -->
		<jsp:include flush="false" page="../common/commonComponent.jsp"></jsp:include>
		
		<div class="title_name relative">
			강사관리
			<div class="navi absolute">
				<span><a href=""><img width="15" class="home_icon" src="/resources/images/home.png"></a></span>>
				<span><a href="">관리자</a></span> > 
				<span><a href="">강사관리</a></span>
			</div>
		</div>
		<c:out value=""  />
		<div class="box-blue-line clear relative">
			<!-- 상단버튼 영역 -->
			<div id="buttonDivBox" class="button_box">
				<button type="button" id="searchBtn" onclick="javascript:fn_search();return false;"><span></span><c:out value="${ssITEM5 }" /></button><!-- 조회버튼 -->
				<button type="button" id="newBtn"><span></span><c:out value="${ssITEM6 }" /></button><!-- 신규버튼 function 구현 필요 없음 -->
				<button type="button" id="delBtn" onclick="javascript:fn_delete();return false;"><span></span><c:out value="${ssITEM7 }" /></button><!-- 삭제버튼 -->
				<button type="button" id="saveBtn" onclick="javascript:fn_save();return false;"><span></span><c:out value="${ssITEM8 }" /></button><!-- 저장버튼 -->
<%-- 				<button type="button" id="apprBtn"><span></span><c:out value="${ssITEM9 }" /></button><!-- 승인버튼 --> --%>
<%-- 				<button type="button" id="apprCancelBtn"><span></span><c:out value="${ssITEM90 }" /></button><!-- 승인취소버튼 --> --%>
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
</body>
</html>