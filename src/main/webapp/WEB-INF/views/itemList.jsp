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

<jsp:include page="include/header.jsp" flush="false" />
<main>

<script>
    let msg = "${msg}";
    if(msg=="LIST_ERR")  alert("상품 목록을 가져오는데 실패했습니다. 다시 시도해 주세요.");
    if(msg=="READ_ERR")  alert("삭제되었거나 없는 상품입니다.");
    if(msg=="MOD_OK") alert("성공적으로 수정되었습니다.");
    <%--let reMsg = "${param.msg}";--%>
    if(msg=="DEL_OK") alert("성공적으로 삭제되었습니다.");
    if(msg=="UPL_OK") alert("성공적으로 등록 되었습니다.");
</script>

    <div class="main">
        <jsp:include page="include/admin.jsp" flush="false" />

        <div class="itemList">
<%--<div id="menu">--%>
<%--    <ul>--%>
<%--        <li id="logo">meal</li>--%>
<%--        <li><a href="<c:url value='/'/>">Home</a></li>--%>
<%--        <li class="item-admin">상품관리</li>--%>
<%--        <li><a href="<c:url value='/order/list'/>">판매관리</a></li>--%>
<%--        <li><a href="<c:url value='/user/list'/>">회원관리</a></li>--%>
<%--        <li><a href=""><i class="fa fa-search"></i></a></li>--%>
<%--    </ul>--%>
<%--</div>--%>

<div class="pageTitle_container">
    <h1>상품 및 재고목록</h1>
    <hr>
</div>

<div>
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
                <th class="item-image">이미지</th>
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
                    <td class="item-image"><img src="${itemVO.imgName}" width="100px" height="100px"></td>
                    <td class="category1">${itemVO.itemCategory1}</td>
                    <td class="category1">${itemVO.itemCategory2}</td>
                    <td class="name">${itemVO.itemName}</td>
                    <td class="amount">${itemVO.itemAmount} 개</td>
                    <td class="price"><fmt:formatNumber pattern="###,###,###" value="${itemVO.itemPrice}"/> 원</td>
                    <td class="update"><a href="<c:url value="/item/read${ph.sc.queryString}&itemNo=${itemVO.itemNo}"/>">변경/삭제</a></td>
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
        </div>
    </div>
</main>
<jsp:include page="include/footer.jsp" flush="false" />
</body>
</html>