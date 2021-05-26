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
<!-- 풀캘린더 부트스트랩 테마 -->
<!-- <link href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.css' rel='stylesheet' /> -->

<script>
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
    	themeSystem: 'bootstrap',
    	headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,listYear'
          },
      displayEventTime: false, // don't show the time column in list view
   		// THIS KEY WON'T WORK IN PRODUCTION!!!
      // To make your own Google API key, follow the directions here:
      // http://fullcalendar.io/docs/google_calendar/
      googleCalendarApiKey: 'AIzaSyDcnW6WejpTOCffshGDDb4neIrXVUA1EAE',
   		// US Holidays
      events: 'en.usa#holiday@group.v.calendar.google.com',
      initialDate: new Date(),
      locale: "ko",
      editable: false,
      selectable: true,
      selectMirror: true,
      dayMaxEvents: true, // allow "more" link when too many events
      eventClick: function(arg) {
          // opens events in a popup window
          window.open(arg.event.url, 'google-calendar-event', 'width=700,height=600');

          arg.jsEvent.preventDefault() // don't navigate in main tab
        },

        loading: function(bool) {
          document.getElementById('loading').style.display =
            bool ? 'block' : 'none';
        },
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

    var eventArr = calendar.getEvents();
    //console.log(eventArr);

    eventArr.forEach((event, idx) => {
    	console.log(idx, event);
    	console.log(idx, event.id);
    	console.log(idx, event.title);
    	console.log(idx, "dateObject = ", event.start);
    	console.log(idx, "dateObject = ", event.end);
    	console.log(idx, "jsonStr = " + JSON.stringify(event.start));
    	console.log(idx, "jsonStr = " + JSON.stringify(event.end));
    });

});
</script>


<style>
body {
  margin: 40px 10px;
  padding: 0;
  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  font-size: 14px;
}

#loading {
  display: none;
  position: absolute;
  top: 10px;
  right: 10px;
}

#calendar {
  max-width: 1100px;
  margin: 50px auto;
}
</style>


<div class="container">
	<div id='loading'>loading...</div>
	<div id='calendar'></div>
</div> <!-- container -->


<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>