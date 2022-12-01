<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<%--<%@ page import="java.net.URLDecoder"%>--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>meal</title>
    <link rel="stylesheet" href="<c:url value='/css/event.css'/>">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

</head>

<body>

<jsp:include page="../include/header.jsp" flush="false" />
<main>

<script>
    <%--let msg = "${msg}";--%>
    <%--if(msg=="LIST_ERR")  alert("상품 목록을 가져오는데 실패했습니다. 다시 시도해 주세요.");--%>
    <%--if(msg=="READ_ERR")  alert("삭제되었거나 없는 상품입니다.");--%>
    <%--if(msg=="MOD_OK") alert("성공적으로 수정되었습니다.");--%>
    <%--&lt;%&ndash;let reMsg = "${param.msg}";&ndash;%&gt;--%>
    <%--if(msg=="DEL_OK") alert("성공적으로 삭제되었습니다.");--%>
    <%--if(msg=="UPL_OK") alert("성공적으로 등록 되었습니다.");--%>
</script>

    <div class="main">
        <jsp:include page="../include/admin.jsp" flush="false" />

        <div class="eventList">


<div class="pageTitle_container">
    <h1>이벤트</h1>
    <hr>
</div>

    <div class="event-container">
            <div class="event_box">
            <c:forEach var="eventVO" items="${list}">
                <c:set var="pageLink" value="/event?eventN0=${eventVO.eventNo}"/>
                <div class="${eventVO.banner=='none'? 'none':'banner'}">
                   <a href="<c:url value='${pageLink}'/>"><img src="<c:url value='${eventVO.imgName}'/>"></a>
                    <h3>${eventVO.eventName}</h3>
                </div>
            </c:forEach>
            </div>
    </div>

<script>

</script>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>