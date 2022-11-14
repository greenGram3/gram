<%@ page contentType="text/html;charset=UTF-8"  language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<!DOCTYPE html>
<html>
<head>
    <title>orderList</title>
    <link rel="stylesheet" href="<c:url value='/css/loginForm.css'/>">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

</head>
<%@include file="include/header.jsp"%>
<body>
<main>
    <div class="loginForm">
        <h1 id="title">로그인</h1>
        <form action="<c:url value="/login/login"/>" method="post" onsubmit="return formCheck(this)">
            <div class="login">
                <p>회원 로그인</p><c:if test="${not empty param.msg}"> ${param.msg}</i>
            </c:if>
                <div class="memberLogin">
                    <div class="memberLoginDetail">
                        <li>　아이디　<input type="text" name="userId" value="${cookie.userId.value}" placeholder="　아이디 입력" autofocus></li>
                        <li>　비밀번호　<input type="password" name="userPwd" placeholder="　비밀번호">　</li>　
                    </div>
                    <button>로그인</button></div>
                <div class="rememberId">
                    <label>
                        <input type="checkbox" name="rememberId" value="on" ${empty cookie.userId.value ? "":"checked"}>　아이디 저장　</label>
                </div>
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
<%@include file="include/footer.jsp"%>
</body>
</html>
