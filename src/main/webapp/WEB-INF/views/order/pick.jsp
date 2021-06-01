<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="찜목록" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pick.css" />

<!-- Font Awesome(아이콘) CSS -->
<script src="https://kit.fontawesome.com/0e3c91e1c6.js" crossorigin="anonymous"></script>
<head>
</head>


<script>
$(() => {
	//Bootstrap Tooltip을 사용하기 위한 tooltip 초기화 코드
	var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
	var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
	  return new bootstrap.Tooltip(tooltipTriggerEl)
	});

	/* $(".hide .btn").click(e => {
		location.href="${pageContext.request.contextPath}/order/addPick.do?refLectureNo=" + ${pick.refLectureNo}
	}); */
});
</script>
<div class="container-pick">
    <h2 class="mt-5">찜 목록</h2>
    <hr/>

    <div class="orderBy mb-5">
        <div class="dropdown">
            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenu2" data-bs-toggle="dropdown" aria-expanded="false">
                정렬 기준
            </button>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
                <li><button class="dropdown-item" type="button">최신순</button></li>
                <li><button class="dropdown-item" type="button">제목순</button></li>
                <li><button class="dropdown-item" type="button">카테고리순</button></li>
                <li><button class="dropdown-item" type="button">수강료순</button></li>
            </ul>
        </div>
    </div>

    <div class="container">
		<c:forEach items="${pickList}" var="pick" varStatus="vs">
		<c:if test="${vs.count % 4 == 1}">
		<div class="row my-5">
		</c:if>
		<div class="col-3">
	        <div class="lecture">
	            <div class="show">
	                <div class="img">
	                	<c:choose>
	                	<c:when test="${empty pick.lectureThumbRenamed}">
	               			<img src="https://via.placeholder.com/450x300.png?text=Thumbnail+Image" alt="...">
	                	</c:when>
	                	<c:otherwise>
	                    	<img src="${pageContext.request.contextPath}/resources/upload/lecture/thumbnails/${pick.lectureThumbRenamed}" alt="">
	                	</c:otherwise>
	                	</c:choose>
	                </div>
	                <div class="info">
	                    <span class="title">${pick.lectureName}</span>
	                    <span class="name">${pick.teacherName}</span>
	                    <span class="price">${pick.lecturePrice}</span>
	                    <span class="avgLecAssessment">${pick.avgLecAssessment}</span>
	                	<span class="category">카테고리 : ${pick.lecCatName}</span>
	                </div>
	            </div> <!-- show -->
	            <div class="hide d-flex flex-column justify-content-between p-3 m-0">
	                <div class="link_info">
	                    <a href="${pageContext.request.contextPath}/lecture/lectureDetail?no=${pick.refLectureNo}" class="moreInfo">
	                        <span class="info">${pick.lectureIntro}</span>
	                    </a>
	                </div>
	                <div class="addLecture d-flex justify-content-end">
	                	<div class="m-0">
	                	<c:forEach items="${list}"></c:forEach>
	                		<form:form action="${pageContext.request.contextPath}/order/addBasket.do" method="POST">
	                		<input name="lectureNo" type="hidden" value="${pick.refLectureNo}" type="hidden" />
	                        <button type="submit" class="btn btn-outline-light" data-bs-toggle="tooltip" data-bs-placement="right" title="장바구니에 담기">
	                            <i class="fas fa-shopping-basket"></i>
	                        </button>
	                        </form:form>
	                	</div>
	                	<div class="m-0">
	                		<form:form action="${pageContext.request.contextPath}/order/deletePick.do" method="POST">
	                		<input name="lectureNo" type="hidden" value="${pick.refLectureNo}" type="hidden"	/>
	                        <button type="submit" class="btn btn-outline-light" data-bs-toggle="tooltip" data-bs-placement="right" title="찜삭제">
	                            <i class="far fa-trash-alt"></i>
	                        </button>
	                        </form:form>
	                	</div>
	                </div>
	            </div> <!--hide -->
	        </div> <!-- lecture -->
		</div>
        <c:if test="${vs.count % 4 == 0}">
		</div>
		</c:if>
		</c:forEach>
    </div> <!-- pick -->
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>