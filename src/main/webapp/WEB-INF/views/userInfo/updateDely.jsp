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

        <div>배송지 주소
<%--            <input type="text" name="delyAddr" id="delyAddr" value="${dely.delyAddr}">--%>
            <input type="text" id="zipNo" style="width: 100px" name="zipNo" placeholder="우편번호" value="${zipNo}" readonly/>
            <input type="text" id="roadAddrPart1" style="width: 300px" name="roadAddrPart1" value="${roadAddrPart1}" placeholder="도로명주소" readonly/>
            <input type="text" id="addrDetail" name="addrDetail" placeholder="상세주소" value="${addrDetail}" />
            <button type="button" id="addrBtn" style="width: 100px" onClick="goPopup();">우편번호 검색</button>
        </div>
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
            <input type="button" value="수정" id="updBtn">
            <input type="button" value="취소" id="delBtn">
        </div>
    </div>
</main>
</body>
</html>

<script>
    let receiver = $('#receiver')[0];
    let delyPlace = $('#delyPlace')[0];
    let delyPhone = $('#delyPhone')[0];

    let msgReceiver = $('#msgReceiver')[0];
    let msgDelyPlace = $('#msgDelyPlace')[0];
    let msgDelyPhone = $('#msgDelyPhone')[0];
    let msgDelyAddr = $('#msgDelyAddr')[0];

    let RAP = $('#roadAddrPart1')[0];
    let AD = $('#addrDetail')[0];
    let ZN = $('#zipNo')[0];

    // 주소 우편번호 팝업창 api
    function goPopup(){
        let url = "/meal/addr?userId=${sessionScope.userId}";
        let pop = window.open(url,"pop","width=570,height=420,left=1000,top=200, scrollbars=yes, resizable=yes");
    }

    function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){
        RAP.value = roadAddrPart1+roadAddrPart2;
        AD.value = addrDetail;
        ZN.value = zipNo;
    }

    $('#delBtn').click(function (){
        window.close();
    })

    $(function(){
        // ** Json
        $('#updBtn').click(function () {
            let flag = true;

            //데이터 검증
            let test = /^[0-9]{3}-[0-9]{4}-[0-9]{4}/;
            let test2 = delyPhone.value
            let last = '';

            if(receiver.value.length < 1){
                msgReceiver.innerHTML = "빈칸이어서는 안됩니다.";
                last+="1";
            }else{
                msgReceiver.innerHTML = ""
            }
            if(delyPlace.value.length < 1){
                msgDelyPlace.innerHTML = "빈칸이어서는 안됩니다.";
                last+="1";
            }else {
                msgDelyPlace.innerHTML = ""
            }
            if(test.test(test2) && test2.length <14){
                msgDelyPhone.innerHTML = ""
            }else{
                msgDelyPhone.innerHTML = "010-0000-0000 형식이어야 합니다.";
                last+="1";
            }
            if(AD.value.length < 1){
                msgDelyAddr.innerHTML = "빈칸이어서는 안됩니다.";
                last+="1";
            }else {
                msgDelyAddr.innerHTML = ""
            }

            if (last.length != 0) return;

            let delyNoValue = $('#delyNo').is(':checked')?1:0;

            if($('#delyNo')[0].value == 1 && delyNoValue==0){ //기본배송지 였던거 체크박스 해제할경우
                flag = false;
                alert("기본배송지는 1개 존재해야합니다.");
            }
            else if($('#delyNo')[0].value == 0 && delyNoValue==1){ // 일반배송지에서 기본배송지 체크할경우
                $.ajax({   // 싸그리 delyNo 0으로 설정
                    type: 'Post',
                    url: 'update2',
                    async: false,
                    success: function (result) {},
                    error: function (result) {
                        alert('error : '+result+" "+result.code);
                    }
                })
            }
            else{   // 체크박스 안건드릴경우
                if(delyPlace.value !=  $('input[name=delyPlace1]').val()){ // 배송지 이름 바꿀경우
                    $.ajax({       //동일한 이름의 배송지 있는지 확인
                        type: 'Post',
                        async: false,
                        url: 'countDelyPlace',
                        data: {
                            delyPlace :  delyPlace.value,
                        },
                        success: function (result) {
                            if (result.code != 0) {
                                flag = false;
                                alert("동일한 이름의 배송지가 있습니다.")
                            }
                        },
                        error: function (result) {
                            alert('error : '+result+" "+result.code);
                        }
                    })
                }
            }

            if(flag){      // 조건 만족할 경우
                $.ajax({         // 업데이트
                    type: 'Post',
                    url: 'update',
                    async: false,
                    data: {
                        receiver :  receiver.value,
                        delyPlace :  delyPlace.value,
                        delyPhone :  delyPhone.value,
                        delyAddr : ZN.value+"@"+RAP.value+"@"+AD.value,
                        delyNo : delyNoValue,

                        receiver1 :  $('input[name=receiver1]').val(),
                        delyPlace1 :  $('input[name=delyPlace1]').val(),
                        delyPhone1 :  $('input[name=delyPhone1]').val(),
                        delyAddr1: $('input[name=delyAddr1]').val(),
                    },
                    success: function () {
                        alert("수정되었습니다.");
                        opener.parent.location.reload();
                        window.close();
                    },
                    error: function (result) {
                        alert('error : '+result+" "+result.code);
                    }
                })
            }
        })
    }) //ready
</script>