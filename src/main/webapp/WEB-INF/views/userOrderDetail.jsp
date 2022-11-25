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
                            <th>수량</th>
                            <th><li class="itemPrice">(개별금액)</li><li>합계금액</li></th>
                            <th>주문상태</th>
                            <c:if test="${orderListDto.orderState == '구매확정'}">
                                <th>상품후기</th>
                            </c:if>
                        </tr>
                        <c:forEach var="orderDetailDto" items="${orderListDto.list}">
                            <tr>
                                <td>
                                    <li><img src="<c:url value='${orderDetailDto.fileName}'/>" width="100"></li>
                                    <li>${orderDetailDto.itemName}</li>
                                </td>
                                <td>${orderDetailDto.itemAmount} 개</td>
                                <td><li class="itemPrice">(<fmt:formatNumber pattern="###,###,###" value="${orderDetailDto.itemPrice}"/> 원)</li>
                                    <li><fmt:formatNumber pattern="###,###,###" value="${orderDetailDto.itemAmount*orderDetailDto.itemPrice}"/> 원</li>
                                </td>
                                <td>${orderListDto.orderState}</td>
                                <c:if test="${orderListDto.orderState == '구매확정'}">
                                    <td>
                                        <button type="button"
                                                onclick="location.href='<c:url value='/reviewinsertf?itemName=${orderDetailDto.itemName}&itemNo=${orderDetailDto.itemNo}&orderNo=${orderDetailDto.orderNo}'/>'">
                                            후기 작성하기</button>
                                    </td>
                                </c:if>
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


