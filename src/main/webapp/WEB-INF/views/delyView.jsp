<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <title>배송지 정보</title>
    <style>
        table {
            border: 1px solid black;
            margin: 10px;
        }
        .input-field-delyPlace {
            border: none;
        }
    </style>
</head>
<body>

<h3>배송지 정보</h3>
<hr>

<form id="form" action="" method="">
    <div>배송지명 ${vo.delyPlace}</div>
    <input type="hidden" name="delyPlace" value="${vo.delyPlace}">
    <div id="msgDelyPlace" style="color: red"></div>
    <hr class="hr3">

    <div>수령인 <input type="text" name="newReceiver" id="newReceiver" value="${vo.receiver}"></div>
    <input type="hidden" name="receiver" value="${vo.receiver}">
    <div id="msgReceiver" style="color: red"></div>
    <hr class="hr2">

    <div>휴대전화 <input type="text" name="newDelyPhone" id="newDelyPhone" value="${vo.delyPhone}"></div>
    <input type="hidden" name="delyPhone" value="${vo.delyPhone}">
    <div id="msgDelyPhone" style="color: red"></div>
    <hr class="hr4">

    <div>배송지 주소 <input type="text" name="newDelyAddr" id="newDelyAddr" value="${vo.delyAddr}"></div>
    <input type="hidden" name="delyAddr" value="${vo.delyAddr}">
    <div id="msgDelyAddr" style="color: red"></div>
    <hr class="hr5">
</form>

<button type="button" id="updBtn" class="update-btn">수정</button>
<button type="button" id="closeBtn" class="close-btn">닫기</button>

<script>

    $(document).ready(function(){

        $("#closeBtn").on("click", function () {
            window.close();
        })  //closeBtn

        let formCheck = function () {

            let test = /^[0-9]{3}-[0-9]{4}-[0-9]{4}/;
            let test2 = $('#newDelyPhone')[0].value
            let last = '';

            if($('#newReceiver')[0].value.length < 1){
                $('#msgReceiver')[0].innerHTML = "빈칸이어서는 안됩니다.";
                last+="1";
            }else{
                $('#msgReceiver')[0].innerHTML = ""
            }
            if(test.test(test2) && test2.length <14){
                $('#msgDelyPhone')[0].innerHTML = ""
            }else{
                $('#msgDelyPhone')[0].innerHTML = "핸드폰 번호를 확인해주세요.";
                last+="1";
            }
            if($('#newDelyAddr')[0].value.length < 1){
                $('#msgDelyAddr')[0].innerHTML = "빈칸이어서는 안됩니다.";
                last+="1";
            }else {
                $('#msgDelyAddr')[0].innerHTML = ""
            }

            if (last.length == 0) return true;

        }   //formCheck

        $('#updBtn').click(function () {

            let form = $("#form");
            form.attr("action", "<c:url value='/buy/delyUpdate'/>");
            form.attr("method", "POST");
            if(formCheck()) {
                form.submit();
                alert("수정이 완료되었습니다.");
                opener.parent.location.reload();
            } else {
                alert("수정에 실패했습니다. 다시 시도해주세요.");
            }

        })  //updBtn

    }) //ready

</script>

</body>
</html>
