<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
		<div class="col-md-6">
			<c:forEach var="talk" items="${talkList}">
				<div class="media my-1">
					<img src="${root}member/avata?userId=${talk.withTalk}"class="d-flex mr-3 rounded-circle avata">
					<div class="media-body talk-message">
						<div>
							<div style="overflow:hidden">
								<div class="font-weight-bold float-left">
									<a href="with?userId=${USER.userId}&withTalk=${talk.withTalk}">${talk.withTalk}</a>
									<c:if test="${talk.checked==0}">
										<span class="small text-muted">안 읽은 메시지</span>
									</c:if>
								</div>
								<div class="small float-right">
									<fmt:formatDate value="${talk.regDate}" pattern="yyyy-MM-dd hh:mm:ss"/>
								</div>
							</div>
							<div>${talk.message}</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
