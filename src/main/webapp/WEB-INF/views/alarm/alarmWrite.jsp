<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css">



    <div class="container">
        <div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-sm-4">알림 작성</h2>
        </div>
          <div class="row title-group">
            <h5 class="col-sm-2 board-title">제목</h5>
             <div class="col-2">
			    <select id="stomp-url" class="form-select">
					<option value="">전송대상</option>
					<option value="/app/user">유저</option>
					<option value="/app/teacher">강사</option>
			    </select>
		 	  </div>
            <div class="col-sm-7">
              <input class="form-control" type="text" name="msgTitle" id="msgTitle" placeholder="title">
            </div>
          </div>
 		  <div class="board-container">
            <div class="form-group content">
              <textarea class="form-control" name="msgContent" id="msgContent" rows="10"></textarea>
            </div>
          </div>
          <div class="board-footer">
            <button type="reset" class="btn btn-danger cancel-btn" onclick="location.href='${pageContext.request.contextPath}/alarm/alarmList.do';">취소</button>
            <button type="button" class="btn btn-primary sendBtn" id="sendBtn">완료</button>
          </div>
      </div>
      
<script>
toastr.options.escapeHtml = true;
toastr.options.closeButton = true;
toastr.options.newestOnTop = false;
toastr.options.progressBar = true;
const ws = new SockJS("${pageContext.request.contextPath}/stomp");
const stompClient = Stomp.over(ws);

//2.connect핸들러 작성. 구독
stompClient.connect({}, (frame) => {
	
	stompClient.subscribe("/topic/user", (frame) => {
		const msgObj = JSON.parse(frame.body);
		const {msgTitle, msgContent} = msgObj;
		toastr.info(msgContent, "[유저알림] "+msgTitle, {timeOut: 5000});
	});
	
	stompClient.subscribe("/topic/teacher", (message) => {
		const msgObj = JSON.parse(frame.body);
		const {msgTitle, msgContent} = msgObj;
		toastr.info(msgContent, "[강사알림] "+msgTitle, {timeOut: 5000});
	});
});

//3.메세지 전송
$("#sendBtn").click(() => {
	const $message = $("#msgContent");
	const $title = $("msgTitle");
	const $url = $("#stomp-url"); // $("#stomp-url option:selected")
	
	if($message.val() == '') {
		alert("메세지를 작성하세요.");
		return;
	}
	if($url.val() == ''){
		alert("전송 url을 선택하세요."); 
		return;
	}
	console.log("============"+$url.val());
	sendMessage($url.val());
});

function sendMessage(url){
	const $message = $("#msgContent");
	const $title = $("#msgTitle");
	
	const message = {
		msgTitle : $title.val(),
		msgContent : $message.val(),
		readYN : 'N'
	};
	
	stompClient.send(url, {}, JSON.stringify(message));
	
	$title.val('');
	$message.val(''); // 초기화
}

//유효성검사
function checkContent() {
	const title = $("[name=msgTitle]");
	const content = $("[name=msgContent]");
	if(/^(.|\n)+$/.test(title.val()) == false){
		alert("제목을 입력하세요");
		return false;
	}
	if(/^(.|\n)+$/.test(content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>