<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
    <script src="https://apis.google.com/js/api:client.js"></script>
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
	    attachSignin(document.getElementById('google'));
	  });
	};
	
	function attachSignin(element) {
	  console.log(element.id);
	  auth2.attachClickHandler(element, {},
	      function(googleUser) {
		  console.log(googleUser.getBasicProfile().getName());
		  console.log(googleUser.getBasicProfile().getEmail());
	        document.getElementById('name').innerText = "Signed in: " +
	            googleUser.getBasicProfile().getName();
	      }, function(error) {
	        alert(JSON.stringify(error, undefined, 2));
	      });
	}
	
/* 	var onSignIn = function(googleUser) {
		  var profile = googleUser.getBasicProfile();
		  console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
		  console.log('Name: ' + profile.getName());
		  console.log('Image URL: ' + profile.getImageUrl());
		  console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
		}; */
	</script>
</head>

  <section class="container-signup">
    <h5>회원가입</h5>

    <!-- 메일/비밀번호 입력 -->
    <div class="signup-input">
      <form name="memberEnrollFrm" 
      		action="${pageContext.request.contextPath}/member/memberEnroll.do" 
      		method="POST" 
      		class="signupFrm">
        <!-- 이메일 -->
        <div class="row mb-3">
          <label for="id" class="col-sm-3 col-form-label">이메일(아이디)</label>
          <div class="col-sm-9" id="memberId">
            <input type="text" class="form-control" id="id" name="id" required>
            <span class="guide ok">이 아이디는 사용 가능합니다.</span>
            <span class="guide no">이 아이디는 이미 사용중입니다.</span>
            <input type="hidden" id=idValid" value="0"/>
          </div>
        </div>
        <div class="row mb-3">
          <label for="chkId" class="col-sm-3 col-form-label">이메일 확인</label>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="chkId" required>
          </div>
        </div>
        <!-- 비밀번호 -->
        <div class="row mb-3">
          <label for="password" class="col-sm-3 col-form-label">비밀번호</label>
          <div class="col-sm-9">
            <input type="password" class="form-control" id="password" name="password" required>
          </div>
        </div>
        <div class="row mb-3">
          <label for="chkPassword" class="col-sm-3 col-form-label">비밀번호 확인</label>
          <div class="col-sm-9">
            <input type="password" class="form-control" id="chkPassword" required>
          </div>
        </div>
        <button type="submit" class="btn btn-primary col-12 mt-3 mb-5" id="submit">가입하기</button>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      </form>

    </div>


    <!-- 소셜 연동 가입 -->
    <div class="social">
      <button type="submit" class="btn btn-primary col-5 mt-1 mb-2" data-onsuccess="onSignIn" id="google">구글 가입&nbsp;<i class="fab fa-google-plus-g"></i></button>
    	<div id="name"></div>
  		<script>startApp();</script>
  		<!-- <script>onSignIn();</script> -->
      <button type="submit" class="btn btn-primary col-5 mt-1 mb-1" id="kakao">카카오 가입&nbsp;<img src="${pageContext.request.contextPath}/resources/images/kakao.png"
						alt="" style="width: 15px;"></button>
    </div>
  </section>

<script>
/* 아이디 중복 확인 */
$("#id").keyup(e => {
	const id = $(e.target).val();
	const $no = $(".guide.no");
	const $ok = $(".guide.ok");
	const $idValid = $("#idValid");
	
	//아이디 처음 작성하거나, 다시 작성하는 경우
	if(id.length < 4){
		$(".guide").hide();
		$idValid.val(0);
		return;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/chkIdDupl.do",
		data: {id},
		success: data => {
			console.log(data);
			if(data.usable){
				$no.hide();
				$ok.show();
				$idValid.val(1);
			}
			else{
				$no.show();
				$ok.hide();
				$idValid.val(0);
			}
		},
		error: (xhr, status, err) => {
			console.log(xhr, status, err);
		}
	});
});

/* 아이디 확인 */
$("#chkId").blur(function(){
	var $id = $("#id"), $chkId = $("#chkId");
	if($id.val() != $chkId.val()){
		alert("아이디가 일치하지 않습니다.");
		$id.select();
	}
});
/* 패스워드 확인 */
$("#chkPassword").blur(function(){
	var $password = $("#password"), $chkPassword = $("#chkPassword");
	if($password.val() != $chkPassword.val()){
		alert("패스워드가 일치하지 않습니다.");
		$password.select();
	}
});
/* 회원 등록 유효성 검사 */
$("[name=memberEnrollFrm]").submit(function(){
	var $id = $("#id");
	if(/^\w{4,}$/.test($id.val()) == false) {
		alert("아이디는 최소 4자리이상이어야 합니다.");
		$id.focus();
		return false;
	}
	//중복검사여부
	var $idValid = $("#idValid");
	if($idValid.val() == 0){
		alert("아이디 중복 검사해주세요.");
		return false;
	}
	
	return true;
});
</script>  

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>