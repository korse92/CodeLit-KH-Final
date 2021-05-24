<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/userPage(notice,lectureList).css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />


<div class="container">
  <div class="row mt-5">
   <h2 class=" jb-larger mt-3 col-4">알림 목록</h2>
  </div>
  <sec:authorize access="hasRole('ADMIN')">
  <div class="row mt-3">
	  <div class="col-2">
	    <select id="stomp-url" class="form-select">
		  <option value="">전송구분자</option>
	 	  <option value="/app/all">전체</option>
		  <option value="/app/teacher">강사</option>
		  <option value="/app/user">사용자</option>
	    </select>
 	  </div>
      <div class="mb-3 col-8">
	    <input type="text" class="form-control" id="message" placeholder="알림 내용 입력">
	  <datalist id="datalistOptions">
	    <option value="">전체공지</option>
	  </datalist>
      </div>
	  <div class=" col-2">
	    <button class="btn btn-primary" id="send" type="button">보내기</button>
	  </div>
  </div>
  </sec:authorize>
      <div class="mt-5">
        <table class="table text-center">
          <thead class="table-primary">
            <tr>
              <th scope="col">번호</th>
              <th scope="col">알림 내용</th>
              <th scope="col">날짜</th>
              <th scope="col">대상</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>1</td>
              <td>새로운 공지</td>
              <td>2020/05/05</td>
              <td>User/Teacher/All</td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="notice-paging mt-5">
        <span class="pagination-span">
          <ul class="pagination board-paging">
            <li class="page-item"><a class="page-link" href="#">&#60</a></li>
            <li class="page-item"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#">4</a></li>
            <li class="page-item"><a class="page-link" href="#">5</a></li>
            <li class="page-item"><a class="page-link" href="#">&#62</a></li>
          </ul>
        </span>
      </div>
  </div>
<script type="text/javascript">
const ws = new SockJS("${pageContext.request.contextPath}/alarm/alarmList");
console.log(ws);
const stompClient = Stomp.over(ws);

//connect 핸들러 작성
stompClient.connect({}, (frame) => {
	
	stompClient.subscribe("/app/all", (frame) => {
		const msgObj = JSON.parse(frame.body);
		console.log(msgObj);
		const {from, to, content, type, time} = msgObj;
		console.log(msgObj);
		alert(content + "\n" + new Date(time));
	});
	
	stompClient.subscribe("/app/user", (message) => {
		toastr.info(message);
	});
	
	stompClient.subscribe("/app/teacher", (message) => {
		toastr.info(message);
	});
});

toastr.options = {
  "closeButton": true,
  "debug": false,
  "newestOnTop": false,
  "progressBar": true,
  "positionClass": "toast-bottom-right",
  "preventDuplicates": false,
  "onclick": null,
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "3000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
}
//3.메세지 발행
$("#send").click(() => {
	const $message = $("#message");
	const $url = $("#stomp-url"); // $("#stomp-url option:selected")
	
	if($url.val() == ''){
		swal ("경고" ,"url을 선택해주세요","error");
		return;
	}
	if($message.val() == '') {
		swal ("경고" ,"메세지를 입력해주세요","error");
		return;
	}
	sendMessage($url.val());
});

function sendMessage(url){
	const $to = $("#toDataList");
	const $message = $("#message");
	// 전체공지가 아닌 경우, url에 사용자id를 append한다.
	if($to.val())
		url += `/\${$to.val()}`;
	const message = {
		from : '관리자',
		to : $to.val() ? $to.val() : 'everybody',
		content : $message.val(),
		type : "notice",
		time : Date.now()
	};
	
	stompClient.send(url, {}, JSON.stringify(message));
	$message.val(''); // 초기화
}
</script>  
  
  
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>