<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의 등록" name="title"/>
</jsp:include>
<!-- 컨텐츠 시작 -->
<!-- 개인 CSS, JS 위치 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ckeditor/ckeditor.js"></script>

<!-- full Calendar -->
<!-- <link href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.css' rel='stylesheet' /> -->
<!-- <link href='https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.13.1/css/all.css' rel='stylesheet'>-->

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/main.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/locales/ko.js"></script>

<!-- datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- timepicker -->
<!-- <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/jquery.timepicker.min.js" ></script><!-- 타이머js -->
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/jquery.timepicker.css" media=""/><!-- 타이머css -->

<!-- full Calendar script -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
     	themeSystem: 'bootstrap',//fullcalendar bootstrap테마는 bootstrap4 기반
      initialDate: new Date(),
      locale: "ko",
      editable: true,
      selectable: true,
      selectMirror: true,
      businessHours: true,
      dayMaxEvents: true, // allow "more" link when too many events
      dayHeaderContent: function (date) {
          let weekList = ["일", "월", "화", "수", "목", "금", "토"];
              return weekList[date.dow];
          },
      dateClick: function(info) {
    	  $("#eventModal").modal("show");
          var date = info.dateStr
          $("#eventModal").find("#startDate").val(date);
          $("#eventModal").find("#endDate").val(date);
          $('#close').on('click', function(){
      		$("#eventModal").modal("hide");
      		});
      },
      select : function(info) {
    	  $("#eventModal").modal("show");

    	  $("#eventModal").find("#startDate").val(info.startStr);
    	  $("#eventModal").find("#endDate").val(info.endStr);
          $('#close').on('click', function(){
			 $("#eventModal").modal("hide");
       	  });
      },
      eventClick: function(info){
  		$("#eventModal").modal("show");
  		$("#eventModal").find("#title").val(info.event.title)
  		$("#eventModal").find("#startDate").val(info.event.startStr);
  		$("#eventModal").find("#endDate").val(info.event.endStr);
        $('#close').on('click', function(){
			 $("#eventModal").modal("hide");
     	  });
		console.log(info);
      },
      //연월 표기 한국어 설정
      titleFormat : function(date) {
      	return date.date.year +"년 "+(date.date.month +1)+"월";
      }
    });

    calendar.render();

    $(calTest).click(e => {
    	var eventArr = calendar.getEvents();
    	console.log(eventArr);
    	$(eventArr).each((idx, elem) => {
    		eventArr[idx] = elem.toPlainObject();
    	});

    	console.log(eventArr);

    	$("[name=streamingDateList]").val(JSON.stringify(eventArr));
    	console.log($("[name=streamingDateList]").val());
    });


    /******** 임시 RAMDON ID - 실제 DB 연동시 삭제 **********/
    var eventId = 1 + Math.floor(Math.random() * 1000);

    $("#save-event").on('click', function(){
    	var title = $("#title").val();
   		var startDate = $("#startDate").val();
   		var endDate = $("#endDate").val();

        if (startDate > endDate) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (title === '') {
            alert('일정명은 필수입니다.');
            return false;
        }

   		calendar.addEvent({
    		title: title,
    		start: startDate,
    		end: endDate,
    		allDay: true
    	});

        $("#eventModal").modal('hide');
    });
});

//datepicker
$(function() {
	$.datepicker.setDefaults({
		dateFormat : 'yy-mm-dd',
		startDate: '7d', //달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
		endDate: '6m',	//달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
		showOtherMonths : true,
		showMonthAfterYear : true,
		changeYear : true,
		changeMonth : true,
       	yearSuffix: "년",
      	monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
      	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
       dayNamesMin: ['일','월','화','수','목','금','토'],
       dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
	});

	$("#startDate").datepicker();
	$("#endDate").datepicker();

	$("#startDate").datepicker('setDate', 'today');
	$("#endDate").datepicker('setDate', 'today');
});

//timepicker
/* $('#startTime')
    .timepicker({timeFormat:'H:i','minTime':'06:00','maxTime':'23:00','scrollDefaultNow': true }) //stime 시작 기본 설정
    .on('changeTime',function() {                           //stime 을 선택한 후 동작
        var from_time = $("input[name='startTime']").val(); //stime 값을 변수에 저장
        $('#endTime').timepicker('option','minTime', from_time);//etime의 mintime 지정
        if ($('#endTime').val() && $('#endTime').val() < from_time) {
            $('#endTime').timepicker('setTime', from_time);
//etime을 먼저 선택한 경우 그리고 etime시간이 stime시간보다 작은경우 etime시간 변경
        }
    });

$('#endTime').timepicker({timeFormat:'H:i','minTime':'06:00','maxTime':'23:00'});//etime 시간 기본 설정
 */

