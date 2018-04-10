<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<div style="width: 70%" class="mt-4 mb-3 ml-auto mr-auto">
	<h1>이미지 업로드</h1>
	<form:form commandName="image" enctype="multipart/form-data">
		<div class="md-form">
			<label for="title">제목</label>
			<form:input path="title" required="required" />
			<form:errors path="title" />
		</div>
		<div>
			<label for="description">설명</label>
			<form:textarea path="description" rows="4" />
		</div>
		<div>
			<label>이미지 파일들</label>
		</div>
		<div>
			<input type="file" name="imageFiles" multiple="multiple"
				accept="image/*" required>
		</div>
		<div class="text-center">
			<button type="submit" class="btn btn-primary btn-md">
				<i class="fa fa-check-circle mr-2"></i> 확인
			</button>
			<a href="javascript:history.back()" class="btn btn-primary btn-md">돌아가기</a>
		</div>
	</form:form>
</div>