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
          <h2 class=" jb-larger mt-3 col-2">공지사항</h2>
        </div>
        <div class="row mt-3 header">
          <h5 class="col-1 board-title">제목</h5>
          <p class="col-3">${notice.noticeTitle}</p>
          <h5>${notice.noticeCount}</h5>
          <fmt:formatDate value="${notice.noticeDate}" pattern="yy/MM/dd HH:mm:ss"/>
        </div>
        <div class="board-container">
          <h5 class="content-title">내용</h5>
            <!-- 이미지가 들어가면 콘텐츠에서 보여줘야함. 어떻게 서버처리할지 생각해볼것. -->
            <img src="../images/testImage.jpg" alt="페페이미지" value="">
            <p class="content">
              ${notice.noticeContent}
            </p>          
        </div>
        <div class="board-footer">
          <!-- 관리자-->
          <button type="button" class="btn btn-primary update-btn" onclick="location.href='${pageContext.request.contextPath}/community/noticeUpdate.do?noticeNo=${notice.noticeNo}'">수정</button>
          <button type="button" class="btn btn-danger delete-btn" onclick="location.href='${pageContext.request.contextPath}/community/noticeDelete.do?noticeNo=${notice.noticeNo}'">삭제</button>
          <button type="button" class="btn btn-primary list-btn" onclick="location.href='${pageContext.request.contextPath}/community/noticeList.do'">목록으로</button>
        </div>
            
      </div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>