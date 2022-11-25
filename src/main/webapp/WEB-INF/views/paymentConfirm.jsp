<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<%--<%@ page import="java.net.URLDecoder"%>--%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value='/css/pay.css'/>">
    <meta charset="UTF-8">
    <title>paymentConfirm</title>

</head>
<style>

</style>

<body>
<jsp:include page="include/header.jsp" flush="false" />
<main>
    <div class="main">
        <div class="paymentConfirm">
<h1>결제완료</h1>
<hr>

<table>
    <tr>
        <th>상품명</th>
        <th>수량</th>
        <th><li class="itemPrice">(개별금액)</li>
            <li>합계금액</li></th>

    </tr>
    <c:forEach var="odvo" items="${odvoList}">
        <tr>
            <td>${odvo.itemName}</td>
            <td>${odvo.cartAmount} 개</td>
            <td><li class="itemPrice">(<fmt:formatNumber pattern="###,###,###" value="${odvo.itemPrice}"/> 원)</li>
                <li><fmt:formatNumber pattern="###,###,###" value="${odvo.cartAmount*odvo.itemPrice}"/> 원</li></td>

        </tr>
    </c:forEach>
    <tr>
        <th>총 금액</th>
        <c:set var="totalPrice" value="${totalPrice}"/>
        <td colspan="2"><fmt:formatNumber pattern="###,###,###" value="${totalPrice}"/> 원</td>
    </tr>
    <tr>
        <th>배송지 주소</th>
        <td colspan="2">${vo.delyAddr}</td>
    </tr>
</table>
            <div class="ConfirmBtn">
                <button onclick="location.href='/meal'">홈으로</button>
                <button onclick="location.href='/meal/mypage/order'">주문목록</button>
            </div>
    </div>
    </div>

</main>
<jsp:include page="include/footer.jsp" flush="false" />

</body>

</html>