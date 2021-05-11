<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="${pageContext.request.contextPath}/test/test.do" method="GET">
		<h3>팀원 이름 입력</h3>
		<input type="text" name="name"/>
		<input type="submit" />
	</form>

	<p>번호 : ${test.no}</p>
	<p>이름 : ${test.name}</p>
	
</body>
</html>