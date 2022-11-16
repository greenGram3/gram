<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="<c:url value='/css/delyRegister.css'/>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delivery</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<body>
<main>
    <h2>신규배송지</h2>
    <hr class="hr1">
    <div class="delyRegister">
        <div>수령인 <input type="text" name="receiver" id="receiver"></div>
        <div id="msgReceiver" style="color: red"></div>
        <hr class="hr2">
        <div>배송지명 <input type="text" name="delyPlace" id="delyPlace"></div>
        <div id="msgDelyPlace" style="color: red"></div>
        <hr class="hr3">
        <div>휴대전화 <input type="text" name="delyPhone" id="delyPhone"></div>
        <div id="msgDelyPhone" style="color: red"></div>
        <hr class="hr4">
        <div>배송지 주소 <input type="text" name="delyAddr" id="delyAddr"></div>
        <div id="msgDelyAddr" style="color: red"></div>
        <hr class="hr5">
        <div class="delyCheck">
            <input type="checkbox" name="delyNo" value="1" id="delyNo">　기본 배송지 설정　
            <input type="button" value="등록" id="submitBtn">
        </div>
    </div>
</main>
</body>
</html>

<script>
    $(function(){
        // ** Json
        $('#submitBtn').click(function () {

            let test = /^[0-9]{3}-[0-9]{4}-[0-9]{4}/;
            let test2 = $('#delyPhone')[0].value
            let last = '';

            if($('#receiver')[0].value.length < 1){
                $('#msgReceiver')[0].innerHTML = "빈칸이어서는 안됩니다."
                last += '1';
            }else {
                $('#msgReceiver')[0].innerHTML = ""
            }
            if($('#delyPlace')[0].value.length < 1){
                $('#msgDelyPlace')[0].innerHTML = "빈칸이어서는 안됩니다."
                last += '1';
            }else {
                $('#msgDelyPlace')[0].innerHTML = ""
            }
            if(test.test(test2) && test2.length<14){
                $('#msgDelyPhone')[0].innerHTML = ""
            }else{
                $('#msgDelyPhone')[0].innerHTML = "핸드폰 번호를 확인해주세요."
                last += '1';
            }

            if($('#delyAddr')[0].value.length < 1){
                $('#msgDelyAddr')[0].innerHTML = "빈칸이어서는 안됩니다."
                last += '1';
            }else {
                $('#msgDelyAddr')[0].innerHTML = ""
            }

            if (last.length != 0) return;

            ajax();
        })
    }) //ready

    function ajax() {
        let delyNoValue = $('#delyNo').is(':checked')?$('#delyNo').val():0;
        let flag = true;

        if (delyNoValue == 0){
            $.ajax({
                type: 'Post',
                async: false,
                url: 'register2',
                success: function (result) {
                    if (result.code == 0) {
                        flag = !flag;
                        alert("기본배송지는 1개 존재해야합니다.");
                    };
                },
                error: function (result) {
                    alert('error : '+result+" "+result.code);
                }
            }) //ajax
        }
        if(flag) {
            $.ajax({
                type: 'Post',
                async: false,
                url: 'register',
                data: {
                    receiver :  $('#receiver').val(),
                    delyPlace :  $('#delyPlace').val(),
                    delyPhone :  $('#delyPhone').val(),
                    delyAddr : $('#delyAddr').val(),
                    delyNo : delyNoValue
                },
                success: function (result) {
                    alert(result.code);
                    opener.parent.location.reload();
                    window.close();
                },
                error: function (result) {
                    alert('error : '+result+" "+result.code);
                }
            }) //ajax
        }
    }
</script>