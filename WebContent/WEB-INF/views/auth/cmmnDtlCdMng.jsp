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
		
		// 공통코드 정보
// 		fn_compoInputboxReadOnly('M', 'I', 'detail_1_1', 'CODE_SE', 'CODE_SE', '', '코드구분');
// 		fn_compoInputboxReadOnly('M', 'I', 'detail_1_2', 'CODE_NM', 'CODE_NM', '', '코드구분명');
// 		fn_compoInputboxReadOnly('M', 'I', 'detail_1_3', 'CODE_DC', 'CODE_DC', '', '코드구분 설명');
		
		// 코드상세 정보
	}
	
	// 조회 버튼
	function fn_search(){
		var url = "/auth/cmmnDtlCdMng.do";
		goSearch(url);
	}
	
	// 페이징 조회
	function pageCall(pageNo) {
		var url = "/auth/cmmnDtlCdMng.do";
		goPageCall(url, pageNo);
	}
	
	// 그리드에서 상세보기를 위한 row onclick 이벤트
	function fn_gridDetailOnclick(obj, trId){
		
		pageLoadingShow();
				
		// 선택한 row 키값 셋팅
		var paramCodeSe = $('#' + trId).find('input[name^=CODE_SE]').val();
		$.ajax({
			url : '/auth/cmmnDtlCdMngDetail.do',
			data : {CODE_SE:paramCodeSe},   //전송파라미터
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				var d = result.detailMapList;
				var str = '';
				if(d.length > 0){
					for(var i = 0; i < d.length; i++){
						var val1 = d[i].CODE_SE;
						var val2 = d[i].CODE_NM;
						var val3 = d[i].DTLCODE == undefined ? '' : d[i].DTLCODE;
						var val4 = d[i].DTLCODE_NM == undefined ? '' : d[i].DTLCODE_NM;
						var val8 = d[i].DTLCODE_ENG_NM == undefined ? '' : d[i].DTLCODE_ENG_NM;
						var val5 = d[i].DTLCODE_DC == undefined ? '' : d[i].DTLCODE_DC;
						var val6 = d[i].ORDR == undefined ? '' : d[i].ORDR;
						var val7 = d[i].USE_AT;
						var checked
						
						str += '<tr id="tr'+i+'">';
							str += '<td><input type="checkbox" name="rowCheck" onclick="javascript:fn_chk();"></td>';
							str += '<td><input type="hidden" name="CODE_SE">' + val1 + '</td>';
							str += '<td><input type="hidden" name="CODE_NM">' + val2 + '</td>';
							str += '<td><input type="text" name="DTLCODE" value="'+val3+'" /></td>';
							str += '<td><input type="text" name="DTLCODE_NM" value="'+val4+'" /></td>';
							str += '<td><input type="text" name="DTLCODE_ENG_NM" value="'+val8+'" /></td>';
							str += '<td><input type="text" name="DTLCODE_DC" value="'+val5+'" /></td>';
							str += '<td><input type="text" name="ORDR" maxlength="3" value="'+val6+'" /></td>';
							str += '<td>';
								str += '<select name="USE_AT">';
									if(val7 == 'Y'){
										str += '<option value="Y" selected>사용</option>';
										str += '<option value="N">사용안함</option>';
									}else{
										str += '<option value="Y">사용</option>';
										str += '<option value="N" selected>사용안함</option>';
									}
								str += '</select>';
							str += '</td>';
						str += '</tr>';
					}
				}else{
					str += '<tr id="trNoData">';
						str += '<td style="text-align: center;" colspan="9">조회된 데이터가 없습니다.</td>';
					str += '</tr>';
				}
				
				$('#detailTbody').html(str);
				
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
			complete : function(result) { // success, error 실행 후 최종적으로 실행
				setTimeout(function(){ pageLoadingHide(); }, 100);
			}
		});
		
	}

	function fn_add(){
		
		var codeSe = '';
		var codeNm = '';
		
		$('#grid').find('tr').each(function(idx){
			var classNm = $(this).attr('class');
			if(classNm == 'active' || classNm == 'even active'){
				var $td = $(this).children();
				codeSe = $td.eq(0).text();
				codeNm = $td.eq(1).text();
			}
		});
		
		if(codeSe == ''){
			alert('선택된 코드구분이 없습니다.');
			return;
		}

		if($('#trNoData').length == 1){
			$('#trNoData').remove();
		}
		
		// Tr 갯수
		var trLen = $('#detailTbody').find('tr').length;
		
		var str = '';
		str += '<tr id="tr'+trLen+'">';
			str += '<td><input type="checkbox" name="rowCheck" onclick="javascript:fn_chk();"></td>';
			str += '<td><input type="hidden" name="CODE_SE">' + codeSe + '</td>';
			str += '<td><input type="hidden" name="CODE_NM">' + codeNm + '</td>';
			str += '<td><input type="text" name="DTLCODE" value="" /></td>';
			str += '<td><input type="text" name="DTLCODE_NM" value="" /></td>';
			str += '<td><input type="text" name="DTLCODE_ENG_NM" value="" /></td>';
			str += '<td><input type="text" name="DTLCODE_DC" value="" /></td>';
			str += '<td><input type="text" name="ORDR" maxlength="3" value="" /></td>';
			str += '<td>';
				str += '<select name="USE_AT">';
					str += '<option value="Y">사용</option>';
					str += '<option value="N">사용안함</option>';
				str += '</select>';
			str += '</td>';
		str += '</tr>';
		
		$('#detailTbody').prepend(str);
		
	}
	
	// 행삭제 버튼
	function fn_delete(){
		$('input:checkbox[name=rowCheck]:checked').each(function(idx){
			$(this).parent().parent().remove();
		});
		
		//tr id 번호 재정의
		$('#detailTbody').find('tr').each(function(idx){
			$(this).attr('id', 'tr' + idx);
		});
	}

	// 저장 버튼
	function fn_save(){
		
		var bool = true;
		
		// 필수 입력 체크
		$('#detailTbody').find('tr').each(function(idx){
			if(!bool){return;}
			var $td = $(this).children();
			var dtlCode = $td.eq(3).children().val(); //DTLCODE
			var dtlCodeNm = $td.eq(4).children().val(); //DTLCODE_NM
			
			if(dtlCode == ''){
				alert((idx + 1) + '행의 상세코드는 필수 입력입니다.');
				$td.eq(3).children().focus();
				bool = false;
				return;
			}
			if(dtlCodeNm == ''){
				alert((idx + 1) + '행의 상세코드명은 필수 입력입니다.');
				$td.eq(4).children().focus();
				bool = false;
				return;
			}
			
		});
		if(!bool){return;}
		
		// 키 중복 체크
		var tmpArr = new Array(); // 키 중복 체크를 위해 배열에 키값을 셋팅한다
		$('#detailTbody').find('tr').each(function(idx){
			if(!bool){return;}
			var $td = $(this).children();
			var dtlCode = $td.eq(3).children().val(); //DTLCODE

			if(tmpArr.indexOf(dtlCode) == -1){
				tmpArr.push(dtlCode);
			}else{
				alert('중복된 상세코드가 존재합니다.');
				bool = false;
				return;
			}
		});
		if(!bool){return;}
		
		
		var result = confirm('저장하시겠습니까?');
		if(result){
			
			pageLoadingShow();
			
			var codeSeArr = new Array();
			var dtlcodeArr = new Array();
			var dtlcodeNmArr = new Array();
			var dtlcodeEngNmArr = new Array();
			var dtlcodeDcArr = new Array();
			var ordrArr = new Array();
			var useAtArr = new Array();
			
			$('#detailTbody').find('tr').each(function(idx){
				var $td = $(this).children();
				codeSeArr[idx] = $td.eq(1).text();
				dtlcodeArr[idx] = $td.eq(3).children().val() == '' ? ' ' : $td.eq(3).children().val(); //DTLCODE
				dtlcodeNmArr[idx] = $td.eq(4).children().val() == '' ? ' ' : $td.eq(4).children().val(); //DTLCODE_NM
				dtlcodeEngNmArr[idx] = $td.eq(5).children().val() == '' ? ' ' : $td.eq(5).children().val(); //DTLCODE_ENG_NM
				dtlcodeDcArr[idx] = $td.eq(6).children().val() == '' ? ' ' : $td.eq(6).children().val(); //DTLCODE_DC
				ordrArr[idx] = $td.eq(7).children().val() == '' ? ' ' : $td.eq(7).children().val(); //ORDR
				useAtArr[idx] = $td.eq(8).children().val() == '' ? ' ' : $td.eq(8).children().val(); //USE_AT
			});
			
			if(codeSeArr == "" || codeSeArr == null){
				codeSeArr[0] = "";
				dtlcodeArr[0] = "";
				dtlcodeNmArr[0] = "";
				dtlcodeEngNmArr[0] = "";
				dtlcodeDcArr[0] = "";
				ordrArr[0] = "";
				useAtArr[0] = "";
			}
			
			var CODE_SE = "";
			$('#grid').find('tr').each(function(idx){
				var classNm = $(this).attr('class');
				if(classNm == 'active' || classNm == 'even active'){
					var $td = $(this).children();
					CODE_SE = $td.eq(0).text();
				}
			});
			
			var paramData = {'codeSe':CODE_SE,'codeSeArr':codeSeArr, 'dtlcodeArr':dtlcodeArr, 'dtlcodeNmArr':dtlcodeNmArr, 'dtlcodeEngNmArr':dtlcodeEngNmArr, 'dtlcodeDcArr':dtlcodeDcArr, 'ordrArr':ordrArr, 'useAtArr':useAtArr};
						
			$.ajax({
				url : '/auth/saveCmmnDtlCdMng.do',
				data : paramData,   //전송파라미터
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					alert('저장되었습니다.');
				},
				error : function() { // Ajax 전송 에러 발생시 실행
					alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
				},
				complete : function(result) { // success, error 실행 후 최종적으로 실행
					setTimeout(function(){ pageLoadingHide(); }, 100);
				}
			});
		}
	}
	function fn_allChk(){
		if($('#allChk').prop("checked")){
			$("input[name=rowCheck]").prop("checked", true);
		}else{
			$("input[name=rowCheck]").prop("checked", false);
		}
	}
	
	function fn_chk(){	
		if($("input[name=rowCheck]:checked").length == $("input[name=rowCheck]").length){
			$("#allChk").prop("checked", true);
		}else{
			$("#allChk").prop("checked", false);
		}
	}
	

