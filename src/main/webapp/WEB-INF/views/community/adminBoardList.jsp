<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>
<script type="text/javascript">
$(() => {
	$("tr[data-no]").click(e => {
		var $tr = $(e.target).parent();
		var no = $tr.data("no");
		
		location.href = `${pageContext.request.contextPath}/community/admin/adminBoardDetail.do?noticeNo=\${no}`;
	});
});
</script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css">
  <div class="container">
        <div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-3">공지사항</h2>
        </div>
        
        <div class="mt-5">
          <c:if test="${empty list}">
          	<h1 style="text-align: center">등록된 공지가 없습니다.</h1>
          </c:if>
          <c:if test="${not empty list}">
          <table class="table text-center ">
            <thead class="primary table-primary">
              <tr>
                <th scope="col">번호</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">날짜</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="list" varStatus="status">
              <tr data-no="${list.noticeNo}">
			<!--  전체 레코드 수 - ( (현재 페이지 번호 - 1) * 한 페이지당 보여지는 레코드 수 + 현재 게시물 출력 순서 ) -->
                <td scope="row">${list.rownum}</td>
                <td>
                	<c:choose>
                		<c:when test="${fn:length(list.noticeTitle) > 20}">
			                <a href="">
				                <c:out value="${fn:substring(list.noticeTitle,0,19)}" />...
			                </a>
                		</c:when>
                		<c:otherwise>
                				<c:out value="${list.noticeTitle}" />
                		</c:otherwise>
                	</c:choose>
                <td>${list.refMemberId}</td>
                <td><fmt:formatDate value="${list.noticeDate}" pattern="yy/MM/dd HH:mm:ss"/></td>
              </tr>
            </c:forEach>
            </tbody>
          </table>		          
	       ${pageBar}
          </c:if>
       	<div class="community-footer mt-5">
         <button class="btn btn-primary pull-right board-write" onclick="location.href='${pageContext.request.contextPath}/community/admin/adminBoardWrite.do'">글쓰기</button>		       
       </div>
      </div>
     </div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>