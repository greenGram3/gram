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
    <c:if test="${category ne '베스트' && category ne '신메뉴'}">
      <div class="searchBox">
      <select class="search-option" name="option">
        <option value="정렬조건">정렬조건</option>
        <option value="highPrice">가격높은순</option>
        <option value="lowPrice">가격낮은순</option>
        <option value="latest">최신순</option>
        <option value="review">리뷰많은순</option>
      </select>
  </div>
      <script>
        let searchOption = document.querySelector('.search-option');
        searchOption.addEventListener("change", function(e){
          if(e.target.value === '정렬조건') return;
          $.ajax({
            type: 'Post',
            url: 'select',
            data: {
              value : e.target.value,
              category : '${category}'
            },
            success: function (result) {
              let itemVOList = document.querySelector('.itemVOList');
              itemVOList.innerHTML = "";
              for(let i = 0; i < result.itemNo.length; i++) {
                itemVOList.innerHTML +=
                        '<div class="itemVO"><ul><li> <a href="/meal/itemDetail?itemNo=' +result.itemNo[i]+'"><img src="/meal'+result.fileName[i]+'"  width="300"></a> <h2>'+result.itemName[i]+'</h2> <h3>'+result.itemPrice[i]+' 원</h3> </li></ul> </div>';
              }

            },
            error: function (result) {
              alert('error : '+result+" "+result.code);
            }
          })
        })
      </script>
    </c:if>

    <div class="itemVOList">
    <c:forEach var="itemVO" items="${itemList}">
      <c:set var="pageLink" value="/itemDetail?itemNo=${itemVO.itemNo}"/>
      <div class="itemVO">
        <ul>
          <li>
            <a href="<c:url value='${pageLink}'/>"> <img src="<c:url value='${itemVO.fileName}'/>" width="300"></a>
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
