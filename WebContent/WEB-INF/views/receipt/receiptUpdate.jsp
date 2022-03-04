<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	request.setCharacterEncoding("UTF-8");
%>


<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


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
		//출원번호 필수값 체크
		if($('#APLCT_NO').val() == null || $('#APLCT_NO').val() == ''){
			alert('출원번호를 선택해 주세요');
			form.APLCT_NO.focus();
			return false;
		}
		
		//출원일자 필수값 체크
		if($('#APLCT_DT').val() == null || $('#APLCT_DT').val() == ''){
			alert('출원일자를 입력해 주세요');
			form.APLCT_DT.focus();
			return false;
		}
		
		//출원인을 필수값 체크
		if($('#APLCT_NM').val() == null || $('#APLCT_NM').val() == ''){
			alert('출원인을 입력해 주세요');
			form.APLCT_NM.focus();
			return false;
		}
		
		// 첨부파일확장자 제한
		var file_len = $(".uploadFile").length;
		for(var i = 0; i < file_len; i ++){
			var filename = $("input[name=uploadFile]:eq(" + i + ")").val();
			var ext = filename.substring(filename.lastIndexOf(".")+1,filename.length);
			if(ext != "hwp" && ext != "pdf" && ext != "doc" && ext != "docx"){
				alert("hwp, pdf, doc, docx 파일만 가능합니다.");
// 				$('.uploadFile').val('');	// 모든 첨부파일이 지워져서 주석처리
				$('.uploadFile').focus();
				return false;
			}
		}
		
		//"저장하시겠습니까?" 메시지
		var result = confirm(gb_saveMsg);
		if(result){
			form.action = "/receipt/receiptUpdate.do";
			goSubmit(form);
		}
	}
	
	// 승인 버튼
	function fn_approval(){
		
	}
	
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
		 
		//파일등록(파일 추가 삭제)
		$("#addFile").on("click", function() {
			var attachlength = $(".attachlb").length;
			var filelength = $(".uploadFile").length;
			
			if($(".uploadFile").length + attachlength > 19) {
				alert("첨부파일은 20개까지입니다.");
				return;
			}
			var newfile = $("<input/>", {"type" : "file", "class" : "uploadFile", "name" : "uploadFile", "accept" : ".hwp,.doc,.docx,.pdf"});
			$(this).parent().append(newfile);
		});
		
		
		 //파일 입력 칸 삭제(파일 추가 삭제)
		 $("#delFile").on("click", function(){
			 $(".uploadFile:last").remove();
		 });
		 
		 
		 //불러온 파일 삭제(입력되어있던 첨부파일 삭제)
		 $("a[name='delete']").on("click", function(){
 			 var id_check = $(this).attr("id");
			 var id_check2 = id_check.substring(6);		// 인덱스 주소만 substring
			 var file_value = $("#FILE_NM"+id_check2).val();
			 var apply_value = $("#APPLY_NO"+id_check2).val();
			 var aplct_value = $("#APLCT_NO"+id_check2).val();
			 
			 //파일 삭제 클릭시 첨부파일에서 삭제하는 ajax		<== 잠시주석
			$.ajax({
				url : '/receipt/fileDel.do',
				data : {APLCT_NO:aplct_value, FILE_NM:file_value},   //전송파라미터
				type : 'POST',
				dataType : 'json',
				success : function() {
					return true;
				},
				error : function() { // Ajax 전송 에러 발생시 실행
					alert('오류가 발생했습니다.\n관리자에게 문의 바랍니다.','e');
				}
			});
			 
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

	<form name="form" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
		<!-- KEY 컴포넌트가 없는 경우 hidden 생성 -->
		<input type="hidden" name="KEY" />
		
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
			<!-- 상단버튼 영역 -->
			<div id="buttonDivBox" class="button_box">
				<button type="button" id="saveBtn" onclick="javascript:fn_save();return false;"><span></span>저장</button><!-- 저장버튼 -->
				<button type="button" id="goListBtn" onclick="javascript:fn_goList();return false;"><span></span>목록</button><!-- 목록	 -->
			</div>
			<!-- 상단버튼 영역 END -->
			
			<!-- 조회조건 영역 -->
			<div id="searchDivBox" style="padding: 7px 10px; margin: 28px;">
 				<span class="required_input absolute"><span class="required"></span>항목은 필수 입력 항목입니다.</span>
			</div>
			<!-- 조회조건영역 END -->
			
			<!-- 그리드 영역 -->
			<div id="grid"></div>
			<!-- 그리드 영역 END -->

			<!-- 입력 및 상세영역 -->
			<div id="inputNdetailDivBox" class="inputNdetail">
				<p class="title"><span>상세 정보</span></p>
				<div class="inputNdetail_box">
					<!-- 1라인 -->
					<div class="row clear">
						<div id="inputNdetail_1_1" class="col clear">
							<p class="left">발명의 명칭</p>
							<div class="right">
								<input type="text" id="INVT_NM" name="INVT_NM" value="${receipt.INVT_NM}" maxlength="30" style="ime-mode:active" readonly="readonly">
							</div>
						</div>						
					</div>
					
					<!-- 2라인 -->
					<div class="row clear">
						<div id="inputNdetail_2_1" class="col clear">
							<p class="left">출원 번호</p>
							<div class="right">
								<input type="text" id="APLCT_NO" name="APLCT_NO" value="${receipt.APLCT_NO}" maxlength="30" style="ime-mode:active" readonly="readonly">
							</div>
						</div>
						
						<div id="inputNdetail_2_2" class="col clear">
							<p class="left">출원 일</p>
							<div class="right">
								<input type="text" id="APLCT_DT" name="APLCT_DT" value="${receipt.APLCT_DT}" maxlength="30" style="ime-mode:active" readonly="readonly">
							</div>
						</div>
					</div>
					
					
					<!-- 3라인 -->
					<div class="row clear">
						<div id="inputNdetail_3_1" class="col clear">
							<p class="left">출원 인</p>
							<div class="right">
								<input type="text" id="APLCT_NM" name="APLCT_NM" value="${receipt.APLCT_NM}" maxlength="30" style="ime-mode:active" readonly="readonly">
							</div>
						</div>
						<div id="inputNdetail_3_2" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>상태</p>
							<select style="width:200px;" id="STATUS" name="STATUS">
								<option value="1" <c:if test="${receipt.STATUS eq '결제대기'}">selected</c:if>>결제대기</option>
								<option value="2" <c:if test="${receipt.STATUS eq '결제완료'}">selected</c:if>>결제완료</option>
								<option value="3" <c:if test="${receipt.STATUS eq '접수완료'}">selected</c:if>>접수완료</option>
								<option value="4" <c:if test="${receipt.STATUS eq '납품완료'}">selected</c:if>>납품완료</option>
							</select>
							<input type="hidden" name="STATUS">
						</div>
						
					</div>
					
					<!-- 4라인 -->
					<div class="row clear">
						<div id="inputNdetail_4_1" class="col clear">
							<p class="left">신청 내용</p>
							<div class="right">
								<textarea id="MEMO" name="MEMO" cols="50" rows="20" readonly="readonly">${receipt.MEMO}</textarea>
							</div>
						</div>
					</div>
					
					<!-- 5라인 -->
					<div class="row clear">
						<div id="inputNdetail_5_1" class="col clear file"> 
							<p class="left">이용자 첨부파일</p>
							<div class="right">
								<c:forEach items="${fileInfo}" var="fileInfo" begin="0" end="${fileInfo.size()}" step="1" varStatus="status">
									<label class="attachlb"> 
										<a href="../files/${fileInfo.FILE_CHNG_NM}" name="FILEINFO_NAME" id="FILEINFO_NAME${status.index}" download="${fileInfo.FILE_NM}" target="_blank">
											<input type="text" name="FILE_NM" id="FILE_NM${status.index}" value="${fileInfo.FILE_NM}">
											<input type="hidden" name="FILE_CHNG_NM" id="FILE_CHNG_NM" value="${attachFileVo.file_chng_nm}">
											<input type="hidden" name="APPLY_NO" id="APPLY_NO${status.index}" value="${fileInfo.APPLY_NO}">
											<input type="hidden" name="APLCT_NO" id="APLCT_NO${status.index}" value="${fileInfo.APLCT_NO}">
										</a>
									</label>
									<br>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<input type="hidden" id="USER_ID" name="USER_ID" value="${receipt.USER_ID}">
			</div>
			
			<div class="inputNdetail_box">
				<!-- 6라인 -->
				<div class="row clear">
					<div id="inputNdetail_6_1" class="col clear file"> 
						<p class="left">조사원 첨부파일</p>
						<div class="right">
							<input type="button" id="addFile" value="추가" onclick="attach.add()">
							<input type="button" id="delFile" value="삭제" onclick="attach.del()">
							<c:forEach items="${fileInfo_2}" var="fileInfo_2" begin="0" end="${fileInfo_2.size()}" step="1" varStatus="status">
								<label class="attachlb"> 
									<a href="../files/${fileInfo_2.FILE_CHNG_NM}" name="FILEINFO_NAME" id="FILEINFO_NAME${status.index}" download="${fileInfo_2.FILE_NM}" target="_blank">
										<input type="text" name="FILE_NM" id="FILE_NM${status.index}" value="${fileInfo_2.FILE_NM}">
										<input type="hidden" name="FILE_CHNG_NM" id="FILE_CHNG_NM" value="${attachFileVo.file_chng_nm}">
										<input type="hidden" name="APPLY_NO" id="APPLY_NO${status.index}" value="${fileInfo_2.APPLY_NO}">
										<input type="hidden" name="APLCT_NO" id="APLCT_NO${status.index}" value="${fileInfo_2.APLCT_NO}">
									</a>
									<!-- 삭제버튼  -->
									<a href="#this" id="delete${status.index}" name="delete" class="btn">삭제하기</a>
								</label>
								<br>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
				
			<div class="inputNdetail_box">
				<!-- 7라인 -->
				<div class="row clear">
					<div id="inputNdetail_7_1" class="col clear">
						<p class="left">결제가격</p>
						<div class="right">
							<input type="text" id="PRICE" name="PRICE" value="${receipt.PRICE}" maxlength="30" style="ime-mode:active" readonly="readonly">
						</div>
					</div>
					
				</div>
				
				<!-- 8라인 -->
				<div class="row clear">
					<div id="inputNdetail_8_2" class="col clear">
						<p class="left">결제일</p>
						<div class="right">
							<input type="text" id="ORDER_DT" name="ORDER_DT" value="${receipt.ORDER_DT}" maxlength="30" style="ime-mode:active" readonly="readonly">
						</div>
				    </div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>