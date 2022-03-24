<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
/* 파라메터 설명
 * ■ mpGubun : (필수)화면 종류가 메인인지 팝업인지 구분('M' => 메인, 'P' => 팝업)
 * ■ searchInputGb : 검색영역인지 입력/상세영역인지 구분('S' => 검색영역, 'I' => 입력 및 상세영역)
 * ■ divId : 컴포넌트를 삽입할 DIV영역 아이디
 * ■ tagId : id 지정
 * ■ tagName : name 지정
 * ■ tagId1 : id 지정(입력항목이 2개인 경우)
 * ■ tagName1 : name 지정(입력항목이 2개인 경우)
 * ■ tagId2 : id 지정(입력항목이 2개인 경우)
 * ■ tagName2 : name 지정(입력항목이 2개인 경우)
 * ■ requiredYn : 필수항목 여부('Y' 또는 'N')
 * ■ label : 항목명 설정(예> '봉사실적신청번호')
 * ■ width : 컴포넌트가 위치하는 행의 컴포넌트 길이(3이면 3칸 max=3)
 * ■ cols : <그리드 컴포넌트> 그리드에 표현할 데이타 컬럼명
 * ■ colsNm : <그리드 컴포넌트> 그리드에 표현할 항목명
 * ■ key : <그리드 컴포넌트> 그리드를 클릭하여 상세조회를 위한 key값 셋팅
 * ■ gridCheckboxYn : <그리드 컴포넌트> 체크박스포함 여부('Y' or 'N')
 * ■ rdOnlyOrDisablYn : 셀렉트박스 Disabled 여부
 * ■ hakkiType : 학기구분코드 종류
 * */
var requiredSpan = '<span class="required"></span>';
var gb_saveMsg;
var gb_delMsg;
var gb_mode; // 등록or상세
var gb_curPage = '${param.curPage}' == '' ? '1' : '${param.curPage}';
var gb_auth = '${SS_LOGIN_INFO.AUTH}';
// 1.년도 및 학기 컴포넌트
function fn_compoYearHakki(mpGubun, searchInputGb, divId, tagId1, tagName1, tagId2, tagName2, requiredYn, label, hakkiType){
	
	// 년도목록
	var yearOptionList = getYearComboboxList();
	
	// 학기목록
	var hakkiOptionList = '';
	if(hakkiType == '2'){
		hakkiOptionList = getCmmnCdList("CD000030");
	}else{
		hakkiOptionList = getCmmnCdList("CD000011");
	}
	// 학기목록
	//var hakkiOptionList = getCmmnCdList("CD000011");
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col col2 clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div>';
					tagStr += '<select id="'+tagId1+'" name="'+tagName1+'">';
					if(searchInputGb == 'S'){
						tagStr += '<option value="">전체</option>';
					}
						tagStr += yearOptionList;
					tagStr += '</select>';
				tagStr += '</div>';
				tagStr += '<div>';
					tagStr += '<select id="'+tagId2+'" name="'+tagName2+'">';
					if(searchInputGb == 'S'){
						tagStr += '<option value="">전체</option>';
					}
					tagStr += hakkiOptionList;
					tagStr += '</select>';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}

// 2.년도 및 학기 컴포넌트(readOnly)
function fn_compoYearHakkiReadOnly(mpGubun, searchInputGb, divId, tagId1, tagName1, tagId2, tagName2, requiredYn, label){
	
	// 년도목록
	var yearOptionList = getYearComboboxList();
	
	// 학기목록
	var hakkiOptionList = getCmmnCdList("CD000011");
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col col2 clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div>';
					tagStr += '<select id="'+tagId1+'" name="'+tagName1+'" disabled=\"disabled\">';
					if(searchInputGb == 'S'){
						tagStr += '<option value="">전체</option>';
					}
						tagStr += yearOptionList;
					tagStr += '</select>';
				tagStr += '</div>';
				tagStr += '<div>';
					tagStr += '<select id="'+tagId2+'" name="'+tagName2+'" disabled=\"disabled\">';
					if(searchInputGb == 'S'){
						tagStr += '<option value="">전체</option>';
					}
					tagStr += hakkiOptionList;
					tagStr += '</select>';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}

//3.학번 및 성명 컴포넌트
function fn_compoNameHakbeon(mpGubun, searchInputGb, divId, tagId1, tagName1, tagId2, tagName2, requiredYn, label){
	
	var ssUserId = '';
	var ssUserName = '';
	
	if(gb_auth == 'AUTH0003'){
		ssUserId = '${SS_LOGIN_INFO.USER_ID}';
		ssUserName = '${SS_LOGIN_INFO.USER_NM}';
	}
	
	var dis = '';
	if (searchInputGb=='I') {
		dis = ' readonly="true" class="disabled_input" ';
	} else if (searchInputGb=='S'){
		dis = '';
	}
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col col2 clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId1+'" name="'+tagName1+'" value="'+ssUserId+'" readonly="readonly" class="disabled_input"> ';
				tagStr += '</div>';
				tagStr += '<div>';
				if(gb_auth == 'AUTH0003'){
					tagStr += '<input type="text" id="'+tagId2+'" name="'+tagName2+'" value="'+ssUserName+'" readonly="readonly" class="disabled_input">';
					tagStr += '<button class="magnifier absolute icon_button" onclick="return false;"></button>';
				}else{
					tagStr += '<input type="text" id="'+tagId2+'" name="'+tagName2+'" value="'+ssUserName+'" onfocus="javascript:fn_compoStdntNmOnkeyup(this);" '+dis+'>';
				}
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}

//학년도/학기, 학번/성명을 활성화/비활성화
function lockBasicCompo(lock) {
	if (lock == 'Y') {
		$('#GRADE option, #SEMSTR option').not(":selected").hide();
		$('#STDNT_NO, #STDNT_NM').attr('readonly', true);
		$('#STDNT_NM').attr('onfocus', '');
		$('#STDNT_NM').next().attr('disabled', true);
	} else {
		$('#GRADE option, #SEMSTR option').show();
		$('#STDNT_NM').attr('readonly', true);
		$('#STDNT_NM').next().attr('disabled', false);
	}
}

// 4.학번 및 성명 컴포넌트(readOnly)
function fn_compoNameHakbeonReadOnly(mpGubun, searchInputGb, divId, tagId1, tagName1, tagId2, tagName2, requiredYn, label){
	
	var ssUserId = '';
	var ssUserName = '';
	
	if(gb_auth == 'AUTH0003'){
		ssUserId = '${SS_LOGIN_INFO.USER_ID}';
		ssUserName = '${SS_LOGIN_INFO.USER_NM}';
	}
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col col2 clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId1+'" name="'+tagName1+'" value="" readonly="readonly" class="disabled_input"> ';
				tagStr += '</div>';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId2+'" name="'+tagName2+'" value="" readonly="readonly" class="disabled_input">';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}

// 5.셀렉트박스 컴포넌트
function fn_compoSelectbox(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label, code){
	
	if(mpGubun == 'M'){
		
		if(code != undefined && code != ''){
			fn_codeSelectBoxSetting1(code, mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
		}else{
			
			$('#' + divId).attr('class', 'col clear');
			var tagStr = '<p class="left">';
			if(requiredYn == 'Y'){
				tagStr += requiredSpan;
			}
				tagStr += label;
				tagStr += '</p>';
				tagStr += '<div class="right">';
					tagStr += '<select id="'+tagId+'" name="'+tagName+'">';
						tagStr += '<option value=""></option>';
					tagStr += '</select>';
				tagStr += '</div>';
				
			$('#' + divId).html(tagStr);
		}
		
		
	}else if(mpGubun == 'P'){
		
	}
	
}

// 6.셀렉트박스 컴포넌트(readOnly)
function fn_compoSelectboxReadOnly(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label, code){
	if(mpGubun == 'M'){
		
		if(code != undefined && code != ''){
			fn_codeSelectBoxSetting1(code, mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label, 'Y');
		}else{
			
			$('#' + divId).attr('class', 'col clear');
			var tagStr = '<p class="left">';
			if(requiredYn == 'Y'){
				tagStr += requiredSpan;
			}
				tagStr += label;
				tagStr += '</p>';
				tagStr += '<div class="right">';
					tagStr += '<select id="'+tagId+'" name="'+tagName+'" disabled="disabled" class="disabled_input">';
						tagStr += '<option value=""></option>';
					tagStr += '</select>';
				tagStr += '</div>';
				
			$('#' + divId).html(tagStr);
		}
		
		
	}else if(mpGubun == 'P'){
		
	}
}

// 7.입력박스 및 입력박스 컴포넌트
function fn_compoTwoInputbox(mpGubun, searchInputGb, divId, tagId1, tagName1, tagId2, tagName2, requiredYn, label, length1, length2){
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col col2 clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId1+'" name="'+tagName1+'" value="" maxlength="'+length1+'" class="relative"> ';
				tagStr += '</div>';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId2+'" name="'+tagName2+'" value="" maxlength="'+length2+'" class="relative">';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}

// 8.입력박스 및 입력박스 컴포넌트(readOnly)
function fn_compoTwoInputboxReadOnly(mpGubun, searchInputGb, divId, tagId1, tagName1, tagId2, tagName2, requiredYn, label, length1, length2){
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col col2 clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId1+'" name="'+tagName1+'" value="" maxlength="'+length1+'" class="disabled_input relative" readonly> ';
				tagStr += '</div>';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId2+'" name="'+tagName2+'" value="" maxlength="'+length2+'" class="relative disabled_input" readonly>';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}

// 9.입력박스 컴포넌트
function fn_compoInputbox(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label, width, length){
	
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
				tagStr += '<input type="text" id="'+tagId+'" name="'+tagName+'" value="" maxlength="'+length+'" style="ime-mode:active"/> ';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}else if(mpGubun == 'A'){
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
				tagStr += '<input type="text" onclick="javascript:fn_addressPopup('+tagId+')" id="'+tagId+'" name="'+tagName+'" value="" maxlength="'+length+'"/> ';
				
			tagStr += '</div>';
		$('#' + divId).html(tagStr);
	}else if(mpGubun == 'mini'){
		if(width == undefined || width == ''){
			$('#' + divId).attr('class', 'col clear');
		}else{
			$('#' + divId).attr('class', 'col col1'); // 3칸전용
		}
		var tagStr = '<p class="left" style="font-size:11px">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<input type="text" id="'+tagId+'" name="'+tagName+'" value="" maxlength="'+length+'" style="ime-mode:active"/> ';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
	}
	
}

