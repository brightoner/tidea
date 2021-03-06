<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<style>
	input::placeholder {
	  color: #66666673;
	  font-style: italic;
	}
	
	.inputNdetail.narrow .checkbox {
	margin: 0 5px;
	}
	.inputNdetail.narrow textarea {
	height: 200px;
	}
	
	#applyType2 {
	margin-left: 10px;
	}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		
		// 컴포넌트 호출
		fn_searchCompoSetting();
		
		// 검색조건 유지
		if('${param.searchYn}' != 'Y'){return}
		$('#ANNOUNCE_NO').val('${param.ANNOUNCE_NO}');
		
		
	});
	
	// 검색영역 설정
	function fn_searchCompoSetting(){
		fn_compoInputbox('M', 'S', 'search_2_2', 'SEARCH_USR_NM', 'SEARCH_USR_NM', '', '성명', '', '30');
	}
	
			
	// 목록으로 돌아가기
	function fn_goList(){
		javascript:history.back();
	}
	
	
	// 저장 버튼
	function fn_save(){
		
		//발명의 명칭 필수값 체크
		if($('#INVT_NM').val() == null || $('#INVT_NM').val() == ''){
			alert('발명의 명칭을입력해 주세요.');
			form.INVT_NM.focus();
			return false;
		}
		
		//출원인을 필수값 체크
		if($('#APLCT_NM').val() == null || $('#APLCT_NM').val() == ''){
			alert('출원인을 입력해 주세요');
			form.APLCT_NM.focus();
			return false;
		}
		
		//출원일자 필수값체크, 정규식 체크  - 형식 : 0000-00-00
		var adVal = $("#APLCT_DT").val(); 
		var adReg = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/; // 검증에 사용할 정규식 변수 regExp에 저장 
		if (adVal.match(adReg) == null || adVal.match(adReg) == '' || adVal == null || adVal == '') { 
			alert('날짜 형식에 맞춰 입력해 주세요.'); 
			$('#APLCT_DT').val('');
			$('#APLCT_DT').focus();
			return false;
		}
		
		// 첨부파일확장자 제한
		var file_len = $(".uploadFile").length;
		for(var i = 0; i < file_len; i ++){
			var filename = $("input[name=uploadFile]:eq(" + i + ")").val();
			var ext = filename.substring(filename.lastIndexOf(".")+1,filename.length);
			if(ext != "pdf" && ext != "HLT" && ext != "HLZ" && ext != "hlt" && ext != "hlz"){
				alert("pdf, HLT, HLZ 파일만 가능합니다.");
// 				$('.uploadFile').val('');	// 모든 첨부파일이 지워져서 주석처리
				$('.uploadFile').focus();
				return false;
			}
		}
		
		//출원번호 필수값 체크
		if($('#APLCT_NO').val() == null || $('#APLCT_NO').val() == ''){
			alert('출원번호를 선택해 주세요');
			form.APLCT_NO.focus();
			return false;
		}
		
		//출원번호 중복체크
		$.ajax({
			url : '/apply/duplCheck.do',
			data : {APLCT_NO:$('#APLCT_NO').val()},   //전송파라미터
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				var d = result.duplCheck;
				if(d == "OK"){
// 					return true;
					
					// 출원번호가 중복이 아닐때 저장이된다.!!!
					// "저장하겠습니까?" 메시지
					var result = confirm(gb_saveMsg);
					if(result){
						form.action = "/apply/insertApply.do";	
						goSubmit(form);
					}
					
					
				}else{
					alert("출원번호가 이미 존재합니다. 다시 확인해 주세요.");
					form.APLCT_NO.value = null;
					form.APLCT_NO.focus();
					return false;
				}
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
			},
			complete : function(result) { // success, error 실행 후 최종적으로 실행
				
			}
		});
	}
	
	// 신용카드결제 선택시 alert
	$(document).on("click", "input[name=pay_method]", function(){
		var pay_kind =$('[name="pay_method"]:checked').val();
		if(pay_kind == "1"){
			alert("카드결제준 준비중입니다. 다른 결제수단을 선택해 주세요!");
			return false;
		}
	});
	
	// 화학/바이오 클릭시 alert
	$(document).on("click", "input[name=tech_field]", function(){
		var pay_kind =$('[name="tech_field"]:checked').val();
		if(pay_kind == "3"){
			alert("화학/바이오 분야는 서비스 준비중입니다!");
			return false;
		}
	});
	
	
	//JQUERY달력 (datepicker)
	$(document).ready(function () {
	    $.datepicker.setDefaults($.datepicker.regional['ko']); 
	        
	        // 공고일
		$("#APLCT_DT").datepicker({
			showOn:"button",
			buttonImage:"../images/btn_date.png",
			buttonImageOnly:true,
			changeMonth: true, 
			changeYear: true,
			nextText: '다음 달',
			prevText: '이전 달', 
			dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dateFormat: "yy-mm-dd",
			maxDate: "+1Y",                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가 // +1D:하루후, +1M:한달후, +1Y:일년후)
		});
		 
		 
		//파일등록
		$("#addFile").on("click", function() {
			var attachlength = $(".attachlb").length;
			var filelength = $(".uploadFile").length;
			if($(".uploadFile").length + attachlength > 19) {
				alert("첨부파일은 20개까지입니다.");
				return;
			}
			var newfile = $("<input/>", {"type" : "file", "class" : "uploadFile", "name" : "uploadFile", "accept" : ".pdf,.HLT,.HTZ,.hlt,.hlz"});
			$(this).parent().append(newfile);
		});
		
		
		 //파일 압력 칸 삭제
		 $("#delFile").on("click", function(){
			 $(".uploadFile:last").remove();
		 });
		 
		 //불러온 파일 삭제
		 $("a[name='delete']").on("click", function(){
			 $(this).parent().remove();
		 });
		 
	});
	
	
