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
	/*	
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
    }); */
    
 //유효성 검사
/*  $("#searchBtn").click(e => {
	 //폼 제출 방지
	  e.preventDefault();
	 
	const typeSelector = $("[name=typeSelector]", e.target).val();
	const searchKeyword = $("[name= searchKeyword]", e.target).val();
	 
	if(!typeSelector || !searchKeyword){
		alert("검색어를 입력해주세요.");
		return;
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
	
	
	/*  $(typeSelector).change(e => {
		console.log(e.target.value);
		//href="${pageContext.request.contextPath}/admin/manageLectureBoard.do/${category.no}";
	});  */
	
	/* const searchBtn = document.getElementById("searchBtn");
	searchBtn.addEventListener('click', function(e) {
		
		var searchKeyword = document.getElementById("searchKeyword").value;
		location.href=`${pageContext.request.contextPath}/admin/manageMember.do?keyword=\${searchKeyword}`;
	}); */
	
};         






</script>

<!-- 컨텐츠 시작 -->
<div class="container">
	<div class="mt-5">
		<h2 class=" jb-larger mt-3">강의 관리</h2>

		<form method="GET" id="searchFrm"
			action="${pageContext.request.contextPath}/admin/manageLectureBoard.do">
			<div class="row mt-5 ms-1">
			
				<div class="col-sm-2">
					<select class="form-select" id="category" name="category">
						<option selected disabled>카테고리</option>
						<c:forEach items="${categoryList}" var="category">
							<option value="${category.no}" ${param.category eq category.no ? 'selected' : ''}>${category.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-2">
					<select class="form-select" id="searchType" name="searchType">
						<option selected disabled>검색</option>
						<option value="ref_member_id"  ${param.searchType eq 'ref_member_id' ? 'selected' : ''}>강의자</option>
						<option value="lecture_name"   ${param.searchType eq 'lecture_name' ? 'selected' : ''}>강의명</option>
					</select>
				</div>
				<div class="col-sm-4">
					<div class="input-group">
						<div class="form-outline">
							<input type="search" id="searchKeyword" name="searchKeyword"
								class="form-control" placeholder="강의자 / 강의명" />
						</div>
						<button type="submit" class="btn btn-primary" id="searchBtn">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</div>

			</div>
		</form>


		<table class="table mt-3 col-sm text-center">
			<thead class="thead-light">
				<tr>
					<th scope="col">글 번호</th>
					<th scope="col">카테고리</th>
					<th scope="col">강의자 아이디</th>
					<th scope="col">강의명</th>
					<th scope="col">강의 링크</th>
					<th scope="col">비고</th>
				</tr>
				<!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 하세요 -->
				<c:if test="${empty lecBoardList}">
					<tr>
						<td colspan="14" style="text-align: center;">조회된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</thead>
			<tbody>
				<c:if test="${not empty lecBoardList}">
					<c:forEach items="${lecBoardList}" var="lec" varStatus="vs">
						<tr>
							<td>${vs.count}</td>
							<td>
								<c:forEach items="${categoryList}" var="category">
									<c:if test="${lec.lecCatNo eq category.no}">
										${category.name}
				  					</c:if>
								</c:forEach>
							</td>
							<td>${lec.refMemberId}</td>
							<td>${lec.lectureName}</td>
							<td><a href="${pageContext.request.contextPath}/admin/manageLectureBoard.do?detail=${lec.teacherLink}">강의 상세 페이지</a></td>
							<td>
								<button
									type="button" 
									class="btn btn-warning btn-sm"
									onclick="location.href='${pageContext.request.contextPath}/admin/rejectPlayingLecture.do?no=${lec.lectureNo}';">
								정지
								</button>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		<!-- 페이지 바 -->
		<!-- 조회된 데이터가 있는 경우와 없는 경우를 분기처리 -->
		<c:if test="${!empty lecBoardList}">
			<div>${pageBar}</div>
		</c:if>
	</div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
