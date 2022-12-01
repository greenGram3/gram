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
    <link rel="stylesheet" href="<c:url value='/css/item.css'/>">
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

        <div class="itemList">


<div class="pageTitle_container">
    <h1>이벤트 배너 목록</h1>
    <hr>
</div>

<div>
    <div class="board-container">
<%--        <div class="search-container">--%>
<%--            <form action="<c:url value="/item/list"/>" class="search-form" method="get">--%>
<%--                <select class="search-option" name="option">--%>
<%--                    <option value="A" ${ph.sc.option=='A' || ph.sc.option=='' ? "selected" : ""}>전체</option>--%>
<%--                    &lt;%&ndash;옵션A 매퍼에 없어도 일단 넣어두자, 변수 전달되는거 확인하기에 좋음&ndash;%&gt;--%>
<%--                    <option value="No" ${ph.sc.option=='No' ? "selected" : ""}>상품번호</option>--%>
<%--                    <option value="Ca" ${ph.sc.option=='Ca' ? "selected" : ""}>카테고리</option>--%>
<%--                    <option value="Na" ${ph.sc.option=='Na' ? "selected" : ""}>상품명</option>--%>
<%--                    <option value="Pr" ${ph.sc.option=='Pr' ? "selected" : ""}>가격</option>--%>
<%--                </select>--%>

<%--                <input type="text" name="keyword" class="search-input" type="text" value="${ph.sc.keyword}" placeholder="검색어를 입력해주세요">--%>
<%--                <input type="submit" class="search-button" value="검색">--%>
<%--            </form>--%>
<%--        </div>--%>

        <table>
            <tr>
                <th class="no">번호</th>
                <th class="item-image">이미지</th>
                <th class="name">이벤트명</th>
                <th class="administration">관리</th>
            </tr>
            <c:forEach var="itemVO" items="${list}">
                <tr>
                    <td class="no">${itemVO.itemNo}</td>
                    <td class="item-image"><img src="<c:url value='${itemVO.fileName}'/>" width="100px" height="100px"></td>
                    <td class="name">${itemVO.itemName}</td>
                    <td class="update"><a href="<c:url value="/item/read${ph.sc.queryString}&itemNo=${itemVO.itemNo}"/>">변경/삭제</a></td>
                </tr>
            </c:forEach>
        </table>


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