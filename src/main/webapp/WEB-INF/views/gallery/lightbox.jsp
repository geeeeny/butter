<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:url value="/" var="root"/>
<link href="${root}resources/bower_components/lightbox2/dist/css/lightbox.css" rel="stylesheet"/>
<script src="${root}resources/bower_components/lightbox2/dist/js/lightbox.js"></script>

<div class="container">
	<h1>
		<i class="fa fa-images"></i> Gallery
	</h1>
	<a href="carousel?page=${param.page}" class="btn btn-primary btn-sm">carousel</a>
	<a href="upload" class="btn btn-primary btn-sm"><i class="fa fa-upload"></i> 이미지 등록</a>
	<hr>
	<div class="text-right mb-2">
		<a href = "lightbox?page=${param.page}&mode=tile">
			<i class = "fa fa-th"></i> 타일형
		</a>
		&nbsp;
   		<a href = "lightbox?page=${param.page}&mode=list">
   			<i class = "fa fa-list"></i> 목록형
   		</a>
	</div>
	
	<!--디폴트가 tile이므로 tile은 파라미터 안넘어올 수 있기 때문에 list로 검사  -->
	<c:if test="${param.mode!='list'}">
		<jsp:include page="lightbox_tile.jsp"/>
	</c:if>
	<c:if test="${param.mode=='list'}">
		<jsp:include page="lightbox_list.jsp"/>
	</c:if>
	
	<!-- page block -->
	<%@ taglib tagdir="/WEB-INF/tags/util" prefix="iot" %>
	<iot:pagination pagination="${pagination}" link="" params="&mode=${param.mode}"></iot:pagination>
</div>

