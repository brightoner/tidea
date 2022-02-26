<%@page import="kr.co.amail.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>티디아 우선심사 시스템</title>
</head>
<body>
<script src="/js/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		if(location.href.indexOf('mng') > -1){
			location.href = "/branch/branch.do";	
		}else{
	 		//lcation.href = "/login/goLogin.do?USER_ID=999999999";			
	 		//location.href = "/login/goLogin.do?USER_ID=999999999&USER_PWD=1111";			
	 		//location.href = "/login/goLogin.do?USER_ID=200503002&USER_PWD=1111"; // 학생		
	 		//location.href = "/login/goLogin.do?USER_ID=315017&USER_PWD=1111"; // 관리자		
	 		location.href = "/login/login.do";
		}
	});
</script>
</body>
</html>