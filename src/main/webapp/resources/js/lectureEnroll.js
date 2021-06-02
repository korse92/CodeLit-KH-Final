$((e) => {
	/**
		강의공통 요소
	 */
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

	//ckeditor 리사이징 제한
	CKEDITOR.config.resize_enabled = false;

	//ckeditor 생성
	var editor = CKEDITOR.replace('lectureIntro', {
		height: 500
	});

	$("[name=lectureType]").click((e) =>{
		if(e.target.value === 'S'){
			$("#selectedStreaming").removeClass("d-none");
			calendar.render();//render한 상태로 display:none이면 캘린더가 제대로 render되지 않음
		}
		else
			$("#selectedStreaming").addClass("d-none");
	});

	var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
	var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
		return new bootstrap.Tooltip(tooltipTriggerEl)
	});

	$(".partAddBtn").click(e => {
		//최상위 div
		let $partGroup = $("<div></div>",{
			"class" : "part-group w-100"
		});

		//파트 .input-group div
		let $inputGroup = $("<div></div>", {
			"class" : "input-group"
		});

		let $partDelBtn = $("<button></button>", {
			"type" : "button",
			"class" : "btn p-0 me-2 partDelBtn",
			"data-bs-toggle" : "tooltip",
			"data-bs-placement" : "left",
			"title" : "파트 삭제"
		});
		$partDelBtn.append("<i class='fas fa-minus-square text-warning fs-3'></i>");
		$partDelBtn.click(partDelBtnClickListener);

		let $partInput= $("<input>", {
			"type" : "text",
			"class" : "partInput form-control my-1",
			"placeholder" : "파트 제목 입력"
		});

		$inputGroup.append($partDelBtn, $partInput);

		//챕터 추가 버튼
		let $chapAddBtn = $("<button></button>", {
			"type" : "button",
			"class" : "btn chapAddBtn ms-5 mt-1 p-0",
			"data-bs-toggle" : "tooltip",
			"data-bs-placement" : "left",
			"title" : "챕터 추가"
		});

		$chapAddBtn.append("<i class='fas fa-plus-square text-primary fs-3'></i>");
		$chapAddBtn.click(chapAddBtnClickListener);

		//div.input-group, button.chapAddBtn 추가
		$partGroup.append($inputGroup, $chapAddBtn);

		//console.log($partDiv);
		//console.log($(e.target).parent());

		//파트 추가 버튼 이전의 형제요소로 추가
		const $partAddBtn = $("#inputCurriculum > .partAddBtn");
		$partAddBtn.before($partGroup);
		tooltipInit($partAddBtn.prev());

		/** 스크롤 오프셋 관련 테스트
		let lastPartGroupOffset = $(".part-group").last().offset();

		//
		let navbarHeight = $("nav.navbar").outerHeight(true);
		let bodyHeight = $('html, body').height();

		//$('html, body')

		console.log("navbarHeight : ", navbarHeight);
		console.log("lastPartGroupOffset.top : ", lastPartGroupOffset.top);
		console.log("$bodyHeight : ", bodyHeight);

		console.log(navbarHeight + lastPartGroupOffset.top);
		console.log("$(document).scrollTop() : ", $(document).scrollTop());// 현재스크롤 위치
		*/

		let scrollTop = $(window).scrollTop();
		let partgroupHeight = $partGroup.height();

		//$('html, body').animate({scrollTop : $(window).scrollTop() + $(".part-group").last().outerHeight(true)}, 100);
		window.scrollTo({top: scrollTop + partgroupHeight, behavior: 'smooth'});

	});

	//$(".chapAddBtn").click(chapAddBtnClickListener);
	//$(".partDelBtn").click(partDelBtnClickListener);
	//$(".chapDelBtn").click(chapDelBtnClickListener);

	/**
		캘린더 관련 요소
	 */

	//full Calendar script
	var calendarEl = document.getElementById('calendar');

	var calendar = new FullCalendar.Calendar(calendarEl, {
		//themeSystem: 'bootstrap', //fullcalendar bootstrap테마는 bootstrap4 기반
		initialDate: new Date(),
		locale: "ko",
		editable: true,
		selectable: true,
		selectMirror: true,
		businessHours: true,
		dayMaxEvents: true, // allow "more" link when too many events
		dateClick: function(info) {
			$(".modalBtnContainer-addEvent").removeClass("d-none");
			$(".modalBtnContainer-modifyEvent").addClass("d-none");

			$("#eventModal").modal("show");
			var date = info.dateStr
			$("#eventModal").find("#startDate").val(date);
			$("#eventModal").find("#endDate").val(date);
		},
		select : function(info) {
			$(".modalBtnContainer-addEvent").removeClass("d-none");
			$(".modalBtnContainer-modifyEvent").addClass("d-none");

			$("#eventModal").modal("show");
			$("#eventModal").find("#startDate").val(info.startStr);
			$("#eventModal").find("#endDate").val(info.endStr);
		},
		eventClick: function(info){
			$(".modalBtnContainer-modifyEvent").removeClass("d-none");
			$(".modalBtnContainer-addEvent").addClass("d-none");

			$("#eventModal").modal("show");
			$("#eventModal").find("#title").val(info.event.title)
			$("#eventModal").find("#startDate").val(info.event.startStr);
			$("#eventModal").find("#endDate").val(info.event.endStr);

			console.log(info);

			$("#updateEvent").click(() => {
				updateEvent(info.event);
			});

			$("#deleteEvent").click(() => {
				removeEvent(info.event);
			});
		},
		//연월 표기 한국어 설정
		titleFormat : function(date) {
			return date.date.year +"년 "+(date.date.month +1)+"월";
		}
	});

	$("#saveEvent").on('click', function(){
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

	function updateEvent(calendarEvent) {
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

		calendarEvent.setProp("title", title);
		calendarEvent.setStart(startDate);
		calendarEvent.setEnd(endDate);
		$("#eventModal").modal('hide');
	}

	function removeEvent(calendarEvent) {
		calendarEvent.remove();
		$("#eventModal").modal('hide');
	}

	$('#eventModal').on('hidden.bs.modal', function(){
		$("#title").val('');
		$("#startDate").val('');
		$("#endDate").val('');
	});

	//datepicker
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

	//timepicker
	/*
	$('#startTime')
		.timepicker({timeFormat:'H:i','minTime':'06:00','maxTime':'23:00','scrollDefaultNow': true }) //stime 시작 기본 설정
		.on('changeTime',function() {	//stime 을 선택한 후 동작
			var from_time = $("input[name='startTime']").val(); //stime 값을 변수에 저장
			$('#endTime').timepicker('option','minTime', from_time);//etime의 mintime 지정

			if($('#endTime').val() && $('#endTime').val() < from_time) {
				$('#endTime').timepicker('setTime', from_time);
				//etime을 먼저 선택한 경우 그리고 etime시간이 stime시간보다 작은경우 etime시간 변경
			}
		});

	$('#endTime').timepicker({timeFormat:'H:i','minTime':'06:00','maxTime':'23:00'});//etime 시간 기본 설정
	*/

	//timepicker
	// INPUT 박스에 들어간 ID값을 적어준다.
	$("#streamingStartTime, #streamingEndTime").timepicker({
		'minTime': '09:00am', // 조회하고자 할 시작 시간 ( 09시 부터 선택 가능하다. )
		'maxTime': '22:00pm', // 조회하고자 할 종료 시간 ( 20시 까지 선택 가능하다. )
		'timeFormat': 'H:i',
		'step': 30 // 30분 단위로 지정. ( 10을 넣으면 10분 단위 )
	});

	$(window).scroll(function(){
		$(".ui-timepicker-wrapper").hide();
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
		//소개글을 작성하지 않은 경우 폼제출할 수 없음.
		//아무글자 또는 개행문자가 1개이상
		if(/^(.|\n){1,}$/.test(editor.getData()) == false){
			alert("강의 소개글을 작성해주세요.");
			editor.focus();
			return false;
		}

		var curriculum = createCurriculum();
		if(!curriculum) {
			alert("강의 커리큘럼을 등록해주세요.");
			return false;
		}

		$("[name=curriculum]").val(curriculum);

		if($("[name=lectureType]:checked").val() === 'S') {
			var eventArr = calendar.getEvents();

			if(eventArr.length > 0) {
				$(eventArr).each((idx, elem) => {
					eventArr[idx] = elem.toPlainObject();
				});

				console.log(eventArr);

				$("[name=streamingDates]").val(JSON.stringify(eventArr));
				console.log($("[name=streamingDates]").val());
			} else {
				alert("스트리밍 일정을 등록해주세요.");
				return false;
			}

			var $streamingStartTime = $(streamingStartTime);
			var $streamingEndTime = $(streamingEndTime);

			if((/^(.){1,}$/.test($streamingStartTime.val()) == false)
				|| (/^(.){1,}$/.test($streamingEndTime.val()) == false)) {
				alert("스트리밍 강의 시작시간, 종료시간을 작성해주세요.");
				return false;
			}
		}

		//e.preventDefault();//테스트용
	});

	$(curtest).click(e => {
		createCurriculum();
		console.log(editor.getData());
		console.log(/^(.|\n){1,}$/.test(editor.getData()));
	});


	//calender Test 리스너
	$(calTest).click(e => {
		var eventArr = calendar.getEvents();
		$(eventArr).each((idx, elem) => {
			eventArr[idx] = elem.toPlainObject();
		});

		console.log(eventArr);
		console.log(eventArr.length);

		$("[name=streamingDates]").val(JSON.stringify(eventArr));
		console.log($("[name=streamingDates]").val());

		var startTime = $("#streamingStartTime").val();
		var endTime = $("#streamingEndTime").val();

		console.log(startTime);

		console.log(endTime);
	});




});
function LecturePart(lecturePartNo, lecturePartTitle) {
	this.lecturePartNo = lecturePartNo;
	this.lecturePartTitle = lecturePartTitle;
	this.chapterArr = new Array();
}