</script>


<title>티디아 우선심사 시스템</title>
</head>
<body>

<%
	//현재 날짜 받아오기
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
	String today = sf.format(now);
	sf = new SimpleDateFormat("yyyy-MM-dd");
	today = sf.format(now);
%>
	<form name="form" method="post" enctype="multipart/form-data" class="apply user_mode">
		
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
			<!-- 입력 및 상세영역 -->
			<div id="inputNdetailDivBox" class="inputNdetail narrow">
				<p class="title"><span>우선심사 신청</span><span class="required_input absolute"><span class="required"></span>항목은 필수 입력 항목입니다.</span>
				</p>
				<div class="inputNdetail_box">
					<div class="row clear">
						<div id="inputNdetail_1_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>우선심사 분야</p>
							<div class="right">
								<input type="radio" id="review_field" title="특허" name="review_field" value="1" checked><label for="review_field">특허</label>
								<input type="radio" id="review_field" title="실용신안" name="review_field" value="2"><label for="review_field">실용신안</label>
							</div>
						</div>
						<div id="inputNdetail_1_2" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>기술 분야</p>
							<div class="right">
								<input type="radio" id="tech_field" title="전기/전자" name="tech_field" value="1" checked><label for="tech_field">기계</label>
								<input type="radio" id="tech_field" title="전기/전자" name="tech_field" value="2"><label for="tech_field">전기/전자</label>
								<input type="radio" id="tech_field" title="전기/전자" name="tech_field" value="3"><label for="tech_field">화학/바이오</label>
							</div>
						</div>						
					</div>
					
					<div class="row clear">
						<div id="inputNdetail_1_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>발명의 명칭</p>
							<div class="right">
								<input type="text" id="INVT_NM" name="INVT_NM" value="${apply.INVT_NM}">
							</div>
						</div>						
					</div>			

					<div class="row clear">
						<div id="inputNdetail_2_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>출원번호</p>
							<div class="right">
								<input type="text" id="APLCT_NO" name="APLCT_NO" maxlength="30" style="ime-mode:active">
							</div>
						</div>
						<div id="inputNdetail_2_2" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>출원일</p>
							<div class="right">
								<input type="text" id="APLCT_DT" name="APLCT_DT" value="${apply.APLCT_DT}" placeholder="YYYY-MM-DD">
							</div>
						</div>
					</div>
					
					<div class="row clear">
						<div id="inputNdetail_2_3" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>출원인</p>
							<div class="right">
								<input type="text" id="APLCT_NM" name="APLCT_NM" maxlength="30" style="ime-mode:active" value="${apply.APLCT_NM}">
							</div>
						</div>
					</div>
					
					<div class="row clear">
						<div id="inputNdetail_2_4" class="col clear file"> 
							<p class="left">첨부서류</p>
							<div class="right">
								<input type="button" id="addFile" value="추가">
								<input type="button" id="delFile" value="삭제">
								<p class="note">* 첨부서류는 pdf, HLT, HLZ 파일만 가능합니다.</p>
								<c:forEach items="${fileInfo}" var="attachFileVo">
									<label class="attachlb">${attachFileVo.file_nm} 
										<input type="text" name="FILE_NM" id="FILE_NM" value="${attachFileVo.file_nm}">
										<input type="hidden" name="FILE_CHNG_NM" id="FILE_CHNG_NM" value="${attachFileVo.file_chng_nm}">
										<input type="hidden" name="FILE_NO" id="FILE_NO">
										<!-- 삭제버튼  -->
										<a href="#this" name="delete" class="btn">삭제하기</a>
									</label>
									<br>
								</c:forEach>
							</div>
						</div>
					</div>
					
					<div class="row clear">
						<div id="inputNdetail_4_1" class="col clear">
							<p class="left">요청 사항</p>
							<div class="right">
								<textarea id="MEMO" name="MEMO" cols="50" rows="20" placeholder="신청 건에 관한 참고 사항 및 결제 사항 등에 대해 남겨주시면, 확인 후 진행하도록 하겠습니다.">${apply.MEMO}</textarea>
							</div>
						</div>
					</div>
					
					<div class="row clear">
						<div id="inputNdetail_4_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>결제 방식</p>
							<div class="right" >
								<input type='radio' name='pay_method' value='1' />카드결제
								<input type='radio' name='pay_method' value='2' checked/>무통장입금
								<input type='radio' name='pay_method' value='3' />계좌이체
							</div>
						</div>
					</div>
					
					<div class="row clear">
						<div id="inputNdetail_2_2" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>결제 금액</p>
							<div class="right" >
								<input type='text' id="price" name="price" value="${price}" readonly="readonly">
							</div>
						</div>
					</div>
					
					<div class="row clear">
						<div id="inputNdetail_5_1" class="col clear">
							<p class="left">증빙 서류</p>
							<div class="right">
								<input type='checkbox' name='tax_invoice' value='Y'/>전자세금계산서 발행
								<input type='checkbox' name='cash_receipt' value='Y'/>현금영수증 발행
							</div>
						</div>						
					</div>
				</div>
				<p class="note">견적서 먼저 요청하시는 경우, 무통장입금 선택 후 진행하시기 바랍니다.<br/>
개인이 전자세금계산서 발행을 원하시는 경우, 신청 후 전화(042-934-2021) 또는 이메일(tidea@tidea.co.kr) 연락 부탁드립니다.</p>
			</div>
			<!-- 입력 및 상세영역 END -->
			
			<!-- 상단버튼 영역 -->
			<div id="buttonDivBox" class="button_box">
				<button type="reset" class="differ" id="clearBtn"><span></span>초기화</button>
				<button type="button" id="saveBtn" onclick="javascript:fn_save();return false;"><span></span>신청</button>
				<!-- <button type="button" id="goListBtn" onclick="javascript:fn_goList();return false;"><span></span>목록</button> -->
			</div>
			<!-- 상단버튼 영역 END -->
			
		</div>
		<input type="hidden" id="APPLY_DT" name="APPLY_DT" value="<%=today%>">
	</form>
</body>
</html>