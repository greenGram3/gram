<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <link rel="stylesheet" href="<c:url value='/css/updateDely.css'/>">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <title>배송지 정보</title>
    <style>

    </style>
</head>
<body>
<main>
<h2>배송지 정보</h2>
<hr>
<div class="delyView">
<form id="form" action="" method="">

    <div>배송지명 <span>${vo.delyPlace}</span></div>
    <input type="hidden" name="delyPlace" value="${vo.delyPlace}">
    <div id="msgDelyPlace" style="color: red"></div>
    <hr>

    <div>수령인 <input type="text" name="newReceiver" id="newReceiver" value="${vo.receiver}"></div>
    <input type="hidden" name="receiver" value="${vo.receiver}">
    <div id="msgReceiver" style="color: red"></div>
    <hr>
    <div>연락처 <input type="text" name="newDelyPhone" id="newDelyPhone" value="${vo.delyPhone}"></div>
    <input type="hidden" name="delyPhone" value="${vo.delyPhone}">
    <div id="msgDelyPhone" style="color: red"></div>
    <hr>

    <div>배송지 주소
        <input type="text" id="zipNo" style="width: 100px" name="zipNo" placeholder="우편번호" value="${zipNo}" readonly/>
        <input type="text" id="roadAddrPart1" style="width: 300px" name="roadAddrPart1" value="${roadAddrPart1}" placeholder="도로명주소" readonly/>
        <input type="text" id="addrDetail" name="addrDetail" placeholder="상세주소" value="${addrDetail}"/>
        <button type="button" id="addrBtn" style="width: 100px" onClick="goPopup();">우편번호 검색</button>
    </div>
    <div id="msgDelyAddr" style="color: red"></div>
    <hr class="hr5">
<%--    <div>--%>
<%--        <button type="button" id="addrModifyBtn">주소변경</button>--%>
<%--        <div id="msgAddr" style="color: red"></div>--%>
<%--    </div>--%>

<%--    <div class="addr-input-form">--%>
<%--        <hr>--%>
<%--        <div>주소입력</div>--%>
<%--        <div class="addr-input">--%>
<%--            <input type="text" id="zipNo" style="width: 80px" name="zipNo" placeholder="우편번호" value="${zipNo}" readonly/>--%>
<%--            <input type="text" id="roadAddrPart1" style="width: 200px" name="roadAddrPart1" placeholder="도로명주소" value="${roadAddrPart1}" readonly/>--%>
<%--            <input type="text" id="addrDetail" name="addrDetail" placeholder="상세주소" value="${addrDetail}" readonly/>--%>
<%--        </div>--%>
<%--        <button type="button" id="addrBtn" onClick="goPopup();">우편번호 검색</button> &nbsp;--%>
<%--    </div>--%>
<%--    <hr>--%>
<input hidden name="dely" value="${dely}">


</form>
    <div class="delyCheck">
<button type="button" id="updBtn" class="update-btn">수정</button>
<button type="button" id="closeBtn" class="close-btn">닫기</button>
<div>
<script>

    //주소 우편번호 팝업창 api 열기
    function goPopup(){
        let pop = window.open("<c:url value='/addr'/>","pop","Child","width=570,height=420, scrollbars=yes, resizable=yes");
    }

    //api에서 주소 입력받기
    function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){
        document.querySelector("#roadAddrPart1").value = roadAddrPart1+roadAddrPart2;
        document.querySelector("#addrDetail").value = addrDetail;
        document.querySelector("#zipNo").value = zipNo;
    }

    $(document).ready(function(){

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
            if($('#addrDetail')[0].value.length < 1){
                $('#msgDelyAddr')[0].innerHTML = "빈칸이어서는 안됩니다.";
                last+="1";
            }else {
                $('#msgDelyAddr')[0].innerHTML = ""
            }

            if (last.length == 0) return true;

        }   //formCheck

        $("#addrModifyBtn").click(function () {
            $(".addr-input-form").css("display", "block");
        }); //addrModifyBtn


        $('#updBtn').click(function () {
            let form = $("#form");
            form.attr("action", "<c:url value='/buy/delyUpdate'/>");
            form.attr("method", "POST");
            if(formCheck()) {
                form.submit();
                alert("수정이 완료되었습니다.");
            } else {
                alert("수정에 실패했습니다. 다시 시도해주세요.");
                return;
            }

        })  //updBtn

        $("#closeBtn").on("click", function () {

            opener.document.getElementById('${dely}').value='${newAdder}';

            window.close();
        })  //closeBtn

    }); //ready

</script>
</div>
</main>
</body>
</html>
