<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="login-form">
		<h1 class="pb-4"><i class="fa fa-sign-in-alt"></i> 로그인</h1>
		<form method="post">
			<input type="hidden" name="url" value="${url}"> <!-- 로그인시 가고자 했던 url저장하기 위함 -->
			<div class="md-form">
				<i class="fa fa-user prefix grey-text"></i>
				<label for="userId">사용자 ID</label>
				<input type="text" name="userId" id="userId" class="form-control" required value="${member.userId}"><br>
			</div>
			<div class="md-form">
				<i class="fa fa-lock prefix grey-text"></i>
				<label for="password">비밀번호</label>
				<input type="password" name="password" id="password" class="form-control" required><br>
			</div>
			<c:if test="${not empty error}">
				<div class="error">
					${error}
				</div>
			</c:if>
			<div class="md-form text-center">
				<button type="submit" class="btn btn-primary">
					<i class="fa fa-check"></i>로그인
				</button>
			</div>
		</form>
	</div>
</body>
</html>