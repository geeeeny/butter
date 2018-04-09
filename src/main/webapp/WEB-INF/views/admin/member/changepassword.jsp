<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>
$(function(){
	$('#password').submit(function(e){
		//비밀번호 일치 검사
		var password1 = $('#newPassword').val();
		var password2 = $('#newPassword2').val();
		
		if(password1 != password2){
			alert('비밀번호가 일치하지 않습니다.');
			$('#newPassword').focus();
			e.preventDefault();
		}
	});
});
</script>

<div id="password" class="password">
	<h2 class="pb-4"><i class="fa fa-sign-in-alt"></i> 비밀번호 변경</h2>
	<form:form commandName="password">
		<form:hidden path="userId"/>
		<div class="md-form">
			<label for="oldPassword">관리자 비밀번호</label>
			<form:password path="oldPassword" class="form-control"/>
			<form:errors path="oldPassword"/>
		</div>
		
		<div class="md-form">
			<label for="newPassword">새 비밀번호</label>
			<form:password path="newPassword" class="form-control"/>
			<form:errors path="newPassword"/>
		</div>
		
		<div class="md-form">
			<label for="newPassword2">새 비밀번호 확인</label>
			<input type="password" id="newPassword2"/>
		</div>
		
		<form:errors cssClass="error" element="div"/>
		
		<div class="md-form text-center">
			<button type="submit" class="btn btn-primary">
				<i class="fa fa-check"></i>확인
			</button>
		</div>
	</form:form>
</div>