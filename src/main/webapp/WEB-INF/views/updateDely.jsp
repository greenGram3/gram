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

        }else{
            $('#msgDelyPhone')[0].innerHTML = "핸드폰 번호를 확인해주세요."
            return;
        }

      $.ajax({
        type: 'Post',
        url: 'update',
        data: {
          receiver :  $('#receiver').val(),
          delyPlace :  $('#delyPlace').val(),
          delyPhone :  $('#delyPhone').val(),
          delyAddr : $('#delyAddr').val(),

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