<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--form:form 태그용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의 관리 게시판" name="title" />
</jsp:include>
<script>

$(() => {
		$("#rejectPlayingLecture")
		.modal()
		.on('hide.bs.modal', e => {
			//modal 비활성화(X,취소,모달외 영역 클릭시) 이전페이지로 이동한다. //bs의 이벤트핸들링
			location.href = '${empty header.referer || fn:contains(header.referer, '/member/memberLogin.do') ? pageContext.request.contextPath : header.referer}'; 
			//referer가 없거나,로그인페이지를 경로로 들어간 경우 contextPath로 이동
		})
	});


</script>


<!-- 컨텐츠 시작 -->
<div class="container">
	<div class="mt-5">
		<h2 class=" jb-larger mt-3"><spring:message code="Amenu.manageLecture"/></h2>
		<form method="GET" id="searchFrm"
			action="${pageContext.request.contextPath}/admin/manageLectureBoard.do">
			<div class="row mt-5 ms-1">

				<div class="col-sm-2">
					<select class="form-select" id="category" name="category">
						<option selected disabled>카테고리</option>
						<c:forEach items="${categoryList}" var="category">
							<option value="${category.no}"
								${param.category eq category.no ? 'selected' : ''}>${category.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-2">
					<select class="form-select" id="searchType" name="searchType"
						required>
						<option value="" selected disabled><spring:message code="main.search"/></option>
						<option value="ref_member_id"
							${param.searchType eq 'ref_member_id' ? 'selected' : ''}>강의자</option>
						<option value="lecture_name"
							${param.searchType eq 'lecture_name' ? 'selected' : ''}>강의명</option>
					</select>
				</div>
				<div class="col-sm-4">
					<div class="input-group">
						<div class="form-outline">
						<spring:message code="main.search" var="searchPlaceholder"/>
						<input type="search" class="form-control" id="searchKeyword" name="searchKeyword" aria-label="mainSearchLabel"
							aria-describedby="button-addon2" placeHolder="${searchPlaceholder}">
							<!-- <input type="search" id="searchKeyword" name="searchKeyword"
								class="form-control" placeholder="강의자 / 강의명" /> -->
						</div>
						<button type="submit" class="btn btn-primary" id="searchBtn">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</div>

			</div>
		</form>
		<table class="table mt-3 col-sm text-center">
			<thead class="thead-light">
				<tr>
					<th scope="col"><spring:message code="admin.boardNo"/></th>
					<th scope="col"><spring:message code="admin.category"/></th>
					<th scope="col"><spring:message code="admin.id"/></th>
					<th scope="col"><spring:message code="enrollLec.lecTitle"/></th>
					<th scope="col"><spring:message code="admin.link"/></th>
					<th scope="col"><spring:message code="admin.check"/></th>
				</tr>
				<!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 하세요 -->
				<c:if test="${empty lecBoardList}">
					<tr>
						<td colspan="14" style="text-align: center;"><spring:message code="admin.noData"/></td>
					</tr>
				</c:if>
			</thead>
			<tbody>
				<c:if test="${not empty lecBoardList}">
					<c:forEach items="${lecBoardList}" var="lec" varStatus="vs">
						<tr>
							<td>${vs.count}</td>
							<td><c:forEach items="${categoryList}" var="category">
									<c:if test="${lec.lecCatNo eq category.no}">
										${category.name}
				  					</c:if>
								</c:forEach></td>
							<td>${lec.refMemberId}</td>
							<td>${lec.lectureName}</td>
							<td><a href="${pageContext.request.contextPath}/lecture/lectureDetail.do?no=${lec.lectureNo}"><spring:message code="admin.lecDetail"/></a></td>
							<td>
								<button type="button" class="btn btn-warning btn-sm"
									onclick="location.href='${pageContext.request.contextPath}/admin/rejectPlayingLecture.do?no=${lec.lectureNo}';">
									<spring:message code="admin.stopBtn"/></button>
							</td>
						</tr>
						<input type="hidden" name="memberId" value="${lec.refMemberId}" />
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		<!-- 페이지 바 -->
		<!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 -->
		<c:if test="${!empty lecBoardList}">
			<div>${pageBar}</div>
		</c:if>
	</div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
