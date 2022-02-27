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
<script src="/js/jquery-1.10.2.js"></script>
<script src="/js/common.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	html{
		background:#213152;
	}
</style>
</head>
<body class="main_page relative">
	
	
	<div class="top_right">
		<div class="topmenu_box clear">
			<a href="#" class="user"><strong><c:out value="${SS_LOGIN_INFO.USER_NM }" /></strong>님 </a>
			<c:if test="${empty SS_LOGIN_INFO }">
				<a href="/login/login.do" class="topmenu_btn transition">LOGIN</a>
			</c:if>
			<c:if test="${not empty SS_LOGIN_INFO }">
				<a onclick="javascript:fn_goLogout();" class="topmenu_btn transition">LOGOUT</a>
			</c:if>
		</div>
	</div>


	<div class="main_header boxshadow">
		<div class="main_logo">
<!-- 			<a href=""><img src="/resources/images/ras_logo.png"></a> -->
			<a href=""><img src="/resources/images/tidea_logo.png"></a>
			<p><b> 티디아<span>우선심사 시스템</span>에 오신것을 환영합니다.</b></p>
		</div>
	</div>
	<div class="main_box relative">
		<c:forEach var="ssTopMenuList" items="${SS_MAIN_MENU }" varStatus="idx">
			<a href="#" class="main_btn btn${ssTopMenuList.MENU_ID }" onclick="javascript:fn_topMenuGoUrl('${ssTopMenuList.MENU_URL }', '${ssTopMenuList.MENU_SUB_ID }', '${ssTopMenuList.MENU_ID }');"><span>${ssTopMenuList.MENU_NM}</span></a>
		</c:forEach>
	</div>
		<div class="footer login_footer">
			<p>
				<font color="white">
					상호명 : (주)티디아   |   대표 : 이상호   |   사업자등록번호 : 877-81-02483<br>
					주소 : 대전시 유성구 갑천로 361-39, 201호 | Tel: 042-934-2021   |   Fax: 042-862-7562   |   <a href="mailto:tidea@tidea.co.kr" target="_blank"><font color="white">tidea@tidea.co.kr</font></a><br>
				</font>
			</p>
			<p class="copy">
				<font color="white">copyrights 2021 TIDEA . All rights reserved. </font>
			</p>
		</div>
</body>
</html>