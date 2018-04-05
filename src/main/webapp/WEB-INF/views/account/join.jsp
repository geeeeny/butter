<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form:form commandName="member">
		<p>
			사용자ID:
			<form:input path="userId" value="${member.userId}"/>
			<form:errors path="userId" element="div" cssClass="error"/>
		</p>
		<p>
			이름:
			<form:input path="name" value="${member.name}"/>
			<form:errors path="name" element="div" cssClass="error"/>
		</p>
		<p>
			비밀번호:
			<form:password path="password" value=""/>
			<form:errors path="password" element="div" cssClass="error"/>
		</p>
		<p>
			전화번호:
			<form:input path="cellPhone" value="${member.cellPhone}"/>
			<form:errors path="cellPhone" element="div" cssClass="error"/>
		</p>
		<p>
			email:
			<form:input path="email" value="${member.email}"/>
			<form:errors path="email" element="div" cssClass="error"/>
		</p>
		<p>
			주소:
			<form:input path="address" value="${member.address}"/>
			<form:errors path="address" element="div" cssClass="error"/>
		</p>
		<input type="submit" value="확인">
	</form:form>
</body>
</html>