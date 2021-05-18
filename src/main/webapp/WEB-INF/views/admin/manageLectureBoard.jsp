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
 const menuRestApiHost = "http://localhost:9090/codelit";

window.onload = function() {
	
	$("#typeSelector").change(e => {
      	const type = $(e.target).val();
      	console.log(type); //사용자가 선택한 값이 잘 넘어오는지 확인
      	
      	$.ajax({
      		url: `${pageContext.request.contextPath}/admin/searchCategory.do/\${type}`,  //${type} 은 브라우저와서 실행되야 하므로 escaping처리
      		dataType: "json",
      		success(data){
      			//console.log(data);
      			//displayResultTable("#menuType-result", data);
      		},
      		error(xhr, status, err){
      			console.log(xhr, status, err);
      		}
      	});
    });
    
 //유효성 검사
 $("#searchBtn").click(e => {
	 //폼 제출 방지
	  e.preventDefault();
	 
	const typeSelector = $("[name=typeSelector]", e.target).val();
	const searchKeyword = $("[name= searchKeyword]", e.target).val();
	 
	if(!typeSelector || !searchKeyword){
		alert("검색어를 입력해주세요.");
		return;
	}
	
 });
 /* 
 function displayResultTable(selector, data){
		const $container = $(selector);
		const $table = $("<table></table>").addClass("table");
		const $header = $("<tr><th>글 번호</th><th>카테고리</th><th>강의자 아이디</th><th>강의 링크</th></tr>")
		
		const $no = $("[name=no]", e.target).val();
		const $cat = $("[name=cat]", e.target).val();
		const $teacherId = $("[name=teacherId]", e.target).val();
		const $site = $("[name=site]", e.target).val();
		const $etc = $("[name=etc]", e.target).val();
		
		
		$table.append($header);
		
		if(data.length > 0){
			$(data).each(({no, cat, teacherId, site, etc}) =>{
				const tr = `<tr>
					<td>\${no}</td>
					<td>\${cat}</td>
					<td>\${teacherId}</td>
					<td>\${site}</td>
					<td>\${etc}</td>
				</tr>`; 
				$table.append(tr);
			});		
		}
		else {
			$table.append("<tr><td colspan='6'>조회된 결과가 없습니다.</td></tr>");
		}
		
		$container.html($table);
	}


	
	 //검색
 	$("#searchKeyword").autocomplete({
	     source : function(request, response){
	    	 //서버 통신 이후 success메소드에서 response 호출 할 것!
	    	 console.log(request); //사용자 입력값
	    	 console.log(response); 
	    
	   //ajax 호출
	   $.ajax({
	   	url:`${pageContext.request.contextPath}/admin/searchKeyword.do`,
	       data : {
	       searchKeyword : $("#searchKeyword").val()  
	    
	   },
	   	  // method : "GET"   //기본값 -> 생략가능
	   	  // dataType : "json" //유연하게 처리해줌 -> 생략가능
	   	 success(data){
	   	 console.log(data);   //map ->기본 배열의 요소를 변형해서 새로운 배열 생성가능한 메소드
	   						      //map은 callback 함수를 각각의 요소에 대해 한번씩 순서대로 불러 그 함수의 반환값으로 새로운 배열을 만듭니다. 
	   		 var res = $.map(data, (board) => ({
	 				  label: board.title,
	 				  value: board.title,
	 				  no : board.no //사용자 속성 전달 가능
	 				  
	 			  }));    //화살표 함수에서 객체를 리턴하는 방법 -> 객체를 소괄호로 꼭 감싸주기!
	   		 
	   		  console.log(res);
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
	   	 location.href = `${pageContext.request.contextPath}/admin/manageLectureBoard.do`;
	    }
	    
	}); 
	
	 */
	
	
	$(() => {
		$("#rejectPlayingLecture")
		.modal()
		.on('hide.bs.modal', e => {
			//modal 비활성화(X,취소,모달외 영역 클릭시) 이전페이지로 이동한다. //bs의 이벤트핸들링
			location.href = '${empty header.referer || fn:contains(header.referer, '/member/memberLogin.do') ? pageContext.request.contextPath : header.referer}'; //referer가 없거나,로그인페이지를 경로로 들어간 경우 contextPath로 이동
		})
	});
	
	
	/* $(typeSelector).change(e => {
		console.log(e.target.value);
		//href="${pageContext.request.contextPath}/admin/manageLectureBoard.do/${category.no}";
	}); */
	
	
	
}         






</script>

</head>
<!-- 컨텐츠 시작 -->
<div class="container">
	<section class="container">
      <div class="page-header">
        <div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-sm-3">강의 관리 게시판</h2>
        
        <div class="mt-4 col-sm-2">
          <select class="form-select" id="typeSelector" name="typeSelector">
            	<option value="" disabled selected>카테고리</option>
            	<c:forEach items="${categoryList}" var="category">
          	  <option class="select-item" value="${category.no}">${category.name}</option>
            </c:forEach >
          </select>
        </div>
        <div class="col-4 mt-4">
          <div class="input-group">  
            <div class="form-outline">
              <input type="search" id="searchKeyword" name="searchKeyword" class="form-control"  placeholder="강의자 / 강의명" value="" required/>              
             </div>
            <button type="submit" class="btn btn-primary" id="searchBtn">
              <i class="fas fa-search"></i>
            </button>
          </div>
         </div>
        </div>
      </div>
	<table class="table mt-3 col-sm text-center">
	<thead class="thead-light">
	    <tr>
	      <th scope="col" name="no">글 번호</th>
	      <th scope="col" name="cat">카테고리</th>
	      <th scope="col" name="teacherId">강의자 아이디</th>
	      <th scope="col" name="site">강의 링크</th>
	      <th scope="col" name="etc">비고</th>
	    </tr>
	    <!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 하세요 -->
	<c:if test="${empty list}">
	<tr>
		<td colspan="14" style="text-align:center;">조회된 데이터가 없습니다.</td>
	 </tr>
	</c:if>
  </thead>
	<tbody>
	 	<c:if test="${not empty list}">
	 	<c:forEach items="${list}" var="lec" varStatus="vs">
	       <tr>
	          <td>${vs.count}</td>
	          <td>${lec.refMemberId}</td>
			  <td><a href="${pageContext.request.contextPath}/admin/manageLectureBoard.do?detail="\${lec.teacherLink}>${lec.teacherLink}</a></td>
	       	  <%--<td><a href="${pageContext.request.contextPath}/admin/manageLectureBoard.do">강의 상세보기</a></td> --%>
	          <td>
	          <%--<button type="button" class="btn btn-secondary btn-sm">취소</button> --%>
	             <button type="button" a class="btn btn-warning btn-sm" onclick="location.href='${pageContext.request.contextPath}/admin/rejectPlayingLecture.do?no=${lec.lectureNo}';">정지</button>
	          </td>
	        </tr>
	      </c:forEach>
		</c:if>
	</table>
	 <!-- 페이지 바 -->
	  <!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 -->
	 	<c:if test="${!empty list}">
		 <div>
		  ${pageBar}
		 </div>
		</c:if>
</div>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
