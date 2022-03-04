<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style>
	input::placeholder {
	  color: #66666673;
	  font-style: italic;
	}
	
</style>


<script type="text/javascript">
	$(document).ready(function() {
		
		// 컴포넌트 호출
		fn_searchCompoSetting();
		
		
		
		//파일등록
		$("#addFile").on("click", function() {
			var attachlength = $(".attachlb").length;
			var filelength = $(".uploadFile").length;
			if($(".uploadFile").length + attachlength > 0) {	// 사업자 등록증 1개만 받는다
				return;
			}
			var newfile = $("<input/>", {"type" : "file", "class" : "uploadFile", "name" : "uploadFile", "accept" : ".pdf,.jpg,.jpeg"});
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
	
	
	// 검색영역 설정
	function fn_searchCompoSetting(){
		fn_compoInputbox('M', 'S', 'search_2_2', 'SEARCH_USR_NM', 'SEARCH_USR_NM', '', '성명', '', '30');
	}
	
	// 아이디중복확인, , 필수값 체크, 정규식 체크 - 형식 : 영문, 숫자, _, - 만 가능. 5~20글자 
	function fn_idChek(){
	
		var idVal = $("#INSERT_USER_ID").val(); 
		var idReg = /^[A-Za-z0-9_\-]{5,20}$/;
		if (idVal.match(idReg) == null || idVal.match(idReg) == '' || idVal == null || idVal == '') { 
			alert('아이디 형식에 맞춰 입력해 주세요.'); 
			$('#INSERT_USER_ID').focus();
			return;
		} else {	
			
		$.ajax({
			url : '/regist/duplIdCheck.do',
			data : {INSERT_USER_ID:$('#INSERT_USER_ID').val()},   //전송파라미터
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				var d = result.duplIdCheck;
				console.log(d);
				if(d == "OK"){
					alert("사용가능한 아이디 입니다.");
// 					return true;
				}else{
					alert("사용중인 아이디입니다. 다시 입력해 주세요.");
					form.INSERT_USER_ID.focus();
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
	}
	
	// 저장 버튼
	function fn_save(){

		var idVal = $("#INSERT_USER_ID").val(); 
		if(idVal == null || idVal ==''){
			alert("아이디를 입력해 주세요.");
			$('#USER_PWD').focus();
			return;
		}
		
		// 비밀번호 필수값 체크, 정규식 체크	- 영문, 숫자, 특수문자를 조합한 9~20자리
		var pwVal = $("#USER_PWD").val(); 
		var pwReg = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{9,20}$/; // 검증에 사용할 정규식 변수 regExp에 저장 
		if (pwVal.match(pwReg) == null || pwVal.match(pwReg) == '' || pwVal == null || pwVal == '') { 
			alert('비밀번호 형식에 맞춰 입력해 주세요.'); 
			$('#USER_PWD').val('');
			$('#USER_PWD').focus();
			return;
		}	
		// 비밀번호확인 필수값체크
		if($('#USER_PWD_CFM').val() == ''){
			alert('비밀번호 확인을 입력해 주세요!');
			$('#USER_PWD_CFM').focus();
			return;
		}
		// 비밀번호와 비밀번호확인 값이 같은지 확인
		if($('#USER_PWD').val() != '' && $('#USER_PWD_CFM').val() != ''){
			if($('#USER_PWD').val() != $('#USER_PWD_CFM').val()){
				$('#USER_PWD_CFM').val('');
				$('#USER_PWD_CFM').focus();
				alert('새 비밀번호와 확인이 서로 다릅니다. 다시 입력해 주세요!.');		
				return;
			}
		}

		// 이름 필수값 체크, 정규식 체크	 - 형식 : 한글 2~5자리	
		var nmVal = $("#USER_NM").val(); 
		var nmReg = /^[가-힣]{2,5}$/; // 검증에 사용할 정규식 변수 regExp에 저장 
		if (nmVal.match(nmReg) == null || nmVal.match(nmReg) == '' || nmVal == null || nmVal == '') { 
			alert('이름 형식에 맞춰 입력해 주세요.'); 
			$('#USER_NM').val('');
			$('#USER_NM').focus();
			return;
		} 
			
		//이메일  필수값체크, 정규식 체크 - 형식 :aaa@bbb.ccc
		var emailVal = $("#INSER_USER_EMAIL").val(); 
		var emailReg = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/; 
		if (emailVal.match(emailReg) == null || emailVal.match(emailReg) == '' || emailVal == null || emailVal == '') { 
			alert('이메일 형식에 맞춰 입력해 주세요.'); 
			$('#INSER_USER_EMAIL').val('');
			$('#INSER_USER_EMAIL').focus();
			return;
		}

		// 핸드폰번호 필수값체크, 정규식 체크 - 형식 : 000-0000-0000
		var mpVal = $("#MOBILE").val(); 
		var mpReg = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/; // 검증에 사용할 정규식 변수 regExp에 저장 
		if (mpVal.match(mpReg) == null || mpVal.match(mpReg) == '' || mpVal == null || mpVal == '') { 
			alert('휴대전화번호 형식에 맞춰 입력해 주세요.'); 
			$('#MOBILE').val('');
			$('#MOBILE').focus();
			return;
		}
		
		
		// 첨부파일확장자 제한
		var file_len = $(".uploadFile").length;
		for(var i = 0; i < file_len; i ++){
			var filename = $("input[name=uploadFile]:eq(" + i + ")").val();
			var ext = filename.substring(filename.lastIndexOf(".")+1,filename.length);
			if(ext != "jpg" && ext != "pdf" && ext != "jpeg"){
				alert("pdf, jpg, jpeg 파일만 가능합니다.");
// 				$('.uploadFile').val('');	// 모든 첨부파일이 지워져서 주석처리
				$('.uploadFile').focus();
				return false;
			}
		}
		
		form.action = "/regist/insertUsrMng.do";
		goSubmit(form);
	}
	
	
	// 로그인화면으로 이동
	function fn_goList(){
		form.action = "/login/login.do";
		goSubmit(form);
	}

	
	// 한글입력방지
	
	$(document.body).on('blur', '#USR_ID', function(e) { 
		if (!(e.keyCode >=37 && e.keyCode<=40)) {
			var v = $('#USR_ID').val();
			$('#USR_ID').val(v.replace(/[^a-z0-9]/gi,''));
		}
	});
	$(document.body).on('keyup', '#USR_ID', function(e) { 
		if (!(e.keyCode >=37 && e.keyCode<=40)) {
			var v = $('#USR_ID').val();
			$('#USR_ID').val(v.replace(/[^a-z0-9]/gi,''));
		}
	});
	
	
</script>

<title>티디아 우선심사 시스템</title>
</head>
<body>
	<form name="form" method="post" class="regist user_mode" enctype="multipart/form-data" accept-charset="UTF-8">
		<!-- KEY 컴포넌트가 없는 경우 hidden 생성 -->
		
		<!-- 컴포넌트 사용을 위한 include jsp -->
		<jsp:include flush="false" page="../common/commonComponent.jsp"></jsp:include>
		
		<div class="title_name relative">
			<!-- 각종 특강 등록 -->
			회원가입
			<%-- <c:out value="${SS_ACTIVE_SUB_MENU_NM }" /> --%>
		</div>
		
		<div class="box-blue-line clear relative">
			<!-- 입력 및 상세영역 -->
			<div id="inputNdetailDivBox" class="inputNdetail narrow">
				<p class="title"><span>로그인 정보</span><span class="required_input absolute"><span class="required"></span>항목은 필수 입력 항목입니다.</span></p>
				<div class="inputNdetail_box">
					<div class="row clear">
						<div id="inputNdetail_1_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>ID</p>
							<div class="right">
								<input type="text" id="INSERT_USER_ID" name="INSERT_USER_ID" value="" maxlength="30" style="ime-mode:active" placeholder="영문, 숫자조합 5~20글자"> 
								<button type="button" class="btn_inside" onclick="javascript:fn_idChek();"><b>아이디 중복 확인</b></button>
							</div>
						</div>
					</div>					
					<div class="row clear">
						<div id="inputNdetail_2_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>비밀번호</p>
							<div class="right">
								<input type="password" id="USER_PWD" name="USER_PWD" value="" maxlength="30" placeholder="영문, 숫자, 특수문자를 조합한 9~20자리"> 
								<input type="hidden" id="origin_USER_PWD" value="" maxlength="30"> 
							</div>
						</div>		
						<div id="inputNdetail_2_2" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>비밀번호 확인</p>
							<div class="right">
								<input type="password" id="USER_PWD_CFM" name="USER_PWD_CFM" value="" maxlength="30"> 
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div id="inputNdetailDivBox" class="inputNdetail narrow">
				<p class="title"><span>회원 정보</span></p>
				<div class="inputNdetail_box">
					<div class="row clear">
						<div id="inputNdetail_3_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>담당자 이름</p>
							<div class="right">
								<input type="text" id="USER_NM" name="USER_NM" value="" maxlength="30" style="ime-mode:active" placeholder="한글 2~5자리"> 
							</div>
						</div>
						<div id="inputNdetail_3_2" class="col clear">
							<p class="left">담당자 유선전화</p>
							<div class="right">
								<input type="text" id="OFFICE_PHONE" name="OFFICE_PHONE" value="" maxlength="30" style="ime-mode:active" placeholder="000-000-0000"> 
							</div>
						</div>
					</div>
					<div class="row clear">
						<div id="inputNdetail_4_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>담당자 E-mail</p>
							<div class="right">
								<input type="text" id="INSER_USER_EMAIL" name="INSER_USER_EMAIL" value="" maxlength="30" style="ime-mode:active" placeholder="알림 메일, 견적서, 세금계산서를 수신하기 위한 E-mail 주소"> 
							</div>
						</div>
						<div id="inputNdetail_4_2" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>담당자 휴대전화</p>
							<div class="right">
								<input type="text" id="MOBILE" name="MOBILE" value="" maxlength="30" style="ime-mode:active" placeholder="000-0000-0000"> 
							</div>
						</div>
					</div>
					<br>
					<div class="row clear">
						<div id="inputNdetail_5_1" class="col clear">
							<p class="left">기업명</p>
							<div class="right">
								<input type="text" id="OFFICE_NM" name="OFFICE_NM" value="" maxlength="30" style="ime-mode:active"> 
							</div>
						</div>
						<div id="inputNdetail_5_2" class="col clear">
							<p class="left">사업자등록번호</p>
							<div class="right">
								<input type="text" id="OFFICE_REG_NO" name="OFFICE_REG_NO" value="" maxlength="30" style="ime-mode:active" placeholder=""> 
							</div>
						</div>
					</div>
					<div class="row clear">
						<div id="inputNdetail_6_1" class="col clear">
							<p class="left">대표자 이름</p>
							<div class="right">
								<input type="text" id="OFFICE_OWNER_NM" name="OFFICE_OWNER_NM" value="" maxlength="30" style="ime-mode:active" placeholder="한글 2~5자리"> 
							</div>
						</div>
					</div>
					<div id="inputNdetail_7_1" class="col clear file"> 
							<p class="left">사업자 등록증</p>
							<div class="right">
								<input type="button" id="addFile" value="추가">
								<input type="button" id="delFile" value="삭제">
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
				<p class="note" style="margin: 10px 0 5px; color: #777; font-size: 0.75rem; line-height: 1.5;">[참고] 전자세금계산서, 현금영수증 발행을 위한 분은 기업명, 사업자 등록번호, 대표자 성함, 사업자 등록증을 입력해주시기 바랍니다.<br/>
상기 정보는 회원정보 수정에서 추후 입력 가능합니다.</p>
			</div>
			<!-- 입력 및 상세영역 END -->
			
			<!-- 상단버튼 영역 -->
			<div id="buttonDivBox" class="button_box">
				<button type="button" id="" onclick="javascript:fn_save();return false;"><span></span><c:out value="가입" /></button><!-- 저장하고 다음으로 넘어가기 버튼 -->
			</div>
			<!-- 상단버튼 영역 END -->
		</div>
	</form>
	<script type="text/javascript">
	
	

	
	// 관리자 신규등록시 비밀번호 필수입력 변경 함수
	function newUpchk(flag){
		if (flag == true) {
// 			$('#inputNdetail_3_1 > p').prepend('<span class="required"></span>');	// 필수값 * 넣는 방법
// 			$('#inputNdetail_3_2 > p').prepend('<span class="required"></span>');
			$('#USER_ID').attr('readonly', false);
			$('#USER_ID').removeClass("disabled_input");
// 			$('#USER_PWD').attr('readonly', true);
			$('#USER_PWD').addClass('disabled_input');
			$('#USER_PWD').val('');
			$('#USER_PWD_CFM').val('');
		} else if (flag == false){
// 			$('#inputNdetail_3_1 > p > span').remove();
// 			$('#inputNdetail_3_2 > p > span').remove();
			$('#INSERT_USER_ID').attr('readonly', false);	// 수정일경우 아이디 변경 못하게
// 			$('#inputNdetail_3_2').hide();	// 수정일경우 비밀번호 변경 안보이게
// 			$('#inputNdetail_3_3').hide();	// 수정일경우 비밀번호 변경 확인 안보이게
			$('#inputNdetail_3_2');
			$('#inputNdetail_3_3');	
			$('#USER_ID').attr('readonly', false);
			$('#USER_ID').addClass('disabled_input');
// 			$('#USER_PWD').attr('readonly', false);
			$('#USER_PWD').removeClass("disabled_input");
			$('#USER_PWD').val('');
			$('#USER_PWD_CFM').val('');
			$('#USER_NM').val('').attr('readonly', false);
			$('#inputNdetail_1_3 > p').prepend('<span class="required"></span>');
			$('#INSER_USER_EMAIL').val('').attr('readonly', false);
			$('#BIRTH').val('').attr('readonly', false);
			$('#MOBILE').val('').attr('readonly', false);
			$('#OFFICE_NM').val('').attr('readonly', false);
			$('#DEPT').val('').attr('readonly', false);
			$('#JOB').val('').attr('readonly', false);
			$('#inputNdetail_4_1 > p').prepend('<span class="required"></span>');
		}
	}
	
	// 라디오박스 체크 고정
	$('[value='+$('#PARAM_GB').val()+']').prop('checked', 'checked');
	
	</script>
	<input type="hidden" id="PARAM_GB" name="PARAM_GB" value='${param.USR_GB}'>
</body>
</html>