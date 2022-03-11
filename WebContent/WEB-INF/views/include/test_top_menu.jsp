<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript">

	function fn_topMenuGoUrl(url, menuId, prstId){
		location.href = url + "?ACTIVE_TOP_MENU=" + prstId + "&ACTIVE_SUB_MENU=" + menuId;
	}
	
	function fn_goLogout(){
		var auth = '${SS_LOGIN_INFO.AUTH_CD}';
		//alert(auth);
		
		var returnPage = '/login/goLogout.do';
		
		// 통합정보시스템에서 넘어온 경우 로그아웃 시 통합정보시스템으로 이동
		if(auth != 'AUTH0001'){
			//returnPage += '?returnPage=http://192.168.1.15:8080';
			returnPage += '?returnPage=http://114.70.126.46:8080';
		}
		location.href = returnPage;
	}
	
	$(document).ready(function(){
		$(".drop_btn").click(function(){
			$(".drop_btn_arrow").toggleClass("on");
			$(".drop_ul").toggleClass("active");
		});
	});
</script>
<header class="clear">
	<div class="gnb">
		<h1 class="logo">
			<a href="/sample/samplemain.do"><img src="/resources/images/tidea_logo.png" alt="티디아 로고 이미지"></a>
		</h1>
		<div class="menubar">
			<div class="menu_box clear">
				<ul class="clear">
					<c:forEach var="ssTopMenuList" items="${SS_TOP_MENU }">
	<%-- 				<c:if test="${ssTopMenuList.MENU_ID eq SS_ACTIVE_TOP_MENU }"> --%>
	<!-- 					<li class="active menu_btn"> -->
	<%-- 				</c:if> --%>
	<%-- 				<c:if test="${ssTopMenuList.MENU_ID ne SSH_ACTIVE_TOP_MENU }"> --%>
	<!-- 					<li class="menu_btn"> -->
	<%-- 				</c:if> --%>
						<li class="menu_btn">
							<a href="#" class="menu_btn transition" onclick=""><c:out value="${ssTopMenuList.MENU_NM }" /></a>
							<ul class="drop_ul">
								<c:forEach var="ssSubMenuList" items="${SS_ALL_MENU }">
									<c:if test="${ssTopMenuList.MENU_ID eq ssSubMenuList.MENU_PRTS_ID }">
										<li class="transition">
											<a href="#"  class="transition" onclick="javascript:fn_topMenuGoUrl('${ssSubMenuList.MENU_URL }', '${ssSubMenuList.MENU_ID }', '${ssTopMenuList.MENU_ID }', '${ssTopMenuList.MENU_NM }');"><c:out value="${ssSubMenuList.MENU_NM }" /></a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="top_right">
			<div class="topmenu_box clear">
				<c:if test="${empty SS_LOGIN_INFO }">
					<a href="/login/login.do" class="transition">로그인</a>
					<a href="#" onclick="">회원가입</a>
				</c:if>
				<c:if test="${not empty SS_LOGIN_INFO }">
					<div class="user"><strong><c:out value="${SS_LOGIN_INFO.USER_NM }" /></strong>님 환영합니다.</div>
					<a href="#" onclick="javascript:fn_topMenuGoUrl('/regist/userInfo.do', 'TOP_2_1', 'TOP_2');">회원정보 수정</a>
					<a onclick="javascript:fn_goLogout();" class="transition">로그아웃</a>
				</c:if>
			</div>
		</div>
	</div>
</header>

