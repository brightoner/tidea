<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet" href="/resources/css/reset.css" type="text/css" />
		<link rel="stylesheet" href="/resources/css/test.css" type="text/css" />
		<link rel="stylesheet" type="text/css" href="/resources/fontawesome/css/all.css">
		<link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=Lato:wght@300&display=swap" rel="stylesheet">
		<link rel="shortcut icon" href="/resources/images/favicon.ico">
		<link rel="icon" href="/resources/images/favicon.ico">
		<script src="/js/jquery-1.10.2.js"></script>
		<script src="/js/common.js"></script>		
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<!-- responsive -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
		
		<!-- MS Edge tel 링크 제거 -->
		<meta name="format-detection" content="telephone=no">
		
		<!-- 링크 공유 시 썸네일 설정 -->
		<meta property="og:url" content="https://www.pretidea.co.kr">
		<meta property="og:title" content="티디아 우선심사 시스템">
		<meta property="og:type" content="website">
		<meta property="og:description" content="신속하고 전문적인 우선심사조사 시스템">
		<meta property="og:image" content="http://pretidea.co.kr/resources/images/tidea_logo.png">
		
		<script type="text/javascript">
			$(document).ready(function() {
				
				var errorCode = '${param.errorCode}';
				if(errorCode == 'AUTH_ERROR'){
					alert('해당 메뉴에 대한 권한이 없습니다.\n메인화면으로 이동합니다.');
				}
			});		
			
			function fn_topMenuGoUrl(url, menuId, prstId){
				location.href = url + "?ACTIVE_TOP_MENU=" + prstId + "&ACTIVE_SUB_MENU=" + menuId;
			}
			
			function fn_goLogout(){
				var auth = '${SS_LOGIN_INFO.AUTH_CD}';
				var returnPage = '/login/goLogout.do';
				// 통합정보시스템에서 넘어온 경우 로그아웃 시 통합정보시스템으로 이동
				if(auth != 'AUTH0001'){
					returnPage += '?returnPage=http://114.70.126.46:8080';
				}
				location.href = returnPage;
			}
		</script>
		<title>티디아 우선심사 시스템</title>
		
		<style>
			.topmenu_box {
				right: 30px;
			}
		</style>
	</head>
	<body class="main_page relative" cz-shortcut-listen="true">
		<div class="gnb">
			<h1 class="logo">
				<a href="/sample/samplemain.do"><img src="/resources/images/tidea_logo.png" alt="티디아 로고 이미지"></a>
			</h1>
			<div class="top_right">
				<div class="topmenu_box clear">
					<c:if test="${empty SS_LOGIN_INFO }">
						<a href="/login/login.do">로그인</a>
						<a href="#" onclick="javascript:fn_regist();">회원가입</a>
					</c:if>
					<c:if test="${not empty SS_LOGIN_INFO }">
						<div class="user"><strong><c:out value="${SS_LOGIN_INFO.USER_NM }" /></strong>님 환영합니다.</div>
						<a href="#" onclick="javascript:fn_topMenuGoUrl('/regist/userInfo.do', 'TOP_2_1', 'TOP_2');">회원정보 수정</a>
						<a onclick="javascript:fn_goLogout();">로그아웃</a>
					</c:if>					
				</div>
			</div>
		</div>
		<div class="main_box relative">
			<h2>TIDEA</h2>
			<p>고객 여러분의 특허출원 관련 업무 정확도를 높이기 위해 티디아가 함께 하겠습니다.</p>
			<c:forEach var="ssTopMenuList" items="${SS_MAIN_MENU }" varStatus="idx">
				<a href="#" class="main_btn btn${ssTopMenuList.MENU_ID }" onclick="javascript:fn_topMenuGoUrl('${ssTopMenuList.MENU_URL }', '${ssTopMenuList.MENU_SUB_ID }', '${ssTopMenuList.MENU_ID }');"><span>${ssTopMenuList.MENU_NM}</span></a>
			</c:forEach>
		</div>
		<div class="main_box2 relative">
			<div class="grid animated animatedFadeInUp fadeInUp">
				<div class="relative">
					<i class="ri-award-fill"></i>
					<h3>특허청 선행기술조사전문기관 등록</h3>
					<p>(주)티디아는 2021년 특허청 선행기술조사전문기관으로 등록되어, 앞으로도 심사처리의 효율성을 제고하고, 심사품질을 향상시키기 위해 끊임없이 노력하겠습니다.</p>
				</div>
				<div class="relative animated animatedFadeInUp fadeInUp">
					<i class="ri-time-line"></i>
					<h3>신속한 조사 결과 납품</h3>
					<p>접수일로부터 7일 내로 우선심사조사 결과를 받아보실 수 있으며, 신속한 결과 납품으로 고객님의 소중한 시간을 절약하실 수 있습니다.</p>
				</div>
				<div class="relative animated animatedFadeInUp fadeInUp">
					<i class="ri-team-line"></i>
					<h3>숙련된 전문 조사원 구성</h3>
					<p>(주)티디아는 평균 8년 이상 경력의 조사원으로 구성되어 있어 높은 품질의 조사 서비스를 제공합니다.</p>
				</div>
			</div>
		</div>
		<div class="footer">
			<p>
				<font color="white">
					상호명 : (주)티디아&nbsp;&nbsp;|&nbsp;&nbsp;대표 : 이상호&nbsp;&nbsp;|&nbsp;&nbsp;사업자등록번호 : 877-81-02483<br>
					주소 : 대전시 유성구 갑천로 361-39, 201호&nbsp;&nbsp;|&nbsp;&nbsp;Tel: 042-934-2021&nbsp;&nbsp;|&nbsp;&nbsp;Fax: 042-862-7562&nbsp;&nbsp;|&nbsp;&nbsp;<a href="mailto:tidea@tidea.co.kr" target="_blank"><font color="white">tidea@tidea.co.kr</font></a><br>
	        	</font>
			</p>
			<p class="copy">
				<font color="white">copyrights 2022 TIDEA . All rights reserved. </font>
			</p>
		</div>
	</body>
</html>