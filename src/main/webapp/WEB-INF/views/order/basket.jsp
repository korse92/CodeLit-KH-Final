<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="장바구니" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/basket.css" />

<!-- Font Awesome(아이콘) CSS -->
<script src="https://kit.fontawesome.com/0e3c91e1c6.js" crossorigin="anonymous"></script>
<head>
</head>

<section class="container-basket">
	<h2>장바구니</h2>
    	<hr>

    <div id="orderDiv1" class="my-5">
	    <form action="#" class="row">
    	<c:forEach items="${basketList}" var="basket" varStatus="vs">
	        <div id="orderDiv_left">
	            <div class="card mb-3 or_lec">
	                <div class="row g-0">
	                    <div class="col-md-4" id="imgDiv">
	                    	<c:choose>
			                	<c:when test="${empty basket.lectureThumbRenamed}">
			               			<img src="https://via.placeholder.com/450x300.png?text=Thumbnail+Image" alt="...">
			                	</c:when>
			                	<c:otherwise>
			                    	<img src="${pageContext.request.contextPath}/resources/upload/lecture/thumbnails/${basket.lectureThumbRenamed}" alt="" id="lectureImg">
			                	</c:otherwise>
			                	</c:choose>
	                    </div>
	                    <div class="col-md-8 d-flex">
	                    	<div class="card-body">
	                        	<h5 class="card-title row">${basket.lectureName}</h5>
	                        	<div class="row">
		                        	<span style="width: 10rem; padding:0.5rem;">${basket.teacherName}</span>
	                        	</div>
	                    	</div>
	                       	<div class="d-flex align-content-center flex-wrap">
	                        	<button type="button" class="btn bt text-light col-13 me-2">찜이동</button>
	                        	<form:form action="${pageContext.request.contextPath}/order/deleteBasket.do" method="POST">
		                		<input name="lectureNo" type="hidden" value="${basket.refLectureNo}" type="hidden"	/>
		                        <button type="submit" class="btn bt text-light col-13 me-2">
		                        삭제
		                        </button>
		                        </form:form>
	                       	</div>
	                    </div>
	                </div>
	            </div>
	        </div><!-- orderDiv_left -->

	        <div id="orderDiv_right" class="p-4 justify-content-center card align-self-center">
	            <div id="orderTableTop" class="row mt-3 fs-4">
		            <p class="text-start ps-3">id : ${basket.refMemberId}</p>
		            <p class="text-start ps-3">강의 : UI/UX 분석인데 말이 길어질 수도말이 외 2종</p>
	            </div>

	            <div id="orderTableBottom" class="row">
	            	<hr>
		            <p class="text-end fs-4 me-2">${basket.lecturePrice}</p>
		            <button type="button" class="btn btn-primary text-light fs-5 my-0">결 제</button>
	            </div>
	        </div>
	    </c:forEach>
	    </form>
	</div> <!-- orderDiv1 -->
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>