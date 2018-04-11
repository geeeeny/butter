<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:url value="/resources/js/FlickrApi.js" var="flickr"/>
<script src="${flickr}"></script>

<script>
$(function(){
	var api = new FlickrApi();
	//api.search('superman'); // api.recent();
	
	$('#search').click(function(){
		var keyword = $('#keyword').val();
		api.search(keyword);
	});
});
</script>

<div class="container">
	<h1>
		<i class="fa fa-images"></i> Flickr Gallery
	</h1>
	<hr>

	<!-- Search form -->
	<div class="active-cyan-3 active-cyan-4 mb-4">
		<input type="text" id="keyword" class="form-control" placeholder="Search" aria-label="Search">
		<button id="search" class="btn btn-primary"><i class="fa fa-search"></i></button>
	</div>
	
	<div class="row" id="panel">

	</div>
</div>