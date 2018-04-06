<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<h2><i class="fa fa-user-plus"></i> 회원가입</h2>
<hr>
<form:form commandName="member">
	<div class="md-form">
		<i class="fa fa-user prefix grey-text"></i>
		<label for="userId">사용자 ID</label>
		<form:input path="userId" value="${member.userId}" class="form-control"/>
		<form:errors path="userId" element="div" cssClass="error"/>
	</div>
	<div class="md-form">
		<i class="fa fa-id-badge prefix grey-text"></i>
		<label for="name">이름</label>
		<form:input path="name" value="${member.name}" class="form-control"/>
		<form:errors path="name" element="div" cssClass="error"/>
	</div>
	<div class="md-form">
		<i class="fa fa-lock prefix grey-text"></i>
		<label for="password">비밀번호</label>
		<form:password path="password" value="" class="form-control"/>
		<form:errors path="password" element="div" cssClass="error"/>
	</div>
	<div class="md-form">
		<i class="fa fa-phone prefix grey-text"></i>
		<label for="cellPhone">전화번호</label>
		<form:input path="cellPhone" value="${member.cellPhone}" class="form-control"/>
		<form:errors path="cellPhone" element="div" cssClass="error"/>
	</div>
	<div class="md-form">
		<i class="fa fa-envelope prefix grey-text"></i>
		<label for="email">email</label>
		<form:input path="email" value="${member.email}" class="form-control"/>
		<form:errors path="email" element="div" cssClass="error"/>
	</div>
	<div class="md-form">
		<i class="fa fa-address-book prefix grey-text"></i>
		<label for="address">주소</label>
		<form:input path="address" value="${member.address}" class="form-control"/>
		<form:errors path="address" element="div" cssClass="error"/>
	</div>
	<div class="md-form text-center">
	<button type="submit" class="btn btn-primary">
		<i class="fa fa-check"></i> 회원가입
	</button>
	</div>
</form:form>