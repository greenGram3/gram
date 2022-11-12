<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<body>
<main>
        <h2>신규배송지</h2>
        <div>수령인 <input type="text" name="receiver" id="receiver"></div>
    <div id="msgReceiver" style="color: red"></div>
        <div>배송지명 <input type="text" name="delyPlace" id="delyPlace"></div>
    <div id="msgDelyPlace" style="color: red"></div>
        <div>휴대전화 <input type="text" name="delyPhone" id="delyPhone"></div>
    <div id="msgDelyPhone" style="color: red"></div>
        <div>배송지 주소 <input type="text" name="delyAddr" id="delyAddr"></div>
    <div id="msgDelyAddr" style="color: red"></div>
        <input type="checkbox" name="delyNo" value="1" id="delyNo">기본 배송지 설정
        <input type="button" value="등록" id="submitBtn">
</main>
</body>
</html>

<script>
    $(function(){
        // ** Json
        $('#submitBtn').click(function () {

            let test = /01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/;
            let test2 = $('#delyPhone')[0].value

                if($('#receiver')[0].value.length < 1){
                    $('#msgReceiver')[0].innerHTML = "빈칸이어서는 안됩니다."
                    return;
                }
                if($('#delyPlace')[0].value.length < 1){
                    $('#msgDelyPlace')[0].innerHTML = "빈칸이어서는 안됩니다."
                    return;
                }
                if(test.test(test2)){
                    ajax();
                }else{
                    $('#msgDelyPhone')[0].innerHTML = "핸드폰 번호를 확인해주세요."
                    return;
                }
        })
    }) //ready

    function ajax() {
        let delyNoValue = $('#delyNo').is(':checked')?$('#delyNo').val():0;

        $.ajax({
            type: 'Post',
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
</script>