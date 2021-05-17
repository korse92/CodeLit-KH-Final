<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%
	List<Map<String, Object>> categoryList = (List<Map<String, Object>>)request.getAttribute("categoryList");	
	Map<Integer, String> categoryMap = new HashMap<>();
	
	for(Map<String, Object> category : categoryList) {
		int no = Integer.parseInt(String.valueOf(category.get("no")));
		String name = (String)category.get("name");
		categoryMap.put(no, name);
	}
	
	pageContext.setAttribute("categoryMap", categoryMap);
%>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의 목록" name="title"/>
</jsp:include>

<!-- 컨텐츠 시작 -->

<!-- 개인 CSS, JS 위치 -->
<aside>
test
</aside>
<div class="container my-5">
	<div class="page-header row">
		<h2 class="col-sm-3 ps-5 me-auto">${empty catNo ? '모든 강의' : categoryMap.get(catNo)}</h2>

		<div class="col-sm-auto">
			<select class="form-select">
				<option selected>카테고리</option>
				<option value="1">프론트엔드</option>
				<option value="2">백엔드</option>
				<option value="3">빅데이터</option>
			</select>
		</div>
		<div class="col-sm-auto">
			<div class="input-group">
				<div class="form-outline">
					<input type="search" id="form1" class="form-control" placeholder="강의자 / 강의명" />
				</div>
				<button type="button" class="btn btn-primary">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</div>
		<div class="col-sm-auto">
			<select class="form-select">
				<option selected>정렬</option>
				<option value="1">인기순</option>
				<option value="2">최신순</option>
			</select>
		</div>
	</div>
	<hr />
	<div class="page-body row">
	<c:forEach items="${list}" var="lecture" varStatus="vs">
		<c:if test="${vs.count % 4 == 1}">
		<div class="row my-4 px-5">
		</c:if>
			<div class="col-3">
				<a href="${pageContext.request.contextPath}/lecture/lectureDetail?no=${lecture.lectureNo}" class="text-decoration-none text-dark">
					<div class="card mx-auto" style="width: 15rem;">
						<c:choose>
							<c:when test="${empty lecture.lectureThumbRenamed}">
							<img
								src="https://via.placeholder.com/450x300.png?text=Thumbnail+Image"
								class="card-img-top"
								alt="...">
							</c:when>
							<c:otherwise>
							<img
								src="${pageContext.request.contextPath}/resources/upload/lecture/thumbnails/${lecture.lectureThumbRenamed}"
								class="card-img-top"
								alt="...">
							</c:otherwise>
						</c:choose>
						<div class="card-body">
							<h5 class="card-title">${lecture.lectureName}</h5>
							<p class="card-text">${lecture.refMemberId}</p>
							<p class="card-text">
								별점
							</p>
							<p class="card-text">${lecture.lecturePrice != 0 ? lecture.lecturePrice : "무료"}</p>
						</div>
					</div>
				</a>
			</div>
		<c:if test="${vs.count % 4 == 0}">
		</div>
		</c:if>
	</c:forEach>
	</div>
	<div class="row">
		${pageBar}
	</div>

</div>
<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>