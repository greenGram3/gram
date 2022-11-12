
<%@ page pageEncoding="UTF-8" %>

  <main>
    <form action="<c:url value="/login/login"/>" method="post" onsubmit="return formCheck(this)">
      <h3 id="title">Login</h3>
      <div id="msg">
        <c:if test="${not empty param.msg}">
          ${param.msg}</i>
        </c:if>
      </div>
      아이디<input type="text" name="userId" value="${cookie.userId.value}" placeholder="아이디 입력" autofocus>
     비밀번호<input type="password" name="userPwd" placeholder="비밀번호">
      <button>로그인</button>
      <div>
        <label><input type="checkbox" name="rememberId" value="on" ${empty cookie.userId.value ? "":"checked"}> 아이디 저장</label> |
        <a href="">아이디 찾기</a>
        <a href="">비밀번호 찾기</a>
        <a href="<c:url value="/register/register"/> ">회원가입</a>
      </div>
      <script>
        function formCheck(frm) {
          if(frm.userId.value.length==0) {
            setMessage('id를 입력해주세요.', frm.userId);
            return false;
          }
          if(frm.userPwd.value.length==0) {
            setMessage('password를 입력해주세요.', frm.userPwd);
            return false;
          }
          return true;
        }
        function setMessage(msg, element){
          document.getElementById("msg").innerHTML = msg;
          if(element) {
            element.select();
          }
        }
      </script>
    </form>
  </main>
  </body>
</html>
