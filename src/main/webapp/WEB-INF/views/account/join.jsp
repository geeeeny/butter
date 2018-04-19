<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script>
$(function(){
	$('#check-btn').click(function(e) {
		e.preventDefault();
		// 중복체크
		var userId = $('#userId').val();
		if(userId == '') {
			alert('사용자 ID를 입력하세요');
			return;
		}
		
		$.get('idcheck' , {userId : userId} ,function(data) {
			console.log(data)
			if(!data) {	// 사용자 ID 중복 아님
				$(':submit').prop('disabled', false);
				$('#check-message').removeClass('error')
					.html('사용 가능한 ID 입니다.')
			
			} else {	// 사용자 ID 중복
				$(':submit').prop('disabled', true);
				$('#check-message').addClass('error')
					.html('이미 사용 중인 ID 입니다.')				
			}
		});
	});
	
	$('#join-form').submit(function(e) {
		// 비밀번호 일치 검사
		var password1 = $(':password').eq(0).val();
		var password2 = $(':password').eq(1).val();

		if(password1 != password2) {
			alert('비밀번호가 일치하지 않습니다.')
			$(':password').eq(0).focus();
			e.preventDefault();	
		}
	});
	
});
</script>
<h2><i class="fa fa-user-plus"></i> 회원가입</h2>
<hr>
<form:form commandName="member" id="join-form" enctype="multipart/form-data">
	<div class="md-form">
		<i class="fa fa-user prefix grey-text"></i>
		<label for="userId">사용자 ID</label>
		<form:input path="userId" value="${member.userId}" class="form-control"/>
		<form:errors path="userId" element="div" cssClass="error"/>
	</div>
	<div class="md-form">
		<a id="check-btn" 
		class="btn-floating btn btn-primary btn-sm ">중복 체크</a>
		<span id="check-message"></span>
	</div>
	<div class="md-form">
		<i class="fa fa-id-badge prefix grey-text"></i>
		<label for="name">이름</label>
		<form:input path="name" value="${member.name}" class="form-control"/>
		<form:errors path="name" element="div" cssClass="error"/>
	</div>
	<div class="mb-3">
		<label for="avata">아바타 이미지</label>
		<input type="file" name="avata"/>
	</div>
	<div class="md-form">
		<i class="fa fa-lock prefix grey-text"></i>
		<label for="password">비밀번호</label>
		<form:password path="password" value="" class="form-control"/>
		<form:errors path="password" element="div" cssClass="error"/>
	</div>
	<div class="md-form">
		<i class="fa fa-lock prefix grey-text"></i>
		<label for="password2">비밀번호 확인</label>
		<input type="password" name="password2" id="password2" 
			class="form-control" required>
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
	<button type="submit" class="btn btn-primary" disabled>
		<i class="fa fa-check"></i> 회원가입
	</button>
	</div>
</form:form>