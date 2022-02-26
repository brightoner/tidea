<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="rootPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<c:set var="basePath" value="${rootPath}${path}"/>

<c:set var="cssPath" value="${basePath}/resources/css"/>
<c:set var="acoms4CssPath" value="${basePath}/resources/acoms4Css"/>
<c:set var="scriptPath" value="${basePath}/resources/js"/>
<%-- <c:set var="imagePath" value="${basePath}/contents/images"/> --%>