function LectureChapter(lecChapterNo, lecChapterTitle, lecChapterVideo) {
	this.lecChapterNo = lecChapterNo;
	this.lecChapterTitle = lecChapterTitle;
	this.lecChapterVideo = lecChapterVideo;
}

//챕터 추가버튼 리스너
function chapAddBtnClickListener(e) {
	//최상위 .chapter-group div
	let $chapterGroup = $("<div></div>", {
		"class" : "chapter-group ps-5"
	});

	//챕터 .input-group div
	let $inputGroup = $("<div></div>", {
		"class" : "input-group"
	});

	let $chapDelBtn = $("<button></button>", {
		"type" : "button",
		"class" : "btn p-0 me-2 chapDelBtn",
		"data-bs-toggle" : "tooltip",
		"data-bs-placement" : "left",
		"title" : "챕터 삭제"
	});

	$chapDelBtn.append("<i class='fas fa-minus-square text-warning fs-3'></i>");
	$chapDelBtn.click(chapDelBtnClickListener);

	let $chapterInput = $("<input>", {
		"type" : "text",
		"class" : "chapterInput form-control my-1",
		"placeholder" : "챕터 제목 입력"
	});

	$inputGroup.append($chapDelBtn, $chapterInput);

	//챕터 input:file
	let $chapterInputFile = $("<input>", {
		"type" : "file",
		"class" : "form-control form-control-sm col-sm-12",
		"name" : "chapterVideo",
		"accept" : "video/*"
	});

	//.chapter-group div에 자식요소 추가
	$chapterGroup.append($inputGroup, $chapterInputFile);

	//챕터 추가버튼 이전의 형제요소로 추가
	const $chapAddBtn = $(e.target).parents(".part-group").find(".chapAddBtn");
	$chapAddBtn.before($chapterGroup);
	tooltipInit($chapAddBtn.prev());

	let scrollTop = $(window).scrollTop();
	let chapterGroupHeight = $chapterGroup.height();

	//$('html, body').animate({scrollTop : $(window).scrollTop() + $(".part-group").last().outerHeight(true)}, 100);
	window.scrollTo({top: scrollTop + chapterGroupHeight, behavior: 'smooth'});
}

