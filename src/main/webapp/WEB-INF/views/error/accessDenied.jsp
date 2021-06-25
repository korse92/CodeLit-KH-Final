<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류</title>
</head>
<body>
	<h1><spring:message code="error.msg"/></h1>
	<a href="${empty pageContext.request.contextPath ? '/' : pageContext.request.contextPath}"><spring:message code="error.goHome"/></a>

</body>
</html>