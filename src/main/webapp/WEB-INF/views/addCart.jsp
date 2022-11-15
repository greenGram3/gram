<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>addCart</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<script>
    if (confirm("장바구니에 추가 되었습니다. 장바구니로 이동하시겠습니까?")) {
        location.href = "cart"; //확인
    } else {
        history.back(); //취소
    }
</script>
</body>
</html>