//파트 제거버튼 리스너
function partDelBtnClickListener(e) {
	let $deletedElem = $(e.target).parents(".part-group");
	let deletedElemHeight = $deletedElem.height();

	$deletedElem.remove()
	$(".tooltip").remove();

	let scrollTop = $(window).scrollTop();
	window.scrollTo({top: scrollTop - deletedElemHeight, behavior: 'smooth'});
}

//챕터 제거버튼 리스너
function chapDelBtnClickListener(e) {
	let $deletedElem = $(e.target).parents(".chapter-group");
	let deletedElemHeight = $deletedElem.height();

	$deletedElem.remove();
	$(".tooltip").remove();

	let scrollTop = $(window).scrollTop();
	window.scrollTo({top: scrollTop - deletedElemHeight, behavior: 'smooth'});
}

function tooltipInit(elem) {
	//Bootstrap Tooltip을 사용하기 위한 tooltip 초기화 코드
	var tooltipTriggerList = [].slice.call($(elem).find('[data-bs-toggle="tooltip"]'))
	var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
		return new bootstrap.Tooltip(tooltipTriggerEl)
	});
}

//커리큘럼 json 생성 함수
function createCurriculum(){
	const curArr = new Array();
	const $partGroup = $("#inputCurriculum").find(".part-group");
	//console.log($partGroup);

	//var formData = new FormData($('#lectureEnrollFrm')[0]);
	var videoChapNoArr = new Array();

	var videoIdx = 0;

	$partGroup.each((pIdx, elem) => {
		let $partInput = $(elem).find(".partInput");

		if(!$partInput.val())
			return true;

		const lecturePart = new LecturePart(pIdx, $partInput.val());

		let $chapterInputs = $(elem).find(".chapterInput");
		//console.log($chapterInputs);

		$chapterInputs.each((cIdx, elem) => {
			if(!$(elem).val()) {
				$(elem).parent().next().val("");
				videoIdx++;
				return true;// jQuery의 each에서 true리턴 : continue, false리턴 : break;
			}

			let lectureChapter = new LectureChapter(cIdx, $(elem).val(), null);
			//chapArr.push(lectureChapter);

			//첨부파일이 있을경우 form데이터 videoChapterNo에 참조할 챕터번호(임시) 삽입
			if($(elem).parent().next().val()){
				//formData.append("videoChapNo", videoIdx);
				videoChapNoArr.push(videoIdx);
			}

			videoIdx++;

			lecturePart.chapterArr.push(lectureChapter);
		});
		curArr.push(lecturePart);

	});
	//console.log(curMap);
	console.log("curArr", curArr);

	if(Array.isArray(curArr) && curArr.length === 0)
		return false;
	else {
		const jsonStr = JSON.stringify(curArr);
		console.log("jsonStr", jsonStr);

		//console.log(formData.getAll("videoChapNo"));
		console.log(videoChapNoArr);

		$("[name=videoChapNoArr]").val(JSON.stringify(videoChapNoArr));

		return jsonStr;
	}
}

