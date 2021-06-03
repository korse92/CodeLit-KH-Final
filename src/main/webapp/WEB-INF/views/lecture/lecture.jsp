<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>	

<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title" />
</jsp:include>

<script src="${pageContext.request.contextPath}/resources/js/lecture.js"></script>

<!-- 컨텐츠 시작 -->

<!-- 개인 CSS, JS 위치 -->
    <style>
      video {
        width: 50rem;
        height: 30rem;
      }
      #lectureTitle {
        padding : 1rem;
        border: 1px solid #b8b5ff;
        background-color: #b8b5ff;
        border-radius: 1rem;
      }

      #left {
        width: 50rem;
        min-height: 50rem;
        margin-right: 2rem;
      }
      #right {
        width: 30rem;
        min-height: 50rem;
/*         border: 1px solid black; */
      }

	  .chap {
	  	text-decoration: none;
	  }
    </style>

	<script>
		
	window.onload = function() {
		
		// 파일 가져오는 비동기 요청 -> blob url 생성 -> video src에 삽입
		const lectureVideo = document.getElementById("lectureVideo");
		
		loadXHR("${videoRename}")
		.then(blobUrlCreator)
		.then(url => {
			lectureVideo.src = url;
		});
		
		   /*
	          <script>
	              var xhr = new XMLHttpRequest();
	              xhr.open("GET", "test.mp4", true);
	              xhr.responseType = "blob";
	              xhr.onreadystatechange = function () {
	                if (xhr.readyState == xhr.DONE) {
	                  var blob = xhr.reponse;
	                  var video = URL.createObjectURL(blob);
	                }
	              }
	              xhr.send();
			*/
	}

  </script>



	<div class="container d-flex">

        <div id="left">
          <h3 class="mt-5" id="lectureTitle">${lecture.lectureName}</h3>
          <h4 class="mt-5 mb-2" id="videoTitle">
          	<%-- 파트 --%>
          	<c:forEach items="${lecture.partList}" var="part" varStatus="pvs">
	          	<%-- 챕터 --%>
	          	<c:forEach items="${part.chepterList}" var="chapter" varStatus="cvs">
	          		<c:if test="${playPosition eq chapter.lecChapterNo}">
		          		파트 ${pvs.count} 챕터 ${cvs.count}. ${chapter.lecChapterTitle}
	          		</c:if>
	          	</c:forEach>
          	</c:forEach>
          </h4>
  
            <video id="lectureVideo" src="" controlsList="nodownload" controls>
            </video>

        </div>

        <div id="right">

				<!-- 우측 커리큘럼 파트 -->
				<div  id="curriculum" class="mt-5">
				
					<!--  전체 접기/펴기 버튼 -->
					<button id="allCollapseBtn"
						class="btn btn-primary d-block ms-auto mb-3" type="button" data-bs-toggle="collapse"
						data-bs-target=".accordion-collapse" aria-expanded="false">모두 펼치기 / 접기</button>
					
					<!-- 커리큘럼 몸통 -->
					<div class="accordion" id="curriculumAccordionPanels">
						<c:forEach items="${lecture.partList}" var="part" varStatus="pvs">
						<div class="accordion-item">
						
								<!-- 파트 -->
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#collapseChapterOfPart${part.lecturePartNo}"
									aria-expanded="false" aria-controls="collapseChapterOfPart${part.lecturePartNo}">
									<i class="fas fa-bars me-3"></i>
									<span>파트 ${pvs.count}. ${part.lecturePartTitle}</span>
									<span class="badge bg-primary ms-2">${part.chepterList.size()}</span>
								</button>
							
							<!-- 파트당 내부 챕터들 -->
							<div id="collapseChapterOfPart${part.lecturePartNo}"
								class="accordion-collapse collapse"
								aria-labelledby="partPanel${part.lecturePartNo}">
								<div class="accordion-body px-0">
									<ul class="list-group-flush p-0 m-0">
										<c:forEach items="${part.chepterList}" var="chapter" varStatus="cvs">
										<a class="chap" href="${pageContext.request.contextPath}/lecture/lecture.do?lectureNo=${lecture.lectureNo}&chapterNo=${chapter.lecChapterNo}">
											<li class="list-group-item d-flex">
												<i class="fas fa-play-circle me-1"></i>
												<span>챕터 ${cvs.count}. ${chapter.lecChapterTitle}</span>
												<c:forEach items="${progList}" var="prog">
													<c:if test="${prog.chapterNo eq chapter.lecChapterNo 
																	and prog.yn eq 'Y'}">
														<span class="text-primary fs-5 ms-auto">수강</span>
													</c:if>
												</c:forEach>
											</li>
										</a>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>
						</c:forEach>
					</div>
				</div>
				
        </div> <!-- div#right -->

	</div> <!-- container -->



<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>