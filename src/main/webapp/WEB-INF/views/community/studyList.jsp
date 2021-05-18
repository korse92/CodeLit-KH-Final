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
<script type="text/javascript">
$(() => {
	$("tr[data-no]").click(e => {
		var $tr = $(e.target).parent();
		var no = $tr.data("no");
		
		location.href = `${pageContext.request.contextPath}/community/studyDetail.do?stdBrdNo=\${stdBrdNo}`;
	});
});
</script>


   	<div class="container">
        <div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-sm-3">공부 게시판</h2>

          <c:if test="${empty list}">
          	<h1 style="text-align: center">등록된 게시글이 존재하지 않습니다.</h1>
          </c:if>
          
          <c:if test="${not empty list}">
          <div class="mt-4 col-sm-2">
            <select class="form-select">
              <option selected>검색</option>
              <option value="2">제목</option>
              <option value="3">내용</option>
            </select>
          </div>
            
          <div class="col-4 mt-4">
            <div class="input-group">  
              <div class="form-outline">
                <input type="search" id="form1" class="form-control"  placeholder="Search"/>              
              </div>
              <button type="button" class="btn btn-primary">
                <i class="fas fa-search"></i>
              </button>
            </div>
          </div>
        </div>
        
        <div class="mt-5">
          <table class="table text-center table-hover">
            <thead class="table-primary">
              <tr>
                <th scope="col">번호</th>
                <th scope="col">제목</th>
                <th scope="col">등록일</th>
                <th scope="col">조회수</th>
                <th scope="col">작성자</th>
              </tr>
            </thead>
            <tbody>
               <c:forEach items="${list}" var="list" varStatus="status">
	              <tr data-no="${list.stdBrdNo}">
	                <td scope="row">${list.rownum}</td>
	                <td>
						<c:choose>
	                		<c:when test="${fn:length(list.stdBrdTitle) > 20}">
					                <c:out value="${fn:substring(list.stdBrdTitle,0,19)}" />...
	                		</c:when>
	                		<c:otherwise>
	                				<c:out value="${list.stdBrdTitle}" />
	                		</c:otherwise>
	                	</c:choose>
					</td>
	                <td>
	                	<fmt:formatDate value="${list.stdBrdDate}" pattern="yy/MM/dd HH:mm:ss" />
	                </td>
	              	<td>${list.stdBrdCount}</td>
	              	<td>${list.refMemberId}</td>
	              </tr>
          	    </c:forEach>
            </tbody>
          </table>
        </div>
        ${pageBar}
        </div>
      </c:if>
      	<div>
          <button class="btn btn-primary pull-right board-write" onclick="location.href='${pageContext.request.contextPath}/community/studyWrite.do'">글쓰기</button>
      	</div>
       </div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>