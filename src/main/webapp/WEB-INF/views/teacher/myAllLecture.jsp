<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="내 강의 리스트" name="title" />
</jsp:include>

<script>

</script>

<!-- 컨텐츠 시작 -->
<div class="container">
	<section class="container">
		<div class="page-header">

				<div class="row mt-5 mx-auto">
				<p>
				<span class="fs-2">
	            <sec:authentication property="principal.username"/>
	            </span>
	            <span class="fs-5">님</span>
	            <span class="fs-5">의&nbsp;강의목록</span>
	            </p>
				</div>
				<table class="table mx-3 my-3 col-sm text-center">
					<thead class="thead-light">
						<tr>
							<th scope="col">글 번호</th>
							<th scope="col">강의 종류</th>
							<th scope="col">카테고리</th>
							<th scope="col">강의 제목</th>
							<th scope="col">승인 여부</th>
						</tr>
						<!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 -->
						<c:if test="${empty list}">
							<tr>
								<td colspan="14" style="text-align: center;">조회된 데이터가 없습니다.</td>
							</tr>
						</c:if>
					</thead>
					<tbody>
					  <c:forEach items="${list}" var="teacher" varStatus="vs">
						<c:if test="${not empty list}">
							<tr>
								<td>${vs.count}</td>
								<c:if test="${teacher.lectureType eq 'V'}">
									<td>일반 강의</td>
								</c:if>
								<c:if test="${teacher.lectureType eq 'S'}">
									<td>스트리밍 강의</td>
								</c:if>
								<c:forEach items="${categoryList}" var="category">
								<c:if test="${category.no eq teacher.refLecCatNo}">
								<td>${category.name}</td>
								</c:if>
								</c:forEach>
								<td><a href="#">${teacher.lectureName}</a></td>
								<c:choose>
									<c:when test="${teacher.lectureAcceptYn eq 'Y'}">
										<td><button type="button" class="btn btn-outline-primary btn-sm">승인</button></td>
									</c:when>
									<c:when test="${teacher.lectureAcceptYn eq 'W'}">
										<td><button type="button" class="btn btn-outline-warning btn-sm">대기</button></td>
									</c:when>
									<c:otherwise>
									<form:form 
											   action="${pageContext.request.contextPath}/lecture/reApplyLecture.do?no=${teacher.lectureNo}"
											   method="POST">
										<input type="hidden" name="lectureNo" id="lectureNo" value="${teacher.lectureNo}" type="hidden"/>	   
										<td><button type="submit" class="btn btn-outline-danger btn-sm">거절</button></td>
									</form:form>	
									</c:otherwise>
								</c:choose>
							</tr>
						</c:if>
						</c:forEach>
						</tbody>
				</table>
				<!-- 페이지 바 -->
				<!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 -->
				<c:if test="${!empty list}">
					<div>${pageBar}</div>
				</c:if>

		</div>
	</section>
</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