//timepicker
$(document).ready(function() {
    // INPUT 박스에 들어간 ID값을 적어준다.
    $("#startTime,#endTime").timepicker({
        'minTime': '09:00am', // 조회하고자 할 시작 시간 ( 09시 부터 선택 가능하다. )
        'maxTime': '22:00pm', // 조회하고자 할 종료 시간 ( 20시 까지 선택 가능하다. )
        'timeFormat': 'H:i',
        'step': 30 // 30분 단위로 지정. ( 10을 넣으면 10분 단위 )
	});

	$(window).scroll(function(){
	    $(".ui-timepicker-wrapper").hide();
	});
});

</script>


<style>
.form-group .row {
	margin-top: 1rem;
	margin-bottom: 1rem;
}

.form-group .form-label {
	margin-bottom: 0px;
}

img#thumbImage {
	width: 450px;
	height: 300px;
}

/* full Calendar */
#calendar {
  max-width: 1100px;
  margin: 0 auto;
}

.inputModal {
  width: 65%;
  margin-bottom: 10px;
  justify-content: end;
}
</style>

<div class="container">
	<div class="mt-5 mx-auto form-group" style="width:fit-content;">
		<form:form
			id="lectureEnrollFrm"
			name="lectureEnrollFrm"
			action="${pageContext.request.contextPath}/lecture/lectureEnroll.do"
			method="post"
			enctype="multipart/form-data">
			<div class="row justify-content-center">
				<!-- col-auto : 내부요소 크기에 맞게 컬럼 크기 맞춤 -->
				<div class="col-auto">
					<h2>강의 등록</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="lectureName">강의 제목</label>
				</div>
				<div class="col-sm-4">
					<select class="form-select" name="refLecCatNo" required>
						<option value="" disabled selected>카테고리 선택</option>
						<c:forEach items="${categoryList}" var="category">
						<option value="${category.no}">${category.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-6">
					<input class="form-control" type="text" name="lectureName"
						id="lectureName" placeholder="강의 제목" required>
				</div>
			</div>
			<div class="row justify-content-between">
				<div class="col-sm-2 align-self-center">
					<label class="form-label">강의 종류</label>
				</div>
				<div class="col-sm-auto">
					<input class="form-check-input" type="radio" name="lectureType"	id="lectureType1" value="V" required>
					<label class="form-check-label me-3" for="lectureType1">일반 강의</label>
					<input class="form-check-input" type="radio" name="lectureType"	id="lectureType2" value="S">
					<label class="form-check-label"	for="lectureType2">스트리밍 강의</label>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="lecturePrice">수강료</label>
				</div>
				<div class="col-sm">
					<input class="form-control" type="number" name="lecturePrice" min="0"
						id="lecturePrice" placeholder="무료 강의일 경우 0을 입력해주세요.(기본값 0)">
				</div>
			</div>
			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="lectureHandout">첨부파일</label>
				</div>
				<div class="col-sm-10">
					<input class="form-control" type="file" name="lectureHandout"
						id="lectureHandout">
				</div>
			</div>
			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="lectureThumbnail">썸네일</label>
				</div>
				<div class="col-sm-10">
					<img
						src="https://via.placeholder.com/450x300.png?text=Thumbnail+Image"
						class="img-thumbnail w-100" id="thumbImage" alt="썸네일 이미지">
					<input
						class="form-control d-none" type="file" name="lectureThumbnail"
						id="lectureThumbnail">
				</div>
			</div>
			<div class="row">
				<label class="form-label mb-2" for="">강의 소개글</label>
				<div class="col-sm">
					<textarea name="lectureIntro" id="lectureIntro" class="form-control" required></textarea>
				</div>
			</div>
			<div class="selectedVideo row">
				<label class="form-label mb-2" for="lectureGuideline">가이드라인 (권장하는 하루에 들을 영상개수)</label>
				<div class="col-sm">
					<input class="form-control" type="number" name="lectureGuideline" min="1" max="10"
						id="lectureGuideline" placeholder="입력안할 시 기본값 1, 최대 10">
				</div>
			</div>

			<div class="selectedVideo row">
				<label class="form-label mb-2" for="">커리큘럼 등록 (스트리밍 강의일 경우 영상첨부 안하셔도 됩니다.)</label>
				<!-- <div class="row my-0 justify-content-end">
					<div class="col-auto">
						<button type="button" class="btn p-0" id="partAddBtn"><i class="fas fa-plus-square text-primary fs-3"></i></button>
						<button type="button" class="btn p-0" id="partDelBtn"><i class="fas fa-minus-square text-warning fs-3"></i></button>
					</div>
				</div> -->
				<div class="col-sm">
					<div class="d-flex flex-column align-items-start" id="inputCurriculum">
						<!--
						<div class="part-group w-100">
							<div class="input-group">
								<button type="button" class="btn p-0 me-2 partDelBtn"
										data-bs-toggle="tooltip" data-bs-placement="left" title="파트 삭제">
									<i class="fas fa-minus-square text-warning fs-3"></i>
								</button>
								<input type="text" class="partInput form-control my-1" placeholder="파트 제목 입력">
							</div>
							<div class="chapter-group ps-5">
								<div class="input-group">
									<button type="button" class="btn p-0 me-2 chapDelBtn"
											data-bs-toggle="tooltip" data-bs-placement="left" title="챕터 삭제">
										<i class="fas fa-minus-square text-warning fs-3"></i>
									</button>
									<input type="text" class="chapterInput form-control my-1" placeholder="챕터 제목 입력">
								</div>
								<input type="file" class="form-control form-control-sm" name="chapterVideo" accept="video/*">
							</div>
							<button type="button" class="btn chapAddBtn ms-5 mt-1 p-0"
									data-bs-toggle="tooltip" data-bs-placement="left" title="챕터 추가">
								<i class="fas fa-plus-square text-primary fs-3"></i>
							</button>
						</div>
						-->
						<button type="button" class="btn p-0 mt-1 partAddBtn"
								data-bs-toggle="tooltip" data-bs-placement="left" title="파트 추가">
							<i class="fas fa-plus-square text-primary fs-3"></i>
						</button>
					</div>
					<input type="button" value="테스트" id="curtest"/>
				</div>
				<input type="hidden" name="curriculum" />
				<input type="hidden" name="videoChapNoArr" />
			</div>

			<div id="selectedStreaming" class="row">
				<label class="form-label mb-2" for="">강의일정</label>
				<div class="col-sm">
					<input type="hidden" name="streamingDateList" />
	 				<div id='calendar'></div>
	 				<input type="button" value="테스트" id="calTest" />
				</div>
			</div>

			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="startTime">시작 시간</label>
				</div>
				<div class="col-sm">
					<input class="timepicker form-control" type="text" name="startTime" id="startTime" value="" maxlength="10" />
				</div>
			</div>

			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="endTime">종료 시간</label>
				</div>
				<div class="col-sm">
					<input class="timepicker form-control" type="text" name="endTime" id="endTime" value="" maxlength="10"/>
				</div>
			</div>



			<div class="row form-group justify-content-end">
				<div class="col-sm-auto">
					<input class="btn btn-warning btn" type="reset" value="리셋">
					<input class="btn btn-primary" type="submit" value="등록 요청">
				</div>
			</div>
		</form:form>
	</div>

	<!-- 스트리밍 강의 등록 모달 -->
	<div class="modal fade" tabindex="-1" id="eventModal" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">

            	<!-- modal-header -->
                <div class="modal-header">
                    <h4 class="modal-title"></h4>
                </div>

				<!-- modal-body -->
                <div class="modal-body">
	                <div class="row mb-3">
					    <label for="title" class="col-sm-2 col-form-label">일정명</label>
					    <div class="col-sm-10">
					      <input type="text" class="form-control" id="title" required="required" />
					    </div>
				  	</div>

	                <div class="row mb-3">
					    <label for="start" class="col-sm-2 col-form-label">시작</label>
					    <div class="col-sm-10 form-group">
				        	<input type="text" class="datepicker form-control" id="startDate" name="startDate"/>
					    </div>
				  	</div>

	                <div class="row mb-3">
					    <label for="end" class="col-sm-2 col-form-label">끝</label>
					    <div class="col-sm-10 form-group">
				        	<input type="text" class="datepicker form-control" id="endDate" name="endDate"/>
					    </div>
				  	</div>
                </div>

				<!-- modal-footer -->
                <div class="modal-footer modalBtnContainer-addEvent">
                    <button type="button" class="btn btn-default" id="close">취소</button>
                    <button type="button" class="btn btn-primary" id="save-event">저장</button>
                </div>
                <!--
                <div class="modal-footer modalBtnContainer-modifyEvent">
                    <button type="button" class="btn btn-default" id="close">닫기</button>
                    <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
                    <button type="button" class="btn btn-primary" id="updateEvent">저장</button>
                </div>
 				-->
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div> <!-- container -->

<!-- 강의 등록관련 js -->
<script src="${pageContext.request.contextPath}/resources/js/lectureEnroll.js"></script>

<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>