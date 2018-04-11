<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="todayStr" />
<c:forEach var="image" items="${list}" varStatus="status">
	<fmt:formatDate value="${image.regDate}" pattern="yyyy-MM-dd"
		var="regDate" />
	<section class="text-center text-lg-left">
		<!--Grid row-->
		<div class="row">

			<!--Grid column-->
			<div class="col-lg-3 col-xl-3 pb-3">
				<!--Featured image-->
				<div class="view zoom">
					<a href="image/${image.imageId}" data-lightbox="roadtrip"> <img
						src="thumb/${image.imageId}" width="150" alt="${image.title}" class="margin-auto"/>
					</a>
				</div>
			</div>
			<!--Grid column-->

			<!--Grid column-->
			<div class="col-lg-9 col-xl-9">
				<!--Excerpt-->
				<!-- 등록일이 오늘이면 New표시 -->
				<c:if test="${regDate == todayStr}">
					<p class="badge badge-danger">New</p>
				</c:if>
				<h3 class="mb-4 font-weight-bold dark-grey-text">
					<strong>${image.title}</strong>
				</h3>
				<p>${image.description}</p>
				<p class="gray">${regDate}</p>
			</div>
			<!--Grid column-->

		</div>
		<!--Grid row-->

		<hr class="pb-3">
	</section>
</c:forEach>