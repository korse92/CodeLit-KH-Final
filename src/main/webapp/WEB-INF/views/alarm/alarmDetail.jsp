<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css">
	<div class="container" style="height: 700px;">
        <div class="row mt-5">
          <h2 class=" jb-larger mt-1 col-4"><spring:message code="ud.notiMore"/></h2>
        </div>
        <div class="row mt-1 header">
          <h5 class="col-1 board-title"><spring:message code="user.boardTitle"/></h5>
          <p class="col-8">${message.msgTitle}</p>
          <p class="col-2"><fmt:formatDate value="${message.msgDate}" pattern="yy/MM/dd HH:mm:ss"/></p>
          <p class="col-1">${message.readYN eq 'N' ? '읽지않음' : '읽음'}</p>
        </div>
        <div class="board-container">
          <h5 class="content-title"><spring:message code="user.boardContent"/></h5>
            <p class="content" style=" word-break:break-all;">
              ${message.msgContent}
            </p>          
        </div>
        <div class="board-footer">
          <button type="button" class="btn btn-primary list-btn" onclick="location.href='${pageContext.request.contextPath}/alarm/alarmList.do'"><spring:message code="admin.backBtn"/></button>
        </div>
            
      </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>