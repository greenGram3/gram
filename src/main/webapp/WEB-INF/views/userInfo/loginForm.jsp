<%@ page contentType="text/html;charset=UTF-8"  language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>

<script>
let alertMsg = "${alertMsg}";
if(alertMsg == "wrongAccess") alert("비정상적인 접근입니다.")
</script>

<head>
    <title>login</title>
    <link rel="stylesheet" href="<c:url value='/css/loginForm.css'/>">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

</head>
<jsp:include page="../include/header.jsp" flush="false" />
<body>
<main>
    <div class="loginForm">
        <h1 id="title">로그인</h1>
        <form action="<c:url value="/login/login"/>" method="post" onsubmit="return formCheck(this)">
            <div class="login">
                <p>회원 로그인</p><c:if test="${not empty param.msg}"> ${param.msg}
            </c:if>
                <div class="memberLogin">
                    <div class="memberLoginDetail">
                        <li>　아이디　<input type="text" name="userId" value="${cookie.userId.value}" placeholder="　아이디 입력" autofocus></li>
                        <li>　비밀번호　<input type="password" name="userPwd" placeholder="　비밀번호">　</li>　
                        <input type="hidden" name="requestURI" value="${requestURI}">
                    </div>
                    <button>로그인</button></div>
                <div class="rememberId">
                    <label>
                        <input type="checkbox" name="rememberId" value="on" ${empty cookie.userId.value ? "":"checked"}>　아이디 저장　</label>
                </div>

                <a href="<c:url value="/login/naverLogin2"/>">
                    <div id="naverLogin">
                        <li><img src="<c:url value='/icon/naver.png'/>" alt="naver"></li>
                        <li>네이버 아이디로 로그인</li>
                    </div>
                </a>

                <div class="memberCheck">
                    <a href="">아이디 찾기</a>
                    <a href="">비밀번호 찾기</a>
                    <a href="<c:url value="/register/register"/> ">회원가입</a>
                </div>
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
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>