// 10.입력박스 컴포넌트(readOnly)
function fn_compoInputboxReadOnly(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label, width){
	
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
				tagStr += '<input type="text" class="disabled_input" id="'+tagId+'" name="'+tagName+'" value="" readonly="readonly" /> ';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}else if(mpGubun == 'A'){
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
				tagStr += '<input type="text" class="disabled_input" onclick="javascript:fn_addressPopup('+tagId+')" id="'+tagId+'" name="'+tagName+'" value="" maxlength="'+length+'" placeholder="클릭하여 주소를 검색해주세요." readonly/> ';
				
			tagStr += '</div>';
		$('#' + divId).html(tagStr);
	}
	
}

// 11.입력박스 및 팝업버튼 컴포넌트
function fn_compoInputboxPopBtn(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<input type="text" id="'+tagId+'" name="'+tagName+'" value="" />';
				tagStr += '<button class="magnifier absolute icon_button"></button>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}

//12.날짜 입력 박스 컴포넌트
function fn_compoDateInputbox(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<input type="text" class="datepicker" maxlength="8" onchange="date_check(this);" id="'+tagId+'" name="'+tagName+'" readonly="readonly" />';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}


// 13.날짜 입력 컴포넌트(From~To)
function fn_compoDateInputboxFromTo(mpGubun, searchInputGb, divId, tagId1, tagName1, tagId2, tagName2, requiredYn, label){
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right clear">';
				tagStr += '<div class="fromto">';
					tagStr += '<input type="text" class="datepicker" maxlength="8" onchange="date_check(this);" id="'+tagId1+'" name="'+tagName1+'" readonly="readonly">';
					tagStr += '<span>~</span>';
					tagStr += '<input type="text" class="datepicker" maxlength="8" onchange="date_check(this);" id="'+tagId2+'" name="'+tagName2+'" readonly="readonly">';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}

// 14.파일찾기 컴포넌트
function fn_compoFileAdd(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear file');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<label for="'+tagId+'_custom-file-upload" class="filupp">';
					tagStr += '<span class="filupp-file-name js-value">Files upload</span>';
					tagStr += '<input type="hidden" name="'+tagName+'" id="'+tagId+'" />';
					tagStr += '<input type="file" name="FILE" value="1" id="'+tagId+'_custom-file-upload"';
					tagStr += 'accept=".gif, .jpg, .png, gif, .pdf, .hwp, .docx, .xls, .xlsx, .zip"';
					tagStr += ' onchange="$(\'#'+tagId+'\').prev().text($(\'#'+tagId+'\').next().get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#'+tagId+'\').next().get(0).files[0].name);$(\'#fileChangeYn\').val(\'Y\');" />';
					//tagStr += ' onchange="$(\'.filupp-file-name.js-value\').html($(\'#custom-file-upload\').get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#custom-file-upload\').get(0).files[0].name)" />';
					
					//tagStr += '<img width="18" class="fildfile absolute icon_button" src="/resources/images/file.png" onclick="$(\'#FILE_NM_custom-file-upload\').click();">';
					tagStr += '<img width="18" class="fildfile absolute icon_button" src="/resources/images/file.png" >';
				//tagStr += '</label>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}

// 14.파일찾기 및 수정 컴포넌트
function fn_compoFileModify(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear file');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<label for="'+tagId+'_custom-file-upload" class="filupp">';
					tagStr += '<span class="filupp-file-name js-value">Files upload</span>';
					tagStr += '<input type="hidden" name="'+tagName+'" id="'+tagId+'" />';
					tagStr += '<input type="file" name="FILE" value="1" id="'+tagId+'_custom-file-upload"';
					//tagStr += ' onchange="$(\'.filupp-file-name.js-value\').html($(\'#custom-file-upload\').get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#custom-file-upload\').get(0).files[0].name);$(\'#fileChangeYn\').val(\'Y\');"; />';
					tagStr += ' onchange="$(\'#'+tagId+'\').prev().text($(\'#'+tagId+'\').next().get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#'+tagId+'\').next().get(0).files[0].name);$(\'#fileChangeYn\').val(\'Y\');" />';
					tagStr += '<button type="button" class="icon_button delete"></button>';
// 					tagStr += '<button type="button" class="icon_button filedfile"></button>';
					tagStr += '<button type="button" class="icon_button filedfile"></button>';
					tagStr += '<button type="button" class="icon_button filedown"></button>';
				tagStr += '</label>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}
//14.파일찾기 컴포넌트(해외어학연수용)1
function fn_compoFileAddBF(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear file');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<label for="'+tagId+'_custom-file-upload" class="filupp">';
					tagStr += '<span class="filupp-file-name js-value">Files upload</span>';
					tagStr += '<input type="hidden" name="'+tagName+'" id="'+tagId+'" />';
					tagStr += '<input type="file" name="BF_FILE" value="1" id="'+tagId+'_custom-file-upload"';
					tagStr += 'accept=".gif, .jpg, .png, gif, .pdf, .hwp, .docx, .xls, .xlsx, .zip"';
					tagStr += ' onchange="$(\'#'+tagId+'\').prev().text($(\'#'+tagId+'\').next().get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#'+tagId+'\').next().get(0).files[0].name);$(\'#bf_fileChangeYn\').val(\'Y\');" />';
					//tagStr += ' onchange="$(\'.filupp-file-name.js-value\').html($(\'#custom-file-upload\').get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#custom-file-upload\').get(0).files[0].name)" />';
					tagStr += '<img width="18" class="fildfile absolute icon_button" src="/resources/images/file.png">';
				tagStr += '</label>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}
//14.파일찾기 컴포넌트(해외어학연수용)1
function fn_compoFileAddAF(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear file');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<label for="'+tagId+'_custom-file-upload" class="filupp">';
					tagStr += '<span class="filupp-file-name js-value">Files upload</span>';
					tagStr += '<input type="hidden" name="'+tagName+'" id="'+tagId+'" />';
					tagStr += '<input type="file" name="AF_FILE" value="1" id="'+tagId+'_custom-file-upload"';
					tagStr += 'accept=".gif, .jpg, .png, gif, .pdf, .hwp, .docx, .xls, .xlsx, .zip"';
					tagStr += ' onchange="$(\'#'+tagId+'\').prev().text($(\'#'+tagId+'\').next().get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#'+tagId+'\').next().get(0).files[0].name);$(\'#af_fileChangeYn\').val(\'Y\');" />';
					//tagStr += ' onchange="$(\'.filupp-file-name.js-value\').html($(\'#custom-file-upload\').get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#custom-file-upload\').get(0).files[0].name)" />';
					tagStr += '<img width="18" class="fildfile absolute icon_button" src="/resources/images/file.png">';
				tagStr += '</label>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}
//14.파일찾기 컴포넌트(해외인턴쉽)1
function fn_compoFileAddDGRI(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear file');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<label for="'+tagId+'_custom-file-upload" class="filupp">';
					tagStr += '<span class="filupp-file-name js-value">Files upload</span>';
					tagStr += '<input type="hidden" name="'+tagName+'" id="'+tagId+'" />';
					tagStr += '<input type="file" name="DGRI_FILE" value="1" id="'+tagId+'_custom-file-upload"';
					tagStr += 'accept=".gif, .jpg, .png, gif, .pdf, .hwp, .docx, .xls, .xlsx, .zip"';
					tagStr += ' onchange="$(\'#'+tagId+'\').prev().text($(\'#'+tagId+'\').next().get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#'+tagId+'\').next().get(0).files[0].name);$(\'#dgri_fileChangeYn\').val(\'Y\');" />';
					//tagStr += ' onchange="$(\'.filupp-file-name.js-value\').html($(\'#custom-file-upload\').get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#custom-file-upload\').get(0).files[0].name)" />';
					tagStr += '<img width="18" class="fildfile absolute icon_button" src="/resources/images/file.png">';
				tagStr += '</label>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}


//14.파일찾기 및 수정 컴포넌트(해외어학연수용)
function fn_compoFileModifyBF(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear file');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<label for="'+tagId+'_custom-file-upload" class="filupp">';
					tagStr += '<span class="filupp-file-name js-value">Files upload</span>';
					tagStr += '<input type="hidden" name="'+tagName+'" id="'+tagId+'" />';
					tagStr += '<input type="file" name="BF_FILE" value="1" id="'+tagId+'_custom-file-upload"';
					//tagStr += ' onchange="$(\'.filupp-file-name.js-value\').html($(\'#custom-file-upload\').get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#custom-file-upload\').get(0).files[0].name);$(\'#fileChangeYn\').val(\'Y\');"; />';
					tagStr += ' onchange="$(\'#'+tagId+'\').prev().text($(\'#'+tagId+'\').next().get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#'+tagId+'\').next().get(0).files[0].name);$(\'#bf_fileChangeYn\').val(\'Y\');" />';
					tagStr += '<button type="button" class="icon_button bf_delete"></button>';
					tagStr += '<button type="button" class="icon_button bf_filedfile"></button>';
					tagStr += '<button type="button" class="icon_button bf_filedown"></button>';
				tagStr += '</label>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}
//14.파일찾기 및 수정 컴포넌트(해외어학연수용)
function fn_compoFileModifyAF(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear file');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<label for="'+tagId+'_custom-file-upload" class="filupp">';
					tagStr += '<span class="filupp-file-name js-value">Files upload</span>';
					tagStr += '<input type="hidden" name="'+tagName+'" id="'+tagId+'" />';
					tagStr += '<input type="file" name="AF_FILE" value="1" id="'+tagId+'_custom-file-upload"';
					//tagStr += ' onchange="$(\'.filupp-file-name.js-value\').html($(\'#custom-file-upload\').get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#custom-file-upload\').get(0).files[0].name);$(\'#fileChangeYn\').val(\'Y\');"; />';
					tagStr += ' onchange="$(\'#'+tagId+'\').prev().text($(\'#'+tagId+'\').next().get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#'+tagId+'\').next().get(0).files[0].name);$(\'#af_fileChangeYn\').val(\'Y\');" />';
					tagStr += '<button type="button" class="icon_button af_delete"></button>';
					tagStr += '<button type="button" class="icon_button af_filedfile"></button>';
					tagStr += '<button type="button" class="icon_button af_filedown"></button>';
				tagStr += '</label>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}
//14.파일찾기 및 수정 컴포넌트(해외인턴쉽용)
function fn_compoFileModifyDGRI(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear file');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<label for="'+tagId+'_custom-file-upload" class="filupp">';
					tagStr += '<span class="filupp-file-name js-value">Files upload</span>';
					tagStr += '<input type="hidden" name="'+tagName+'" id="'+tagId+'" />';
					tagStr += '<input type="file" name="DGRI_FILE" value="1" id="'+tagId+'_custom-file-upload"';
					//tagStr += ' onchange="$(\'.filupp-file-name.js-value\').html($(\'#custom-file-upload\').get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#custom-file-upload\').get(0).files[0].name);$(\'#fileChangeYn\').val(\'Y\');"; />';
					tagStr += ' onchange="$(\'#'+tagId+'\').prev().text($(\'#'+tagId+'\').next().get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#'+tagId+'\').next().get(0).files[0].name);$(\'#dgri_fileChangeYn\').val(\'Y\');" />';
					tagStr += '<button type="button" class="icon_button dgri_delete"></button>';
					tagStr += '<button type="button" class="icon_button dgri_filedfile"></button>';
					tagStr += '<button type="button" class="icon_button dgri_filedown"></button>';
				tagStr += '</label>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}
// 15.여부 선택 radio 버튼 컴포넌트
function fn_compoRadioYn(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div class="yorn">';
					tagStr += '<input type="radio" id="'+tagId+'1" name="'+tagName+'" value="Y" checked=true> Y';
					tagStr += '<input type="radio" id="'+tagId+'2" name="'+tagName+'" value="N"> N';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}

function fn_allChkBox(){
	if($('#allChkBox').is(":checked")){
		$('.list_table').find('input[type=checkbox]').prop('checked',true);
	}else if (!$('#allChkBox').is(":checked")){
		$('.list_table').find('input[type=checkbox]').prop('checked',false);
	}
}

// 16.그리드 컴포넌트
function fn_compoGrid(mpGubun, divId, cols, colsNm, key){
	var totalCnt = '${totalCnt}';
	var colLen = cols.length;
	var gridRowCnt = '${gridRowCnt}'; // 그리드 1페이지에 뿌려질 row 갯수
	var gridFixCnt = 10 - gridRowCnt;
	var notPaging = $('#notPaging').val();
	
	var gridCheckboxYn = '';

	if(cols[0] == ''){
		gridCheckboxYn = 'Y';
	}

	if(mpGubun == 'M'){
		
		$('input[name=cols]').val(cols);
		$('input[name=colsNm]').val(colsNm);
		$('input[name=keys]').val(key);
		$('input[name=gridCheckboxYn]').val(gridCheckboxYn);
		
		$('#' + divId).attr('class', 'grid_box');
		var tagStr = '<span class="list_total">총 : ' + totalCnt + ' 건</span>';
				tagStr += '<div class="table_box"><table class="list_table">';
				tagStr += '<colgroup id="'+divId+'Colgroup">';
				for(var i = 0; i < colLen; i++){
					tagStr += '<col id="'+divId+'Col'+i+'" width="" />';
				}
				tagStr += '<tr class="th">';
				for(var i = 0; i < colLen; i++){
					
					if (colsNm[i] == '') {
						tagStr += '<th><input id="allChkBox" type="checkbox" name="rowCheck" onclick="javascript:fn_allChkBox();"></th>';
					} else {
						tagStr += '<th>' + colsNm[i] + '</th>';
					}
				}
				tagStr += '</tr>';
				if(totalCnt > 0){
					tagStr += '${gridList}'; // Data Grid
					
					for(var i = 0; i < gridFixCnt; i++){
						tagStr += '<tr>';
							tagStr += '<td colspan="'+colLen+';" style="text-align: center;">&nbsp;</td>';
						tagStr += '</tr>';	
					}
					
				}else{
					tagStr += '<tr style="text-align: center; height: 282px;">';
					if('${param.searchYn}' == 'Y'){
						tagStr += '<td colspan="'+colLen+'" style="text-align: center;">조회된 결과가 없습니다.</td>';
					}else{
						tagStr += '<td colspan="'+colLen+'" style="text-align: center;">조회버튼을 클릭하여 조회 하십시오.</td>';
					}
					tagStr += '</tr>';
				}
			tagStr += '</table></div>';
			
			// 0건 이상일때만 페이징처리
			if(totalCnt > 0){
				if(notPaging == 'Y'){
					tagStr += '<div class="clear mar_t_10" style="text-align:right;padding-bottom:2px;">';
					tagStr += '<button type="button" onclick="backPage();">페이징보기</button>';//test 용
					tagStr += '</div>';	
				}else{
				tagStr += '<div class="clear mar_t_10">';
					tagStr += '<div class="paging_box clear" style="padding-bottom:2px;">';
// 						tagStr += '<button type="button" style="vertical-align:top;float:right;" onclick="notpage();"">전체보기</button>';//test 용
						tagStr += '<c:if test="${paging.curPage > 1}">';
							tagStr += '<a href="#" onclick="pageCall('+"'1'"+')"><span class="paging">처음</span></a>';
						tagStr += '</c:if>';
						tagStr += '<c:if test="${paging.curPage > 1}">';
							tagStr += '<a href="#" onclick="pageCall('+"'${paging.prevPage}'"+')"><span class="paging">이전</span></a>';
						tagStr += '</c:if>';
						<c:forEach var="num" begin="${paging.blockBegin}" end="${paging.blockEnd}">
							<c:choose>
								<c:when test="${num == paging.curPage}">
									tagStr += '<span class="paging active">${num}</span>';
								</c:when>
								<c:otherwise>
									tagStr += '<a href="#" onclick="pageCall('+"'${num}'"+')"><span class="paging">${num}</span></a>';
								</c:otherwise>
							</c:choose>
						</c:forEach>
						tagStr += '<c:if test="${paging.curPage < paging.totPage}">';
							tagStr += '<a href="#" onclick="pageCall('+"'${paging.nextPage}'"+')"><span class="paging">다음</span></a>';
						tagStr += '</c:if>';
						tagStr += '<c:if test="${paging.curPage < paging.totPage}">';
							tagStr += '<a href="#" onclick="pageCall('+"'${paging.totPage}'"+')"><span class="paging">끝</span></a>';
							tagStr += '</c:if>';
					tagStr += '</div>';
				tagStr += '</div>';	
				}
			}
			tagStr += '<input type="hidden" id="curPage" name="curPage">';
			
			$('#' + divId).html(tagStr);
			
			if(totalCnt > 0){
				//row onclick 이벤트 추가
				var $th = $('#' + divId).find('table>tbody>tr').eq(0);
				$('#' + divId).find('table>tbody>tr').not($th).each(function(index, item){
					if(index < gridRowCnt){
						$(this).attr('id', 'gridTr' + index);
						$(this).attr('onclick', "fn_gridDetailOnclick(this, '" + $(this).attr('id') + "'); lockBasicCompo('Y');");
						
						// 그리드 row  클릭 시 강조
						$(this).on("click", function(){
							$(this).addClass('active');
							var $clickTr = $(this);
							
							// 클릭한 row를 제외한 강조 해제
							$('#' + divId).find('table>tbody>tr').not($clickTr).each(function(){
								$(this).removeClass('active');
							});
							
							// row 클릭 시 업데이트 여부 Y
							$('input[name=updateYn]').val('Y');
							fn_btnMsgSetting();
							newNdetailCompoControll();
						});
					}
				});
				
			}
			
			
			
	}else if(mpGubun == 'P'){
		
	}
	
	
	$('table tr:even').addClass('even');
}

// 17.봉사실적구분(셀렉트박스) 컴포넌트
function fn_compoSelBongsaSiljeokGb(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		fn_codeSelectBoxSetting1("CD000001", mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
	}else if(mpGubun == 'P'){
		
	}
}

// 18.봉사영역구분(셀렉트박스) 컴포넌트
function fn_compoSelBongsaYoungyeokGb(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		fn_codeSelectBoxSetting1("CD000002", mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
	}else if(mpGubun == 'P'){
		
	}
}

// 19.국가(셀렉트박스) 컴포넌트
function fn_compoSelGookga(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		fn_codeSelectBoxSetting1("CO0008", mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
	}else if(mpGubun == 'P'){
		
	}
}

// 20.언어(셀렉트박스) 컴포넌트
function fn_compoSelLanguage(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		fn_codeSelectBoxSetting1("CD000003", mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
	}else if(mpGubun == 'P'){
		
	}
}

// 21.어학구분(셀렉트박스) 컴포넌트
function fn_compoSelAhakGb(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		fn_codeSelectBoxSetting1("CD000004", mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
	}else if(mpGubun == 'P'){
		
	}
}

// 22.동아리구분(셀렉트박스) 컴포넌트
function fn_compoSelDongariGb(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		fn_codeSelectBoxSetting1("CD000007", mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
	}else if(mpGubun == 'P'){
		
	}
}

// 23.학과(셀렉트박스) 컴포넌트
function fn_compoSelHakkwa(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		fn_codeSelectBoxSetting3("30100000", mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
	}else if(mpGubun == 'P'){
		
	}
}

// 24.입학구분(셀렉트박스) 컴포넌트
function fn_compoSelIphakGb(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		fn_codeSelectBoxSetting1("CD000010", mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
	}else if(mpGubun == 'P'){
		
	}
}

// 25.학적상태(셀렉트박스) 컴포넌트
function fn_compoSelHakjeokStat(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		fn_codeSelectBoxSetting1("CD000009", mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
	}else if(mpGubun == 'P'){
		
	}
}

// 26.학기(셀렉트박스) 컴포넌트
function fn_compoSelHakki(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		fn_codeSelectBoxSetting1("CD000011", mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
	}else if(mpGubun == 'P'){
		
	}
}

// 27.학위구분(셀렉트박스) 컴포넌트
function fn_compoSelHakwiGb(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		fn_codeSelectBoxSetting1("CD000005", mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
	}else if(mpGubun == 'P'){
		
	}
}
// 28.수여자(셀렉트박스) 컴포넌트 - 성일
function fn_compoSelReceiver(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		fn_codeSelectBoxSetting1("CD000006", mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
	}else if(mpGubun == 'P'){
		
	}
}

// 29.강사명 조회 팝업 컴포넌트
function fn_compoGangsaPopBtn(mpGubun, searchInputGb, divId, tagId1, tagName1, tagId2, tagName2, requiredYn, label1, label2){
	
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label1;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId1+'" name="'+tagName1+'" maxlength="30" /> ';
				tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		var tagStr2 = '<p class="left">';
// 		if(requiredYn == 'Y'){
// 			tagStr2 += requiredSpan;
// 		}
			tagStr2 += label2;
			tagStr2 += '</p>';
			tagStr2 += '<div class="right">';
				tagStr2 += '<div>';
					tagStr2 += '<input type="text" id="'+tagId2+'" name="'+tagName2+'" maxlength="30" /> ';
				tagStr2 += '</div>';
				
		$('#' + divId).after('<div id="addDIV">' + tagStr2 + '</div>');
		$('#' + divId).next().attr('class', 'col clear');
	}else if(mpGubun == 'P'){
		
	}
	
}

// 30.승인상태 컴포넌트
function fn_compoSelApprStat(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<select id="'+tagId+'" name="'+tagName+'">';
					tagStr += '<option value="">전체</option>';
					tagStr += '<option value="1">승인</option>';
					tagStr += '<option value="0">미승인</option>';
				tagStr += '</select>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}
// 30.재직여부 컨포넌트 19.04.18
function fn_compoSelIn_office(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<select id="'+tagId+'" name="'+tagName+'">';
					tagStr += '<option value="">전체</option>';
					tagStr += '<option value="Y">재직</option>';
					tagStr += '<option value="N">퇴직</option>';
				tagStr += '</select>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}
// 30.관리자 재직여부 컨포넌트 19.04.19
function fn_compoSelIn_admin_office(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<select id="'+tagId+'" name="'+tagName+'">';
					tagStr += '<option value="Y">재직</option>';
					tagStr += '<option value="N">퇴직</option>';
				tagStr += '</select>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}
// 30-1. 사용자관리 컨포넌트
function fn_compoSelIn_AUTH(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<select id="'+tagId+'" name="'+tagName+'">';
					tagStr += '<option value="AUTH0001">슈퍼관리자</option>';
					tagStr += '<option value="AUTH0002">관리책임자</option>';
					tagStr += '<option value="AUTH0003">접수담당자</option>';
					tagStr += '<option value="AUTH0004">일반사용자</option>';
					tagStr += '<option value="AUTH0005">조사원</option>';
				tagStr += '</select>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}


//31.특이사항(testarea) 컴포넌트
function fn_compoTextaPartclrCn(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col col1');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<textarea id="'+tagId+'" name="'+tagName+'" onKeyUp="fn_TextaLeng_chk(this)"></textarea>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}

// 31 - 1. testarea 

function fn_TextaLeng_chk(event){
  var val = event.value;
  var maxLang = 1000;
  
  if( val.length > maxLang){  
	  alert('최대 ' +maxLang+ '자 까지 입력할 수 있습니다.');
	  event.value = val.substring(0, maxLang);  
	  event.focus();  
  } 
} 


// 32.자격증 조회 팝업 컴포넌트
function fn_compoLisencePopBtn(mpGubun, searchInputGb, divId, tagId1, tagName1, tagId2, tagName2, requiredYn, label){
	
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId1+'" name="'+tagName1+'" value="" readonly="readonly" class="disabled_input"> ';
				tagStr += '</div>';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId2+'" name="'+tagName2+'" value="" class="disabled_input">';
					tagStr += '<button class="magnifier absolute icon_button" onclick="javascript:fn_openLisencePopup('+"'"+divId+"'"+');return false;"></button>';
				tagStr += '</div>';
			tagStr += '</div>';
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}
function fn_compoLisencePopBtnMul(mpGubun, searchInputGb, divId, tagId1, tagName1, tagId2, tagName2, requiredYn){
	
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'col col2 clear');
		var tagStr = '<p>';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += '</p>';
			tagStr += '<div style="position: relative; width : 100%;">';
				tagStr += '<div  style="display:inline-block; width:45%; margin-right:5px;">';
					tagStr += '<input type="text" id="'+tagId1+'" name="'+tagName1+'" value="" readonly="readonly" class="disabled_input"> ';
				tagStr += '</div>';
				tagStr += '<div   style="display:inline-block; width:45%; margin-right:5px;">';
					tagStr += '<input type="text" id="'+tagId2+'" name="'+tagName2+'" value="" class="disabled_input">';
					tagStr += '<button class="magnifier absolute icon_button" onclick="javascript:fn_openLisencePopup('+"'"+divId+"'"+');return false;"></button>';
				tagStr += '</div>';
			tagStr += '</div>';
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}

// 33.국가 조회 팝업 컴포넌트
function fn_compoNationPopBtn(mpGubun, searchInputGb, divId, tagId1, tagName1, tagId2, tagName2, requiredYn, label){
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col col2 clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId1+'" name="'+tagName1+'" value="" readonly="readonly" class="disabled_input"> ';
				tagStr += '</div>';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId2+'" name="'+tagName2+'" value="" readonly="readonly" class="disabled_input">';
					tagStr += '<button class="magnifier absolute icon_button" onclick="javascript:fn_openNationPopup('+"'"+divId+"'"+');return false;"></button>';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}

// 34.봉사기관 조회 팝업 컴포넌트
function fn_compoBongsaPopBtn(mpGubun, searchInputGb, divId, tagId1, tagName1, tagId2, tagName2, requiredYn, label){
	
if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col col2 clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId1+'" name="'+tagName1+'" value="" readonly="readonly" class="disabled_input"> ';
				tagStr += '</div>';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId2+'" name="'+tagName2+'" value="" readonly="readonly" class="disabled_input">';
					tagStr += '<button class="magnifier absolute icon_button" onclick="javascript:fn_openBongsaPopup('+"'"+divId+"'"+');return false;"></button>';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}


// 코드성 셀렉트박스 셋팅1
function fn_codeSelectBoxSetting1(code, mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label, rdOnlyOrDisablYn){
	
	var optionList = getCmmnCdList(code);
	$('#' + divId).attr('class', 'col clear');
	var tagStr = '<p class="left">';
	if(requiredYn == 'Y'){
		tagStr += requiredSpan;
	}
		tagStr += label;
		tagStr += '</p>';
		tagStr += '<div class="right">';
		if(rdOnlyOrDisablYn != undefined && rdOnlyOrDisablYn != ''){
			tagStr += '<select id="'+tagId+'" name="'+tagName+'" disabled=\"disabled\">';
		}else{
			tagStr += '<select id="'+tagId+'" name="'+tagName+'">';
		}
			if(searchInputGb == 'S'){
				tagStr += '<option value="">전체</option>';
			}else{
				tagStr += '<option value="">선택</option>';
			}
				tagStr += optionList;
			tagStr += '</select>';
		tagStr += '</div>';
		
	$('#' + divId).html(tagStr);
}

// 코드성 셀렉트박스 셋팅2
function fn_codeSelectBoxSetting2(code, mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	var optionList = getCmmnCdList(code);
	$('#' + divId).attr('class', 'col clear');
	var tagStr = '<p class="left">';
	if(requiredYn == 'Y'){
		tagStr += requiredSpan;
	}
		tagStr += label;
		tagStr += '</p>';
		tagStr += '<div class="right">';
			tagStr += '<select id="'+tagId+'" name="'+tagName+'">';
			if(searchInputGb == 'S'){
				tagStr += '<option value="">전체</option>';
			}else{
				tagStr += '<option value="">선택</option>';
			}
				tagStr += optionList;
			tagStr += '</select>';
		tagStr += '</div>';
		
	$('#' + divId).html(tagStr);
}


// 경력 샐랙트박스
function fn_careerSelectBoxSetting(code, mpGubun, searchInputGb, divId, tagId, tagName){
	var optionList = getCompanyList(code);
	$('#' + divId).attr('class', 'col clear');
	var tagStr = '<p class="">';
		tagStr += '</p>';
		tagStr += '<div class="">';
			tagStr += '<select id="'+tagId+'" name="'+tagName+'">';
			if(searchInputGb == 'S'){
				tagStr += '<option value="">전체</option>';
			}else{
				tagStr += '<option value="">선택</option>';
			}
				tagStr += optionList;
			tagStr += '</select>';
		tagStr += '</div>';
		
	$('#' + divId).html(tagStr);
}

// 그리드 항목별 사이즈 조절 함수
function fn_gridColgroupSetting(gridId, colSizeArr){
	for(var i = 0; i < colSizeArr.length; i++){
		$('#' + gridId + 'Col' + i).attr('width', colSizeArr[i]);
		//alert(colSizeArr[i]);
	}
}

// 그리드 데이터 정렬 설정 함수
function fn_gridAlignSetting(gridId, alignArr){
	var $gridTr0 = $('#' + gridId + 'Tr0');
	var tdCnt = $gridTr0.find('td').length;
	if(tdCnt > 1){
		var $th = $('#' + gridId).find('table>tbody>tr').eq(0);
		$('#' + gridId).find('table>tbody>tr').not($th).each(function(index, item){
			$(this).find('td').each(function(idx){
				var childType = $(this).children().attr('type');
				if(childType == 'checkbox'){
					$(this).attr("style", "text-align: " + alignArr[idx] + "; vertical-align: middle;");
				}else{
					//$(this).attr("style", "text-align: " + alignArr[idx]);
					$(this).attr("style", "text-align: " + alignArr[idx] + ";max-width:150px; overflow: hidden;text-overflow:ellipsis;white-space:nowrap;");
				}
			});
		});
	}
}

// 년도목록 가져오기
function getYearComboboxList(){
	
	var yearOptionList = '';
	$.ajax({
	    url : '/commonSh/getYearComboboxList.do',
	    type : 'POST',
	    dataType : 'json',
	    async 	: false,
	    success : function(result) {
	    	var list = result.list;
	    	for(var i = 0; i < list.length; i++){
	    		yearOptionList += '<option value="' + list[i].YEAR + '">'+ list[i].YEAR +'</option>';
	    	}
	    },
	    error : function() { // Ajax 전송 에러 발생시 실행
	           alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
	    },
	    complete : function(result) { // success, error 실행 후 최종적으로 실행
	    	
	    }
	});
	
	return yearOptionList;
	
}

// 공통코드 검색
function getCmmnCdList(code){
	
	var str = '';
	$.ajax({
		url : '/commonSh/getCmmnCdList.do',
		data : {"CODE_SE": code},   //전송파라미터
		type : 'POST',
		dataType : 'json',
		async 	: false,
		success : function(result) {
			var list = result.list;
			for(var i = 0; i < list.length; i++){
				str += '<option value="' + list[i].DTLCODE + '">'+ list[i].DTLCODE_NM +'</option>';
			}
		},
		error : function() { // Ajax 전송 에러 발생시 실행
			alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
		},
		complete : function(result) { // success, error 실행 후 최종적으로 실행
			
		}
	});
	
	return str;
	
}

//공통코드 검색
function getCmmnCdListToList(code , ASSET_SEBU_CD){
	
	var str = '';
	$.ajax({
		url : '/commonSh/getCmmnCdList.do',
		data : {"CODE_SE": code},   //전송파라미터
		type : 'POST',
		dataType : 'json',
		async 	: false,
		success : function(result) {
			var list = result.list;
			 for(var i = 0; i < list.length; i++){
				 if(list[i].DTLCODE == ASSET_SEBU_CD){
					str += '<option value="' + list[i].DTLCODE + '" selected>'+ list[i].DTLCODE_NM +'</option>';
				 }else{
					str += '<option value="' + list[i].DTLCODE + '">'+ list[i].DTLCODE_NM +'</option>';
					 
				 }
			} 
		},
		error : function() { // Ajax 전송 에러 발생시 실행
			alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
		},
		complete : function(result) { // success, error 실행 후 최종적으로 실행
			
		}
	});
	return str;
	
}



function getCompanyList(EMP_ID){
	
	var str = '';
	$.ajax({
		url : '/project/getCompanyList.do',
		data : {"EMP_ID": EMP_ID},   //전송파라미터
		type : 'POST',
		dataType : 'json',
		async 	: false,
		success : function(result) {
			var rlist = result.list;
			var title = 'none';
			for(var i = 0; i < rlist.length; i++){
					title = rlist[i].JOB_TITLE;
				str += '<option value="' + title + '">'+ title +'</option>';
				
			}
		},
		error : function() { // Ajax 전송 에러 발생시 실행
			alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
		},
		complete : function(result) { // success, error 실행 후 최종적으로 실행
			
		}
	});
	
	return str;
	
}


//************** 202107 ********************************
function getCompanyList(USER_ID){
	
	var str = '';
	$.ajax({
		url : '/project/getCompanyList.do',
		data : {"USER_ID": USER_ID},   //전송파라미터
		type : 'POST',
		dataType : 'json',
		async 	: false,
		success : function(result) {
			var rlist = result.list;
			var title = 'none';
			for(var i = 0; i < rlist.length; i++){
					title = rlist[i].JOB_TITLE;
				str += '<option value="' + title + '">'+ title +'</option>';
				
			}
		},
		error : function() { // Ajax 전송 에러 발생시 실행
			alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
		},
		complete : function(result) { // success, error 실행 후 최종적으로 실행
			
		}
	});
	
	return str;
	
}
//*******************************************************








// 자격증검색 팝업 열기
function fn_openLisencePopup(divId){

	var popUrl = "/commonSh/lisenceSearchPopupList.do?divId=" + divId;	//팝업창에 출력될 페이지 URL
	var popOption = "width=1000, height=500, resizable=yes, scrollbars=yes, status=no;"; //팝업창 옵션(optoin)

	window.open(popUrl, "", popOption);
}

// 국가검색 팝업 열기
function fn_openNationPopup(divId){

	var popUrl = "/commonSh/nationSearchPopupList.do?divId=" + divId;	//팝업창에 출력될 페이지 URL
	var popOption = "width=1000, height=500, resizable=yes, scrollbars=yes, status=no;"; //팝업창 옵션(optoin)

	window.open(popUrl, "", popOption);
}

// 봉사기관검색 팝업 열기
function fn_openBongsaPopup(divId){
	
	var popUrl = "/commonSh/bongsaSearchPopupList.do?divId=" + divId;	//팝업창에 출력될 페이지 URL
	var popOption = "width=1000, height=700, resizable=yes, scrollbars=yes, status=no;"; //팝업창 옵션(optoin)

	window.open(popUrl, "", popOption);
}

//인사검색 팝업 열기
function fn_openEmpPopup(divId){

	var popUrl = "/commonSh/empSearchPopupList.do?divId=" + divId;	//팝업창에 출력될 페이지 URL
	var popOption = "width=1000, height=550, resizable=yes, scrollbars=yes, status=no;"; //팝업창 옵션(optoin)

	window.open(popUrl, "", popOption);
}

//인사검색 팝업 열기(이름 입력)
function fn_openEmpPopupByName(emp_nm){

	var popUrl = "/commonSh/empSearchPopupListByName.do?emp_nm=" + emp_nm;	//팝업창에 출력될 페이지 URL
	var popOption = "width=1000, height=550, resizable=yes, scrollbars=yes, status=no;"; //팝업창 옵션(optoin)

	window.open(popUrl, "", popOption);
}

function fn_newForm(){
	
	// 모든 input value 초기화
	$('#inputNdetailDivBox').find('input').each(function(idx){
		var type = $(this).attr('type');
		var id = $(this).attr('id');
		if(type == 'text'){ //STDNT_NO   STDNT_NM
			if(gb_auth == "AUTH0003" && (id == "STDNT_NO" || id == "STDNT_NM")){
				// 
			}else{
				$(this).val('');
			}
		}
		if(type == 'radio' || type == 'checkbox'){
			$("#tab1").prop('checked', true);
//			$(this).prop('checked', true);
		}
		if(type == 'file'){
			$(this).prev().prev().text('Files upload');
			$(this).val('');
		}
	});
	
	// 모든 selectbox 선택 초기화
	$('#inputNdetailDivBox').find('select').each(function(idx){
		//$(this).find('option:eq(0)').prop('selected', true);
		$(this).val('').prop('selected', true);
	});
	
	// 모든 textarea 초기화
	$('#inputNdetailDivBox').find('textarea').each(function(idx){
		$(this).val('');
	});
	
	//그리드 클릭시 학년도/학기 학번/성명 disabled, 조회 신규시 disabled해제
	lockBasicCompo('N');
	
}

// 조회 시 필수입력 체크
function searchRequiredCheck(){
	var flag = true;
	$('#searchDivBox').find('.required').each(function(idx){
		
		if(flag == false){
			return false;
		}
		
		var compoNm = $(this).parent().text();
		if(idx > 0){
			$(this).parent().next().children().each(function(idx2){
				var val = $(this).children().val();
				if(val == ''){
					alert('[' + compoNm + '] 항목은 필수 입력 항목입니다.');
					$(this).focus();
					flag = false;
					return false;
				}
			});
		}
		
	});
	
	return flag;
}

// 저장 시 필수입력 체크
function inputNdetailRequiredCheck(){
	var flag = true;
	
	// 저장하려는 항목이 승인상태인지 체크
// 	if($('#updateYn').val() == 'Y' && $('#SEARCH_CNFIRM_AT').length > 0){
// 		flag = fn_cnfirmAtCheck();
// 		if(!flag){
// 			alert('이미 승인처리가 되어 변경할 수 없습니다.');
// 			return;
// 		}
// 	}
	
	$('#inputNdetailDivBox').find('.required').each(function(idx){
		
		if(flag == false){
			return false;
		}
		
		var compoNm = $(this).parent().text();
		$(this).parent().next().children().each(function(idx2){
			var tagName = $(this).prop('tagName');
			var val = '';
			
			if(tagName == 'DIV'){
				val = $(this).children().val();
				tagName = $(this).children().prop('tagName');
			}else{
				val = $(this).val();
			}
			
			if(val == '' && (tagName == 'SELECT' || tagName == 'INPUT')){
				alert('[' + compoNm + '] 항목은 필수 입력 항목입니다.');
				$(this).focus();
				flag = false;
				return false;
			}
		});
		
	});
	
	return flag;
}

// 삭제할 대상이 존재하는지 체크
function detailDeleteCheck(){
	if($('input[name=updateYn]').val() != 'Y'){
		alert('선택된 데이터가 없습니다.');
		return false;
	}
	
	// 삭제하려는 항목이 승인상태인지 체크
	if($('#updateYn').val() == 'Y' && $('#SEARCH_CNFIRM_AT').length > 0){
		flag = fn_cnfirmAtCheck();
		if(!flag){
			alert('이미 승인처리가 되어 삭제할 수 없습니다.');
			return;
		}
	}
	
	return true;
}

// 승인 및 취소 처리
function fn_apprOrCancelProcess(gubun){
	
	var checkLen = $('input:checkbox[name=gridCheck]:checked').length;
	
	if(checkLen == 0){
		alert('체크된 항목이 없습니다.');
		return false;
	}
	
	var msg = '';
	var gubunNm = '';
	if(gubun == '1'){
		msg = checkLen + '건에 대한 승인을 하시겠습니까?';
		gubunNm = '승인'
	}else{
		msg = checkLen + '건에 대한 승인취소를 하시겠습니까?';
		gubunNm = '승인취소';
	}
	
	var result = confirm(msg);
	if(result){
		
		var tmpArr = new Array();
		$('input:checkbox[name=gridCheck]:checked').each(function(idx){
			var trId = $(this).parent().parent().attr('id');
			tmpArr[idx] = $('#'+trId).find('input[name^=KEY]').val();
		});
		
		
		if(tmpArr.length > 0){
			
			$('#APPR_KEY').val(tmpArr);
			
			$.ajax({
				url : '/commonSh/approvalOrCancelProcess.do',
				data : {"APPR_KEY": $('#APPR_KEY').val(), "GUBUN": gubun},   //전송파라미터
				type : 'POST',
				dataType : 'json',
				async 	: false,
				success : function(result) {
					pageCall(gb_curPage);
					alert(gubunNm + ' 되었습니다.');
				},
				error : function() { // Ajax 전송 에러 발생시 실행
					alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
				},
				complete : function(result) { // success, error 실행 후 최종적으로 실행
					
				}
			});
		}
		
	}
	
}

// 저장하려는 항목이 승인상태인지 체크
function fn_cnfirmAtCheck(){
	
	var flag = true;
	
	$.ajax({
		url : '/commonSh/cnfirmAtCheck.do',
		data : {"KEY": $('#KEY').val()},   //전송파라미터
		type : 'POST',
		dataType : 'json',
		async 	: false,
		success : function(result) {
			var cnfirmAt = result.cnfirmAt;
			
			// 미승인 상태인 경우
			if(cnfirmAt == '0'){
				flag = true;
			}
			// 승인 상태인 경우
			else{
				flag = false;
			}
		},
		error : function() { // Ajax 전송 에러 발생시 실행
			alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
		},
		complete : function(result) { // success, error 실행 후 최종적으로 실행
			
		}
	});
	
	return flag;
}

// 공통 조회
function goSearch(url){
	if(!searchRequiredCheck()){return false;} // 조회 필수 입력 체크
	$("#curPage").val(1);
	$("#searchYn").val('Y');
	form.action = url;
	goSubmit(form);
}

// 공통 페이징
function goPageCall(url, pageNo){
    $("#curPage").val(pageNo);
    $("#searchYn").val('Y');
	form.action = url;
	goSubmit(form);
}

function goExcelDownLoad(url, colsNm, cols){
	var sub_colsNm = colsNm.toString();
	var sub_cols = cols.toString();
	$("#excelColsNm").val(sub_colsNm);
	$("#excelCols").val(sub_cols);
	form.action = url;
	form.submit();
	/* $.ajax({
	    url : url,
	    type : 'POST',   
	    data : {"colsNm":sub_colsNm,
	    		"cols":sub_cols	
	    
	    },
	    dataType : 'json',
	    async 	: false,
	    success : function(result) {
	    	alert(result.SUCESS);
	    },
	    error : function(result) { // Ajax 전송 에러 발생시 실행
	    	if(result.status==200){
   		     alert('hi');    
   		 
   		     }else if(result.status==300){
   		     alert("엑셀 데이터 저장에 실패하였습니다.");
   		    };
	    },
	    complete : function(result) { // success, error 실행 후 최종적으로 실행
	    }
	}); */
}
function goExcelDownLoadSalary(url, sheet1Cols, sheet1ColsNm, sheet2Cols, sheet2ColsNm, sheet3Cols, sheet3ColsNm){
	var sub_sheet1ColsNm = sheet1ColsNm.toString();
	var sub_sheet1Cols = sheet1Cols.toString();
	var sub_sheet2ColsNm = sheet2ColsNm.toString();
	var sub_sheet2Cols = sheet2Cols.toString();
	var sub_sheet3ColsNm = sheet3ColsNm.toString();
	var sub_sheet3Cols = sheet3Cols.toString();
	$("#sheet1ColsNm").val(sub_sheet1ColsNm);
	$("#sheet1Cols").val(sub_sheet1Cols);
	$("#sheet2ColsNm").val(sub_sheet2ColsNm);
	$("#sheet2Cols").val(sub_sheet2Cols);
	$("#sheet3ColsNm").val(sub_sheet3ColsNm);
	$("#sheet3Cols").val(sub_sheet3Cols);
	form.action = url;
	form.submit();
}

// 글로벌 메세지 처리
function fn_btnMsgSetting(){
	//gb_saveMsg, gb_delMsg
	//추후 DB에 입력된 메시지로 처리할 예정
	if($('input[name=updateYn]').val() == 'Y'){
		gb_saveMsg = '수정하시겠습니까?';
		$('#modeSpan').text('상세 정보');
	}else{
		gb_saveMsg = '저장하시겠습니까?';
		$('#modeSpan').text('신규 등록 정보');
	}
	
	gb_delMsg = '삭제하시겠습니까?';
}

// 신규 또는 상세 시 컴포넌트 콘트롤
function newNdetailCompoControll(){
	
    var now = new Date();
    var nowYear = now.getFullYear(); //현재년도
    var nowMon = Number((now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : +(now.getMonth()+1));
    
	var val = $('input[name=updateYn]').val();
	var gradeYn = $('#GRADE').length == 0 ? 'N' : 'Y';
	
	// 상세모드
	if(val == 'Y'){
		
	}
	// 신규모드
	else{
		// 학년도 컴포넌트 존재하면 현재년도로 설정
		if(gradeYn == 'Y'){
			$('#GRADE').val(nowYear);
			if(nowMon < 7){
				$('#SEMSTR').val(1);
			}else{
				$('#SEMSTR').val(2);
			}
		}
	}
}

// 성명이 빈값인 경우 학번 초기화
function fn_compoStdntNmOnkeyup(obj){
	var tagId = obj.getAttribute('id');
	$('#'+tagId).parent().prev().children().val('');
	$('#'+tagId).val('');
	var val = $('#'+tagId).val();
	if(val == ''){
		$('#'+tagId).parent().prev().children().val('');
	}
}

$(document).ready(function() {
	
	$("#curPage").val(gb_curPage);
	
	fn_btnMsgSetting();
	newNdetailCompoControll();
	
	// 도움말 설정(도움말이 한개도 없는 경우 Hide)
	var cmtLength = $('#cmtDivBox2').children().length;
	if(cmtLength == 0){
		 $('#cmtDivBox').hide();
	}
	
	$('#searchBtn').on("click", function(){
		// 조회 버튼 클릭 시 업데이트여부 초기화
		$('input[name=updateYn]').val('');
		fn_btnMsgSetting();
	});
	//버튼
	$('#newBtn').on("click", function(){
		// 신규 버튼 클릭 시 업데이트여부 초기화
		$('input[name=updateYn]').val('');
		fn_btnMsgSetting();
		fn_newForm();
		// 그리드 선택 강조 해제
		$('.list_table').find('.active').each(function(){
			$(this).removeClass('active');
		});
		
		newNdetailCompoControll();
	});
	
	// 승인버튼 설정
	$('#apprBtn').on("click", function(){
		fn_apprOrCancelProcess('1'); // 승인
	});
	
	$('#apprCancelBtn').on("click", function(){
		fn_apprOrCancelProcess('0'); // 승인취소
	});
	
	// 버튼 css 처리
	$('#searchBtn').addClass('clear');
	$('#searchBtn').html('<span><i class="fas fa-search"></i></span>조회');
	
	$('#newBtn').addClass('clear');
	$('#newBtn').html('<span><i class="fas fa-plus"></i></span>신규');
	
	$('#newRowBtn').addClass('clear');
	$('#newRowBtn').html('<span><i class="fas fa-plus"></i></span>행추가');
	
	
	$('#delBtn').addClass('clear');
	$('#delBtn').html('<span><i class="fas fa-trash-alt"></i></span>삭제');
	
	$('#delRowBtn').addClass('clear');
	$('#delRowBtn').html('<span><i class="fas fa-trash-alt"></i></span>행삭제');
	
	$('#saveBtn').addClass('clear');
	$('#saveBtn').html('<span><i class="fas fa-archive"></i></span>저장');
	
	$('#apprBtn').addClass('clear');
	$('#apprBtn').html('<span><i class="fas fa-clipboard-check"></i></span>승인');
	
	$('#apprCancelBtn').addClass('clear');
	$('#apprCancelBtn').html('<span><i class="fas fa-clipboard-check"></i></span>승인취소');
	
	$('#excelDownBtn').addClass('clear');
	$('#excelDownBtn').html('<span><i class="fas fa-file-excel"></i></span>인사기록카드');
	
	$('#excelDownBtn2').addClass('clear');
	$('#excelDownBtn2').html('<span><i class="fas fa-file-excel"></i></span>재직증명서');
	datepicker_default();
	
	
    $('.button_box').each(function () {
        var $window = $(window), // 창을 jQuery 오브젝트 화
            $button_box = $(this),   // button_box를 jQuery 객체 화
            // button_box의 기본 위치를 검색
            button_boxOffsetTop = $button_box.offset().top;

        // 윈도우의 스크롤 이벤트를 모니터링
        // (창이 스크롤 할 때마다 작업을 수행하기)
        $window.on('scroll', function () {
            // 윈도우의 스크롤 량을 확인하고,
            // button_box의 기본 위치를 지나서 있으면 클래스를 부여,
            // 그렇지 않으면 삭제
            if ($window.scrollTop() > button_boxOffsetTop) {
                $button_box.addClass('sticky');
            } else {
                $button_box.removeClass('sticky');
            }
        });
        // 윈도우의 스크롤 이벤트를 발생시키는
        // (button_box초기 위치를 조정하기 위해)
        $window.trigger('scroll');
    });
    
    datepickSet1();
});
var datepickSet1 = function() {
	$( ".datepicker" ).datepicker({
		showOn: "button",
		buttonImage: "/resources/images/calendar.png",
		buttonImageOnly: true,
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		yearRange: 'c-80:c+10',
		nextText: '다음 달',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		showMonthAfterYear: true,
		yearSuffix: ' ',
		changeYear:true,
		changeMonth:true
	});
}
var datepickSet2 = function() {
	$( ".datepicker" ).datepicker({
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		yearRange: 'c-80:c+10',
		nextText: '다음 달',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		showMonthAfterYear: true,
		yearSuffix: ' ',
		changeYear:true,
		changeMonth:true
	});
}
var datepicker_default = function(){
		
	var datepicker_default = {
	        closeText : "닫기",
	        prevText : "이전달",
	        nextText : "다음달",
	        currentText : "오늘",
	        changeMonth: true,
	        changeYear: true,
	        monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
	        monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
	        dayNames : [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ],
	        dayNamesShort : [ "일", "월", "화", "수", "목", "금", "토" ],
	        dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
	        weekHeader : "주",
	        firstDay : 0,
	        isRTL : false,
	        showMonthAfterYear : true,
	        yearSuffix : '',
	         
	        showOn: 'both',
			buttonImage: "/resources/images/calendar.png",
	        buttonImageOnly: true,
	         
	        showButtonPanel: true
	}
	datepicker_default.closeText = "선택";
	datepicker_default.dateFormat = "yy-mm";
	datepicker_default.onClose = function (dateText, inst) {
	    var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	    var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	    $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
	    $(this).datepicker('setDate', new Date(year, month, 1));
// 		$(this).css("display","none");
	}

	datepicker_default.beforeShow = function () {
	    
	    var selectDate = $(".Monthpicker").val().split("-");
	    var year = Number(selectDate[0]);
	    var month = Number(selectDate[1]) - 1;
	    $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
// 		$(this).css("display","none");
	}
	
	$(".Monthpicker").datepicker(datepicker_default);
	
	$('.ui-datepicker-calendar').css("display","none");
}
var dateinHistory = new Date();
function datePickerinAssetHistory(){
	$( "#USE_END_DT" ).datepicker({
		showOn: "button",
		buttonImage: "/resources/images/calendar.png",
		buttonImageOnly: true,
		dateFormat: 'yy-mm-dd',
		minDate: new Date($('#USE_START_DT').val()),
		maxDate: new Date(dateinHistory.getFullYear()+'-'+(dateinHistory.getMonth()+1)+'-'+d.getDate()),
		prevText: '이전 달',
		yearRange: 'c-80:c+10',
		nextText: '다음 달',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		showMonthAfterYear: true,
		yearSuffix: ' ',
		changeYear:true,
		changeMonth:true
	});
}

function fn_compoYearMonthInputbox(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<input type="text" class="Monthpicker" maxlength="8" onchange="date_check(this);" id="'+tagId+'" name="'+tagName+'" readonly="readonly" />';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}
//7.인사기록 외국어 인풋박스 행추가
function fn_compoInputboxRowPlus(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label, width, length, rowId){

	///////////////////////
	////////////////////////
	if(mpGubun == 'M'){
		if(width == undefined || width == ''){
			$('#' + divId).attr('class', 'col clear');
		}else{
			$('#' + divId).attr('class', 'col col1'); // 3칸전용
		}
	var tagStr = '<div class="row clear">'+'<div id="inputNdetail_401_1" class="col clear"><p class="left">';
	if(requiredYn == 'Y'){
		tagStr += requiredSpan;
	}
		tagStr += label;
		tagStr += '</p>';
		tagStr += '<div class="right">';
			tagStr += '<input type="text" id="'+tagId+'" name="'+tagName+'" value="" maxlength="'+length+'"/> ';
		tagStr += '</div></div></div>';
		
	$('#' + rowId).append(tagStr);
	alert(rowId+"로우아이디");
	alert(tagStr);
}else if(mpGubun == 'P'){
	
}
////////////////////////////////////	
}
//30.부서 컴포넌트 19.04.03
function fn_compoSelApprDepart(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<select id="'+tagId+'" name="'+tagName+'">';
					tagStr += '<option value="">전체</option>';
					tagStr += '<option value="AP">응용 로봇연구센터</option>';
					tagStr += '<option value="SW">소프트웨어 융합본부</option>';
					tagStr += '<option value="MA"></option>';
				tagStr += '</select>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}
//9.비밀번호 입력 
function fn_compoInputboxPassword(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label, width, length){
	
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
//9.비밀번호 입력 
function fn_compoInputboxPasswordByBasic(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label, width, length){
	
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
			tagStr += '<input type="hidden" id="origin_'+tagId+'" value="" maxlength="'+length+'"/> ';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}
//15.여부 선택 radio 버튼 컴포넌트 성일 추가 2019.04.03 부서선택
function fn_compoRadioDepart(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div class="yorn">';
					tagStr += '<input type="radio" id="'+tagId+'1" name="'+tagName+'" value="AP" checked=true> 응용로봇연구센터';
					tagStr += '<input type="radio" id="'+tagId+'2" name="'+tagName+'" value="SW"> 소프트웨어융합본부';
					tagStr += '<input type="radio" id="'+tagId+'3" name="'+tagName+'" value="MA"> 경영관리실';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}
//15.여부 선택 radio 버튼 컴포넌트 성일 추가 2019.04.03 채용구분
function fn_compoRadioHire_devision(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div class="yorn">';
					tagStr += '<input type="radio" id="'+tagId+'1" name="'+tagName+'" value="공개" checked=true> 공개';
					tagStr += '<input type="radio" id="'+tagId+'2" name="'+tagName+'" value="비공개"> 비공개';
					tagStr += '<input type="radio" id="'+tagId+'3" name="'+tagName+'" value="추천"> 추천';
					tagStr += '<input type="hidden" id="'+tagId+'" name="'+tagName+'_hidden">';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}
//15.여부 선택 radio 버튼 컴포넌트 성일 추가 2019.04.03 회화능력
function fn_compoRadioConversat_ability(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div class="yorn">';
					tagStr += '<input type="radio" id="'+tagId+'1" name="'+tagName+'" value="상" checked=true> 상';
					tagStr += '<input type="radio" id="'+tagId+'2" name="'+tagName+'" value="중"> 중';
					tagStr += '<input type="radio" id="'+tagId+'3" name="'+tagName+'" value="하"> 하';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}
//15.여부 선택 radio 버튼 컴포넌트 성일 추가 2019.04.03 자가 전세 하숙 기타
function fn_compoRadioHousing_type(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div class="yorn">';
					tagStr += '<input type="radio" id="'+tagId+'1" name="'+tagName+'" value="자가" checked=true> 자가';
					tagStr += '<input type="radio" id="'+tagId+'2" name="'+tagName+'" value="전세"> 전세';
					tagStr += '<input type="radio" id="'+tagId+'3" name="'+tagName+'" value="하숙"> 하숙';
					tagStr += '<input type="radio" id="'+tagId+'4" name="'+tagName+'" value="자취"> 자취';
					tagStr += '<input type="radio" id="'+tagId+'5" name="'+tagName+'" value="기타"> 기타';
					tagStr += '<input type="hidden" id="'+tagId+'" name="'+tagName+'_hidden"/>';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}
//15.동거유무 버튼 컴포넌트 성일 추가 2019.04.03 동거 비동거
function fn_compoRadioFamily(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div class="yorn">';
					tagStr += '<input type="radio" id="'+tagId+'1" name="'+tagName+'" value="동거"> 동거';
					tagStr += '<input type="radio" id="'+tagId+'2" name="'+tagName+'" value="비동거"> 비동거';
					tagStr += '<input type="hidden" id="'+tagId+'" value="">';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}
//15.군대 면제 필 미필 라디오 컴포넌트 성일 추가 2019.04.03
function fn_compoRadioArmy(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div class="yorn">';
					tagStr += '<input type="radio" id="'+tagId+'1" name="'+tagName+'" value="면제" checked=true> 면제';
					tagStr += '<input type="radio" id="'+tagId+'2" name="'+tagName+'" value="미필"> 미필';
					tagStr += '<input type="radio" id="'+tagId+'3" name="'+tagName+'" value="필"> 필';
					tagStr += '<input type="hidden" id="'+tagId+'" name="'+tagName+'_hidden"/>';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}
//15.졸업구분 라디오 컴포넌트 성일 추가 2019.04.04
function fn_compoRadioEdu(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div class="yorn">';
					tagStr += '<input type="radio" id="'+tagId+'1" name="'+tagName+'" value="졸업" checked=true> 졸업';
					tagStr += '<input type="radio" id="'+tagId+'2" name="'+tagName+'" value="재학"> 재학';
					tagStr += '<input type="radio" id="'+tagId+'3" name="'+tagName+'" value="휴학"> 휴학';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}
//15.성별구분 라디오 컴포넌트 종빈 추가 2019.04.25
function fn_compoRadioGender(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div class="yorn">';
					tagStr += '<input type="radio" id="'+tagId+'1" name="'+tagName+'" value="M"> 남자';
					tagStr += '<input type="radio" id="'+tagId+'2" name="'+tagName+'" value="F"> 여자';
					tagStr += '<input type="hidden" id="'+tagId+'" name="'+tagName+'_hidden">';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}
//2019.04.03 기본키 사원번호 리드온리로 막기
function fn_compoInputbox_PK(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label, width, length){
	var dis = ' readonly="true" class="disabled_input" ';
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
				tagStr += '<input type="text" id="'+tagId+'" name="'+tagName+'" value="auto Input" maxlength="'+length + dis+'" readonly/> ';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}
//파일 업로드
function commonFileUpload(){
	var formData = new FormData($("form[name=form]")[0]);
	formData.append("viewName", window.location.pathname.substring(1,window.location.pathname.indexOf("/",2)));
    $.ajax({
        type : 'POST',
        url : '/commonSh/fileUpload.do',
        enctype: "multipart/form-data",
        data : formData,
        async 	: false,
        processData : false,
        contentType : false,
        error : function() { // Ajax 전송 에러 발생시 실행
			alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
		},
        success : function(html) {
        	//파일을 서버에 성공적으로 올라간다면 파일의 실제 저장된 경로를 DB에 입력하기 위하여 PRUF_FILE에 담는다.
        	$("#PRUF_FILE").val(html);
        }
    });
}

//사원에서 이미지업로드
function empFileUpload(){
	var formData = new FormData(form);
	formData.append("viewName", window.location.pathname.substring(1,window.location.pathname.indexOf("/",2)));
	formData.append("PRUF_FILE", $('input[name=PRUF_FILE]')[0]);
	formData.append("FILE", $('input[name=FILE]')[0]);
    $.ajax({
        type : 'POST',
        url : '/commonSh/fileUpload.do',
        enctype: "multipart/form-data",
        data : formData,
        async 	: false,
        processData : false,
        contentType : false,
        error : function() { // Ajax 전송 에러 발생시 실행
			alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
		},
        success : function(html) {
        	//파일을 서버에 성공적으로 올라간다면 파일의 실제 저장된 경로를 DB에 입력하기 위하여 PRUF_FILE에 담는다.
        	$("#PRUF_FILE").val(html);
        }
    });
}
//파일 업로드BF
function commonFileUploadBF(){
	var formData = new FormData($("form[name=form]")[0]);
	formData.append("viewName", window.location.pathname.substring(1,window.location.pathname.indexOf("/",2)));
    $.ajax({
        type : 'POST',
        url : '/commonSh/fileUploadBF.do',
        enctype: "multipart/form-data",
        data : formData,
        async 	: false,
        processData : false,
        contentType : false,
        error : function() { // Ajax 전송 에러 발생시 실행
			alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
		},
        success : function(html) {
        	//파일을 서버에 성공적으로 올라간다면 파일의 실제 저장된 경로를 DB에 입력하기 위하여 PRUF_FILE에 담는다.
        	$('#BF_PRUF_FILE').val(html);
        }
    });
}
//파일 업로드AF
function commonFileUploadAF(){
	var formData = new FormData($("form[name=form]")[0]);
	formData.append("viewName", window.location.pathname.substring(1,window.location.pathname.indexOf("/",2)));
    $.ajax({
        type : 'POST',
        url : '/commonSh/fileUploadAF.do',
        enctype: "multipart/form-data",
        data : formData,
        async 	: false,
        processData : false,
        contentType : false,
        error : function() { // Ajax 전송 에러 발생시 실행
			alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
		},
        success : function(html) {
        	//파일을 서버에 성공적으로 올라간다면 파일의 실제 저장된 경로를 DB에 입력하기 위하여 PRUF_FILE에 담는다.
        	$('#AF_PRUF_FILE').val(html);
        }
    });
}
//파일 업로드AF
function commonFileUploadDGRI(){
	var formData = new FormData($("form[name=form]")[0]);
	formData.append("viewName", window.location.pathname.substring(1,window.location.pathname.indexOf("/",2)));
    $.ajax({
        type : 'POST',
        url : '/commonSh/fileUploadDGRI.do',
        enctype: "multipart/form-data",
        data : formData,
        async 	: false,
        processData : false,
        contentType : false,
        error : function() { // Ajax 전송 에러 발생시 실행
			alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
		},
        success : function(html) {
        	//파일을 서버에 성공적으로 올라간다면 파일의 실제 저장된 경로를 DB에 입력하기 위하여 PRUF_FILE에 담는다.
        	$('#DGRI_PRUF_FILE').val(html);
        }
    });
}



//엑셀 업로드
function fn_compoExcelUp(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label){
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear file');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<label for="custom-file-upload" class="filupp">';
					tagStr += '<span class="filupp-file-name js-value">Files upload</span>';
					tagStr += '<input type="hidden" name="'+tagName+'" id="'+tagId+'" />';
					tagStr += '<input type="file" name="excel" class="excel" value="1" id="custom-file-upload"';
					tagStr += ' onchange="$(\'.filupp-file-name.js-value\').html($(\'#custom-file-upload\').get(0).files[0].name); $(\'#'+tagId+'\').val($(\'#custom-file-upload\').get(0).files[0].name)" />';
					tagStr += '<img width="18" class="fildfile absolute icon_button" src="/resources/images/file.png">';
				tagStr += '</label>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}
//첨부된 파일 다운로드
function fileDownLoad(fullpath){
	var full_url = fullpath;
	var path = full_url.substr(0,full_url.lastIndexOf("/"));
	var file_name = full_url.substr(full_url.lastIndexOf("/")+1);					
	var url = '/download.do?path='+ path + '&fileName=' + file_name;					
	location.href=url;
	
}

//서버에 올려진 실제 파일 삭제
function fileDelete(){
	var result = confirm('정말로 파일을 삭제 하시겠습니까?\n삭제된 파일은 복구 할수 없습니다');
	if(result){
	var formData = new FormData($("form[name=form]")[0]);
		$.ajax({
	        type : 'POST',
	        url : '/fileDelete.do',
	        data : formData,
	        async 	: false,
	        processData : false,
	        contentType : false,
	        error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
	        complete : function(html){
	        	alert('삭제되었습니다.');
	        }
	    });
		return true;
	}else{
		return false;
	}
	
}
//서버에 올려진 실제 파일 삭제
function fileDeleteBF(){
	
	var result = confirm('정말로 파일을 삭제 하시겠습니까?\n삭제된 파일은 복구 할수 없습니다.');
	if(result){
	var formData = new FormData($("form[name=form]")[0]);
		$.ajax({
	        type : 'POST',
	        url : '/fileDeleteBF.do',
	        data : formData,
	        async 	: false,
	        processData : false,
	        contentType : false,
	        error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
	        complete : function(html){
	        	alert('삭제되었습니다.');
	        }
	    });
		return true;
	}else{
		return false;
	}
	
}
//서버에 올려진 실제 파일 삭제
function fileDeleteAF(){
	var result = confirm('정말로 파일을 삭제 하시겠습니까?\n삭제된 파일은 복구 할수 없습니다.');
	if(result){
	var formData = new FormData($("form[name=form]")[0]);
		$.ajax({
	        type : 'POST',
	        url : '/fileDeleteAF.do',
	        data : formData,
	        async 	: false,
	        processData : false,
	        contentType : false,
	        error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
	        complete : function(html){
	        	alert('삭제되었습니다.');
	        }
	    });
		return true;
	}else{
		return false;
	}
	
}
//서버에 올려진 실제 파일 삭제
function fileDeleteDGRI(){
	var result = confirm('정말로 파일을 삭제 하시겠습니까?\n삭제된 파일은 복구 할수 없습니다.');
	if(result){
	var formData = new FormData($("form[name=form]")[0]);
		$.ajax({
	        type : 'POST',
	        url : '/fileDeleteDGRI.do',
	        data : formData,
	        async 	: false,
	        processData : false,
	        contentType : false,
	        error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
	        complete : function(html){
	        	alert('삭제되었습니다.');
	        }
	    });
		return true;
	}else{
		return false;
	}
	
}
//파일을 삭제할 것인지 묻지않고 바로 삭제
function fileDeleteDirect(){
	var formData = new FormData($("form[name=form]")[0]);
		$.ajax({
	        type : 'POST',
	        url : '/fileDelete.do',
	        data : formData,
	        async 	: false,
	        processData : false,
	        contentType : false,
	        error : function() { // Ajax 전송 에러 발생시 실행
				//alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
	        complete : function(html){
	        }
	    });
	
}
//파일을 삭제할 것인지 묻지않고 바로 삭제
function fileDeleteDirectBF(){
	var formData = new FormData($("form[name=form]")[0]);
		$.ajax({
	        type : 'POST',
	        url : '/fileDeleteBF.do',
	        data : formData,
	        async 	: false,
	        processData : false,
	        contentType : false,
	        error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
	        complete : function(html){
	        }
	    });
	
}
//파일을 삭제할 것인지 묻지않고 바로 삭제
function fileDeleteDirectAF(){
	$('#PRUF_FILE').val('');
	$('#PRUF_FILE').val($('#AF_PRUF_FILE').val());
	var formData = new FormData($("form[name=form]")[0]);
		$.ajax({
	        type : 'POST',
	        url : '/fileDeleteAF.do',
	        data : formData,
	        async 	: false,
	        processData : false,
	        contentType : false,
	        error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
	        complete : function(html){
	        }
	    });
	
}
//파일을 삭제할 것인지 묻지않고 바로 삭제
function fileDeleteDirectDGRI(){
	$('#PRUF_FILE').val('');
	$('#PRUF_FILE').val($('#DGRI_PRUF_FILE').val());
	var formData = new FormData($("form[name=form]")[0]);
		$.ajax({
	        type : 'POST',
	        url : '/fileDeleteDGRI.do',
	        data : formData,
	        async 	: false,
	        processData : false,
	        contentType : false,
	        error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
	        complete : function(html){
	        }
	    });
	
}

//도로명주소 팝업 기능
function fn_addressPopup(tagId){
	var id = tagId[0].id
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수
            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById(id).value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById(id).focus();
        }
    }).open();
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

// 인사번호 성명 컴포넌트
function fn_compoNameEmpId(mpGubun, searchInputGb, divId, tagId1, tagName1, tagId2, tagName2, requiredYn, label){
	
	var dis = '';
	if (searchInputGb=='I') {
		dis = ' readonly="true" class="disabled_input" ';
	} else if (searchInputGb=='S'){
		dis = '';
	}
	
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col col2 clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div>';
					tagStr += '<input type="text" id="'+tagId1+'" name="'+tagName1+'" readonly="readonly" class="disabled_input"> ';
				tagStr += '</div>';
				tagStr += '<div>';
				tagStr += '<input type="text" id="'+tagId2+'" name="'+tagName2+'" '+dis+'>';
				tagStr += '<button class="magnifier absolute icon_button" onclick="javascript:fn_openEmpPopup('+"'"+divId+"'"+');return false;"></button>';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
	
}

//코드별 샐랙트박스
function fn_compoSelGbSetting(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label, gbCode){
	gbCode += "";
	if(mpGubun == 'M'){
		fn_codeSelectBoxSetting1(gbCode, mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label);
	}else if(mpGubun == 'P'){
		
	}
}
// select box 컴포넌트
function fn_compoSelBox(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label , codeSe){
	var optionList = getCmmnCdList(codeSe);
	if(mpGubun == 'M'){
		
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<select id="'+tagId+'" name="'+tagName+'">';
				tagStr += optionList;
				tagStr += '</select>';
			tagStr += '</div>';
		tagStr += '</div>'
				
			$('#' + divId).html(tagStr);
			
	}
}
//select box 컴포넌트 여러코드 한꺼번에 불러올때
function fn_compoSelBoxMulti(mpGubun, searchInputGb, divId, tagId, tagName, requiredYn, label , codeSe, codeSe2){
	var optionList = getCmmnCdList(codeSe);
	optionList += getCmmnCdList(codeSe2);
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<select id="'+tagId+'" name="'+tagName+'">';
				tagStr += '<option value="">전체</option>';
				tagStr += optionList;
				tagStr += '</select>';
			tagStr += '</div>';
		tagStr += '</div>'
				
			$('#' + divId).html(tagStr);
			
	}
}
//15.여부 선택 radio 버튼 컴포넌트
function fn_compoSelBoxOrder(mpGubun, searchInputGb, divId, tagId, tagId2, tagName, tagName2, requiredYn, label){
	if(mpGubun == 'M'){
		$('#' + divId).attr('class', 'col clear');
		var tagStr = '<p class="left">';
		if(requiredYn == 'Y'){
			tagStr += requiredSpan;
		}
			tagStr += label;
			tagStr += '</p>';
			tagStr += '<div class="right">';
				tagStr += '<div  style="width:49.5%; float:left">';
				tagStr += '<select id="'+tagId+'" name="'+tagName+'" class="relative">';
				tagStr += '<option value="">선택하세요</option>';
				tagStr += '<option value="DEPART">부서</option>';
				tagStr += '<option value="EMP_NM">이름</option>';
				tagStr += '<option value="ENTERING_DATE">입사일</option>';
				tagStr += '<option value="POSITION">직급</option>';
				tagStr += '</select>';
				tagStr += '</div>';
				tagStr += '<div style="width:49.5%;margin-left:1%;	float:left">';
				tagStr += '<select id="'+tagId2+'" name="'+tagName2+'" class="relative">';
				tagStr += '<option value="UP">오름차순</option>';
				tagStr += '<option value="DOWN">내림차순</option>';
				tagStr += '</select>';
				tagStr += '</div>';
			tagStr += '</div>';
			
		$('#' + divId).html(tagStr);
		
	}else if(mpGubun == 'P'){
		
	}
}



// 폼 초기화
var fn_form_reset = function(){
	$('form')[0].reset();
}

function comma(num){
    var len, point, str; 
       
    num = num + ""; 
    point = num.length % 3 ;
    len = num.length; 
   
    str = num.substring(0, point); 
    while (point < len) { 
        if (str != "") str += ","; 
        str += num.substring(point, point + 3); 
        point += 3; 
    } 
     
    return str;
 
}

function removeComma(str)

{

	n = parseInt(str.replace(/,/g,""));

	return n;

}
</script>



<!-- ***************** 202107 ******************* -->
<input type="hidden" id="USER_ID" name="USER_ID">
<!-- ********************************************* -->


<input type="hidden" id="EMP_ID" name="EMP_ID">
<input type="hidden" id="SINGLEYN" name="SINGLEYN" value="Y"><!-- 단일 다중 -->
<input type="hidden" id="NOWTAB" name="NOWTAB" value="basic"><!-- 현재탭 -->
<input type="hidden" id="notPaging" name="notPaging"><!-- 상세조회를 위한 키 -->
<input type="hidden" id="KEY" name="KEY"><!-- 상세조회를 위한 키 -->
<input type="hidden" id="APPR_KEY" name="APPR_KEY"><!-- 승인 키 -->
<input type="hidden" name="cols">
<input type="hidden" name="colsNm">
<input type="hidden" id="excelCols" name="excelCols">
<input type="hidden" id="excelColsNm" name="excelColsNm">
<input type="hidden" name="keys">
<input type="hidden" name="gridCheckboxYn">
<input type="hidden" id="searchYn" name="searchYn" value="">
<input type="hidden" id="updateYn" name="updateYn"><!-- 수정저장 여부 Y인 경우에만 update 하면 됨.. -->
<input type="hidden" id="ACTIVE_TOP_MENU" name="ACTIVE_TOP_MENU" value="${SS_ACTIVE_TOP_MENU }"><!-- 선택된 TOP 메뉴 -->
<input type="hidden" id="ACTIVE_SUB_MENU" name="ACTIVE_SUB_MENU" value="${SS_ACTIVE_SUB_MENU }"><!-- 선택된 SUB 메뉴 -->
<input type="hidden" id="PRUF_FILE" name="PRUF_FILE">
<input type="hidden" id="BF_PRUF_FILE" name="BF_PRUF_FILE">
<input type="hidden" id="AF_PRUF_FILE" name="AF_PRUF_FILE">
<input type="hidden" id="DGRI_PRUF_FILE" name="DGRI_PRUF_FILE">
<input type="hidden" id="FILE_GUBUN" name="FILE_GUBUN" value="normal">
<input type="hidden" id="fileChangeYn" name="fileChangeYn" value="N">
<input type="hidden" id="bf_fileChangeYn" name="bf_fileChangeYn" value="N">
<input type="hidden" id="af_fileChangeYn" name="af_fileChangeYn" value="N">
<input type="hidden" id="dgri_fileChangeYn" name="dgri_fileChangeYn" value="N">
<input type="hidden" id="sheet1Cols" name="sheet1Cols">
<input type="hidden" id="sheet1ColsNm" name="sheet1ColsNm">
<input type="hidden" id="sheet2Cols" name="sheet2Cols">
<input type="hidden" id="sheet2ColsNm" name="sheet2ColsNm">
<input type="hidden" id="sheet3Cols" name="sheet3Cols">
<input type="hidden" id="sheet3ColsNm" name="sheet3ColsNm">