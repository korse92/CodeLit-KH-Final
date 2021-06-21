
	
/**
*	서버의 동영상을 비동기요청을 통해, 응답(blob타입)으로부터 blob url을 생성하고
*	video.src에 적용하여 재생
*/

// blob url 생성 함수
const blobUrlCreator = blob => {
	const url = window.URL.createObjectURL(blob);
	return url;
};
  

// 동영상 불러오는 함수
function loadXHR(url) {
	
	return new Promise((resolve, reject) => {
		try {
			const xhr = new XMLHttpRequest();
			//xhr.open("GET", "http://localhost:9090/codelit/resources/upload/lecture/mp4/" + url);
			xhr.open("GET", getContextPath() + "/resources/upload/lecture/mp4/" + url);
			xhr.responseType = "blob";
			xhr.onerror = event => {
				reject(`Network error : ${event}`);
			};
			xhr.onload = () => {
          		if (xhr.status === 200) {
			    	resolve(xhr.response);
				} else {
			    	reject(`XHR load error: ${xhr.statusText}`);
			    }
			};
			xhr.send();
		} catch(err) {
			reject(err.message);
		}
	});
	
}	// function loadXHR(url)
	
