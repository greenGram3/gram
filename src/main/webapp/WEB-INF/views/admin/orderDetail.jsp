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
    <link rel="stylesheet" href="<c:url value='/css/order.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

</head>

<body>
<jsp:include page="../include/header.jsp" flush="false" />
<main>
<script>
    let msg = "${msg}";
    if(msg=="LIST_ERR")  alert("주문 목록을 가져오는데 실패했습니다. 다시 시도해 주세요.");
    if(msg=="READ_ERR")  alert("주문 상세 보기를 가져오는데 실패했습니다. 다시 시도해 주세요.");
    let reMsg = "${param.msg}";
    if(reMsg=="SEND_OK")  alert("발송 처리를 완료했습니다.");
    if(reMsg=="SEND_ERR")  alert("발송 처리에 실패했습니다. 다시 시도해 주세요.");
</script>
    <div class="main">
        <jsp:include page="../include/admin.jsp" flush="false" />

        <div class="orderDetail">

<div class="pageTitle_container">
    <h3>주문 상세 정보</h3>
    <hr>
</div>

<div style="text-align:center">
    <c:set var="i" value="${list.size()}"/>
    <div class="board-container">
        <form id="form" action="" method="">
            <table>
                <tr>
                    <th class="order-no">주문번호</th>
                    <td colspan="${i}"><input name="orderNo" type="text" value="${list.get(0).orderNo}" readonly></td>
                </tr>
                <tr>
                    <th class="user-id">아이디</th>
                    <td colspan="${i}"><input name="userId" type="text" value="${list.get(0).userId}" readonly></td>
                </tr>
                <tr>
                    <th class="user-phone">연락처</th>
                    <td colspan="${i}"><input name="userPhone" type="text" value="${list.get(0).userPhone}" readonly></td>
                </tr>
                <tr>
                    <th class="order-date">주문일</th>
                    <td colspan="${i}"><input name="orderDate" type="text" value="${list.get(0).orderDate}" readonly></td>
                </tr>

                <tr>
                    <th class="payment">결제수단</th>
                    <td colspan="${i}"><input name="payment" type="text" value="${list.get(0).payment}" readonly></td>
                </tr>
                <tr>
                    <th class="order-state">주문상태</th>
                    <td colspan="${i}"><input name="orderState" id ="orderState" type="text" value="${list.get(0).orderState}" readonly></td>
                </tr>


                <tr>
                    <th class="dely-addr">배송지</th>
                    <td colspan="${i}" class="addt"><input class="delyAddr" name="delyAddr" type="content" value="${list.get(0).delyAddr}" readonly></td>
                </tr>

                <tr >
                    <th class="requestment">요청사항</th>
                    <td colspan="${i}" class="req"><input class="orderReq" name="orderReq" type="content" value="${list.get(0).orderReq}" readonly></td>
                </tr>

                <tr>
                    <th class="item-no">상품번호</th>
                    <c:forEach var="orderDetailVO" items="${list}">
                    <td><input name="itemNoArr" type="text" value="${orderDetailVO.itemNo}"></td>
                     </c:forEach>
                </tr>

                <tr>
                    <th class="quantity">수량</th>
                    <c:forEach var="orderDetailVO" items="${list}">
                    <td> <input name="itemAmountArr" type="text" value="${orderDetailVO.itemAmount}"> 개</td>
                    </c:forEach>
                </tr>

                <tr>
                    <th class="item-price">가격</th>
                    <c:forEach var="orderDetailVO" items="${list}">
                    <td><input name="itemPriceArr" type="text" value="${orderDetailVO.itemPrice}"> 원</td>
                    </c:forEach>
                </tr>

            </table>

            <div class="button_container">
                <button type="button" id="listBtn" class="btn-cancel">목록으로</button>
                <button type="button" id="returnBtn" class="btn-return">반품처리</button>
                <button type="button" id="sendBtn" class="btn-send">발송처리</button>
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
            if(!confirm('발송처리를 하시겠습니까?')) return;
            let sendCheck = function() {
                let orderState = document.getElementById('orderState');

                if(orderState.value!='주문완료') {
                    alert('이미 처리 된 주문입니다.')
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


        $("#returnBtn").click(function(){
            if(!confirm('정말로 반품확정을 하시겠습니까?')) return;

            let returnCheck = function() {
                let orderState = document.getElementById("orderState");

                if(orderState.value=='반품확정') {
                    alert('이미 반품 된 주문입니다')
                    return false;
                }
                return true;
            }

            let form = $("#form");
            form.attr("action", "<c:url value='/order/return${searchCondition.queryString}'/>");
            form.attr("method", "post");
            if(returnCheck()){
                form.submit();
            }
        });


    });

</script>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>

</html>