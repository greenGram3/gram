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
        <span> <span class="star">*</span> 은 필수 입력 사항 입니다</span>
        <hr>

        <form:form modelAttribute="userVO" method="post">
            <span class="star">*</span><label for="userId">아이디　</label>
            <input type="text" id="userId" name="userId" placeholder="　아이디(6~12자 이내, 특수문자 사용 불가)" style="width: 300px" value="${user.userId}">　
            <button type="button" id="dupliCheck" disabled>중복검사</button>
            <span id="msgId1"></span>
            <div id="msgId2" style="display:none; color: red"></div>
            <div id="msgId3" style="display:none; color: red"></div>
            <form:errors path="userId" cssClass="class" cssStyle="color: red" id="userIdError"/>
            <hr>

            <span class="star">*</span><label for="userName">이름　</label>
            <input type="text" id="userName" name="userName" placeholder="　이름(1~10자 이내, 특수문자 사용불가)" style="width: 300px" value="${user.userName}">
            <div id="msgName" style="display:none; color: red"></div>
            <form:errors path="userName" cssClass="class" cssStyle="color: red" ></form:errors>
            <hr>
            <span class="star">*</span><label for="userEmailArr">이메일　</label>
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
            <span class="star">*</span> <label for="userPwd">비밀번호　</label>
            <input type="password" id="userPwd" name="userPwd" placeholder="　비밀번호(8~20자 이내, 하나이상의 영문,숫자,특수문자)" style="width: 350px" value="${user.userPwd}">
            <div id="msgPwd1" style="color: red; display: none"></div>
            <div id="msgPwd2" style="color: red; display: none"></div>
            <form:errors path="userPwd" cssClass="class" cssStyle="color: red"></form:errors>
            <hr>
            <span class="star">*</span><label for="pwdCheck">비밀번호 확인　</label>
            <input type="password" id="pwdCheck" name="pwdCheck" value="${pwdCheck}">
            <div id="msgPwdCheck" style="color: red; display: none"></div>
            <hr>
            <span class="star">*</span><label for="userPhone">휴대폰번호　</label>
            <input type="text" id="userPhone" name="userPhone" placeholder="　010-0000-0000" value="${user.userPhone}">
            <div id="msgPhone" style="color: red; display: none"></div>
            <form:errors path="userPhone" cssClass="class" cssStyle="color: red"></form:errors>
            <hr>
            <span class="star">*</span>주소　</label>
            <input type="text" id="zipNo" style="width: 100px" name="zipNo" placeholder="우편번호" value="${zipNo}" readonly/>
            <input type="text" id="roadAddrPart1" style="width: 300px" name="roadAddrPart1" value="${roadAddrPart1}" placeholder="도로명주소" readonly/>
            <input type="text" id="addrDetail" name="addrDetail" placeholder="상세주소" value="${addrDetail}" />
            <button type="button" id="addrBtn" style="width: 100px" onClick="goPopup();">우편번호 검색</button>
            <div id="msgAddr" style="color: red; display: none"></div>
            <hr>
            <label class="birth" for="userBirth">생일　</label>
            <input type="date" name="userBirth" id="userBirth">

            　　|　　성별　</label>
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
    // 주소 우편번호 팝업창 api
    function goPopup(){
        let url = "/meal/addr2";
        let pop = window.open(url,"pop","width=570,height=420, scrollbars=yes, resizable=yes");
    }

    function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){
        document.querySelector("#roadAddrPart1").value = roadAddrPart1+roadAddrPart2;
        document.querySelector("#addrDetail").value = addrDetail;
        document.querySelector("#zipNo").value = zipNo;
    }

    const selectEmail = document.querySelector("#selectEmail");
    const selectedEmail = document.querySelector("#selectedEmail");
    const dupliCheck = document.querySelector("#dupliCheck");
    const userId = document.querySelector("#userId");
    const userName = document.querySelector("#userName");
    const userPwd = document.querySelector("#userPwd");
    const pwdCheck = document.querySelector("#pwdCheck");
    const userPhone = document.querySelector("#userPhone");
    const delBtn = document.querySelector("#delBtn");
    let msgId1 = $('#msgId1')[0];
    let msgId2 = $('#msgId2')[0];
    let msgId3 = $('#msgId3')[0];
    let msgPwd1 = $('#msgPwd1')[0];
    let msgPwd2 = $('#msgPwd2')[0];
    let msgName = $('#msgName')[0];
    let msgPwdCheck = $('#msgPwdCheck')[0];
    let msgPhone = $('#msgPhone')[0];
    let msgAddr = $('#msgAddr')[0];
    let btnNum = 0;

    //이메일 선택할시 선택한 이메일 세팅
    selectEmail.addEventListener('change', function (e) {
        selectedEmail.setAttribute('value', e.target.value);
    });

    //아이디 체크
    userId.addEventListener('keyup', function(){
        //6~12체크
        if(userId.value.length<6 || userId.value.length>12){
            msgId2.style.display = 'block';
            msgId2.innerHTML="6~12이내로 입력하셔야 합니다.";
        }
        else{
            msgId2.style.display = 'none';
            msgId2.innerHTML="";
        }
    });

    //아이디 체크
    userId.addEventListener('keyup', function(){
        //특수문자 체크
        if(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g.test(userId.value)){
            msgId3.style.display = 'block';
            msgId3.innerHTML="특수문자가 있어선 안됩니다.";
        }
        else{
            msgId3.style.display = 'none';
            msgId3.innerHTML="";
        }
    });

    // 아이디 중복검사 버튼 disable 풀기
    userId.addEventListener('keyup', function (){
        if ((userId.value.length>=6 && userId.value.length<=12) && !/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g.test(userId.value)){
            dupliCheck.removeAttribute("disabled");
        }
        else{
            dupliCheck.setAttribute("disabled", true);
        }
    });

    //이름 체크
    userName.addEventListener('keyup', function(){
        //특수문자 체크
        if(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g.test(userName.value)){
            msgName.style.display = 'block';
            msgName.innerHTML="특수문자가 있어선 안됩니다.";
        }
        else{
            msgName.style.display = 'none';
            msgName.innerHTML="";
        }
    });

    //비밀번호 체크
    userPwd.addEventListener('keyup', function(){
        //8~20 체크
        if(userPwd.value.length<8 || userPwd.value.length>20){
            msgPwd1.style.display = 'block';
            msgPwd1.innerHTML="8~20이내로 입력하셔야 합니다.";
        }
        else{
            msgPwd1.style.display = 'none';
            msgPwd1.innerHTML="";
        }
    });

    userPwd.addEventListener('keyup', function(){
        //문자조합 체크
        if(!(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(userPwd.value))){
            msgPwd2.style.display = 'block';
            msgPwd2.innerHTML="영문+숫자+특수문자 조합이여야 합니다.";
        }
        else{
            msgPwd2.style.display = 'none';
            msgPwd2.innerHTML="";
        }
    });

    //비밀번호 재입력 체크
    pwdCheck.addEventListener('keyup', function (){
        if(pwdCheck.value != userPwd.value){
            msgPwdCheck.style.display = 'block';
            msgPwdCheck.innerHTML = '비밀번호와 맞지 않습니다';
        }else{
            msgPwdCheck.style.display = 'none';
            msgPwdCheck.innerHTML = '';
        }
    });

    //휴대폰 번호 체크
    userPhone.addEventListener('keyup', function (){
        if(!(/^[0-9]{3}-[0-9]{4}-[0-9]{4}/.test(userPhone.value)) || userPhone.value.length>13 ){
            msgPhone.style.display = 'block';
            msgPhone.innerHTML = '010-0000-0000 형식이어야 합니다.';
        }else{
            msgPhone.style.display = 'none';
            msgPhone.innerHTML = '';
        }
    });



    //아이디 중복검사 버튼 누를시 중복체크
    dupliCheck.addEventListener('click', function (){
        $.ajax({
            type:'POST',
            url: '/meal/register/dupliCheck',
            headers: {"content-type":"apllication/json"},
            dataType: 'text',
            data:JSON.stringify(userId.value),
            success: function (result){
                if(result == 'available'){
                    msgId1.style.color = 'green';
                    msgId1.innerHTML="〇 사용 가능한 아이디 입니다.";
                    btnNum += 1;
                }else{
                    msgId1.style.color = 'red';
                    msgId1.innerHTML="✖이미 사용중인 아이디 입니다.";
                }
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

    $('#regBtn')[0].addEventListener('click',function (){
        if(userId.value.length != 0 && userName.value.length != 0 && $('#userEmailArr')[0].value.length != 0 &&
            $('#selectedEmail')[0].value.length != 0 && userPwd.value.length != 0 && pwdCheck.value.length != 0 &&
            userPhone.value.length != 0 && $('#addrDetail')[0].value.length !=0 && msgId2.textContent.length==0
            && msgId3.textContent.length==0 && msgPhone.textContent.length==0 && msgAddr.textContent.length==0
            && msgName.textContent.length==0 && msgPwd1.textContent.length==0 && msgPwd2.textContent.length==0
            && msgPwdCheck.textContent.length==0 && btnNum !=0
        ){
            $('#userVO')[0].submit();
        }
        else if(btnNum == 0 && userId.value.length != 0){
            alert("아이디 중복검사를 해주세요");
            return;
        }
        // else if($('#addrDetail')[0].value.length == 0){
        //     msgAddr.style.display = 'block';
        //     msgAddr.innerHTML = '주소를 확인해 주세요';
        //     return;
        // }
        else {
            alert("필수입력란을 확인해주세요.");
            return;
        };
    })

</script>

