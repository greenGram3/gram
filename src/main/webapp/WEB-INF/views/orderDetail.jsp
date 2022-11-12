<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<%--<%@ page import="java.net.URLDecoder"%>--%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 상세</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
        }
        a {
            text-decoration: none;
            color: black;
        }
        button,
        input {
            border: none;
            outline: none;
        }
        .board-container {
            width: 60%;
            height: 1200px;
            margin: 0 auto;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            border-top: 2px solid rgb(39, 39, 39);
        }
        .tr6:nth-child(even) {
            background-color: #f0f0f070;
        }
        .tr2, .tr4 {
            background-color: #f0f0f070;
        }
        .tr2 td, .tr6 td {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        th,
        td {
            width:100px;
            text-align: center;
            padding: 10px 12px;
        }
        td {
            color: rgb(53, 53, 53);
        }
        .tr2 {
            width: 100%;
        }
        .tr1, .tr2, .tr3, .tr4, .tr5, .tr6 {
            display: flex;
            justify-content: space-evenly;
            width: 100%;
        }
        .dely-addr, .requestment, .addt, .req {
            width: 50%;
        }
        .delyAddr, .orderReq {
            width: 100%;
        }
        .block-div {
            width: 100%;
            height: 50px;
            border-bottom: 1px solid rgb(39, 39, 39);
        }
        .board-container {
            margin-top: 50px;
        }

        .pageTitle_container {
            margin-top: 50px;
            display: flex;
            justify-content: center;
        }
        .order-admin {
            font-weight: bold;
            color: #ffffff;
        }
        button {
            background-color: rgb(89,117,196);
            border-radius: 5px;
            border : none;
            cursor: pointer;
            color : white;
            width:100px;
            height:40px;
            font-size: 15px;
            margin : 30px 0 20px 20px;
        }
        .button_container {
            width: 100%;
            display: flex;
            justify-content: center;
        }
        input {
            background : none;
            text-align: center;
        }
    </style>
</head>

<body>
<script>
    let msg = "${msg}";
    if(msg=="LIST_ERR")  alert("주문 목록을 가져오는데 실패했습니다. 다시 시도해 주세요.");
    if(msg=="READ_ERR")  alert("주문 상세 보기를 가져오는데 실패했습니다. 다시 시도해 주세요.");
    let reMsg = "${param.msg}";
    if(reMsg=="SEND_OK")  alert("발송 처리를 완료했습니다.");
    if(reMsg=="SEND_ERR")  alert("발송 처리에 실패했습니다. 다시 시도해 주세요.");
</script>
<div id="menu">
    <ul>
        <li id="logo">meal</li>
        <li><a href="<c:url value='/'/>">Home</a></li>
        <li><a href="<c:url value='/item/list'/>">상품관리</a></li>
        <li class="order-admin"><a href="<c:url value='/order/list'/>">판매관리</a></li>
        <li><a href="<c:url value='/user/list'/>">회원관리</a></li>
        <li><a href=""><i class="fa fa-search"></i></a></li>
    </ul>
</div>

<div class="pageTitle_container">
    <h2>주문 상세 보기</h2>
</div>

<div style="text-align:center">

    <div class="board-container">
        <form id="form" action="" method="">
            <table>
                <tr class="tr1">
                    <th class="order-no">주문번호</th>
                    <th class="user-id">아이디</th>
                    <th class="user-phone">연락처</th>
                    <th class="order-date">주문일</th>
                    <th class="payment">결제수단</th>
                    <th class="order-state">주문상태</th>
                </tr>
                <tr class="tr2">
                    <td><input name="orderNo" type="text" value="${list.get(0).orderNo}" readonly></td>
                    <td><input name="userId" type="text" value="${list.get(0).userId}" readonly></td>
                    <td><input name="userPhone" type="text" value="${list.get(0).userPhone}" readonly></td>
                    <td><input name="orderDate" type="text" value="${list.get(0).orderDate}" readonly></td>
                    <td><input name="payment" type="text" value="${list.get(0).payment}" readonly></td>
                    <td><input name="orderState" id ="orderState" type="text" value="${list.get(0).orderState}" readonly></td>
                </tr>

                <tr class="block-div"></tr>

                <tr class="tr3">
                    <th class="dely-addr">배송지</th>
                    <th class="requestment">요청사항</th>
                </tr>

                <tr class="tr4">
                    <td class="addt"><input class="delyAddr" name="delyAddr" type="content" value="${list.get(0).delyAddr}" readonly></td>
                    <td class="req"><input class="orderReq" name="orderReq" type="content" value="${list.get(0).orderReq}" readonly></td>
                </tr>

                <tr class="block-div"></tr>

                <tr class="tr5">
                    <th class="item-no">상품번호</th>
                    <th class="quantity">수량</th>
                    <th class="item-price">가격</th>
                </tr>

                <c:forEach var="orderDetailVO" items="${list}">
                    <tr class="tr6">
                        <td><input name="itemNoArr" type="text" value="${orderDetailVO.itemNo}"></td>
                        <td><input name="itemAmountArr" type="text" value="${orderDetailVO.itemAmount}"></td>
                        <td><input name="itemPriceArr" type="text" value="${orderDetailVO.itemPrice}"></td>
                    </tr>
                </c:forEach>

            </table>

            <div class="button_container">
                <button type="button" id="listBtn" class="btn-cancel">목록</button>
                <button type="button" id="sendBtn" class="btn-send">발송처리</button>
                <button type="button" id="returnBtn" class="btn-return">반품처리</button>
            </div>

        </form>

    </div>
</div>

<script>

    $(document).ready(function(){

        $("#listBtn").on("click", function(){
            location.href="<c:url value='/order/list${searchCondition.queryString}'/>";
        });

        $("#sendBtn").on("click", function(){

            let sendCheck = function() {
                let orderState = document.getElementById("orderState");

                if(orderState.value=="d") {
                    alert("이미 발송처리 된 주문입니다.")
                    return false;
                }
                return true;
            }

            let form = $("#form");
            form.attr("action", "<c:url value='/order/send${searchCondition.queryString}'/>");
            form.attr("method", "post");
            if(sendCheck()){
                form.submit();
            }

        });

    });

</script>

</body>

</html>