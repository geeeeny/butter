<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<div id="join-form" class="join-form">
	<h2 class="pb-4">
		<i class="fa fa-user-plus"></i> 정보 수정
	</h2>
	<form:form commandName="member">
		<div>
			<label for="userId">사용자 ID: ${member.userId}</label>
			<form:hidden path="userId" />
		</div>

		<div>
			<label for="name">이름: ${member.name}</label>
			<form:hidden path="name" />
		</div>

		<div class="md-form">
			<label for="password">비밀번호</label>
			<form:password path="password" />
			<form:errors path="password" cssClass="error" />
		</div>

		<div class="md-form">
			<label for="cellPhone">전화번호</label>
			<form:input path="cellPhone" />
			<form:errors path="cellPhone" />
		</div>

		<div class="md-form">
			<label for="email">email</label>
			<form:input path="email" />
			<form:errors path="email" />
		</div>

		<div class="md-form">
			<label for="address">주소</label>
			<form:input path="address" />
			<form:errors path="address" />
		</div>

		<form:errors cssClass="error" element="div" />

		<div class="md-form text-center">
			<button type="submit" class="btn btn-primary">
				<i class="fa fa-check"></i>확인
			</button>
			<a href="../view/${member.userId}?page=${param.page}" class="btn btn-primary">돌아가기</a>
		</div>
	</form:form>
</div>