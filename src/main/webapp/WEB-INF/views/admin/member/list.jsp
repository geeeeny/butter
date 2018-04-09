<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="text-right">
	(총 ${pagination.totalCount}명/ <a href="create?page=${param.page}"><i
		class="fa fa-user-plus"></i>추가</a>)
</div>
<!-- 현재 페이지에 있는 멤버 정보 출력 -->
<table class="table table-stripped">
	<thead>
		<tr>
			<th style="width: 60">No</th>
			<th>사용자 ID</th>
			<th>이름</th>
			<th>email</th>
			<th>전화번호</th>
			<th>등록일</th>
		</tr>
	</thead>
	<tbody>
		<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="todayStr"/>
		<c:forEach var="member" items="${list}" varStatus="status">
			<fmt:formatDate value="${member.regDate}" pattern="yyyy-MM-dd" var="regDate"/>
			<tr>
				<td>${pagination.start+status.index}</td>
				<td>
					<!-- 등록일이 오늘이면 New표시 -->
					<a href="view/${member.userId}?page=${param.page}">${member.userId}</a>
					<c:if test="${regDate == todayStr}">
						<span class="badge badge-danger">New</span>
					</c:if>
				</td>
				
				<td>${member.name}</td>
				<td>${member.email}</td>
				<td>${member.cellPhone}</td>
				<td><fmt:formatDate value="${member.regDate}"
						pattern="yyyy-MM-dd" /></td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<!-- page block -->
<%@ taglib tagdir="/WEB-INF/tags/util" prefix="iot" %>
<iot:pagination pagination="${pagination}" link="list"></iot:pagination>
