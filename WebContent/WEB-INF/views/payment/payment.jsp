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

<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">

	// 할인사유 라디오 버튼 클릭시 총액 계산
// 	$(document).on("click","input[name=discnt_rs]",function(){
// 	    var discount=$('[name="discnt_rs"]:checked').val();
// 	    var no_dis = 660000;
// 	    var dis_0 = 1;
// 		var dis_2 = 0.1;
// 		var dis_3 = 0.15;
// 		var dis_4 = 0.05;
// 	    if(discount == 1){
// 	        var a = 660000;
// 	        var aa = a.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
// 	        $('input[name=price]').attr('value',aa);
// 		}else if (discount == 2){
// 			var b = 660000 - (660000 * dis_2);
// 			var bb = b.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
// 			$('input[name=price]').attr('value',bb);
// 		}else if (discount == 3){
// 			var c = 660000 - (660000 * dis_3);
// 			var cc = c.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
// 			$('input[name=price]').attr('value',cc);
// 		}else if(discount == 4){
// 			var d = 660000 - (660000 * dis_4);
// 			var dd = d.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
// 			$('input[name=price]').attr('value',dd);
// 	    }
// 	});

	// 신용카드결제 클릭시 alert
	$(document).on("click", "input[name=pay_method]", function(){
		var pay_kind =$('[name="pay_method"]:checked').val();
		if(pay_kind == "1"){
			alert("카드결제준 준비중입니다. 다른 결제수단을 선택해 주세요!");
			return false;
		}
	});

	
	function fn_save(){
		form.action = "/regist/payment.do";
		goSubmit(form);
	}
	
	
</script>
<title>Insert title here</title>
</head>
<body>

	<form name="form" method="post" enctype="multipart/form-data">
		
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
<!-- 				<button type="reset" id="clearBtn"><span></span>초기화</button> -->
				<button type="button" id="saveBtn" onclick="javascript:fn_save();return false;"><span></span>저장</button><!-- 저장버튼 -->
<!-- 				<button type="button" id="goListBtn" onclick="javascript:fn_goList();return false;"><span></span>목록</button>목록 -->
			</div>
			<!-- 상단버튼 영역 END -->
			
			<!-- 조회조건 영역 -->
<!-- 			<div id="searchDivBox" style="padding: 7px 10px; margin: 28px;"> -->
			<div id="searchDivBox">
 				<span class="required_input absolute"><span class="required"></span>항목은 필수 입력 항목입니다.</span>
			</div>
			<!-- 조회조건영역 END -->
			
			<!-- 그리드 영역 -->
			<div id="grid"></div>
			<!-- 그리드 영역 END -->

			<div id="inputNdetailDivBox" class="inputNdetail">
				<p class="title"><span>결제화면</span></p>
				<div class="inputNdetail_box">					
					<!-- 1라인 -->
					<div class="row clear">
						<div id="inputNdetail_1_1" class="col clear">
							<p class="left">발명의 명칭</p>
							<div class="right">
								<input type="text" id="INVT_NM" name="INVT_NM" value="${INVT_NM}" readonly="readonly">
							</div>
						</div>						
						<div id="inputNdetail_1_2" class="col clear">
							<p class="left">출원 번호</p>
							<div class="right">
								<input type="text" id="APLCT_NO" name="APLCT_NO" value="${APLCT_NO}" readonly="readonly">
							</div>
						</div>						
					</div>
										
					<!-- 2라인 -->
					<div class="row clear">
						<div id="inputNdetail_2_1" class="col clear">
							<p class="left">출원 인</p>
							<div class="right">
								<input type="text" id="APLCT_NM" name="APLCT_NM" value="${APLCT_NM}" readonly="readonly">
							</div>
						</div>						
						<div id="inputNdetail_2_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>신청 인</p>
							<div class="right">
								<input type="text" id="USER_NM" name="USER_NM" value="${USER_NM}">
							</div>
						</div>						
					</div>
				
					
					<!-- 3라인 -->
<!-- 					<div class="row clear"> -->
<!-- 						<div id="inputNdetail_3_1" class="col clear"> -->
<!-- 							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>할인사유</p> -->
<!-- 							<div class="right" > -->
<!-- 								<input type='radio' name='discnt_rs' value='1' checked/>없음 -->
<!-- 							    <input type='radio' name='discnt_rs' value='2' />유공자 -->
<!-- 							    <input type='radio' name='discnt_rs' value='3' />장애인 -->
<!-- 							    <input type='radio' name='discnt_rs' value='4' />학생 -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
					
					<!-- 4라인 -->
					<div class="row clear">
						<div id="inputNdetail_4_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>결제방식</p>
							<div class="right" >
								<input type='radio' name='pay_method' value='1' />카드결제
								<input type='radio' name='pay_method' value='2' checked/>무통장입금
								<input type='radio' name='pay_method' value='3' />계좌이체
							</div>
						</div>
					</div>
					
					
					<!-- 5라인 -->
					<div class="row clear">
						<div id="inputNdetail_5_1" class="col clear">
							<p class="left"><span style="color:#C00000;"><strong>*</strong></span>결제금액</p>
							<div class="right">
								<input id="price" name="price" value="660,000">
							</div>
						</div>						
					</div>
				</div>
			</div>

		</div>
	</form>
</body>
</html>