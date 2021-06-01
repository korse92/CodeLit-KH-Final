<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--form:form 태그용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<script src="https://code.jquery.com/jquery-3.6.0.js"
	crossorigin="anonymous"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>

<!-- 알림관련 추가 설정 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.js"
	integrity="sha512-Kdp1G1My+u1wTb7ctOrJxdEhEPnrVxBjAg8PXSvzBpmVMfiT+x/8MNua6TH771Ueyr/iAOIMclPHvJYHDpAlfQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"
	integrity="sha512-tL4PIUsPy+Rks1go4kQG8M8/ItpRMvKnbBjQm4d2DQnFwgcBYRRN00QdyQnWSCwNMsoY/MfJY8nHp2CzlNdtZA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"
	integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css"
	integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="${pageContext.request.contextPath}/resources/js/alarm.js"></script>

<!-- bootstrap css -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의거절" name="title" />
</jsp:include>

<script>
      // jquery onload 함수
      $(() => {
        $("#rejectPlayingLecture")
          .modal()
          .on('hide.bs.modal', e => {
            // modal 비활성화시 (X, 취소, 모달외 영역 클릭)
            location.href = '${pageContext.request.contextPath}';
          });
      //hide.bs.modal은 이벤트 이름
      });
      function sendMsg(){
    	  sendMessage('/app/reject/'+$('[name=id]').val());
      }
    </script>

<div class="container">
	<section class="container">
		<!-- Modal시작 -->
		<!-- https://getbootstrap.com/docs/4.1/components/modal/#live-demo -->
		<form:form
			action="${pageContext.request.contextPath}/admin/rejectPlayingLecture.do"
			method="post" onsubmit="sendMsg();">
			<div class="modal fade" id="rejectPlayingLecture" tabindex="-1"
				role="dialog" aria-labelledby="rejectPlayingLectureLabel"
				aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<!--폼 -->
						<!-- https://getbootstrap.com/docs/4.1/components/forms/#overview -->
						<div class="modal-body">
							<input type="hidden" name="no" value="${no}">
							<p class="text-center mt-5">해당 강의를 정말 정지하시겠습니까?</p>
						</div>
						<div class="d-grid gap-2 d-md-flex m-3 justify-content-md-end">
							<button type="button" class="btn btn-outline-primary m-2"
								onclick="location.href='${pageContext.request.contextPath}/admin/manageLectureBoard.do';">취소</button>
							<button type="submit" class="btn btn-outline-danger m-2">정지</button>
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
	</section>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>