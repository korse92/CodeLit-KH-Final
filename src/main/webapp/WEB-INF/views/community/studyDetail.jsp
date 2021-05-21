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

	<div class="container">
       <div class="row mt-5">
         <h2 class=" jb-larger mt-3 col-2">공부게시판</h2>
       </div>
       <div class="row mt-3 header">
         <h5 class="col-1 board-title">제목</h5>
         <p class="col-7">[${stdBrd.lectureName}] ${stdBrd.stdBrdTitle}</p>
         <p class="col-1">${stdBrd.refMemberId}</p>
         <p class="col-2"><fmt:formatDate value="${stdBrd.stdBrdDate}" pattern="yy/MM/dd HH:mm:ss" /></p>
         <p class="col-1">${stdBrd.stdBrdCount}</p>
       </div>
       <div class="board-container">
         <h5 class="content-title">내용</h5>
			<c:if test="${not empty attach}">
	            <img src='${pageContext.request.contextPath}${attachPath}' />
          	</c:if>
   
           <p class="content">
           	${stdBrd.stdBrdContent}
           </p>          
       </div>
         <div class="board-footer">
         <sec:authentication property='principal.username'/>
         <c:if test="${stdBrd.refMemberId} == <sec:authentication property='principal.username'/>">
           <button type="button" class="btn btn-primary update-btn" onclick="location.href='${pageContext.request.contextPath}/community/studyUpdate.do?stdBrdNo=${stdBrd.stdBrdNo}'">수정</button>
           <button type="button" class="btn btn-danger delete-btn" onclick='del();'>삭제</button>
         </c:if>
           <button type="button" class="btn btn-primary list-btn" onclick="location.href='${pageContext.request.contextPath}/community/studyList.do'">목록으로</button>
         </div>
<!--            <br>
           <div class="">
             <h5 class="comment-writer">작성자이름</h5>
             <span class="comment-content">
             	
             </span>
             <div class="comment-btn">
               <button type="button" class="btn btn-link btn-sm" name="comment-update-btn">수정</button>
               <button type="button" class="btn btn-link btn-sm" name="comment-delete-btn" onclick="commentDelete()">삭제</button>
               <button type="button" class="btn btn-link btn-sm" name="comment-reply-btn" onclick="commentReply()">답글</button>
             </div>
           </div> -->
           
           <div class="comment-title">댓글</div>
           	<div class="row" id="REF_MEMBER_ID" name="REF_MEMBER_ID">
<%--            	  <div class="col-3">
	           	${listCmt.refMemberId}
	           	
           	  </div>
           	  <div class="col-7">
           	  	${listCmt.stdCmtContent}
           	  </div>
           	  <div class="col-2">
           	  	${listCmt.stdCmtDate}
           	  </div> --%>
           	</div>
           	
        	<form action="${pageContext.request.contextPath}/community/insertComment.do?${_csrf.parameterName}=${_csrf.token}" method="post"
        	id="commentForm" name="commentForm" onsubmit="return commentSubmit();">
             <div class="comment-form-group mt-5">
             	<table class="table">
             		<tr>
             		</tr>
             		<tr>
           				<td>
	                 		<textarea class="form-control rounded-0" rows="2" id="stdCmtContent" name="stdCmtContent" placeholder="댓글입력"></textarea>
            			</td>
             		</tr>
           			<tr>
            			<td>
                 	 		<button type="submit"  class="btn btn-primary comment-submit-btn">전송</button>
            			</td>
           			<tr>
             	</table>
             <input type="hidden" id="refStdBrdNo" name="refStdBrdNo" value="${stdBrd.stdBrdNo}">
             </div>
        </form>
     </div>

  <script>
    $("button[name='comment-update-btn']").on("click", function(e){
      $(".comment-btn").append(`
        <div class="update-div">
          <form>
            <input type="text" class="form-control" value="수정내용"/>
            <input type="submit" class="btn btn-primary-sm" value="전송"/>
            <input type="reset" name="update-cancel"  class="btn btn-danger-sm comment-update-cancel" value="취소">
          </form>
        </div>`);
            $(this).off(e);
        $("input[name='update-cancel']").on("click", function(e){
          $(".update-div").hide();
        });
    });
	function del(){
		if(confirm("삭제 하실거예요?")){
			location.href=`${pageContext.request.contextPath}/community/studyDelete.do?stdBrdNo=${stdBrd.stdBrdNo}`;
		} else{
			return false;
		}
	};
	function commentSubmit() {
		const input = $("[name=stdCmtContent]");
		if(/^(.|\n)+$/.test(input.val()) == false){
			alert("내용을 입력하세요");
			return false;
		}
		return true;
	}
  </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>