<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="<c:url value='/css/updateDely.css'/>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<body>
<main>

    <h2>배송지 수정</h2>
    <hr class="hr1">
    <div class="updateDely">

        <div>수령인 <input type="text" name="receiver" id="receiver" value="${dely.receiver}"></div>
        <input type="hidden" name="receiver1" value="${dely.receiver}">
        <div id="msgReceiver" style="color: red"></div>
        <hr class="hr2">

        <div>배송지명 <input type="text" name="delyPlace" id="delyPlace" value="${dely.delyPlace}"></div>
        <input type="hidden" name="delyPlace1" value="${dely.delyPlace}">
        <div id="msgDelyPlace" style="color: red"></div>
        <hr class="hr3">

        <div>휴대전화 <input type="text" name="delyPhone" id="delyPhone" value="${dely.delyPhone}"></div>
        <input type="hidden" name="delyPhone1" value="${dely.delyPhone}">
        <div id="msgDelyPhone" style="color: red"></div>
        <hr class="hr4">

        <div>배송지 주소 <input type="text" name="delyAddr" id="delyAddr" value="${dely.delyAddr}"></div>
        <input type="hidden" name="delyAddr1" value="${dely.delyAddr}">
        <div id="msgDelyAddr" style="color: red"></div>
        <hr class="hr5">

        <c:choose>
            <c:when test="${dely.delyNo eq 1}">
                <input type="checkbox" name="delyNo"  id="delyNo" value="1" checked>　기본 배송지 설정
            </c:when>
            <c:otherwise>
                <input type="checkbox" name="delyNo"  id="delyNo" value="0">　기본 배송지 설정
            </c:otherwise>
        </c:choose>
        　

        <div class="delyCheck">
            <input type="button" value="취소" id="delBtn">
            <input type="button" value="수정" id="updBtn">
        </div>
    </div>
</main>
</body>
</html>

<script>
    $('#delBtn').click(function (){
        window.close();
    })

    $(function(){
        // ** Json
        $('#updBtn').click(function () {

            let test = /^[0-9]{3}-[0-9]{4}-[0-9]{4}/;
            let test2 = $('#delyPhone')[0].value
            let last = '';

            if($('#receiver')[0].value.length < 1){
                $('#msgReceiver')[0].innerHTML = "빈칸이어서는 안됩니다.";
                last+="1";
            }else{
                $('#msgReceiver')[0].innerHTML = ""
            }
            if($('#delyPlace')[0].value.length < 1){
                $('#msgDelyPlace')[0].innerHTML = "빈칸이어서는 안됩니다.";
                last+="1";
            }else {
                $('#msgDelyPlace')[0].innerHTML = ""
            }
            if(test.test(test2) && test2.length <14){
                $('#msgDelyPhone')[0].innerHTML = ""
            }else{
                $('#msgDelyPhone')[0].innerHTML = "핸드폰 번호를 확인해주세요.";
                last+="1";
            }
            if($('#delyAddr')[0].value.length < 1){
                $('#msgDelyAddr')[0].innerHTML = "빈칸이어서는 안됩니다.";
                last+="1";
            }else {
                $('#msgDelyAddr')[0].innerHTML = ""
            }

            if (last.length != 0) return;

            let delyNoValue = $('#delyNo').is(':checked')?1:0;

            if($('#delyNo')[0].value == 1 && delyNoValue==0){
                let flag = false;
                $.ajax({
                    type: 'Post',
                    url: 'register2',
                    async: false,
                    success: function (result) {
                        if (result.code == 1) {
                            flag = !flag
                            alert("기본배송지는 1개 존재해야합니다.");
                        };
                    },
                    error: function (result) {
                        alert('error : '+result+" "+result.code);
                    }
                }) //ajax
                if(flag) return;
            }
            else if($('#delyNo')[0].value == 0 && delyNoValue==1){
                $.ajax({
                    type: 'Post',
                    url: 'update2',
                    async: false,
                    success: function (result) {
                        console.log(result);
                    },
                    error: function (result) {
                        alert('error : '+result+" "+result.code);
                    }
                }) //ajax
            }
            $.ajax({
                type: 'Post',
                url: 'update',
                async: false,
                data: {
                    receiver :  $('#receiver').val(),
                    delyPlace :  $('#delyPlace').val(),
                    delyPhone :  $('#delyPhone').val(),
                    delyAddr : $('#delyAddr').val(),
                    delyNo : delyNoValue,

                    receiver1 :  $('input[name=receiver1]').val(),
                    delyPlace1 :  $('input[name=delyPlace1]').val(),
                    delyPhone1 :  $('input[name=delyPhone1]').val(),
                    delyAddr1: $('input[name=delyAddr1]').val(),
                },
                success: function (result) {
                    alert(result.code);
                    opener.parent.location.reload();
                    window.close();
                },
                error: function (result) {
                    alert('error : '+result+" "+result.code);
                }
            })




        })
    }) //ready
</script>