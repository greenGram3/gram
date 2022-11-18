<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="false" %>
<html>
<head>
  <title>itemDetail</title>
  <link rel="stylesheet" href="<c:url value='/css/item.css'/>">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

</head>
<body>
<jsp:include page="../include/header.jsp" flush="false"/>

<main>
  <div class="main">
  <div class="category">
    <h1>${category}</h1>
    <hr>
    <div class="itemVOList">
    <c:forEach var="itemVO" items="${itemList}">
      <c:set var="pageLink" value="/itemDetail?itemNo=${itemVO.itemNo}"/>
      <div class="itemVO">
        <ul>
          <li>
            <a href="<c:url value='${pageLink}'/>"> <img src="<c:url value='${itemVO.imgName}'/>" width="300"></a>
            <h2>${itemVO.itemName}</h2>
            <h3><fmt:formatNumber pattern="###,###,###" value="${itemVO.itemPrice}"/> 원</h3>
          </li>
        </ul>
      </div>
    </c:forEach>
  </div>
  </div>
  </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false"/>
</body>
</html>
