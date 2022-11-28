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
        <div>배송지 주소
<%--            <input type="text" name="delyAddr" id="delyAddr">--%>
            <input type="text" id="zipNo" style="width: 100px" name="zipNo" placeholder="우편번호" value="${zipNo}" readonly/>
            <input type="text" id="roadAddrPart1" style="width: 300px" name="roadAddrPart1" value="${roadAddrPart1}" placeholder="도로명주소" readonly/>
            <input type="text" id="addrDetail" name="addrDetail" placeholder="상세주소" value="${addrDetail}" />
            <button type="button" id="addrBtn" style="width: 100px" onClick="goPopup();">우편번호 검색</button>
        </div>
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
    let receiver = $('#receiver')[0];
    let delyPlace = $('#delyPlace')[0];
    let delyPhone = $('#delyPhone')[0];
    let addrDetail = $('#addrDetail')[0];

    let msgReceiver = $('#msgReceiver')[0];
    let msgDelyPlace = $('#msgDelyPlace')[0];
    let msgDelyPhone = $('#msgDelyPhone')[0];
    let msgDelyAddr = $('#msgDelyAddr')[0];

    let RAP = $('#roadAddrPart1')[0];
    let AD = $('#addrDetail')[0];
    let ZN = $('#zipNo')[0];

    function goPopup(){
        let url = "/meal/addr?userId=${sessionScope.userId}";
        let pop = window.open(url,"pop","width=570,height=420, scrollbars=yes, resizable=yes");
    }

    function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){
        RAP.value = roadAddrPart1+roadAddrPart2;
        AD.value = addrDetail;
        ZN.value = zipNo;
    }

    $(function(){
        // ** Json
        $('#submitBtn').click(function () {
            //데이터 검증
            let test = /^[0-9]{3}-[0-9]{4}-[0-9]{4}/;
            let test2 = delyPhone.value
            let last = '';

            if(receiver.value.length < 1){
                msgReceiver.innerHTML = "빈칸이어서는 안됩니다."
                last += '1';
            }else {
                msgReceiver.innerHTML = ""
            }
            if(delyPlace.value.length < 1){
                msgDelyPlace.innerHTML = "빈칸이어서는 안됩니다."
                last += '1';
            }else {
                msgDelyPlace.innerHTML = ""
            }
            if(test.test(test2) && test2.length<14){
                msgDelyPhone.innerHTML = ""
            }else{
                msgDelyPhone.innerHTML = "010-0000-0000형식 이어야 합니다."
                last += '1';
            }

            if(addrDetail.value.length < 1){
                msgDelyAddr.innerHTML = "빈칸이어서는 안됩니다."
                last += '1';
            }else {
                msgDelyAddr.innerHTML = ""
            }

            if (last.length != 0) return;

            delyRegister();
        })
    }) //ready

    function delyRegister() {
        let delyNoValue = $('#delyNo').is(':checked')?$('#delyNo').val():0;
        let flag = true;

        $.ajax({       //동일한 이름의 배송지 있는지 확인
            type: 'Post',
            async: false,
            url: 'countDelyPlace',
            data: {
                delyPlace :  delyPlace.value,
            },
            success: function (result) {
                if (result.code != 0) {
                    flag=false;
                    alert("동일한 이름의 배송지가 있습니다.")
                };
            },
            error: function (result) {
                alert('error : '+result+" "+result.code);
            }
        })

        if (delyNoValue == 0){
            $.ajax({           //기본배송지 없을경우
                type: 'Post',
                async: false,
                url: 'register2',
                success: function (result) {
                    if (result.code == 0) {
                        flag = false;
                        alert("기본배송지는 1개 존재해야합니다.");
                    };
                },
                error: function (result) {
                    alert('error : '+result+" "+result.code);
                }
            }) //ajax
        }
        if(flag) {
            $.ajax({        //조건 만족할경우 배송지 등록
                type: 'Post',
                async: false,
                url: 'register',
                data: {
                    receiver :  receiver.value,
                    delyPlace :  delyPlace.value,
                    delyPhone :  delyPhone.value,
                    delyAddr : ZN.value + '@' + RAP.value+ '@' + AD.value,
                    delyNo : delyNoValue
                },
                success: function (result) {
                    alert("등록되었습니다.");
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