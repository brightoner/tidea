<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$(document).ready(function() {
		
		setDateBox();
		
		// 컴포넌트 호출
		fn_buttonCompoSetting();
		fn_searchCompoSetting();
		fn_gridCompoSetting();
		fn_inputNdetailCompoSetting();
		
		// 검색조건 유지
		$('#SEARCH_AUTH_NM').val('${param.SEARCH_AUTH_NM}');
		
	});
	
	// 날짜 콤보박스
	   function setDateBox(){
        var dt = new Date();
        var year = "";
        var com_year = dt.getFullYear();
        // 발행 뿌려주기
        $("#YEAR").append("<option value=''>공고년도</option>");
        // 올해 기준으로 -1년부터 +5년을 보여준다.
        for(var y = (com_year-10); y <= (com_year); y++){
            $("#YEAR").append("<option value='"+ y +"'>"+ y + "</option>");
        }
    }

	// 버튼영역 설정
	function fn_buttonCompoSetting(){
	}
	
	// 검색영역 설정
	function fn_searchCompoSetting(){
		fn_compoInputbox('M', 'S', 'search_1_1', 'SEARCH_AUTH_NM', 'SEARCH_AUTH_NM', '', '권한명');
	}
	
	// 그리드 설정
	var cols = ['APPLY_NO', 'APLCT_NO', 'USER_ID', 'APPLY_DT', 'INVT_NM', 'ESTIMATE', 'PAY_METHOD', 'PRICE', 'STATUS']; //예) var cols = ['COL1', 'COL2', 'COL3'];
	var colsNm = ['신청번호', '출원번호', '유저아이디', '신청일', '발명의명칭', '견적서', '결제방식', '결제금액', '진행상태']; //예) var colsNm = ['컬럼한글명1', '컬럼한글명2', '컬럼한글명3'];
	var key = ['APPLY_NO', 'APLCT_NO', 'USER_ID','INVT_NM','STATUS']; //예) var key = ['SN', 'HAKBEON'];
	function fn_gridCompoSetting(){
		fn_compoGrid('M', 'grid', cols, colsNm, key);
		fn_gridColgroupSetting('grid', ['5%', '10%', '10%', '10%', '*%', '10%', '10%', '10%','10%', '10%']); // colgroup 설정
		fn_gridAlignSetting('grid', ['center', 'center', 'center', 'center', 'left', 'center', 'center', 'center', 'center', 'center']); // 그리드 데이터 정렬 설정(종류:left, center, right)
	}
	
	// 입력 및 상세영역 설정
 	function fn_inputNdetailCompoSetting(){
 		fn_compoInputbox('M', 'I', 'inputNdetail_1_1', 'APPLY_NO', 'APPLY_NO', 'Y', '신청번호');
 
 	}
	
	// 조회 버튼
	function fn_search(){
		var url = "/receipt/receiptMng.do?APPLY_NO=" +  $('#APPLY_NO').val() + "&APLCT_NO=" + $('#APLCT_NO').val() + "&USER_ID=" + $('#USER_ID').val() + "&INVT_NM=" + $('#INVT_NM').val() + "&STATUS=" + $('#STATUS').val();
		goSearch(url);
	}
	
	// 페이징 조회
	function pageCall(pageNo) {
		var url = "/receipt/receiptMng.do?";
		goPageCall(url, pageNo);
	}
	
	// 신규등록
	function fn_registration(){
		var url = "/receipt/receiptReg.do";
		goSearch(url);
		
	}
	
	
	// 그리드에서 상세보기를 위한 row onclick 이벤트
	function fn_gridDetailOnclick(obj, trId){
		
		//GOV_ORG의 n번째 값을 가져오기 위해 table의 row값을 받아옴
		$(".list_table tr").click(function(){ 	

			var str = ""
			var tdArr = new Array();	// 배열 선언
			
			// 현재 클릭된 Row(<tr>)
			var tr = $(this);
			var td = tr.children();
			
			// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
			td.each(function(i){
				tdArr.push(td.eq(i).text());
			});
			
			// td.eq(index)를 통해 값을 가져올 수도 있다.
			var no = td.eq(0).text() -1;
			
			// 마지막 자리숫자가 index번호와 같으므로 마지막 자리수만 잘라온다
			var str_no = String(no);
			var last_no = str_no.substr(str_no.length-1 ,1);
			var APPLY_NO = $('#' + trId).find('input[name^=APPLY_NO]').val();
	        var APLCT_NO = tdArr[1];
	        var USER_ID = tdArr[2];
			document.form.action = "/receipt/receiptDetail.do?APLCT_NO=" +  APLCT_NO + "&APPLY_NO=" + APPLY_NO+ "&USER_ID=" + USER_ID ;
       		document.form.submit();
		});
	}
	
	
</script>
<title>티디아 우선심사 시스템</title>
</head>
<body>
	<form name="form" method="post" accept-charset="UTF-8">
		<!-- KEY 컴포넌트가 없는 경우 hidden 생성 -->
		
		<!-- 컴포넌트 사용을 위한 include jsp -->
		<jsp:include flush="false" page="../common/commonComponent.jsp"></jsp:include>
		
		<div class="title_name relative">
			공고현황
			<div class="navi absolute">
				<span><a href=""><img width="15" class="home_icon" src="/resources/images/home.png"></a></span>>
				<span><a href="">신청과제관리</a></span>  
				<span><a href="">공고현황</a></span>
			</div>
		</div>
		
		<div class="box-blue-line clear relative">
			<!-- 상단버튼 영역 -->
			<div id="buttonDivBox" class="button_box">
				<button type="button" id="searchBtn" onclick="javascript:fn_search();return false;"><span></span>조회</button><!-- 조회버튼 -->
			</div>
			<!-- 상단버튼 영역 END -->
			
			<!-- 조회조건 영역 -->
			<div id="searchDivBox" class="search_box relative">
		
<!-- 				<label>신청번호</label> -->
<!-- 				<input style="width:50px;" type="text" name="APPLY_NO" id="APPLY_NO"> -->
				
				<label>출원번호</label>
				<input style="width:100px;" type="text" name="APLCT_NO" id="APLCT_NO">
				
				<label>발명의 명칭</label>
				<input style="width:400px;" type="text" name=INVT_NM id="INVT_NM">
		
				<label>진행상태</label>
				<select style="width:250px;" id="STATUS">
					<option value="">전체</option>
					<option value="1">결제대기</option>
					<option value="2">결제완료</option>
					<option value="3">접수완료</option>
					<option value="4">납품완료</option>
				</select>
					
			</div>
			<!-- 조회조건영역 END -->
			
			<!-- 그리드 영역 -->
			<div id="grid"></div>
			<!-- 그리드 영역 END -->
	
			<input type="hidden" id="inputNdetail_1_1"/>
		</div>
	</form>
</body>
</html>