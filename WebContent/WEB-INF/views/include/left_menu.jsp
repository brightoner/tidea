<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<script type="text/javascript">
	function fn_leftMenuGoUrl(url, menuId, prstId){
		location.href = url + "?ACTIVE_TOP_MENU=" + prstId + "&ACTIVE_SUB_MENU=" + menuId;
	}
</script>

<div class="left_menu_title relative">
<%-- 	<img src="/resources/images/${SS_ACTIVE_TOP_MENU }.png"> --%>
	<p class="absolute"><span id="activeTopNm">${SS_ACTIVE_TOP_MENU_NM }</span></p>
</div>
<div class="left_menu_list_wrap">

	<c:forEach var="ssLeftMenuList" items="${SS_LEFT_MENU }">
		<c:if test="${ssLeftMenuList.MENU_ID eq SS_ACTIVE_SUB_MENU }">
		<div class="left_menu_list active">
		</c:if>
		<c:if test="${ssLeftMenuList.MENU_ID ne SS_ACTIVE_SUB_MENU }">
		<div class="left_menu_list">
		</c:if>
			<a onclick="javascript:fn_leftMenuGoUrl('${ssLeftMenuList.MENU_URL }', '${ssLeftMenuList.MENU_ID }', '${ssLeftMenuList.MENU_PRTS_ID }');"><c:out value="${ssLeftMenuList.MENU_NM }" /></a>
		</div>
	</c:forEach>
</div>
</html>