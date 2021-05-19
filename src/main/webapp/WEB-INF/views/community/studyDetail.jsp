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
         <h2 class=" jb-larger mt-3 col-2">공지사항</h2>
       </div>
       <div class="row mt-3 header">
         <h5 class="col-1 board-title">제목</h5>
         <p class="col-8">${stdBrd.stdBrdTitle}</p>
         <p class="col-2"><fmt:formatDate value="${stdBrd.stdBrdDate}" pattern="yy/MM/dd HH:mm:ss" /></p>
         <p class="col-1">${stdBrd.stdBrdCount}</p>
       </div>
       <div class="board-container">
         <h5 class="content-title">내용</h5>
          	<c:if test="${not empty attach}">
	            <img src='${pageContext.request.contextPath}${attachPath}'>
          	</c:if>
           <p class="content">
           	${stdBrd.stdBrdContent}
           </p>          
       </div>
         <div class="board-footer">
           <button type="button" class="btn btn-primary update-btn" onclick="location.href='${pageContext.request.contextPath}/community/studyUpdate.do?stdBrdNo=${stdBrd.stdBrdNo}'">수정</button>
           <button type="button" class="btn btn-danger delete-btn" onclick='del();'>삭제</button>
           <button type="button" class="btn btn-primary list-btn" onclick="location.href='${pageContext.request.contextPath}/community/studyList.do'">목록으로</button>
         </div>
         <div class="comment">
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
        	<form id="commentForm" name="commentForm">
             <div class="comment-form-group mt-5">
             	<table class="table">
             		<tr>
           				<td>
	                 		<textarea class="form-control rounded-0" rows="2" id="" name="" placeholder="댓글입력"></textarea>
                 	 		<input class="btn btn-primary comment-submit-btn" onclick="commentSubmit('${stdBrd.stdBrdNo}')" value="전송"/>
            			</td>
             		</tr>
             	</table>
             </div>
             <input type="hidden" id="stdBrdNo" name="stdBrdNo" value="${stdBrd.stdBrdNo}">
        </form>
         </div>
     </div>


  <script>
  function commentSubmit(no){
		$.ajax({
			type : 'POST',
			url : "<c:url value='/community/stdBrdInsertComment.do />'",
			data : $("form[name='commentForm']").serialize(),
			success : function(data){
				if(data=="success"){
					getCommentList();
					$("#comment").val("");
				}
			},
			error : function(request, status, error)P
				console.log(error);
		});  
	  }
    $("button[name='comment-delete-btn']").on("click", function(){
      confirm("삭제 하시겠습니까?");
    });

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
  </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>