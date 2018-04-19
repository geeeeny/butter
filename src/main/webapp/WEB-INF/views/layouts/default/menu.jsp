<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- <c:url value="/" var="root" />--%>
	<!-- Brand -->
	<a class="navbar-brand" href="${root}">Seojin :D</a>

	<!-- Toggler/collapsibe Button -->
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>

	<!-- Navbar links -->
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link"
				href="${root}gallery/lightbox">Gallery</a></li>
			<li class="nav-item"><a class="nav-link"
				href="${root}gallery/flickr">Flickr</a></li>
			<li class="nav-item"><a class="nav-link"
				href="${root}board/list">Board</a></li>
		</ul>
		<ul class="navbar-nav ml-auto">
			<c:choose>
				<c:when test="${not empty USER}">
					<c:if test="${USER.userId=='admin'}">
						<li class="nav-item"><a class="nav-link"
							href="${root}admin/member/list"> 회원관리</a></li>
					</c:if>
					<li class="nav-item">
						<a class="nav-link" href="${root}member/profile">
							<img src="${root}member/avata?userId=${USER.userId}" class="rounded-circle avata-small"/>
							${USER.userId}
						</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="${root}logout"><i
							class="fa fa-sign-in-alt"></i> Logout</a></li>
				</c:when>
				<c:otherwise>
					<li class="nav-item"><a class="nav-link" href="${root}login"><i
							class="fa fa-sign-in-alt"></i> Login</a></li>
					<li class="nav-item"><a class="nav-link" href="${root}join"><i
							class="fa fa-user"></i> Join</a></li>
				</c:otherwise>
			</c:choose>

		</ul>
	</div>
