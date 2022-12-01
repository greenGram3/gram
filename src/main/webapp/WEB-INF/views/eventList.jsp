<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<c:set var="loginId" value="${sessionScope.userId}"/>
<c:set var="setEvent" value="${loginId=='admin' ? 'adminEventList' : 'userEventList'}"/>
<%@ page session="true"%>
<%--<%@ page import="java.net.URLDecoder"%>--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>eventList</title>
    <link rel="stylesheet" href="<c:url value='/css/event.css'/>">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

</head>

<body>

<jsp:include page="include/header.jsp" flush="false" />
<main>

<script>

</script>

    <div class="main">

        <c:if test="${loginId=='admin'}">
            <jsp:include page="include/admin.jsp" flush="false" />
        </c:if>

        <div class="${setEvent}">

<div class="pageTitle_container">
    <h1>이벤트</h1>
    <hr>
</div>
            <div class="event_box">
            <c:forEach var="eventVO" items="${list}">
                <c:set var="pageLink" value="/event/detail?eventNo=${eventVO.eventNo}"/>
                <div>
                   <a href="<c:url value='${pageLink}'/>"><img src="<c:url value='${eventVO.imgName}'/>" class="${eventVO.banner=='none'? 'none':'banner'}" width="300" height="200">
                    <h3>${eventVO.eventName}</h3></a>
                </div>
            </c:forEach>
            </div>

            <c:if test="${loginId=='admin'}">
                <button type="button" onclick="location.href='/meal/event/upload'" >이벤트 등록</button>
            </c:if>

        </div>
    </div>
</main>
<jsp:include page="include/footer.jsp" flush="false" />
</body>
</html>