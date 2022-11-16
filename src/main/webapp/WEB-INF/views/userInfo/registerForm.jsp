<%@ page contentType="text/html;charset=UTF-8"  language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <title>orderList</title>
    <link rel="stylesheet" href="<c:url value='/css/registerForm.css'/>">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>

<body>

<jsp:include page="../include/header.jsp" flush="false" />

<main>
    <div class="registerForm">
        <h1>회원가입</h1>
        <hr>

        <form:form modelAttribute="userVO" method="post">
            <label for="userId">아이디　</label>
            <input type="text" id="userId" name="userId" placeholder="　아이디(6~12자 이내, 특수문자 사용 불가)" style="width: 300px" value="${user.userId}">　
            <button type="button" id="dupliCheck">중복검사</button>
            <br>
            <form:errors path="userId" cssClass="class" cssStyle="color: red" id="userIdError"/>
            <hr>

            <label for="userName">이름　</label>
            <input type="text" id="userName" name="userName" placeholder="　이름(1~10자 이내, 특수문자 사용불가)" style="width: 300px" value="${user.userName}">
            <br>
            <form:errors path="userName" cssClass="class" cssStyle="color: red" ></form:errors>
            <hr>
            <label for="userEmailArr">이메일　</label>
            <input type="text" id="userEmailArr" name="userEmailArr" value="${userEmailArr[0]}"> @ <input type="text" id="selectedEmail" name="userEmailArr" value="${userEmailArr[1]}">
            <select id="selectEmail">
                <option value="직접입력" selected>　직접입력</option>
                <option value="naver.com">naver.com</option>
                <option value="daum.net">daum.net</option>
                <option value="gmail.com">gmail.com</option>
                <option value="nate.com">nate.com</option>
            </select>
            <br>
            <form:errors path="userEmail" cssClass="class" cssStyle="color: red"></form:errors>
            <hr>
            <label for="userPwd">비밀번호　</label>
            <input type="text" id="userPwd" name="userPwd" placeholder="　비밀번호(8~20자 이내, 하나이상의 영문,숫자,특수문자)" style="width: 450px" value="${user.userPwd}">
            <br>
            <form:errors path="userPwd" cssClass="class" cssStyle="color: red"></form:errors>
            <hr>
            <label for="pwdCheck">비밀번호 확인　</label>
            <input type="text" id="pwdCheck" name="pwdCheck" value="${pwdCheck}">
            <div id="msgPwd" style="color: red; display: none"></div>
            <hr>
            <label for="userPhone">휴대폰번호　</label>
            <input type="text" id="userPhone" name="userPhone" placeholder="　010-0000-0000" value="${user.userPhone}">
            <br>
            <form:errors path="userPhone" cssClass="class" cssStyle="color: red"></form:errors>
            <hr>
            <label for="userAddr">주소　</label>
            <input type="text" id="userAddr" name="userAddr" value="${user.userAddr}">
            <br>
            <hr>
            <label for="userBirth">생일　</label>
            <input type="date" name="userBirth" id="userBirth">

            <label for="">　　|　　성별　</label>
            <input type="radio" name="userGender" value="man">　남　
            <input type="radio" name="userGender" value="woman">　여　
            <input type="radio" name="userGender" value="선택안함">　선택안함
            <br>
            <hr>
            <div class="registerFormBtn">
                <button type="button" id="delBtn">취소</button>
                <input type="button" value="회원가입" id="regBtn">
            </div>
        </form:form>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
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

    //비밀번호 재입력 체크
    $('#regBtn')[0].addEventListener('click', function (){
        if($('#pwdCheck')[0].value != $('#userPwd')[0].value){
            $('#msgPwd')[0].style.display = 'block';
            $('#msgPwd')[0].innerHTML = '비밀번호와 맞지 않습니다';
            console.log( $('#msgPwd')[0].getAttribute('display'));
        }
        else{
            $('#userVO').submit();
        }
    });

    //아이디 중복검사 버튼 누를시 중복체크
    dupliCheck.addEventListener('click', function (){
        //6~12체크
        if($('#userId')[0].value.length<6 || $('#userId')[0].value.length>12){
            alert('6~12이내로 입력하셔야 합니다.');
            return;
        }
        //특수문자 체크
        if($('#userId')[0].value.search(/\W|\s/g) > -1){
            alert('특수문자가 있어선 안됩니다.');
            return;
        }

        $.ajax({
            type:'POST',
            url: '/meal/register/dupliCheck',
            headers: {"content-type":"apllication/json"},
            dataType: 'text',
            data:JSON.stringify(userId.value),
            success: function (result){
                alert(result)
            },
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

