<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script>

//CORS를 위한 Origin 변수처리
const menuRestApiHost = "http://localhost:9090/codelit";

function displayResultTable(selector, data){
	const $container = $(selector);
	const $table = $("<table></table>").addClass("table");
	const $header = $("<tr><th>번호</th><th>음식점</th><th>메뉴명</th><th>가격</th><th>타입</th><th>맛</th></tr>")
	$table.append($header);
	
	if(data.length > 0){
		$(data).each((i, {id, restaurant, name, price, type, taste}) =>{
			const tr = `<tr>
				<td>\${id}</td>
				<td>\${restaurant}</td>
				<td>\${name}</td>
				<td>\${price}</td>
				<td>\${type}</td>
				<td>\${taste}</td>
			</tr>`; 
			$table.append(tr);
		});		
	}
	else {
		$table.append("<tr><td colspan='6'>조회된 결과가 없습니다.</td></tr>");
	}
	
	$container.html($table);
}

// 카테고리
$("#typeSelector").change(e => {
      	const type = $(e.target).val();
      	console.log(type); //사용자가 선택한 값이 잘 넘어오는지 확인
      	
      	$.ajax({
      		url: `\${menuRestApiHost}/menus/\${type}`,
      		dataType: "json",
      		success(data){
      			console.log(data);
      			displayResultTable("#menuType-result", data);
      		},
      		error(xhr, status, err){
      			console.log(xhr, status, err);
      		}
      	})
    });
	        


//검색

$( "#searchByAdmin" ).autocomplete({
     source : function(request, response){
    
   //ajax 호출
   $.ajax({
   	url:`${pageContext.request.contextPath}/board/searchByAdmin.do`,
       data : {
   	  	searchTitle : request.term
   	  	
   },
   	//method : "GET"   //기본값 -> 생략가능
   	//dataType : "json" //유연하게 처리해줌 -> 생략가능
   	 success(data){
   		//console.log(data);   //map ->기본 배열의 요소를 변형해서 새로운 배열 생성가능한 메소드
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
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="강의 관리 게시판" name="title"/>
</jsp:include>
<div class="container">
	<section class="container">
      <div class="page-header">
        <div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-sm-3">강의 관리 게시판</h2>
        
        <div class="mt-4 col-sm-2">
          <select class="form-select" id="typeSelector">
            <option value="" selected>카테고리</option>
            <option value="fe">프론트엔드</option>
            <option value="be">백엔드</option>
            <option value="dt">빅데이터</option>
          </select>
        </div>
        <div class="result" id="menuType-result"></div>
        
        <div class="col-4 mt-4">
          <div class="input-group">  
            <div class="form-outline">
              <input type="search" id="searchByAdmin" class="form-control"  placeholder="강의자 / 강의명"/>              
             </div>
            <button type="button" class="btn btn-primary">
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
