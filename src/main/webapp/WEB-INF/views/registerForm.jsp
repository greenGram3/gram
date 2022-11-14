<%@ page contentType="text/html;charset=UTF-8"  language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <title>orderList</title>
    <link rel="stylesheet" href="<c:url value='/css/registerForm.css'/>">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>

<body>

<%@include file="include/header.jsp"%>

<main>
    <div class="registerForm">
        <h1>회원가입</h1>
        <hr>

        <form:form modelAttribute="userVO" method="post">
            <label for="">아이디　</label>
            <input type="text" id="userId" name="userId" placeholder="　아이디(6~12자 이내, 특수문자 사용 불가)" style="width: 300px">　
            <button type="button" id="dupliCheck">중복검사</button>
            <form:errors path="userId" cssClass="class" cssStyle="color: red" />
            <br>
            <hr>

            <label for="">이름　</label>
            <input type="text" id="" name="userName" placeholder="　이름(1~10자 이내, 특수문자 사용불가)" style="width: 300px">
            <form:errors path="userName" cssClass="class" cssStyle="color: red"></form:errors>
            <br>
            <hr>
            <label for="">이메일　</label>
            <input type="text" id="" name="userEmailArr"> @ <input type="text" id="selectedEmail" name="userEmailArr" value="">
            <select id="selectEmail">
                <option value="직접입력" selected>　직접입력</option>
                <option value="naver.com">naver.com</option>
                <option value="daum.net">daum.net</option>
                <option value="gmail.com">gmail.com</option>
                <option value="nate.com">nate.com</option>
            </select>
            <form:errors path="userEmail" cssClass="class" cssStyle="color: red"></form:errors>
            <br>
            <hr>
            <label for="">비밀번호　</label>
            <input type="text" id="" name="userPwd" placeholder="　비밀번호(8~20자 이내, 하나이상의 영문,숫자,특수문자)" style="width: 450px">
            <form:errors path="userPwd" cssClass="class" cssStyle="color: red"></form:errors>
            <br>
            <hr>
            <label for="">비밀번호 확인　</label>
            <input type="text" id="" name="">
            <br>
            <hr>
            <label for="">휴대폰번호　</label>
            <input type="text" id="" name="userPhone" placeholder="　010-0000-0000">
            <form:errors path="userPhone" cssClass="class" cssStyle="color: red"></form:errors>
            <br>
            <hr>
            <label for="">주소　</label>
            <input type="text" id="" name="userAddr">
            <br>
            <hr>
            <label for="">생일　</label>
            <input type="date" name="userBirth" id="userBirth">

            <label for="">　　|　　성별　</label>
            <input type="radio" name="userGender" value="man">　남　
            <input type="radio" name="userGender" value="woman">　여　
            <input type="radio" name="userGender" value="선택안함">　선택안함
            <br>
            <hr>
            <div class="registerFormBtn">
                <button type="button" id="delBtn">취소</button>
                <input type="submit" value="회원가입">
            </div>
        </form:form>
    </div>
    <%--    </form>--%>
</main>
<%@include file="include/footer.jsp"%>
</body>
</html>

<script>
    const selectEmail = document.querySelector("#selectEmail");
    const selectedEmail = document.querySelector("#selectedEmail");
    const dupliCheck = document.querySelector("#dupliCheck");
    const userId = document.querySelector("#userId");
    const delBtn = document.querySelector("#delBtn")

    //이메일 선택할시 선택한 이메일 세팅
    selectEmail.addEventListener('change', function (e) {
        selectedEmail.setAttribute('value', e.target.value);
    });

    //아이디 중복검사 버튼 누를시 중복체크
    dupliCheck.addEventListener('click', function (){
        console.log("userId.value : "+userId.value);
        $.ajax({
            type:'POST',
            url: '/meal/register/dupliCheck',
            headers: {"content-type":"apllication/json"},
            dataType: 'text',
            data:JSON.stringify(userId.value),
            success: function (result){alert(result)},
            error: function(){alert("error : ")}
        })
    })

    delBtn.addEventListener('click', function (){
        if(window.confirm("회원가입을 그만두시겠습니까?")){
            location.href = "/meal";
        }
        else return;
    })

</script>


