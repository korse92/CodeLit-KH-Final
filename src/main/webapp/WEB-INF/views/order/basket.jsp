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

<div class="container">
	<h2>장바구니</h2>
   	<hr>
	<div class="row">
		<div id="orderDiv_left me-3" class="col-7">
			<c:forEach items="${basketList}" var="basket" varStatus="vs">
			<div class="card mb-4">
				<div class="row">
					<div class="col-md-4" id="imgDiv">
						<c:choose>
		                	<c:when test="${empty basket.lectureThumbRenamed}">
		               			<img src="https://via.placeholder.com/450x300.png?text=Thumbnail+Image" alt="..." id="lectureImg">
		                	</c:when>
		                	<c:otherwise>
		                    	<img src="${pageContext.request.contextPath}/resources/upload/lecture/thumbnails/${basket.lectureThumbRenamed}" alt="" id="lectureImg">
		                	</c:otherwise>
	                	</c:choose>
					</div>
					<div class="col-md-8">
						<div class="card-body">
							<div class="row justify-content-between">
								<div class="col">
									<h5 class="card-title">${basket.lectureName}</h5>
									<h6 class="card-subtitle">${basket.teacherName}</h6>
								</div>
								<!-- <button type="button" class="btn bt text-light me-2">찜이동</button> -->
								<div class="col-auto">
<!-- 									<button type="button" class="btn bt text-light mb-2">찜이동</button> -->
		                        	<form:form id="deleteFrm" action="${pageContext.request.contextPath}/order/deleteBasket.do" method="POST">
										<button type="submit" class="btn bt text-light">삭제</button> <!-- bt text-light me-2 -->
				                		<input name="lectureNo" type="hidden" value="${basket.refLectureNo}" type="hidden"	/>
									</form:form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>

		</div>

		<div class="col-5">
			<div id="orderDiv_right" class="card py-4 px-5 justify-content-between">
				<div id="orderTableTop" class="row fs-4">
					<c:choose>
						<c:when test="${not empty basketList}">
							<p class="text-start ps-3">ID : ${refMemberId}</p>
				            <p class="text-start ps-3">강의 : ${basketList.get(0).lectureName} 외 ${basketList.size()}종</p>
						</c:when>
						<c:otherwise>
							<p class="text-center ps-5">장바구니에 담긴 강의가 없습니다.</p>
						</c:otherwise>
					</c:choose>
				</div>

<!-- 				<div id="orderTableBottom" class="row"> -->
	            	<hr>
		            <p class="text-end fs-4 me-2">${sumBasket}</p>
		            <button type="button" class="btn btn-primary text-light fs-5 my-0">결 제</button>
	            </div>
			</div>
		</div>
	</div>
  		<div id="orderDiv1" class="my-5">

		<%-- <form action="#"> --%>



		<%-- </form> --%>

	</div>

   <%--  <div id="orderDiv1" class="my-5">
	    <form action="#" class="row">
        <div id="orderDiv_left">
    		<c:forEach items="${basketList}" var="basket" varStatus="vs">
	            <div class="card mb-3 or_lec">
	                <div class="row g-0">
	                    <div class="col-md-4" id="imgDiv">
	                    	<c:choose>
			                	<c:when test="${empty basket.lectureThumbRenamed}">
			               			<img src="https://via.placeholder.com/450x300.png?text=Thumbnail+Image" alt="..." id="lectureImg">
			                	</c:when>
			                	<c:otherwise>
			                    	<img src="${pageContext.request.contextPath}/resources/upload/lecture/thumbnails/${basket.lectureThumbRenamed}" alt="" id="lectureImg">
			                	</c:otherwise>
		                	</c:choose>
	                    </div>
	                    <div class="col-md-8">
	                    	<div class="card-body">
	                        	<div class="row">
	                        		<div class="col-auto">
			                        	<h5 class="card-title row">${basket.lectureName}</h5>
			                        	<span style="width: 10rem; padding:0.5rem;">${basket.teacherName}</span>
	                        		</div>
			                       	<div class="col-auto"> <!-- d-flex align-content-center flex-wrap -->
			                        	<button type="button" class="btn bt text-light me-2">찜이동</button>
			                        	<form:form action="${pageContext.request.contextPath}/order/deleteBasket.do" method="POST">
				                		<input name="lectureNo" type="hidden" value="${basket.refLectureNo}" type="hidden"	/>
				                        <button type="submit" class="btn bt text-light me-2">
				                        삭제
				                        </button>
				                        </form:form>
			                       	</div>
	                        	</div>
	                    	</div>
	                    </div>
	                </div>
	            </div>
	    	</c:forEach>
        </div><!-- orderDiv_left -->

	        <div id="orderDiv_right" class="p-4 d-flex justify-content-center card align-self-center">
	            <div id="orderTableTop" class="row mt-3 fs-4">
		            <p class="text-start ps-3">id : ${refMemberId}</p>
		            <p class="text-start ps-3">강의 : ${basketList.get(0).lectureName} 외 ${basketList.size()}종</p>
	            </div>

	            <div id="orderTableBottom" class="row">
	            	<hr>
		            <p class="text-end fs-4 me-2">${sumBasket}</p>
		            <button type="button" class="btn btn-primary text-light fs-5 my-0">결 제</button>
	            </div>
	        </div>
	    </form>
	</div> --%> <!-- orderDiv1 -->
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>