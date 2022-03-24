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

</script>
<title>티디아 우선심사 시스템</title>
</head>
<body>
	<div>
		<div class="title_name relative">
			이용안내
	<%-- 			<c:out value="${SS_ACTIVE_SUB_MENU_NM }" /> --%>
		</div>
		
		<div class="box-blue-line clear relative guide">
			<!-- 입력 및 상세영역 -->
			<div id="inputNdetailDivBox" class="inputNdetail">
				<p class="title"><span id="modeSpan">유의사항</span></p>
				<div class="inputNdetail_box">
					<div class="row clear">
						<ul>
							<li>1. (주)티디아에 우선심사용 선행기술조사를 의뢰하시고, 별도로 본인 또는 대리인을 통해 특허청에 우선심사를 신청하셔야 심사를 받을 수 있습니다.</li>
							<li>2. 우선심사신청서에 전문기관에 선행기술의 조사 의뢰된 출원임을 표시하고, 의뢰기관((주)티디아) 및 의뢰일자를 적음으로써 우선심사 신청 설명서를 갈음하실 수 있습니다.</li>
							<li>3. 별도의 선행기술조사보고서를 이미 가지고 계시더라도, 우선심사를 받기 위해서는 우선심사 선행기술조사 전문기관에 반드시 의뢰하셔야 합니다.</li>
							<li>4. 우선심사는 출원하신 특허/실용신안에 대한 등록 결정 또는 등록 거절에 대한 심사정보를 우선적으로 받아보실 수 있는 것으로, 우선심사 신청만으로 출원하신 특허/실용신안에 바로 등록 받을 수 있음을 의미하는 것은 아닙니다.</li>
							<li>5. 우선심사 신청 단계에서 결제가 완료된 이후로부터 7일 이내(영업일 기준)에 우선심사 선행기술조사 결과를 받아보실 수 있습니다.
								<br/>(오후 4시 이전 결제 건 대상, 오수 4시 이후 결제 건은 익일부터 7일 이내)</li>
							<li>6. 우선심사 선행기술조사 결과는 특허청과 신청인에게 전자매체 형태의 규정 보고서와 인용문헌 원문으로 납품합니다.</li>
							<li>7. 조사완료 통보일로부터 3개월이 지난 우선심사 선행기술조사 결과는 관리지침에 따라 폐기합니다.</li>
						</ul>
					</div>
				</div>
			</div>
			<div id="inputNdetailDivBox" class="inputNdetail">
				<p class="title"><span id="modeSpan">할인 규정</span></p>
				<div class="inputNdetail_box">
					<div class="row clear">
						<ul>
							<li>1. 우선심사 선행기술조사는 45만원(부과세 포함/별도)입니다.</li>
							<li>2. 연간 계약 시, 우선심사 선행기술조사는 30만원(부과세 포함/별도)입니다.</li>
							<li>3. 연간 계약 관련 문의는 전화(042-934-2021) 또는 이메일(tidea@tidea.co.kr)을 통해 안내 받으시길 바랍니다.</li>
						</ul>
					</div>
				</div>
			</div>
			<div id="inputNdetailDivBox" class="inputNdetail">
				<p class="title"><span id="modeSpan">환불 규정</span></p>
				<div class="inputNdetail_box">
					<div class="row clear">
						<ul>
							<li>1. (주)티디아의 귀책사유로 우선심사 신청이 기각된 경우 또는 특허청으로의 조사 보고서 송부가 접수일로부터 30일 넘게 이루어지지 않은 경우 조사 서비스료를 전액 환불해 드리겠습니다.</li>
							<li>2. 미활용 발생 시, 미활용 1건당 조사 서비스료의 30%를 환불해 드리겠습니다.<br/>
							(특허청의 미활용 통보일 기준 12개월 이내에 증빙 서류를 제출하는 경우에 한하여 환불 적용)</li>
							<li>3. 미활용에 관한 환불 규정은 계약 관계 여부에 따라 차등 적용될 수 있습니다.</li>
							<li>4. 신청취소 및 조사보류 요청은 신청일로부터 2~3일 이내에만 가능합니다. (단 조사 착수 시에는 환불 불가)</li>
<!-- 							+조사 착수 후에는 환불 불가<br/> -->
<!-- 							※ 신청취소 및 조사보류 요청은 의뢰일로부터 2~3일 이내에만 가능합니다. (단, 조사착수 시에는 환불 불가)</li> -->
						</ul>
					</div>
				</div>
			</div>
			<!-- 입력 및 상세영역 END -->
		</div>
	<div>
</body>
</html>