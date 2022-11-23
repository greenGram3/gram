<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>서비스 오류 안내</title>
    <style>

        @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@400;500&display=swap');

        * {
            margin: auto;
            padding: 0;
            list-style: none;
            text-decoration: none;
            color: rgb(18, 14, 2);
            font-family: 'IBM Plex Sans KR', sans-serif;
        }

        .errorPage {
            margin-top: 250px;
            width: 500px;
            text-align: center;
        }

        h1 {
            margin-top: 30px;
            margin-bottom: 20px;
        }

        .btn {
            display: flex;
            margin-top: 20px;
            justify-content: center;
        }
        button {
            width: 100px;
            height: 40px;
            border-radius: 0px;
            background-color: white;
            border: 1px solid gray;
            margin: 0px 20px;
            cusor: pointer;
        }

    </style>
</head>
<body>

<div class="errorPage">
  <img src="<c:url value='/icon/not.png'/>" width="250">

<h1>요청하신 페이지를 찾을 수 없습니다</h1>
<div>서비스 이용에 불편을 드려 죄송합니다</div>
    <div class="btn">
<button class="back" onclick="history.back()">뒤로가기</button>
<button class="home" onclick="location.href='/meal'">홈 바로가기</button></div>
</div>
</body>

</html>
