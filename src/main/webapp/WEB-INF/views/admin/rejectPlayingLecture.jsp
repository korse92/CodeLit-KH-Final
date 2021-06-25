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
	<jsp:param value="강의거절" name="title" />
</jsp:include>

<script>
   	// jquery onload 함수
	$(() => {
		$("#rejectPlayingLecture").modal("show")
		.on('hide.bs.modal', e => {
			// modal 비활성화시 (X, 취소, 모달외 영역 클릭)
			location.href = '${pageContext.request.contextPath}/admin/manageLectureBoard.do';
		});
		//$("#rejectPlayingLecture").modal()
		//hide.bs.modal은 이벤트 이름
	});
	function sendMsg(){
		sendMessage('/app/reject/'+$('[name=id]').val());
	}
</script>

<div class="container">
	<!-- Modal시작 -->
	<!-- https://getbootstrap.com/docs/4.1/components/modal/#live-demo -->
	<form:form
		action="${pageContext.request.contextPath}/admin/rejectPlayingLecture.do"
		method="post" onsubmit="sendMsg();">
		<div class="modal fade" id="rejectPlayingLecture" tabindex="-1"=aria-labelledby="rejectPlayingLectureLabel"
			aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<!--폼 -->
					<!-- https://getbootstrap.com/docs/4.1/components/forms/#overview -->
					<div class="modal-body">
						<input type="hidden" name="no" value="${no}">
						<p class="text-center mt-5"><spring:message code="admin.stopMsg"/></p>
					</div>
					<div class="d-grid gap-2 d-md-flex m-3 justify-content-md-end">
						<button type="button" class="btn btn-outline-primary m-2"
							onclick="location.href='${pageContext.request.contextPath}/admin/manageLectureBoard.do';"><spring:message code="admin.backBtn"/></button>
						<button type="submit" class="btn btn-outline-danger m-2"><spring:message code="admin.stopBtn"/></button>
						<!-- 취소 버튼 클릭시 강의관리게시판페이지로 이동처리 or 모달창 없앨거면 data-dismiss="modal" 속성 주기  -->
					</div>
				</div>
				<input type="hidden" name="id" value="${lec.refMemberId}">
				<input type="hidden" id="msgTitle" value="등록하신 강의가 정지되었습니다.">
				<input type="hidden" id="msgContent"
					value="등록하신 ${lec.lectureName} 강의가 정지 처리되었습니다.">
			</div>
		</div>
	</form:form>
	<!-- Modal 끝-->
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>