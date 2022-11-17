<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>itemDetailPage</title>
    <link rel="stylesheet" href="<c:url value='/css/item.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<div class="itemDetailPage">
    <img src="<c:url value='${imageResult.imgName}'/>"> <!-- imageResult.imgName -->
</div>
</body>
</html>
