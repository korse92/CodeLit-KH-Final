<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

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
        height: 70rem;
        margin-right: 2rem;
      }
      #right {
        width: 30rem;
        height: 70rem;
        border: 1px solid black;
      }

    </style>

	<script>
		
	window.onload = function() {
		
		// 파일 가져오는 비동기 요청 -> blob url 생성 -> video src에 삽입
		const lectureVideo = document.getElementById("lectureVideo");
		
		loadXHR('test.mp4')
		.then(blobUrlCreator)
		.then(url => {
			lectureVideo.src = url;
		});
		
	}

  </script>



	<div class="container d-flex">

        <div id="left">
          <h3 class="mt-5" id="lectureTitle">강의 제목 자리</h3>
          <h4 class="mt-5" id="videoTitle">영상 제목 자리</h4>
  
            <video id="lectureVideo" src="" controlsList="nodownload" controls>
            </video>

        </div>

        <div id="right">
	          
		   <!--
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
	          </script>
			-->

				<div class="tab-pane fade" id="curriculum" role="tabpanel"
					aria-labelledby="profile-tab">
					<button id="allCollapseBtn"
						class="btn btn-primary d-block ms-auto mb-3" type="button" data-bs-toggle="collapse"
						data-bs-target=".accordion-collapse" aria-expanded="false">모두 펼치기 / 접기</button>
					<div class="accordion" id="curriculumAccordionPanels">
						<c:forEach items="${lecture.partList}" var="part" varStatus="pvs">
						<div class="accordion-item">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#collapseChapterOfPart${part.lecturePartNo}"
									aria-expanded="false" aria-controls="collapseChapterOfPart${part.lecturePartNo}">
									<i class="fas fa-bars me-3"></i>
									<span>파트 ${pvs.count }. ${part.lecturePartTitle}</span>
									<span class="badge bg-primary ms-2">${part.chepterList.size()}</span>
								</button>
							</h2>
							<div id="collapseChapterOfPart${part.lecturePartNo}"
								class="accordion-collapse collapse"
								aria-labelledby="partPanel${part.lecturePartNo}">
								<div class="accordion-body px-0">
									<ul class="list-group-flush p-0 m-0">
										<c:forEach items="${part.chepterList}" var="chapter" varStatus="cvs">
										<li class="list-group-item">
											<i class="fas fa-play-circle"></i>
											<span>챕터 ${cvs.count}. ${chapter.lecChapterTitle}</span>
										</li>
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