
<%@ page pageEncoding="UTF-8" %>

<main>

  <section>
    <h1>회원정보변경</h1>

    <ul>
      <li>아이디</li>
      <li>${user.userId}</li>
    </ul>

    <ul>
      <li>비밀번호</li>
      <li>********</li>
      <li><input type="button" class="pwd" value="비밀번호 변경"></li>
    </ul>

    <div class="pwd hidden">
      <div><span>현재비밀번호</span><input type="text" id="currentPwd"></div>
      <div><span>신규비밀번호</span><input type="text" id="newPwd1"></div>
      <div><span>신규비밀번호 재입력</span><input type="text" id="newPwd2"></div>
      <div id="msgPwd" style="color: red"></div>
      <div>
        <input type="button" id="pwdCancel" value="취소">
        <input type="button" id="pwdComplete" value="완료">
      </div>
    </div>

    <ul>
      <li>이름(실명)</li>
      <li>${user.userName}</li>
      <li><input type="button" class="name" value="이름 변경"></li>
    </ul>

    <form action="<c:url value='/update/userName'/>" method="post" id="nameForm">
      <div class="name hidden">
        <div><span>이름 입력</span><input type="text" id="newName" name="newName"></div>
        <div id="msgName" style="color: red"></div>
        <div>
          <input type="button" id="nameCancel" value="취소">
          <input type="button" id="nameComplete" value="완료">
        </div>
      </div>
    </form>

    <script>
      $('#nameComplete')[0].addEventListener('click', function (){
        let test = /[!?@#$%^&*():;+-=~{}<>\_\[\]\|\\\"\'\,\.\/\`\₩]/g;
        let test2 = $('#newName')[0].value;
        if(test.test(test2)){
          $('#msgName')[0].innerHTML = "특수문자가 있어선 안됩니다.";
          $('#newName').focus();
          return;
        }

        if(test2.length < 1 || test2.length > 10){
          $('#msgName')[0].innerHTML = "1~10자 이내로 입력하셔야 합니다.";
          $('#newName').focus();
          return;
        }

        $('#nameForm').submit();
      })
    </script>

    <ul>
      <li>이메일</li>
      <li>${user.userEmail}</li>
      <li><input type="button" class="email" value="이메일 변경"></li>
    </ul>

    <form action="<c:url value='/update/userEmail'/>" method="post" id="emailForm">
      <div class="email hidden">
        <div><span>이메일 입력</span><input type="text" id="newEmail" name="newEmail"></div>
        <div id="msgEmail" style="color: red"></div>
        <div>
          <input type="button" id="emailCancel" value="취소">
          <input type="button" id="emailComplete" value="완료">
        </div>
      </div>
    </form>

    <script>
      $('#emailComplete')[0].addEventListener('click', function (){
        let test = /[a-z0-9]+@[a-z]+\.[a-z]{2,3}/g;
        let test2 = $('#newEmail')[0].value;
        if(test.test(test2)){
          $('#emailForm').submit();
        }else{
          $('#msgEmail')[0].innerHTML = "이메일 형식이 아닙니다.";
          $('#newEmail').focus();
        }
      })
    </script>

    <ul>
      <li>휴대전화</li>
      <li>${user.userPhone}</li>
      <li><input type="button" class="phone" value="휴대전화 변경"></li>
    </ul>

    <form action="<c:url value='/update/userPhone'/>" method="post" id="phoneForm">
      <div class="phone hidden">
        <div><span>휴대폰번호 입력</span><input type="text" id="newPhone" name="newPhone"></div>
        <div id="msgPhone" style="color: red"></div>
        <div>
          <input type="button" id="phoneCancel" value="취소">
          <input type="button" id="phoneComplete" value="완료">
        </div>
      </div>
    </form>

    <script>
      $('#phoneComplete')[0].addEventListener('click', function (){
        let test = /01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/;
        let test2 = $('#newPhone')[0].value;
        if(test.test(test2)){
          $('#PhoneForm').submit();
        }else{
          $('#msgPhone')[0].innerHTML = "핸드폰 번호를 확인해주세요.";
          $('#newPhone').focus();
        }
      })
    </script>

    <ul>
      <li>성별</li>
      <li>${user.userGender}</li>
    </ul>
  </section>

</main>
</body>
</html>

<style>
  .hidden {
    display: none;
  }
</style>




<script>
  const currentPwd = document.querySelector("#currentPwd");
  const newPwd1 = document.querySelector("#newPwd1");
  const newPwd2 = document.querySelector("#newPwd2");
  const msgPwd = document.querySelector("#msgPwd");

  document.getElementsByTagName("main")[0].addEventListener('click', function (e) {
    if (e.target.getAttribute('type') != 'button') return;
    if(e.target.value == '취소'){
      $('.'+e.target.id.replace("Cancel", ""))[0].classList.remove('hidden');
      $('.'+e.target.id.replace("Cancel", ""))[1].classList.add('hidden');
    }else if(e.target.value == '완료'){
      return;
    }else visible(e.target);
  })

  function visible(object) {
    $('.'+object.className)[1].classList.remove('hidden');
    hidden(object.className);
    object.classList.add('hidden');
  }

  document.querySelector("#pwdComplete").addEventListener('click',function(){
    //신규 비밀번호 형식이 안맞을경우
    let reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/g;
    let txt =  $('#newPwd1')[0].value;
    if( !reg.test(txt) ) {
      msgPwd.innerHTML = "8자 이상 숫자,특수문자,영문자가 하나씩 포합되어야합니다.";
      return;
    }

    //현재 비밀번호와 신규비밀번호가 같을경우
    if (currentPwd.value == newPwd1.value){
      msgPwd.innerHTML = "현재비밀번호와 신규비밀번호가 같습니다.";
      return;
    }

    //신규비밀번호 안맞을경우
    if (newPwd1.value!=newPwd2.value){
      msgPwd.innerHTML = "신규 비밀번호가 다릅니다";
      return;
    }
    $.ajax({
      type:'POST',
      url: '/meal/update/userPwd',
      headers: {"content-type":"apllication/json"},
      dataType: 'text',
      data:JSON.stringify(currentPwd.value+"/"+newPwd1.value),
      success: function (result){
        if(result==0) alert("비밀번호가 변경되지 않았습니다.")
        location.reload();
        if(result==1) alert("비밀번호가 변경되었습니다.")
        if (result==2) msgPwd.innerHTML = "현재 비밀번호가 맞지 않습니다";
        else {
          $('.pwd')[0].style.display = 'inline-block'
          $('.pwd')[1].style.display = 'none'
        }
      },
      error: function(){alert("error : ")}
    })
  });

  function hidden(name) {
    $('.pwd')[0].classList.remove('hidden');
    $('.name')[0].classList.remove('hidden');
    $('.email')[0].classList.remove('hidden');
    $('.phone')[0].classList.remove('hidden');

    $('.pwd')[1].classList.add('hidden');
    $('.name')[1].classList.add('hidden');
    $('.email')[1].classList.add('hidden');
    $('.phone')[1].classList.add('hidden');
    $('.'+name)[1].classList.remove('hidden');
  }

</script>
