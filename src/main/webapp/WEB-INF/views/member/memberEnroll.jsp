<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원등록" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css" />

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
      <button type="submit" class="btn btn-primary col-5 mt-1 mb-2" id="google">구글 가입</button>
      <button type="submit" class="btn btn-primary col-5 mt-1 mb-1" id="kakao">카카오 가입</button>
    </div>

<%-- <div id="enroll-container" class="mx-auto text-center">
	<form 
		name="memberEnrollFrm" 
		action="${pageContext.request.contextPath}/member/memberEnroll.do" 
		method="post">
		<table class="mx-auto">
			<tr>
				<th>아이디</th>
				<td>
					<div id="memberId-container">
					<input type="text" 
						   class="form-control" 
						   placeholder="4글자이상"
						   name="id" 
						   id="id"
						   required>
						<span class="guide ok">이 아이디는 사용가능합니다.</span>
						<span class="guide error">이 아이디는 이미 사용중입니다.</span>
						<input type="hidden" id="idValid" value="0"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" class="form-control" name="password" id="password" required>
				</td>
			</tr>
			<tr>
				<th>패스워드확인</th>
				<td>	
					<input type="password" class="form-control" id="passwordCheck" required>
				</td>
			</tr>  
			<tr>
				<th>이름</th>
				<td>	
					<input type="text" class="form-control" name="name" id="name" required>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>		
					<input type="date" class="form-control" name="birthday" id="birthday"/>
				</td>
			</tr> 
			<tr>
				<th>이메일</th>
				<td>	
					<input type="email" class="form-control" placeholder="abc@xyz.com" name="email" id="email">
				</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>	
					<input type="tel" class="form-control" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>	
					<input type="text" class="form-control" placeholder="" name="address" id="address">
				</td>
			</tr>
			<tr>
				<th>성별 </th>
				<td>
					<div class="form-check form-check-inline">
						<input type="radio" class="form-check-input" name="gender" id="gender0" value="M">
						<label  class="form-check-label" for="gender0">남</label>&nbsp;
						<input type="radio" class="form-check-input" name="gender" id="gender1" value="F">
						<label  class="form-check-label" for="gender1">여</label>
					</div>
				</td>
			</tr>
			<tr>
				<th>취미 </th>
				<td>
					<div class="form-check form-check-inline">
						<input type="checkbox" class="form-check-input" name="hobby" id="hobby0" value="운동"><label class="form-check-label" for="hobby0">운동</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="hobby" id="hobby1" value="등산"><label class="form-check-label" for="hobby1">등산</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="hobby" id="hobby2" value="독서"><label class="form-check-label" for="hobby2">독서</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="hobby" id="hobby3" value="게임"><label class="form-check-label" for="hobby3">게임</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="hobby" id="hobby4" value="여행"><label class="form-check-label" for="hobby4">여행</label>&nbsp;
					 </div>
				</td>
			</tr>
		</table>
		<input type="submit" value="가입" >
		<input type="reset" value="취소">
	</form>
</div> --%>
<script>
$("#id").keyup(e => {
	const id = $(e.target).val();
	const $error = $(".guide.error");
	const $ok = $(".guide.ok");
	const $idValid = $("#idValid");
	
	//아이디 처음 작성하거나, 다시 작성하는 경우
	if(id.length < 4){
		$(".guide").hide();
		$idValid.val(0);
		return;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/checkIdDuplicate1.do",
		data: {id},
		success: data => {
			console.log(data);
			if(data.usable){
				$error.hide();
				$ok.show();
				$idValid.val(1);
			}
			else{
				$error.show();
				$ok.hide();
				$idValid.val(0);
			}
		},
		error: (xhr, status, err) => {
			console.log(xhr, status, err);
		}
	});
});
	
$("#passwordCheck").blur(function(){
	var $password = $("#password"), $passwordCheck = $("#passwordCheck");
	if($password.val() != $passwordCheck.val()){
		alert("패스워드가 일치하지 않습니다.");
		$password.select();
	}
});
	
/**
 * 회원 등록 유효성검사
 */
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