</script>
<title>티디아 우선심사 시스템</title>
</head>
<body>
	<form name="form" method="post">
		<!-- KEY 컴포넌트가 없는 경우 hidden 생성 -->
		<input type="hidden" name="CODE_SE">
		
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
<%-- 				<button type="button" id="newBtn"><span></span><c:out value="${ssITEM6 }" /></button><!-- 신규버튼 function 구현 필요 없음 --> --%>
<%-- 				<button type="button" id="delBtn" onclick="javascript:fn_delete();return false;"><span></span><c:out value="${ssITEM7 }" /></button><!-- 삭제버튼 --> --%>
<%-- 				<button type="button" id="saveBtn" onclick="javascript:fn_save();return false;"><span></span><c:out value="${ssITEM8 }" /></button><!-- 저장버튼 --> --%>
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

			<c:if test="${totalCnt > 0 }">
				<div class="button_box">
					<button type="button" id="newRowBtn" onclick="javascript:fn_add();return false;"><span></span>행추가</button><!-- 신규버튼 function 구현 필요 없음 -->
					<button type="button" id="delRowBtn" onclick="javascript:fn_delete();return false;"><span></span>행삭제</button><!-- 삭제버튼 -->
					<button type="button" id="saveBtn" onclick="javascript:fn_save();return false;"><span></span><c:out value="${ssITEM8 }" /></button><!-- 저장버튼 -->
				</div>
				<!-- 상세 그리드 영역 -->
				<div class="grid_box" style="margin-top: 25px; overflow: auto; height: 400px;">
					<table class="list_table2">
						<colgroup>
							<col width="3%">
							<col width="8%">
							<col width="12%">
							<col width="8%">
							<col width="12%">
							<col width="12%">
							<col width="*">
							<col width="8%">
							<col width="8%">
						</colgroup>
						<thead>
							<tr class="th">
								<th><input type="checkbox" id="allChk" onclick="javascript:fn_allChk();"></th>
								<th>코드구분</th>
								<th>코드구분명</th>
								<th>상세코드</th>
								<th>상세코드명</th>
								<th>상세코드 영문명</th>
								<th>상세코드 설명</th>
								<th>순서</th>
								<th>사용여부</th>
							</tr>
						</thead>
						<tbody id="detailTbody">
							<tr>
								<td style="text-align: center;" colspan="9">조회된 데이터가 없습니다.</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 상세 그리드 영역 END-->
			</c:if>
		</div>
	</form>
</body>
</html>