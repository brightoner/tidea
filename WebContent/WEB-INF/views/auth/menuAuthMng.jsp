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
		$('#SEARCH_AUTH_NM').val('${param.SEARCH_AUTH_NM}');
		
	});
	
	// 버튼영역 설정
	function fn_buttonCompoSetting(){
		
	}
	
	function fn_allChk(){
		if($('#allChk').prop("checked")){
			$("input[name=MENU_USE_AUTH]").prop("checked", true);
		}else{
			$("input[name=MENU_USE_AUTH]").prop("checked", false);
		}
	}
	
	function fn_chk(levl,menu_id){
		var lgth = $('input[id^='+menu_id+'_'+']').length;
		var chk = 0;
		if(levl == 0){
				$('#detailTbody').find('tr').each(function(idx){
					var $td = $(this).children();
						if($td.eq(4).children().attr('id') == menu_id){
							return true;
						}else if($td.eq(4).children().attr('id').indexOf(menu_id+'_') != -1){
							if($td.eq(4).children().is(':checked') == false){
								chk++;
							}
						}
				});
			
				if(lgth != chk){
					alert('하위항목 제거 후 해제해주십시요.');
					$('#'+menu_id).prop('checked',true);
				}
		}else{
			var chkStr = "N";
			$('#detailTbody').find('tr').each(function(idx){
				chk = 0;
				var $td = $(this).children();
					if($td.eq(4).children().attr('id').indexOf(menu_id+'_') != -1){
						var trChild = $td.eq(4).children().attr('id');
						if($('input[id='+menu_id+']').is(':checked') == false){
							chkStr = "Y";
							$('#'+trChild).prop('checked',false);
						}
					}
					
			});
			if(chkStr == "Y"){
				alert('상위항목 체크 후 선택해주십시요.');
			}
			
		}
		
		if($("input[name=MENU_USE_AUTH]:checked").length == $("input[name=MENU_USE_AUTH]").length){
			$("#allChk").prop("checked", true);
		}else{
			$("#allChk").prop("checked", false);
		}
	}
	
	// 검색영역 설정
	function fn_searchCompoSetting(){
		fn_compoInputbox('M', 'S', 'search_1_1', 'SEARCH_AUTH_NM', 'SEARCH_AUTH_NM', '', '권한명');
	}
	
	// 그리드 설정
	var cols = ['AUTH_CD', 'AUTH_NM', 'ETC', 'USE_AT', 'WRTER', 'RGSDE', 'UPDDE']; //예) var cols = ['COL1', 'COL2', 'COL3'];
	var colsNm = ['권한코드', '권한명', '비고', '사용여부', '작성자', '등록일', '수정일']; //예) var colsNm = ['컬럼한글명1', '컬럼한글명2', '컬럼한글명3'];
	var key = ['KEY1']; //예) var key = ['SN', 'HAKBEON'];
	function fn_gridCompoSetting(){
		fn_compoGrid('M', 'grid', cols, colsNm, key);
		fn_gridColgroupSetting('grid', ['10%', '20%', '*', '5%', '15%', '10%', '10%']); // colgroup 설정
		fn_gridAlignSetting('grid', ['center', 'left', 'left', 'center', 'center', 'center', 'center']); // 그리드 데이터 정렬 설정(종류:left, center, right)
	}
	
	// 입력 및 상세영역 설정
	function fn_inputNdetailCompoSetting(){
		fn_compoInputbox('M', 'I', 'inputNdetail_1_1', 'AUTH_CD', 'AUTH_CD', 'Y', '권한코드');
		fn_compoInputbox('M', 'I', 'inputNdetail_1_2', 'AUTH_NM', 'AUTH_NM', 'Y', '권한명');
		fn_compoInputbox('M', 'I', 'inputNdetail_1_3', 'etc', 'etc', '', '비고');
		
		fn_compoRadioYn('M', 'I', 'inputNdetail_2_1', 'USE_AT', 'USE_AT', '', '사용여부');
	}
	
	// 조회 버튼
	function fn_search(){
		var url = "/auth/menuAuthCdMng.do";
		goSearch(url);
	}
	
	// 페이징 조회
	function pageCall(pageNo) {
		var url = "/auth/menuAuthCdMng.do";
		goPageCall(url, pageNo);
	}
	
	// 저장 버튼
	function fn_save(){
		
		var authArr = new Array();
		var menuIdArr = new Array();
		var authCd = $('#auth_cd').val();
		
		if(!inputNdetailRequiredCheck()){return false;} // 저장 필수 입력 체크
		var result = confirm('저장하시겠습니까?');
		
		
		
		if(result){
			pageLoadingShow();
			$('#detailTbody').find('tr').each(function(idx){
				var $td = $(this).children();
					authArr[idx] = $td.eq(4).children().is(':checked') == true ? 'Y' : 'N';
					menuIdArr[idx] = $td.eq(2).children().val() == '' ? ' ' : $td.eq(2).children().val();
			});
			
			
			var paramData = {'authCd':authCd,'authArr':authArr,'menuIdArr':menuIdArr};
		
			$.ajax({
				url : '/auth/saveMenuAuthDtlMng.do',
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
	
	
	// 그리드에서 상세보기를 위한 row onclick 이벤트
	function fn_gridDetailOnclick(obj, trId){
		
// 		pageLoadingShow();
		
		var auth = $('#' + trId).find('input[name^=KEY1]').val();

		// 선택한 row 키값 셋팅
		$.ajax({
			url : '/auth/menuAuthMngDetail.do',
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				var d = result.authMenuList;
				var str = '';
				if(d.length > 0){
					for(var i = 0; i < d.length; i++){
						var val1 = d[i].menu_prts_id == '0' ? '' : d[i].menu_prts_id;
						var val2 = d[i].menu_levl;
						var val3 = d[i].menu_id == undefined ? '' : d[i].menu_id;
						var val4 = d[i].menu_nm == undefined ? '' : d[i].menu_nm;
						var val5 = d[i].menu_use_yn == 'Y' ? '사용' : '미사용';
						var val6 = d[i].menu_use_auth == undefined ? '' : d[i].menu_use_auth;
						var checked
						
						str += '<tr id="tr'+i+'">';
							if(val1 == ''){
								str += '<td><input type="text" name="MENU_PRTS_ID" value="'+val4+'" readonly  style="text-align: center;"/></td>';
								str += '<td><input type="text" name="MENU_NM" value="" readonly/></td>';
							}else{
								str += '<td><input type="text" name="MENU_PRTS_ID" value="" readonly  style="text-align: center;"/></td>';
								str += '<td><input type="text" name="MENU_NM" value="'+val4+'" readonly/></td>';
							}
							str += '<td><input type="hidden" name="MENU_ID" value="'+val3+'" readonly/><input type="text" name="MENU_LEVL" value="'+val2+'" readonly  style="text-align: center;"/></td>';
							str += '<td><input type="text" name="MENU_USE_YN" value="'+val5+'" readonly  style="text-align: center;"/></td>';
							if(val6.indexOf(auth) > -1){
								if(val2 == 0){
									str += '<td style="text-align: center;"><input type="checkbox" id="'+val3+'" name="MENU_USE_AUTH" onclick="javascript:fn_chk('+val2+',\''+val3+'\');" checked="checked"></td>';
								}else{
									str += '<td style="text-align: center;"><input type="checkbox" id="'+val1+"_"+val3+'" name="MENU_USE_AUTH" onclick="javascript:fn_chk('+val2+',\''+val1+'\');" checked="checked"></td>';
								}
							}else{
								if(val2 == 0){
									
									str += '<td style="text-align: center;"><input type="checkbox" id="'+val3+'" name="MENU_USE_AUTH" onclick="javascript:fn_chk('+val2+',\''+val3+'\');"></td>';
								}else{
									str += '<td style="text-align: center;"><input type="checkbox" id="'+val1+"_"+val3+'" name="MENU_USE_AUTH" onclick="javascript:fn_chk('+val2+',\''+val1+'\');"></td>';
								}
							}
						str += '</tr>';
					}
				}else{
					str += '<tr id="trNoData">';
						str += '<td style="text-align: center;" colspan="9">조회된 데이터가 없습니다.</td>';
					str += '</tr>';
				}
				
				$('#detailTbody').html(str);
				$('#auth_cd').val(auth);
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
			complete : function(result) { // success, error 실행 후 최종적으로 실행
				setTimeout(function(){ pageLoadingHide(); }, 100);
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
			메뉴권한 관리
			<div class="navi absolute">
				<span><a href=""><img width="15" class="home_icon" src="/resources/images/home.png"></a></span>>
				<span><a href="">관리자</a></span> > 
				<span><a href="">메뉴권한 관리</a></span>
			</div>
		</div>
		
		<div class="box-blue-line clear relative">
			<!-- 상단버튼 영역 -->
			<div id="buttonDivBox" class="button_box">
				<button type="button" id="searchBtn" onclick="javascript:fn_search();return false;"><span></span><c:out value="${ssITEM5 }" /></button><!-- 조회버튼 -->
			</div>
			<!-- 상단버튼 영역 END -->
			
			<!-- 조회조건 영역 -->
			<div id="searchDivBox" class="search_box relative">
				<span class="required_input absolute"><span class="required"></span>항목은 필수 입력 항목입니다.</span>
				<div class="row clear">
					<div id="search_1_1"></div>
					<div id="search_1_2"></div>
				</div>
				
			</div>
			<!-- 조회조건영역 END -->
			
			<!-- 그리드 영역 -->
			<div id="grid"></div>
			<!-- 그리드 영역 END -->

			<!-- 입력 및 상세영역 -->
			<c:if test="${totalCnt > 0 }">
				<div class="button_box" style="margin-top:5px;">
					<button type="button" id="saveBtn" onclick="javascript:fn_save();return false;"><span></span><c:out value="${ssITEM8 }" /></button><!-- 저장버튼 -->
				</div>
				<!-- 상세 그리드 영역 -->
				<div class="grid_box grid_box2">
					<table class="list_table2">
						<colgroup>
							<col width="25%">
							<col width="*">
							<col width="10%">
							<col width="10%">
							<col width="10%">
						</colgroup>
						<thead>
							<tr class="th">
								<th>상위메뉴</th>
								<th>메뉴명</th>
								<th>메뉴레벨</th>
								<th>사용여부</th>
								<th><input type="checkbox" id="allChk" onclick="javascript:fn_allChk();"></th>
							</tr>
						</thead>
						<tbody id="detailTbody" class="border_bottom_table">
							<tr>
								<td style="text-align: center;" colspan="9">조회된 데이터가 없습니다.</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 상세 그리드 영역 END-->
			</c:if>
			<!-- 입력 및 상세영역 END -->
		</div>
		<!-- 권한코드 -->
		<input type="hidden" id="auth_cd" name="auth_cd"/>
	</form>
</body>
</html>