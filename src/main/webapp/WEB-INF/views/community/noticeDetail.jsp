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

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css">
	<div class="container" style="height: 700px;">
        <div class="row mt-5">
          <h2 class=" jb-larger mt-1 col-2">공지사항</h2>
        </div>
        <div class="row mt-1 header">
          <h5 class="col-1 board-title">제목</h5>
          <p class="col-8">${notice.noticeTitle}</p>
          <p class="col-2"><fmt:formatDate value="${list.Date}" pattern="yy/MM/dd HH:mm:ss"/></p>
          <p class="col-1">${notice.noticeCount}</p>
        </div>
        <div class="board-container">
          <h5 class="content-title">내용</h5>
          	<c:if test="${not empty attach}">
	            <img src='${pageContext.request.contextPath}${attachPath}'>
          	</c:if>
            <p class="content">
              ${notice.noticeContent}
            </p>          
        </div>
        <div class="board-footer">
          <button type="button" class="btn btn-primary update-btn" onclick="location.href='${pageContext.request.contextPath}/community/noticeUpdate.do?noticeNo=${notice.noticeNo}'">수정</button>
          <button type="button" class="btn btn-danger delete-btn" onclick="del()">삭제</button>
        
          <button type="button" class="btn btn-primary list-btn" onclick="location.href='${pageContext.request.contextPath}/community/noticeList.do'">목록으로</button>
        </div>
            
      </div>

	<script type="text/javascript">
		function del(){
			if(confirm("삭제 하실거예요?")){
				location.href=`${pageContext.request.contextPath}/community/noticeDelete.do?noticeNo=${notice.noticeNo}`;
			} else{
				return false;
			}
		}
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>