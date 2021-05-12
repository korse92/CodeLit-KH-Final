<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css" />

<!-- Font Awesome(아이콘) CSS -->
<script src="https://kit.fontawesome.com/0e3c91e1c6.js" crossorigin="anonymous"></script>


<head>
    <meta charset="utf-8" />
    <meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="58001672943-vf21bvk8p312h3gs59o3p1m7geopjpl9.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
</head>
	<script>
	  var googleUser = {};
	  var startApp = function() {
	    gapi.load('auth2', function(){
	      // Retrieve the singleton for the GoogleAuth library and set up the client.
	      auth2 = gapi.auth2.init({
	        client_id: '58001672943-vf21bvk8p312h3gs59o3p1m7geopjpl9.apps.googleusercontent.com',
	        cookiepolicy: 'single_host_origin',
	        // Request scopes in addition to 'profile' and 'email'
	        //scope: 'additional_scope'
	      });
	      attachSignin(document.getElementById('customBtn'));
	    });
	  };
	
	  function attachSignin(element) {
	    console.log(element.id);
	    auth2.attachClickHandler(element, {},
	        function(googleUser) {
	          document.getElementById('name').innerText = "Signed in: " +
	              googleUser.getBasicProfile().getName();
	        }, function(error) {
	          alert(JSON.stringify(error, undefined, 2));
	        });
	  }
	  </script>
	  <style type="text/css">
    #customBtn {
      display: inline-block;
      background: white;
      color: #444;
      width: 190px;
      border-radius: 5px;
      border: thin solid #888;
      box-shadow: 1px 1px 1px grey;
      white-space: nowrap;
    }
    #customBtn:hover {
      cursor: pointer;
    }
    span.label {
      font-family: serif;
      font-weight: normal;
    }
    span.icon {
      background: url('/identity/sign-in/g-normal.png') transparent 5px 50% no-repeat;
      display: inline-block;
      vertical-align: middle;
      width: 42px;
      height: 42px;
    }
    span.buttonText {
      display: inline-block;
      vertical-align: middle;
      padding-left: 42px;
      padding-right: 42px;
      font-size: 14px;
      font-weight: bold;
      /* Use the Roboto font that is loaded in the <head> */
      font-family: 'Roboto', sans-serif;
    }
  </style>

<section class="container-signup">
    <h5>회원가입</h5>

    <!-- 메일/비밀번호 입력 -->
    <div class="signup-input">
      <form action="#" method="POST" class="signupFrm">
        <div class="row mb-3">
          <label for="inputEmail" class="col-sm-3 col-form-label">이메일(아이디)</label>
          <div class="col-sm-9">
            <input type="email" class="form-control" id="inputEmail">
          </div>
        </div>
        <div class="row mb-3">
          <label for="chkEmail" class="col-sm-3 col-form-label">이메일 확인</label>
          <div class="col-sm-9">
            <input type="email" class="form-control" id="chkEmail">
          </div>
        </div>
        <div class="row mb-3">
          <label for="inputPassword" class="col-sm-3 col-form-label">비밀번호</label>
          <div class="col-sm-9">
            <input type="password" class="form-control" id="inputPassword">
          </div>
        </div>
        <div class="row mb-3">
          <label for="chkPassword" class="col-sm-3 col-form-label">비밀번호 확인</label>
          <div class="col-sm-9">
            <input type="password" class="form-control" id="chkPassword">
          </div>
        </div>
        <button type="submit" class="btn btn-primary col-12 mt-3 mb-5">가입하기</button>
      </form>

    </div>


    <!-- 소셜 연동 가입 -->
    <div class="social">
      <button type="submit" class="btn btn-primary col-5 mt-1 mb-2" id="customBtn">구글 가입&nbsp;<i class="fab fa-google-plus-g"></i></button>
      <button type="submit" class="btn btn-primary col-5 mt-1 mb-1" id="kakao">카카오 가입&nbsp;<img src="${pageContext.request.contextPath}/resources/images/kakao.png"
						alt="" style="width: 15px;"></button>
    </div>
    


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
