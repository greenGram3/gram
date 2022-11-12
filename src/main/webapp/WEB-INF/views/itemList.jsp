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
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
        }
        a {
            text-decoration: none;
            color: black;
        }
        button,
        input {
            border: none;
            outline: none;
        }
        .board-container {
            width: 60%;
            height: 1200px;
            margin: 0 auto;
            /* border: 1px solid black; */
        }
        .search-container {
            background-color: rgb(253, 253, 250);
            width: 100%;
            height: 110px;
            border: 1px solid #ddd;
            margin-top : 10px;
            margin-bottom: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .search-form {
            height: 37px;
            display: flex;
        }
        .search-option {
            width: 100px;
            height: 100%;
            outline: none;
            margin-right: 5px;
            border: 1px solid #ccc;
            color: gray;
        }
        .search-option > option {
            text-align: center;
        }
        .search-input {
            color: gray;
            background-color: white;
            border: 1px solid #ccc;
            height: 100%;
            width: 300px;
            font-size: 15px;
            padding: 5px 7px;
        }
        .search-input::placeholder {
            color: gray;
        }
        .search-button {
            /* 메뉴바의 검색 버튼 아이콘  */
            width: 20%;
            height: 100%;
            background-color: rgb(22, 22, 22);
            color: rgb(209, 209, 209);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 15px;
        }
        .search-button:hover {
            color: rgb(165, 165, 165);
        }
        table {
            border-collapse: collapse;
            width: 100%;
            border-top: 2px solid rgb(39, 39, 39);
        }
        tr:nth-child(even) {
            background-color: #f0f0f070;
        }
        th,
        td {
            width:300px;
            text-align: center;
            padding: 10px 12px;
            border-bottom: 1px solid #ddd;
        }
        td {
            color: rgb(53, 53, 53);
        }
        .page {
            color: black;
            padding: 6px;
            margin-right: 10px;
        }
        .paging-active {
            background-color: rgb(216, 216, 216);
            border-radius: 5px;
            color: rgb(24, 24, 24);
        }
        .paging-container {
            width:100%;
            height: 70px;
            /*display: inline-flex;*/
            position: relative;
            margin-top: 50px;
            margin : auto;
        }
        .paging {
            color: black;
            width: 80%;
            align-items: center;
            position: absolute;
            transform: translate(calc(1/8*100%), 0);
            margin: 20px 0;
        }
        .itemUpload-button {
            width: 8%;
            height: 60%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 15px;
            position: absolute;
            margin-top: 10px;
            right: 35px;
            background-color: rgb(89,117,196);
            border-radius: 5px;
            border : none;
            cursor: pointer;
            color: #fff;
        }
        .board-container {
            margin-top: 50px;
        }

        .pageTitle_container {
            margin-top: 50px;
            display: flex;
            justify-content: center;
        }
        .item-admin {
            font-weight: bold;
            color: #ffffff;
        }
    </style>
</head>

<body>
<script>
    let msg = "${msg}";
    if(msg=="LIST_ERR")  alert("상품 목록을 가져오는데 실패했습니다. 다시 시도해 주세요.");
    if(msg=="READ_ERR")  alert("삭제되었거나 없는 상품입니다.");
    if(msg=="MOD_OK") alert("성공적으로 수정되었습니다.");
    <%--let reMsg = "${param.msg}";--%>
    if(msg=="DEL_OK") alert("성공적으로 삭제되었습니다.");
    if(msg=="UPL_OK") alert("성공적으로 등록 되었습니다.");
</script>
<div id="menu">
    <ul>
        <li id="logo">meal</li>
        <li><a href="<c:url value='/'/>">Home</a></li>
        <li class="item-admin">상품관리</li>
        <li><a href="<c:url value='/order/list'/>">판매관리</a></li>
        <li><a href="<c:url value='/user/list'/>">회원관리</a></li>
        <li><a href=""><i class="fa fa-search"></i></a></li>
    </ul>
</div>

<div class="pageTitle_container">
    <h2>상품관리</h2>
</div>

<div style="text-align:center">
    <div class="board-container">
        <div class="search-container">
            <form action="<c:url value="/item/list"/>" class="search-form" method="get">
                <select class="search-option" name="option">
                    <option value="A" ${ph.sc.option=='A' || ph.sc.option=='' ? "selected" : ""}>전체</option>
                    <%--옵션A 매퍼에 없어도 일단 넣어두자, 변수 전달되는거 확인하기에 좋음--%>
                    <option value="No" ${ph.sc.option=='No' ? "selected" : ""}>상품번호</option>
                    <option value="Ca" ${ph.sc.option=='Ca' ? "selected" : ""}>카테고리</option>
                    <option value="Na" ${ph.sc.option=='Na' ? "selected" : ""}>상품명</option>
                    <option value="Pr" ${ph.sc.option=='Pr' ? "selected" : ""}>가격</option>
                </select>

                <input type="text" name="keyword" class="search-input" type="text" value="${ph.sc.keyword}" placeholder="검색어를 입력해주세요">
                <input type="submit" class="search-button" value="검색">
            </form>
        </div>

        <table>
            <tr>
                <th class="no">번호</th>
                <th class="category1">카테고리1</th>
                <th class="category2">카테고리2</th>
                <th class="name">상품명</th>
                <th class="amount">재고수량</th>
                <th class="price">가격</th>
                <th class="administration">관리</th>
            </tr>
            <c:forEach var="itemVO" items="${list}">
                <tr>
                    <td class="no">${itemVO.itemNo}</td>
                    <td class="category1">${itemVO.itemCategory1}</td>
                    <td class="category1">${itemVO.itemCategory2}</td>
                    <td class="name">${itemVO.itemName}</td>
                    <td class="amount">${itemVO.itemAmount}</td>
                    <td class="price">${itemVO.itemPrice}</td>
                    <td class="update"><a href="<c:url value="/item/read${ph.sc.queryString}&itemNo=${itemVO.itemNo}"/>">수정/삭제</a></td>
                </tr>
            </c:forEach>
        </table>

        <div class="paging-container">
            <div class="paging">
                <c:if test="${totalCnt==null || totalCnt==0}">
                    <div> 게시물이 없습니다. </div>
                </c:if>
                <c:if test="${totalCnt!=null && totalCnt!=0}">
                    <c:if test="${ph.showPrev}">&lt;</c:if>
                    <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                        <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value="/item/list${ph.sc.getQueryString(i)}"/>">${i} </a>
                    </c:forEach>
                    <c:if test="${ph.showNext}">&gt;</c:if>
                </c:if>
            </div>
            <button type="button" class="itemUpload-button" id="uploadBtn">상품등록</button>
        </div>

    </div>
</div>

<script>

    $(document).ready(function(){

        $("#uploadBtn").on("click", function(){
            location.href="<c:url value='/item/upload'/>";

        });

    });

</script>

</body>
</html>