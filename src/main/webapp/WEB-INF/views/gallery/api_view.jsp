<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="<c:url value="/resources/js/rest.js"/>"></script>
<script src="<c:url value="/resources/js/gallery.js"/>"></script>
<c:url value="/api/gallery/" var="apiUrl"/>

<script>
var api = new Rest('${apiUrl}');
$(function(){
	api.list('', function(images){
		console.log(images);
	});
	
 	$('#gallery').gallery({
		url: '${apiUrl}'
	}); 
 	
});
</script>

<h1>Gallery</h1>
<hr>
<div id="gallery"></div>