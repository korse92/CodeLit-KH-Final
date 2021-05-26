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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/main.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/locales/ko.js"></script>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<!-- datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- timepicker -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

<!-- full Calendar script -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
    	themeSystem: 'bootstrap',
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
    	  //alert('a day has been clicked!');
          //console.log('Date: ' + info.dateStr);
      },
      //연월 표기 한국어 설정
      titleFormat : function(date) {
      	return date.date.year +"년 "+(date.date.month +1)+"월";
      }
    });

    calendar.render();

    calendar.on('dateClick', function() {
    	$("#eventModal").modal("show");
    	  //console.log('clicked on ' + info.dateStr);
    	});

    $('#close').on('click', function(){
    		$("#eventModal").modal("hide");
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
			action="${pageContext.request.contextPath}/teacher/lectureEnroll.do"
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
						class="img-thumbnail" id="thumbImage" alt="썸네일 이미지">
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
			<div id="selectedVideo" class="row">
				<div class="row">
					<label class="form-label mb-2" for="lectureGuideline">가이드라인 (권장하는 하루에 들을 영상개수)</label>
					<div class="col-sm">
						<input class="form-control" type="number" name="lectureGuideline" min="1" max="10"
							id="lectureGuideline" placeholder="입력안할 시 기본값 1, 최대 10">
					</div>
				</div>
			</div>

			<div id="selectedVido" class="row">
				<label class="form-label mb-2" for="">커리큘럼 등록</label>
				<div class="row my-0 justify-content-end">
					<div class="col-auto">
						<button type="button" class="btn p-0" id="partAddBtn"><i class="fas fa-plus-square text-primary fs-3"></i></button>
						<button type="button" class="btn p-0" id="partDelBtn"><i class="fas fa-minus-square text-warning fs-3"></i></button>
					</div>
				</div>
				<div class="row justify-content-start">
					<div class="col-sm-12" id="inputCurriculum">
						<div class="partDiv row justify-content-end my-1">
							<input type="text" class="partInput form-control my-1" placeholder="파트 제목 입력">
							<div class="col-sm-11 chapterDiv">
								<input type="text" class="chapterInput form-control my-1" placeholder="챕터 제목 입력">
								<input type="text" class="chapterInput form-control my-1" placeholder="챕터 제목 입력">
								<input type="text" class="chapterInput form-control my-1" placeholder="챕터 제목 입력">
								<input type="text" class="chapterInput form-control my-1" placeholder="챕터 제목 입력">
							</div>
						</div>
						<div class="partDiv row justify-content-end my-1">
							<input type="text" class="partInput form-control my-1" placeholder="파트 제목 입력">
							<div class="col-sm-11 chapterDiv">
								<input type="text" class="chapterInput form-control my-1" placeholder="챕터 제목 입력">
								<input type="text" class="chapterInput form-control my-1" placeholder="챕터 제목 입력">
								<input type="text" class="chapterInput form-control my-1" placeholder="챕터 제목 입력">
								<input type="text" class="chapterInput form-control my-1" placeholder="챕터 제목 입력">
							</div>
						</div>
						<div class="partDiv row justify-content-end my-1">
							<input type="text" class="partInput form-control my-1" placeholder="파트 제목 입력">
							<div class="col-sm-11 chapterDiv">
								<input type="text" class="chapterInput form-control my-1" placeholder="챕터 제목 입력">
								<input type="text" class="chapterInput form-control my-1" placeholder="챕터 제목 입력">
								<input type="text" class="chapterInput form-control my-1" placeholder="챕터 제목 입력">
								<input type="text" class="chapterInput form-control my-1" placeholder="챕터 제목 입력">
							</div>
						</div>
						<input type="button" value="테스트" id="curtest"/>
					</div>
				</div>
				<input type="hidden" name="curriculumMap" />
			</div>

			<div id="selectedStreaming" class="row">
				<label class="form-label mb-2" for="">강의일정</label>
				<div class="col-sm">
					<input type="hidden" name="streamingDateList" />
	 				<div id='calendar'></div>
				</div>
			</div>

			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="startTime">시작 시간</label>
				</div>
				<div class="col-sm">
					<input class="form-control" type="text" name="startTime" id="startTime" />
				</div>
			</div>

			<div class="row">
				<div class="col-sm-2 align-self-center">
					<label class="form-label" for="endTime">종료 시간</label>
				</div>
				<div class="col-sm">
					<input class="form-control" type="text" name="endTime" id="endTime" />
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
	<div class="modal fade" tabindex="-1" role="dialog" id="eventModal" aria-hidden="true">
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
<script>



	//part>chapter div 추가 함수
	var partInputNo = 0;

	$((e) => {
		$(partAddBtn).click(e => {
			/* let $partDiv = $("<div></div>", {
				"class" : ""
			}).; */
			$(inputCurriculum).append($("<input>", {
				"type" : "text",
				"class" : "form-control my-1",
				"placeholder" : "파트 제목 입력"
			}));
		});

		$(thumbImage).click(e => {
			$(lectureThumbnail).trigger('click');
		});

		$(lectureThumbnail).change(e => {
			const target = e.target;
			const files = target.files;

			// FileReader support
			if (FileReader && files && files.length) {
				var fr = new FileReader();
				fr.onload = function () {
						document.getElementById("thumbImage").src = fr.result;
				}
				fr.readAsDataURL(files[0]);
			}
			// Not supported
			else {
				// fallback -- perhaps submit the input to an iframe and temporarily store
				// them on the server until the user's session ends.
				document.getElementById("thumbImage").src = "https://via.placeholder.com/450x300.png?text=Thumbnail+Image";
			}
		});

		$("[name=lectureEnrollFrm").on('reset', e => {
			document.getElementById("thumbImage").src = "https://via.placeholder.com/450x300.png?text=Thumbnail+Image";
		});

		//ckeditor 생성
		CKEDITOR.replace('lectureIntro', {
			height: 500
		});

		$("[name=lectureEnrollFrm]").submit(e => {
			var $lectureGuideline = $(lectureGuideline)
			if(!$lectureGuideline.val()){
				$lectureGuideline.val(1);
			}

			var $lecturePrice = $(lecturePrice)
			if(!$lecturePrice.val()){
				$lecturePrice.val(0);
			}

			$("[name=curriculumMap]").val(createCurMap());

			//e.preventDefault();//테스트용
		});

		$(curtest).click(e => {
			createCurMap();
		});

	});

	//파트, 챕터값을 map(part, chapter[])로 만들어주기
	function createCurMap(){
		//var curMap = new Map();
		const curArr = new Array();
		const $partDiv = $("#inputCurriculum").find(".partDiv");
		//console.log($partDiv);
		$partDiv.each((pIdx, elem) => {
			let $partInput = $(elem).find(".partInput");
			//curMap에 key: Part객체 생성, value: Array객체 생성

			if(!$partInput.val())
				return true;

			let lecturePart = new LecturePart(pIdx, $partInput.val());

			const curObj =  {
					"part" : lecturePart,
					"chapterArr" : new Array()
			}
			//curMap.set(lecturePart, new Array());

			let $chapterInputs = $partInput.next().find(".chapterInput");
			//console.log($chapterInputs);
			$chapterInputs.each((cIdx, elem) => {
				if(!$(elem).val())
					return true;// jQuery의 each에서 true리턴 : continue, false리턴 : break;
				//let chapArr = curMap.get(lecturePart);

				//console.log(chapArr);
				let lectureChapter = new LectureChapter(cIdx, $(elem).val(), null);
				//chapArr.push(lectureChapter);
				curObj.chapterArr.push(lectureChapter);
			});
			curArr.push(curObj);

		});
		//console.log(curMap);
		console.log("curArr", curArr);

		const jsonStr = JSON.stringify(curArr);
		console.log("jsonStr", jsonStr);

		return jsonStr;
	}

	function LecturePart(lecturePartNo, lecturePartTitle) {
		this.lecturePartNo = lecturePartNo;
		this.lecturePartTitle = lecturePartTitle;
	}

	function LectureChapter(lecChapterNo, lecChapterTitle, lecChapterVideo) {
		this.lecChapterNo = lecChapterNo;
		this.lecChapterTitle = lecChapterTitle;
		this.lecChapterVideo = lecChapterVideo;
	}

	function replacer(key, value) {
		if(value instanceof Map) {
			return Array.from(value.entries()); // or with spread: value: [...value]
		} else {
			return value;
		}
	}

	function reviver(key, value) {
		if(typeof value === 'object' && value !== null) {
			if (value.dataType === 'Map') {
				return new Map(value.value);
			}
		}
		return value;
	}
</script>

<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>