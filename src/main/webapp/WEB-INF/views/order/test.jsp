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

<!-- 컨텐츠 시작 -->
		
	<script>
	
		window.onload = function() {
			
			var xhr = new XMLHttpRequest();
			xhr.responseType = 'blob';
			xhr.onload = function() {
	
	// 			xhr.open("GET", "${pageContext.request.contextPath}/resources/upload/notice/test.mp4", true);
				xhr.open("GET", "${pageContext.request.contextPath}/order/video.do", true);
				xhr.responseType = "blob";
				xhr.onreadystatechange = function () {
				  if (xhr.readyState == xhr.DONE) {
					var blob = xhr.reponse;
					console.log(xhr.response);
					var video = URL.createObjectURL(blob);
					
					var videotest = document.getElementById("videotest");
					videotest.src = video;
					console.log(videotest);
					console.log(video);
				  }
				}
				xhr.send();
	
			}
		
			
// 			var video = URL.createObjectURL(${blob});
// 			var videotest = document.getElementById("videotest");
// 			videotest.src = video;
		}
	
	</script>
	

<!-- 개인 CSS, JS 위치 -->

	<div class="container">
	
		<video id="videotest" src="" style="width:20rem; height:15rem; border:1px solid black;">
		</video>
	
<%-- 		<form:form method="post" enctype="multipart/form-data" --%>
<%-- 			action="${pageContext.request.contextPath}/order/testInPayment.do"> --%>
			
<!-- 			<input type="file" name="upFile" /> -->
<!-- 			<button type="submit" class="btn btn-primary">업로드</button> -->
<%-- 		</form:form> --%>

		  <button id="btn">영상요청</button>
		  <video src="" id="remote-video" controls></video>
		  
		  <script>
		  /**
		   * 서버의 sample.mp4 비동기요청을 통해, 응답(blob타입)로부터 blob url을 생성하고 
		   * video.src에 적용해서 재생
		   */
		  const blobUrlCreator = blob => {
			    const url = window.URL.createObjectURL(blob);
			    return url;
		  };
		   
		  const btn = document.querySelector("#btn");
		  const remoteVideo = document.querySelector("#remote-video");
		  btn.addEventListener('click', () => {
		    loadXHR('${pageContext.request.contextPath}/resources/upload/notice/test.mp4')
		    .then(blobUrlCreator)
		    .then(url => {
		      remoteVideo.src = url;
		    });
		  });
		  function loadXHR(url) {
		    return new Promise((resolve, reject) => {
		      try {
		        const xhr = new XMLHttpRequest();
		        xhr.open("GET", url);
		        xhr.responseType = "blob";
		        xhr.onerror = event => {
		          reject(`Network error: ${event}`);
		        };
		        xhr.onload = () => {
		          if (xhr.status === 200) {
		            resolve(xhr.response);
		          } else {
		            reject(`XHR load error: ${xhr.statusText}`);
		          }
		        };
		        xhr.send();
		      } catch (err) {
		        reject(err.message);
		      }
		    });
		  }

  </script>



	</div>





<!-- 컨텐츠 끝 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>