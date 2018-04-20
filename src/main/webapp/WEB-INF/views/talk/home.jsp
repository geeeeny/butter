<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<div class="m-4">
	<h2><i class="fa fa-comments"></i> Talk</h2>
	<hr/>
	<div class="row" >
		<div class="col-md-6">
			<c:forEach var="member" items="${memberList}">
				<div class="media my-1">
					<img src="${root}member/avata?userId=${member.userId}"class="d-flex mr-3 rounded-circle avata">
					<div class="media-body">
						<a href="with?userId=${USER.userId}&withTalk=${member.userId}">
						${member.userId}
						<c:if test="${member.newMessages>0}">
							<span class="badge badge-pill pink">
								${member.newMessages}
							</span>
						</c:if>
						</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>