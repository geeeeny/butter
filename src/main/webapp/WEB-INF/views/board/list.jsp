<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib tagdir="/WEB-INF/tags/util" prefix="iot"%>

<h2 class="mt-5 mb-4">게시글 목록</h2>


<div class="text-right">
	총 ${pagination.totalCount}건
	<c:if test="${not empty USER}"> / 
		<a href="create"><i class="fa fa-plus"></i> 추가</a>
	</c:if>
</div>

<table class="table table-hover table-sm">
	<thead class="blue-grey lighten-4">
		<tr>
			<th style="width: 60px">No</th>
			<th>제목</th>
			<th style="width: 100px">작성자</th>
			<th style="width: 90px">조회수</th>
			<th style="width: 120px">등록일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="board" items="${list}" varStatus="status">
			<tr>
				<td>${board.boardId}</td>
				<td><a href="view/${board.boardId}">${board.title}</a></td>
				<td>${board.writer}</td>
				<td>${board.readCnt}</td>
				<td><fmt:formatDate value="${board.regDate}"
						pattern="yyyy-MM-dd" /></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<iot:pagination pagination="${pagination}" link="list"/>