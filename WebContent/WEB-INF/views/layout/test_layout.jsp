<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>티디아 우선심사 시스템</title>
<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="/resources/css/test.css">
<link rel="stylesheet" type="text/css" href="/resources/css/responsive.css">
<link rel="stylesheet" type="text/css" href="/resources/fontawesome/css/all.css">
<link rel="shortcut icon"    href="/resources/images/favicon.ico">
<link rel="icon"    href="/resources/images/favicon.ico">
</head>
<body>
	<style>
		.border_div {
			border: 1px solid #FFAAAA;
		}
		.side{
		float: left;
		}
		.data_view{
			float:right;
		}
	</style>
	<div class="body">
		<div class="header clear">
			<header>
				<tiles:insertAttribute name="header"  />
			</header>
			<tiles:insertAttribute name="top_menu"/>
		</div>
		<div class="main_body clear">
			<div class="left_menu">
				<tiles:insertAttribute name="left_menu" />
			</div>
			<div class="left_menu_mobile">
				<tiles:insertAttribute name="left_menu_moblie" />
			</div>
			<div class="main_contents clear">
				<tiles:insertAttribute name = "body"/>
			</div>
		</div>
		<div id="footer">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>
</html>