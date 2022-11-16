<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<%--<%@ page import="java.net.URLDecoder"%>--%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 목록</title>
    <link rel="stylesheet" href="<c:url value='/css/order.css'/>">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

</head>
<body>
<jsp:include page="../include/header.jsp" flush="false" />
<main>


<script>
    let msg = "${msg}";
    if(msg=="LIST_ERR")  alert("주문 목록을 가져오는데 실패했습니다. 다시 시도해 주세요.");
    if(msg=="READ_ERR")  alert("주문 상세를 가져오는데 실패 했습니다. 다시 시도해 주세요");
</script>

<div class="main">
    <jsp:include page="../include/admin.jsp" flush="false" />

    <div class="orderList">

<div class="pageTitle_container">
    <h1>주문 목록</h1>
    <hr>
</div>

<div style="text-align:center">
    <div class="board-container">
        <div class="search-container">
            <form action="<c:url value="/order/list"/>" class="search-form" method="get">
                <select class="search-option" name="option">
                    <option value="A" ${ph.sc.option=='A' || ph.sc.option=='' ? "selected" : ""}>전체</option>
                    <%--옵션A 매퍼에 없어도 일단 넣어두자, 변수 전달되는거 확인하기에 좋음--%>
                    <option value="No" ${ph.sc.option=='No' ? "selected" : ""}>주문번호</option>
                    <option value="Id" ${ph.sc.option=='Id' ? "selected" : ""}>아이디</option>
                    <option value="Ph" ${ph.sc.option=='Ph' ? "selected" : ""}>연락처</option>
                    <option value="St" ${ph.sc.option=='St' ? "selected" : ""}>주문상태</option>
                </select>

                <input type="text" name="keyword" class="search-input" type="text" value="${ph.sc.keyword}" placeholder="검색어를 입력해주세요">
                <input type="submit" class="search-button" value="검색">
            </form>
        </div>

        <table>
            <tr>
                <th class="order-no">주문번호</th>
                <th class="user-id">아이디</th>
                <th class="user-phone">연락처</th>
                <th class="order-date">주문일</th>
                <th class="order-state">주문상태</th>
                <th class="administration">관리</th>
            </tr>
            <c:forEach var="orderDetailVO" items="${list}">
                <tr>
                    <td class="id">${orderDetailVO.orderNo}</td>
                    <td class="name">${orderDetailVO.userId}</td>
                    <td class="phone">${orderDetailVO.userPhone}</td>
                    <td class="order-date">${orderDetailVO.orderDate}</td>
                    <td class="statement">${orderDetailVO.orderState}</td>
                    <td class="administration"><a href="<c:url value="/order/read${ph.sc.queryString}&orderNo=${orderDetailVO.orderNo}"/>">상세보기</a></td>
                </tr>
            </c:forEach>
        </table>

        <div class="paging-container">
            <div class="paging">
                <c:if test="${totalCnt==null || totalCnt==0}">
                    <div> 주문 내용이 없습니다. </div>
                </c:if>
                <c:if test="${totalCnt!=null && totalCnt!=0}">
                    <c:if test="${ph.showPrev}">&lt;</c:if>
                    <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                        <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value="/order/list${ph.sc.getQueryString(i)}"/>">${i} </a>
                    </c:forEach>
                    <c:if test="${ph.showNext}">&gt;</c:if>
                </c:if>
            </div>
        </div>

    </div>
</div>
    </div>
</div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>