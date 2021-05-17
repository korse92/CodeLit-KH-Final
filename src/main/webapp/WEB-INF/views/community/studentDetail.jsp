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
         <p class="col-3">신규 개설 강의</p>
       </div>
       <div class="board-container">
         <h5 class="content-title">내용</h5>
           <!-- 이미지가 들어가면 콘텐츠에서 보여줘야함. 어떻게 서버처리할지 생각해볼것. -->
           <img class="detail-img" src="../images/testImage.jpg" alt="페페이미지" value="">
           <p class="content">
             Lorem ipsum dolasdasdasdasdasdasdasdasdasdr
             sit amet consectetur adipisicing elit. Est perferendis accusamus ex voluptates optio impedit consequuntur voluptatibus laudantium facilis eos rem libero, id
             sunt dolorum repellendus? Omnis laborum impedit a.
           </p>          
       </div>
         <div class="board-footer">
           <!-- 관리자-->
           <button type="button" class="btn btn-primary update-btn">수정</button>
           <button type="button" class="btn btn-danger delete-btn">삭제</button>
           <button type="button" class="btn btn-primary list-btn" onclick="location.href='./studentBoardList.html'">목록으로</button>
         </div>
         <div class="comment">
           <div class="comment-title">댓글</div>
           <br>
             <h5 class="comment-writer">작성자이름</h5>
             <span class="comment-content">Lorem ipsum dolor sit amet consectetur adipisicing elit. Eaque sapiente ratione dolor magnam ullam tempora eum earum ex eligendi ab nisi architecto, incidunt quo amet consequuntur aliquid repellat praesentium qui!</span>
             <div class="comment-btn">
               <button type="button" class="btn btn-link btn-sm" name="comment-update-btn">수정</button>
               <button type="button" class="btn btn-link btn-sm" name="comment-delete-btn" onclick="commentDelete()">삭제</button>
               <button type="button" class="btn btn-link btn-sm" name="comment-reply-btn" onclick="commentReply()">답글</button>
             </div>
             <div class="comment-form-group mt-5">
             <form action="">
                 <label for="lable">댓글 작성자 이름</label>
                 <textarea class="form-control rounded-0" rows="2"></textarea>
                 <input class="btn btn-primary comment-submit-btn" type="submit" value="전송"/>
               </form>                 
             </div>
         </div>
     </div>


  <script>
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
  </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>