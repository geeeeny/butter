<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script>
	
</script>
<h2><i class="fa fa-sign-in-alt"></i> 로그인</h2>
<hr>
<form:form commandName="login">
<input type="hidden" name="url" value="${url}"/>
<div class="md-form">
	<i class="fa fa-user prefix grey-text"></i>
	<label for="userId">사용자 ID</label>
	<form:input path="userId" class="form-control" value="${login.userId}"/>
	<form:errors path="userId" cssClass="error"/>
</div>
<div class="md-form">
	<i class="fa fa-lock prefix grey-text"></i>
	<label for="password">비밀번호</label>
	<form:password path="password" class="form-control"/>
	<form:errors path="password" cssClass="error"/>
</div>
<div class="md-form text-center">
	<button type="submit" class="btn btn-primary">
		<i class="fa fa-check"></i> 로그인
	</button>
</div>
</form:form>	