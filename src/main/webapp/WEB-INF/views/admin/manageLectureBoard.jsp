<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--form:form 태그용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의 관리 게시판" name="title"/>
</jsp:include>
<script>

// 카테고리
/* const menuRestApiHost = "http://localhost:9090/codelit";

window.onload = function() {
	
$("#typeSelector").change(e => {
      	const type = $(e.target).val();
      	console.log(type); //사용자가 선택한 값이 잘 넘어오는지 확인
      	
      	$.ajax({
      		url: `\${menuRestApiHost}/admin/\${type}`,    //${type} 은 브라우저와서 실행되야 하므로 escaping처리
      		dataType: "json",
      		success(data){
      			console.log(data);
      			
      		},
      		error(xhr, status, err){
      			console.log(xhr, status, err);
      		}
      	})
    });
}         


//검색
$("#searchByAdmin").autocomplete({
     source : function(request, response){
    	 //서버 통신 이후 success메소드에서 response 호출 할 것!
    	 console.log(request); //사용자 입력값
    	 console.log(response); 
    
   //ajax 호출
   $.ajax({
   	url:`${pageContext.request.contextPath}/admin/searchByAdmin.do`,
       data : {
   	  	searchTitle : request.term
   	  	
   },
   	//method : "GET"   //기본값 -> 생략가능
   	//dataType : "json" //유연하게 처리해줌 -> 생략가능
   	 success(data){
   		console.log(data);   //map ->기본 배열의 요소를 변형해서 새로운 배열 생성가능한 메소드
   						      //map은 callback 함수를 각각의 요소에 대해 한번씩 순서대로 불러 그 함수의 반환값으로 새로운 배열을 만듭니다. 
   		 var res = $.map(data, (board) => ({
 				  label: board.title,
 				  value: board.title,
 				  no : board.no //사용자 속성 전달 가능
 				  
 			  }));//화살표 함수에서 객체를 리턴하는 방법 -> 객체를 소괄호로 꼭 감싸주기!
   		 
   		 // console.log(res);
   		 response(res);  //response에 result값 전달 -> 드랍다운에 표시됨
   	},
   	  error(xhr, status, err){
   		 console.log(xhr, status, err); 
   	  }
   	})
   },
    focus: function(){return false},
    select: function(e, selected){
   	 console.log(e);
   	 console.log(selected.item.no);
   	 const no = selected.item.no;
   	 location.href = `${pageContext.request.contextPath}/admin/manageLectureBoard.do?no=\${no}`;
    }
    
  });



 */
$(() => {
	$("#rejectTeacherRight")
	.modal()
	.on('hide.bs.modal', e => {
		//modal 비활성화(X,취소,모달외 영역 클릭시) 이전페이지로 이동한다. //bs의 이벤트핸들링
		location.href = '${empty header.referer || fn:contains(header.referer, '/member/login.do') ? pageContext.request.contextPath : header.referer}'; //referer가 없거나,로그인페이지를 경로로 들어간 경우 contextPath로 이동
	})
});



</script>

</head>
<!-- 컨텐츠 시작 -->
<div class="container">
	<section class="container">
      <div class="page-header">
        <div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-sm-3">강의 관리 게시판</h2>
        
        <div class="mt-4 col-sm-2">
          <select class="form-select" id="typeSelector">
            <option value="" selected>카테고리</option>
             <%-- <c:forEach items="${catList}" var="list">
              	<option value="${list.no}">${list.name}</option>
              </c:forEach>
             --%>
             <option value="fe"  ${param.searchType eq 'fe' ? 'selected' : ''}>프론트 엔드</option>
            <option value="be"  ${param.searchType eq 'be' ? 'selected' : ''}>백엔드</option>
            <option value="dt"  ${param.searchType eq 'dt' ? 'selected' : ''}>빅데이터</option> 
            
            
         <%--  <c:forEach items="${categoryList}" var="category">
          <option class="select-item" href="${pageContext.request.contextPath}/admin/manageLectureBoard.do/${category.no}">${category.name}</option>
          </c:forEach --%>>
          </select>
          
        </div>
        <div class="col-4 mt-4">
          <div class="input-group">  
            <div class="form-outline">
              <input type="search" id="searchByAdmin" name="searchKeyword" class="form-control"  placeholder="강의자 / 강의명" value="${param.searchKeyword}" required/>              
             </div>
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-search"></i>
            </button>
          </div>
         </div>
        </div>
      </div>
	<table class="table mt-3 col-sm text-center">
	<thead class="thead-light">
	    <tr>
	      <th scope="col">번호</th>
	      <th scope="col">카테고리</th>
	      <th scope="col">강의자 아이디</th>
	      <th scope="col">강의자 명</th>
	      <th scope="col">강의 링크</th>
	      <th scope="col">비고</th>
	    </tr>
	    <!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 하세요 -->
	<c:if test="${empty list}">
	<tr>
		<td colspan="14" style="text-align:center;">조회된 데이터가 없습니다.</td>
	</tr>
	</c:if>
	<c:if test="${not empty list}">
	<c:forEach items="${list}" var="lec" varStatus="vs">
	<tr>
	 </thead>
	  <tbody>
	       <tr>
	          <td>0</td>
	          <td>백엔드</td>
	          <td>jisuco</td>
	          <td>김지수</td>
	       	 <td><a href="${pageContext.request.contextPath}/admin/manageLectureBoard.do">강의 상세보기</a></td>
	       	<%--  <td><a href="${pageContext.request.contextPath}/admin/manageLectureBoard.do?detail="\${teacher.link}>강의관리 게시판</a></td> --%>
	          <td>
	             <button type="button" class="btn btn-secondary btn-sm">취소</button>
	             <button type="button" a class="btn btn-warning btn-sm" onclick="location.href='${pageContext.request.contextPath}/admin/rejectTeacherRight.do';">정지</button>
	          </td>
	        </tr>
	      </c:forEach>
		</c:if>
	</table>
	
		<!-- 페이지 바 -->
	     <ul class="pagination d-flex justify-content-center">
	       <li class="page-item"><a class="page-link" href="#"><</a></li>
	       <li class="page-item"><a class="page-link" href="#">1</a></li>
	       <li class="page-item active"><a class="page-link" href="#">2</a></li>
	       <li class="page-item"><a class="page-link" href="#">3</a></li>
	       <li class="page-item"><a class="page-link" href="#">4</a></li>
	       <li class="page-item"><a class="page-link" href="#">5</a></li>
	       <li class="page-item"><a class="page-link" href="#">></a></li>
	     </ul>
</div>
</section>

             


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
