<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Material Design Bootstrap -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.0/css/mdb.min.css" rel="stylesheet">
<!-- font awesome -->
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/solid.js" integrity="sha384-+Ga2s7YBbhOD6nie0DzrZpJes+b2K1xkpKxTFFcx59QmVPaSA8c7pycsNaFwUK6l" crossorigin="anonymous"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/fontawesome.js" integrity="sha384-7ox8Q2yzO/uWircfojVuCQOZl+ZZBg2D2J5nkpLqzH1HY0C1dHlTKIbpRz/LG23c" crossorigin="anonymous"></script>
<!--  bootstrap stylesheet -->
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<c:set value="${pageContext.request.contextPath}/" var="root" scope="request"/>
<%-- <c:url value="/" var="root" /> 이제 필요 없음--%>
<script src="<c:url value="/resources/js/common.js"/>"></script>
<link rel="stylesheet" href="${root}/resources/css/main.css" />
</head>

<body>
	<nav id="menu" class="navbar fixed-top navbar-expand-lg navbar-dark pink scrolling-navbar">
		<tiles:insertAttribute name="menu" />
	</nav>
	<header>
		<tiles:insertAttribute name="header" />
	</header>
	<div class="container">

		<div id="body">
			<tiles:insertAttribute name="body" />
		</div>
		<footer>
			<tiles:insertAttribute name="footer" />
		</footer>
</div>
</body>

</html>
<!-- material design bootstrap -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.4.5/js/mdb.min.js"></script>
