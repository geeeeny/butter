<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:url value="/" var="root" />

<h2><i class="fa fa-user"></i> 회원 정보</h2>
<hr>
<div class="row">
	<div class="col-md-2">사용자 ID</div>
	<div class="col-md-10">${member.userId}</div>
</div>

<div class="row">
	<div class="col-md-2">이름</div>
	<div class="col-md-10">${member.name}</div>
</div>

<div class="row">
	<div class="col-md-2">전화번호</div>
	<div class="col-md-10">${member.cellPhone}</div>
</div>

<div class="row">
	<div class="col-md-2">email</div>
	<div class="col-md-10">${member.email}</div>
</div>

<div class="row">
	<div class="col-md-2">주소</div>
	<div class="col-md-10">${member.address}</div>
</div>

<div class="row">
	<div class="col-md-2">가입일</div>
	<div class="col-md-10">
		<fmt:formatDate value="${member.regDate}" pattern="yyyy-MM-dd"/>
	</div>
</div>

<div class="row">
	<div class="col-md-2">수정일</div>
	<div class="col-md-10">
		<fmt:formatDate value="${member.updateDate}" pattern="yyyy-MM-dd"/>
	</div>
</div>
<div class="row">
	<a href="${root}member/changepassword" class="btn btn-primary"><i class="fa fa-lock"></i> 비밀번호</a>
	<a href="${root}member/edit" class="btn btn-primary"><i class="fa fa-edit"></i> 정보수정</a>
</div>