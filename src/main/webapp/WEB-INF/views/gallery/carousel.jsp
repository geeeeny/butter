<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="container">
	<h1>
		<i class="fa fa-images"></i> Gallery
	</h1>
	<a href="lightbox?page=${param.page}" class="btn btn-primary btn-sm">lightbox</a>
	<hr>

	<div id="demo" class="carousel slide" data-ride="carousel">
		<!-- Indicators -->
		<ul class="carousel-indicators">
			<c:forEach items="${list}" varStatus="status">
				<li data-target="#demo" data-slide-to="${image.imageId}"
					<c:if test="${status.first}">class="active"</c:if>></li>
			</c:forEach>
		</ul>

		<!-- The slideshow -->
		<div class="carousel-inner">
			<c:forEach var="image" items="${list}" varStatus="status">
				<div
					class="carousel-item 
							<c:if test="${status.first}">active</c:if>">
					<img src="image/${image.imageId}"
						alt="${image.title}">
				</div>
			</c:forEach>
		</div>

		<!-- Left and right controls -->
		<a class="carousel-control-prev" href="#demo" data-slide="prev"> <span
			class="carousel-control-prev-icon"></span>
		</a> <a class="carousel-control-next" href="#demo" data-slide="next">
			<span class="carousel-control-next-icon"></span>
		</a>
	</div>
</div>