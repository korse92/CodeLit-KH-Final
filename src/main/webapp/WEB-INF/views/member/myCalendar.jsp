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
	<jsp:param value="캘린더" name="title"/>
</jsp:include>

<!-- 컨텐츠 시작 -->
<!-- 개인 CSS, JS 위치 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fullcalendar-custom.css"/>

<!-- full Calendar -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/main.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/locales/ko.js"></script>
<!-- 풀캘린더 부트스트랩 테마 -->
<!-- <link href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.css' rel='stylesheet' /> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
<script src="https://unpkg.com/tippy.js@6.3.1/dist/tippy-bundle.umd.min.js"></script>

<script>
var globalColorCode = [];
var first = true;

document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	headerToolbar: {
           left: 'prev,next today',
           center: 'title',
           right: 'dayGridMonth,listMonth'
         },
      displayEventTime: false, // don't show the time column in list view
   		// THIS KEY WON'T WORK IN PRODUCTION!!!
      // To make your own Google API key, follow the directions here:
      // http://fullcalendar.io/docs/google_calendar/
      //googleCalendarApiKey: 'AIzaSyDcnW6WejpTOCffshGDDb4neIrXVUA1EAE',
   		// US Holidays
      //events: 'en.usa#holiday@group.v.calendar.google.com',
      initialDate: new Date(),
      locale: "ko",
      editable: false,
      selectable: true,
      selectMirror: true,
      dayMaxEvents: true, // allow "more" link when too many events
      //eventClick: function(arg) {
          // opens events in a popup window
      //    window.open(arg.event.url, 'google-calendar-event', 'width=700,height=600');
      //    arg.jsEvent.preventDefault() // don't navigate in main tab
      //  },
      //  loading: function(bool) {
      //    document.getElementById('loading').style.display =
      //      bool ? 'block' : 'none';
      //  },
      eventDidMount: function(info) {

			//console.log(info.event.id);
			//스트리밍강의
			if(info.event.id == 'slecture'){
	            tippy(info.el, {
	            	content: '<div class=p-2>강의명 : ' + info.event.extendedProps.lectureName + '<hr/>'
	            			+ '일정이름 : ' + info.event.extendedProps.sTitle + '<hr/>'
	            			+ '강사명 : ' + info.event.extendedProps.teacherName + '<hr/>'
	            			+ '강의일자 : ' + info.event.extendedProps.sDate + ' - ' + info.event.extendedProps.eDate + '<hr/>'
	            			+ '강의시간 : ' + info.event.extendedProps.sTime + ' - ' + info.event.extendedProps.eTime + '<hr/></div>',
	            	allowHTML: true,
	            	placement: 'bottom',
	            	duration: 1000
	            });
			} else {
				//일반강의
				tippy(info.el, {
	            	content: '<div class=p-2>강의명 : ' + info.event.extendedProps.lectureName + '<hr/>'
	            			+ '일정이름 : ' + info.event.extendedProps.lecturePartTitle + " - " + info.event.extendedProps.lecChapterTitle + '<hr/>'
	            			+ '강사명 : ' + info.event.extendedProps.teacherName + '<hr/>'
	            			+ '강의일자 : ' + info.event.extendedProps.sDate + '<hr/></div>',
	            	allowHTML: true,
	            	placement: 'bottom',
	            	duration: 1000
	            });
			}
        },
        eventSources:[
        	{
              	//스트리밍 강의 일정
        		events: function(info, successCallback, failureCallback){
					$.ajax({
						url:"${pageContext.request.contextPath}/member/myStreamingCal.do",
						dataType: "json",
						success: function(result) {
							var events = [];
							//console.log("result : " + result);
							if(result != null){
								$.each(result, function(index, elem){
									var endDate = elem.streamingEndDate;
										if(endDate == null){
											endDate = moment(elem.streamingStartDate).format('YYYY-MM-DD');
										} else {
											endDate = moment(elem.streamingEndDate).format('YYYY-MM-DD');
										}
									var startDate = moment(elem.streamingStartDate).format('YYYY-MM-DD');
									var lectureName = elem.lectureName;
									var sTitle = elem.streamingTitle
									var teacherName = elem.teacherName;
									var sTime = elem.streamingStartTime;
									var eTime = elem.streamingEndTime;
									var thumbNail = elem.lectureThumbRenamed;
										if(thumbNail == null){
											thumbNail = "noThumbnail.png";
										}
									var lectureNo = elem.refLectureNo;

									events.push({
										title: lectureName,
										start: startDate,
										end: endDate,
										lectureName: lectureName,
										teacherName: teacherName,
										sTime: sTime,
										eTime: eTime,
										thumbNail: "${pageContext.request.contextPath}/resources/upload/lecture/thumbnails/" + thumbNail,
										sTitle: sTitle,
										sDate: startDate,
										eDate: endDate,
										display : "block",
										url: "${pageContext.request.contextPath}/lecture/lectureDetail.do?no=" + lectureNo,
										color: "#6937a1",
										id: 'slecture'
									});
									//console.log(elem);
								}); //.each()
									//console.log(events);
							}//if
							successCallback(events);
						}//success:function
					}); //ajax
		      } //events
        	},
        	{
        		//일반강의
			    events: function(info, successCallback, failureCallback){
					$.ajax({
						url:"${pageContext.request.contextPath}/member/myLectureCal.do",
						dataType: "json",
						success: function(result) {
							var events = [];
							//console.log("result : " + result);
							if(result != null){
								var sDate;
								//var colorCode = "#" + Math.round(Math.random() * 0xffffff).toString(16);
								var colorIdx = 0;

								$.each(result, function(index, elem){
									var lectureNo = elem.lectureNo;
									var refLecCatNo = elem.refLecCatNo;
									var teacherName = elem.teacherName;
									var lectureName = elem.lectureName;
									var thumbNail = elem.lectureThumbRenamed;
										if(thumbNail == null){
											thumbNail = "noThumbnail.png";
										}
									var guideline = elem.lectureGuideline;
									var lecturePartNo = elem.lecturePartNo;
									var lecturePartTitle = elem.lecturePartTitle;
									var lecChapterNo = elem.lecChapterNo;
									var lecChapterTitle = elem.lecChapterTitle;

									//console.log("guideline = ", guideline);
									//console.log("index = ", index);
									//console.log("elem.payDate=", elem.payDate);
									//console.log(moment(sDate).format('YYYY-MM-DD'));
									var colorCode;

									if(first) {
										if(index > 0){
											if(result[index].lectureNo != result[index-1].lectureNo) {
												var randomColor = "#" + Math.round(Math.random() * 0xffffff).toString(16);
												globalColorCode.push(randomColor);
												console.log("globalColorCode = ", globalColorCode);
											}
										} else if(index == 0) {
											var randomColor = "#" + Math.round(Math.random() * 0xffffff).toString(16);
											globalColorCode.push(randomColor);
											console.log("globalColorCode = ", globalColorCode);
										}
									}

										if(index > 0) {
											if(result[index].lectureNo != result[index-1].lectureNo) {
												colorIdx++;
												colorCode = globalColorCode[colorIdx];
												console.log("colorCode = ", colorCode);
											}
										} else if(index == 0) {
											colorCode = globalColorCode[colorIdx];
											console.log("colorCode = ", colorCode);
										}


									if(index == 0){
										sDate = moment(elem.payDate);
										//console.log("payDate = ", sDate);
									}
									else {
										if(index % guideline == 0) {
											sDate = moment(sDate).add(1, 'days').format('YYYY-MM-DD');
											//console.log("sDate = ", sDate);
										}
									}
									//프론트
									if(refLecCatNo == '5'){
										events.push({
											title: lectureName,
											start: sDate,
											lectureName: lectureName,
											teacherName: teacherName,
											thumbNail: thumbNail,
											guideline: guideline,
											lecturePartNo: lecturePartNo,
											lecturePartTitle: lecturePartTitle,
											lecChapterTitle: lecChapterTitle,
											sDate: moment(sDate).format('YYYY-MM-DD'),
											display : "block",
											url: "${pageContext.request.contextPath}/lecture/lectureDetail.do?no=" + lectureNo,
											color: colorCode,
											id: 'vlecture'
										});
										//백엔드
									} else if(refLecCatNo == '6'){
										events.push({
											title: lectureName,
											start: sDate,
											lectureName: lectureName,
											teacherName: teacherName,
											thumbNail: thumbNail,
											guideline: guideline,
											lecturePartNo: lecturePartNo,
											lecturePartTitle: lecturePartTitle,
											lecChapterTitle: lecChapterTitle,
											sDate: moment(sDate).format('YYYY-MM-DD'),
											display : "block",
											url: "${pageContext.request.contextPath}/lecture/lectureDetail.do?no=" + lectureNo,
											color: colorCode
										});
										//빅데이터
									} else {
										events.push({
											title: lectureName,
											start: sDate,
											lectureName: lectureName,
											teacherName: teacherName,
											thumbNail: thumbNail,
											guideline: guideline,
											lecturePartNo: lecturePartNo,
											lecturePartTitle: lecturePartTitle,
											lecChapterTitle: lecChapterTitle,
											sDate: moment(sDate).format('YYYY-MM-DD'),
											display : "block",
											url: "${pageContext.request.contextPath}/lecture/lectureDetail.do?no=" + lectureNo,
											color: colorCode
										});

									}
									//console.log(elem);
								}); //.each()
									//console.log(events);
								first = false;
							}//if
							successCallback(events);
						}//success:function
					}); //ajax
			    }, //events
        	}
      ],
      dayHeaderContent: function (date) {
          let weekList = ["일", "월", "화", "수", "목", "금", "토"];
              return weekList[date.dow];
      },
      //연월 표기 한국어 설정
      titleFormat : function(date) {
      	return date.date.year +"년 "+(date.date.month +1)+"월";
      }
    });
    calendar.render();

  /*
    var eventArr = calendar.getEvents();
    console.log("eventArr = ", eventArr);

  	$("#calTest").click(e => {
	    var eventArr = calendar.getEvents();
	    console.log("eventArr = ", eventArr);

	    eventArr.forEach((event, idx) => {
	    	console.log(idx, event);
	    	console.log(idx, event.id);
	    	console.log(idx, event.title);
	    	console.log(idx, "dateObject = ", event.start);
	    	console.log(idx, "dateObject = ", event.end);
	    	console.log(idx, "jsonStr = " + JSON.stringify(event.start));
	    	console.log(idx, "jsonStr = " + JSON.stringify(event.end));
	    });
	    console.log(eventArr);
    });
 */

});
</script>


<style>
#loading {
  display: none;
  position: absolute;
  top: 10px;
  right: 10px;
}

#calendar {
  max-width: 1100px;
  margin: 100px auto;
}
</style>


<div class="container">
	<div id='loading'>loading...</div>
	<div id='calendar'></div>

	<!-- <input type="button" value="테스트" id="calTest"/> -->
</div> <!-- container -->


<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>