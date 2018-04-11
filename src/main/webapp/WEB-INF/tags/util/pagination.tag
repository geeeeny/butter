<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ attribute name="pagination" required="true" type="edu.iot.butter.model.Pagination"%>
<%@ attribute name="link" required="true" type="String"%>
<%@ attribute name="params" required="false" type="String"%>
<%-- 
<div class="text-center mt-4 mb-4">
	<c:if test="${pagination.currentBlock > 1}">
		<a href="${link}?page=1${params}">처음</a>
		<a href="${link}?page=${pagination.prevBlockPage}${params}">◀</a>
	</c:if>
	<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}"
		var="i">
		<c:if test="${i == pagination.page}"> ${i} </c:if>
		<c:if test="${i != pagination.page}">
			<a href="${link}?page=${i}${params}">${i}</a>
		</c:if>
	</c:forEach>
	<c:if test="${pagination.currentBlock < pagination.totalBlock}">
		<a href="${link}?page=${pagination.nextBlockPage}${params}">▶</a>
		<a href="${link}?page=${pagination.totalPage}${params}">마지막</a>
	</c:if>
</div>
 --%>
 
<!-- mdb style -->
<script>
$(function(){

	if(${pagination.currentBlock} > 1){ 
	    $('#first').addClass('disabled');
	    $('#firstArrow').addClass('disabled');
	}else{
		$('#first').removeClass('disabled');
		$('#firstArrow').removeClass('disabled');

	}
	
	if(${pagination.currentBlock} < ${pagination.totalBlock}){
	    $('#first').addClass('disabled');
	    $('#firstArrow').addClass('disabled');
	}else{
		$('#first').removeClass('disabled');
		$('#firstArrow').removeClass('disabled');

	}

});
</script>

<!--Pagination -->
<nav aria-label="pagination example">
    <ul class="pagination pagination-circle pg-red mb-0 justify-content-center mt-5">

        <!--First-->
        <li id="first" class="page-item">
      	  <a class="page-link" href="${link}?page=1${params}">First</a>
        </li>

        <!--Arrow left-->
        <li id="firstArrow" class="page-item">
            <a class="page-link" aria-label="Previous" href="${link}?page=${pagination.prevBlockPage}${params}">
                <span aria-hidden="true">&laquo;</span>
                <span class="sr-only">Previous</span>
            </a>
        </li>
	
		
		 <!--Numbers-->
		<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}"
			var="i">
			<c:if test="${i == pagination.page}">
				<li class="page-item active">
					<a href="${link}?page=${i}${params}" class="page-link">${i}</a>
				</li>
			 </c:if>
			<c:if test="${i != pagination.page}">
				<li class="page-item">
					<a href="${link}?page=${i}${params}" class="page-link">${i}</a>
				</li>
			</c:if>
		</c:forEach>
	
        <!--Arrow right-->
        <li id="endArrow" class="page-item">
            <a class="page-link" aria-label="Next" href="${link}?page=${pagination.nextBlockPage}${params}">
                <span aria-hidden="true">&raquo;</span>
                <span class="sr-only">Next</span>
            </a>
        </li>

        <!--Last-->
        <li id="end" class="page-item">
      	  <a class="page-link" href="${link}?page=${pagination.totalPage}${params}">Last</a>
        </li>

    </ul>
</nav>