<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>

<!-- 컨텐츠 시작 -->
        <style>
            #conuselContent {
                border-top : 1px solid black;
            }
            #detailDiv {
                border-bottom : 1px solid black;
                min-height: 15rem;
            }
            
        </style>

		<script>
			window.onload = function() {
				
				const answer = document.getElementById("answerBtn");
				answer.addEventListener('click', function(e) {
					location.href="${pageContext.request.contextPath}/counsel/counselAnswer.do?counselNo=${counsel.counselNo}";
				});
				
			}
		</script>

<!-- 개인 CSS, JS 위치 -->

	<div class="col-8 mx-auto">

		<div class="row mt-5">
		 	<h2 class=" jb-larger mt-3 col-2">문의사항</h2>
		</div>
		<hr>
		<div class="col-10 mx-auto mt-5" id="detailDiv">
			<div class="row header ps-2">
		    	<h5 class="col-1 board-title fs-4">제목 : </h5>
		    	<p class="col-9 fs-4">${counsel.counselTitle}</p>
		    	<p class="col-2 fs-5"><fmt:formatDate value="${counsel.counselDate}" pattern="yy/MM/dd" /></p>
		  	</div>
		  	<div class="row mb-2 ps-2">
		  		<span class="col-1 fs-5">작성자 : </span><span class="col-11 fs-5">${counsel.refMemberId}</span>
		  	</div>
		    <div class="board-container mt-3 ps-2" id="conuselContent" style=" word-break:break-all;">
		    	<c:if test="${not empty attach}">
		    		<img src="${pageContext.request.contextPath}${attach.contentsAttachPath}/${attach.renamedFilename}" alt="">
		    	</c:if>
		
		        <p class="content mt-4 ps-3 fs-5">
		            ${counsel.counselContent}
		        </p>          
		    </div>
		
		</div>
		
		<sec:authorize access="hasRole('ADMIN')">
			<c:if test="${counsel.counselQNo eq 0 && counsel.counselLevel eq 1}" >
				<div class="col-2 mx-auto mt-5">
				    <button type="button" id="answerBtn" class="btn btn-primary col-12">답글</button>
				</div>
			</c:if>
		</sec:authorize>

	</div>


<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>