<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link rel='stylesheet prefetch' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.2/css/font-awesome.min.css'>
    <style>
        #map {
            width: 100%; height: 100vh;
            position: absolute;
            top: 0; left: 0;
            z-index: 0;
        }
    </style>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a548dc6d5b22802d185f641807cca585"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css' />">

</head>
<body>
  <!-- 모달 창 -->
  <div class="modalBody">
 <div id="myModal" class="modal" style="z-index: 10;">
    <div class="modal-content">
      <span class="close" id="closeBtn" style="visibility:hidden;">&times;</span>
      <div class="logo"></div>
      <form action="${pageContext.request.contextPath}/login" method="POST" class="my-login-validation" novalidate="">

             
        <div class="form-group">
          <input id="email" type="email" class="form-control" name="email" value="" placeholder="ID@example.com" required autofocus>
<span id="email-error" class="errMsg" style="display:none; position: absolute;">올바른 형식의 이메일이 아닙니다.</span>
        </div>
        

       <div class="form-group">  
          <input id="password" type="password" class="form-control" name="password" placeholder="Password" required data-eye>
          <div id="keyShow" style="  position: absolute;
    right: 95px;
    top: 335px;
    cursor: pointer;
     user-select: none;">👁️</div>
          
          
          <div class="custom-checkbox" style="padding-top: 5px;">
<label class='checkbox' style="    padding-top: 5px;">
          <input type="checkbox"/>
            <span class="icon"></span>
              <span class="text" style="font-size: 10px; padding-left: 10px;"> 비밀번호 기억하기</span>
          </label>
          </div>
        </div>

        <div class="form-group m-0">
          <input type="submit" class="logBtn" value="로 그 인">

        </div>
              <div class="social-links" style="padding-top: 30px;">
          <div>
            <a href="/kakaologin" style="height: 60px;"><i class="kakao" aria-hidden="true"><img src="/resources/imgs/kakaolog.png" class="btn" alt="Kakao Login"></i></a>
          </div>
          <div>
            <a href="#" style="height: 60px;"><i class="naver" aria-hidden="true"><img src="/resources/imgs/naverlog.png" class="btn" alt="NAVER Login" ></i></a>
          </div>
          <div>
            <a href="#" style="height: 60px;"><i class="google" aria-hidden="true"><img src="/resources/imgs/googlelog.png" class="btn" alt="google Login"></i></a>
          </div>
        </div>

        <div class="mt-3" style="    padding-top: 20px;">
          <a href="registerPage" style="margin-left: 110px;">회원가입</a>
             <a href="#" class="float-right">
              비밀번호 찾기
            </a>
        </div>
        
      </form>
    </div>
  </div>
</div>
<!-- 모달에 해당되는 코드입니다. -->
<!-- 아래로는 메인의 코드입니다. -->
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript">
    //모달에 해당되는 스크립트입니다.
    // HTML 문서의 로딩이 완료되었을 때, 해당 함수를 실행
document.addEventListener("DOMContentLoaded", function () {
  // elements
  var modal = document.getElementById("myModal");
  var closeBtn = document.getElementById("closeBtn");
  var emailInput = document.getElementById("email");
  var emailError = document.getElementById("email-error");
  var passwordInput = document.getElementById("password");
  var keyShow = document.getElementById("keyShow");

  // 정규식
  var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;

  // functions
  function toggleModal() {
    modal.classList.toggle("show");
  }

  function togglePasswordVisibility() {
    if (passwordInput.type === "password") {
      passwordInput.type = "text";
      keyShow.innerHTML = "🙈";
    } else {
      passwordInput.type = "password";
      keyShow.innerHTML = "👁️";
    }
  }

  // events
  closeBtn.addEventListener("click", toggleModal);
  keyShow.addEventListener("click", togglePasswordVisibility);

  emailInput.addEventListener("blur", function () {
    if (emailInput.value && !emailRegex.test(emailInput.value)) {
      emailError.style.display = "block";
    } else {
      emailError.style.display = "none";
    }
  });

  // 모달 자동 열기
  toggleModal();
});

</script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="<c:url value='/resources/js/index.js'/>"></script>
</body>
</html>