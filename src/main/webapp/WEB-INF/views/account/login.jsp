<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>로그인</h2>
	<form:form commandName="login">
		사용자 ID: 
		<form:input path="userId" placeholder="Enter userId" value="${login.userId}"/>
		<form:errors path="userId" cssClass="error"/>
		<br>
		비밀번호: 
		<form:password path="password" placeholder="Enter password"/>
		<form:errors path="password" cssClass="error"/>
		<br>
		<input type="submit">
	</form:form>	
</body>
</html>