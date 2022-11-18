<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <title>배송지 정보</title>
    <style>
        table {
            border: 1px solid black;
            margin: 10px;
        }
    </style>
</head>
<body>

<h3>배송지 정보</h3>
<hr>

<table>
    <tr>
        <td><label for="delyPlace">배송지명</label></td>
        <td><input class="input-field" type="text" id="delyPlace" name="delyPlace" value="${vo.delyPlace}" ></td>
    </tr>
    <tr>
        <td><label for="receiver">수령자</label></td>
        <td><input class="input-field" type="text" id="receiver" name="receiver" value="${vo.receiver}" readonly></td>
    </tr>
    <tr>
        <td><label for="delyPhone">연락처</label></td>
        <td><input class="input-field" type="text" id="delyPhone" name="delyPhone" value="${vo.delyPhone}" readonly></td>
    </tr>
    <tr>
        <td><label for="delyAddr">배송지 주소</label></td>
        <td><input class="input-field" type="text" id="delyAddr" name="delyAddr" value="${vo.delyAddr}" readonly></td>
    </tr>
</table>

<button type="button" id="closeBtn" class="close-btn">닫기</button>

<script>

    $(document).ready(function(){

        <%--배송지 목록 팝업창으로 띄워서 배송지 선택하기 (실패)--%>
        <%--$("#delySelect-Btn").on("click", function(){--%>
        <%--    let delyNo = $("#delyNo").val();--%>
        <%--    opener.parent.location.href="<c:url value='/buy'><c:param name="delyNo" value="${list.delyNo}"></c:param></c:url>";--%>
        <%--});--%>

        $("#closeBtn").on("click", function () {
            window.close();
        })

    });

</script>

</body>
</html>
