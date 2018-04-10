<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="todayStr"/>
<div class="row">
	<c:forEach var="image" items="${list}" varStatus="status">
	<fmt:formatDate value="${image.regDate}" pattern="yyyy-MM-dd" var="regDate"/>
		<div class="col-md-3 col-sm-4 text-center view zoom">
			<!-- ImageServlet에 get방식으로 전달 -->
			<a href="image/${image.imageId}"
				data-lightbox="roadtrip"> 
				<img src="thumb/${image.imageId}" alt="${image.title}">
			</a>
			<div>
				<a href="download/${image.imageId}"> 
					<i class="fa fa-download"></i>
				</a>
				 ${image.title}
				<p class="gray">${image.description}</p>
				<!-- 등록일이 오늘이면 New표시 -->
				<c:if test="${regDate == todayStr}">
					<p class="badge badge-danger">New</p>
				</c:if>
			</div>
		</div>
	</c:forEach>
</div>
