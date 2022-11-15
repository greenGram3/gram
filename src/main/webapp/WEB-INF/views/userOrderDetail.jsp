<%@ page contentType="text/html;charset=UTF-8"  language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <title>orderList</title>
    <link rel="stylesheet" href="<c:url value='/css/userOrderDetail.css'/>">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

</head>

<body>
<jsp:include page="include/header.jsp" flush="false" />
<main>
    <div class="main">

        <%@include file="include/mypage.jsp"%>

        <div class="orderDetail">
            <h3>주문상세정보</h3>
            <div class="orderDetailInfo">
                <div>　주문일자　${orderListDto.orderDate}</div> <div>　주문번호　${orderListDto.order}</div>
            </div>

            <figure>
                <div>
                    <table>
                        <tr>
                            <th>상품정보</th>
                            <th>상품금액(수량)</th>
                            <th>주문상태</th>
                        </tr>
                        <c:forEach var="orderDetailDto" items="${orderListDto.list}">
                            <tr>
                                <td>
                                    <li><img src="${orderDetailDto.path}"></li>
                                    <li>${orderDetailDto.itemName}</li>
                                </td>
                                <td><li><fmt:formatNumber pattern="###,###,###" value="${orderDetailDto.itemPrice}"/> 원</li>
                                    <li>( ${orderDetailDto.itemAmount} 개)</li>
                                </td>
                                <td>${orderListDto.orderState}</td>
                            </tr>
                        </c:forEach>
                    </table>

                    <table>
                        <tr>
                            <th colspan="2">결제 배송지 정보</th>
                        </tr>
                        <tr>
                            <th>수령인</th>
                            <td>　${orderListDto.receiver}</td>
                        </tr>
                        <tr>
                            <th>연락처</th>
                            <td>　${orderListDto.userPhone} </td>
                        </tr>
                        <tr>
                            <th>배송지</th>
                            <td>　${orderListDto.delyAddr}</td>
                        </tr>
                        <tr>
                            <th>배송메모</th>
                            <td>　${orderListDto.orderReq}</td>
                        </tr>
                        <tr>
                            <th>결제수단</th>
                            <td>　${orderListDto.payment}</td>
                        </tr>
                        <tr>
                            <th>결제금액</th>
                            <td>　<fmt:formatNumber pattern="###,###,###" value="${orderListDto.totalPay}"/> 원</td>
                        </tr>

                    </table>
                </div>
            </figure>
        </div>
    </div>
</main>
<jsp:include page="include/footer.jsp" flush="false" />
</body>
</html>


