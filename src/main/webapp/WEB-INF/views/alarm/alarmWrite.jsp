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
            <div class="col-sm-9">
              <input class="form-control" type="text" name="msgTitle" id="msgTitle" placeholder="title">
   	 		  <input type="hidden" value="/app/user" id="url">
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

$("#sendBtn").click(() => {
	const $message = $("#msgContent");
	const $title = $("#msgTitle");
	const $url = $("#url"); 
	
	if($title.val() == '') {
		alert("제목을 작성하세요.");
		return;
	}
	if($message.val() == '') {
		alert("메세지를 작성하세요.");
		return;
	}
	if($url.val() == ''){
		alert("전송 url을 선택하세요."); 
		return;
	}
	sendMessage($url.val());
	
	location.href='${pageContext.request.contextPath}/alarm/alarmList.do';
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>