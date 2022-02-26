<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%-- <%@ include file="/WEB-INF/views/common/include.jsp"%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<style type="text/css">
.error_wrap{line-height:1.5; font-family:dotum, Arial, Verdana, Helvetica, sans-serif; word-wrap:break-word; word-break:break-all;}
.error_container_1{position:relative; width:620px; height:384px; margin:80px auto 0 auto; background:url(/resources/images/error_bg_1.jpg) left top no-repeat;}
.error_text_1{position:absolute; top:160px; left:340px; width:230px; font-size:12px; margin-top: 4%;}
.error_text_1 strong{color:#ca4e00;}
.error_text_2{position:absolute; top:400px; left:180px; width:400px; font-size:12px;}
.goHome{
    width: 120%;
    height: 45px;
    margin-bottom: 15px;
    text-align: center;
    font-size: 14px;
    font-weight: bold;
    color:  #225796;
    border-radius: 3px;
    box-shadow: 0 1px 1px #aaa;
}
</style>
</head>
<body>
<!-- error_wrap -->
<div class="error_wrap">
	<div class="error_container_1">


		<!-- 에러메시지 텍스트 7줄 이상 넘어가지 마세요~ -->
		<div class="error_text_1">
			<strong>죄송합니다.</strong> <br /> 페이지를 찾을 수 없습니다.<br />
			<strong>Sorry,</strong> <br />The page you requested  <br />could not be found.
		</div>
		<!-- //에러메시지 텍스트 -->
		<div class="error_text_2">
			<a href="javascript:window.history.back();" class="goHome">이전 페이지로 돌아가기</a>&nbsp;&nbsp;
	      	<a href="/sample/samplemain.do" class="goHome">메인 페이지로 이동하기</a>
		</div>
	</div>
</div>
<!-- //error_wrap -->
</body>
</html>