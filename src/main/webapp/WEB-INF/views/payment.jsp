<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@page session="true"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>payment</title>

  <link rel="stylesheet" href="<c:url value='/css/pay.css'/>">
  <!-- jQuery -->
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <!-- iamport.payment.js -->
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

</head>

<body>

<jsp:include page="include/header.jsp" flush="false" />
<main>
  <div class="main">
    <div class="payment">
      <h1>주문서작성/결제</h1>
      <hr>

  <div class="board-container">

    <form id="form" action="" method="">
      <h3>주문상세내역</h3>
      <table>
        <tr>
          <th>상품/옵션정보</th>
          <th>수량</th>
          <th>상품금액</th>
        </tr>
        <c:forEach var="list" items="${odvoList}" varStatus="status">
          <tr >
            <td>
<%--             <img src="${list.fileName}" width="100"> --%>
                <input hidden name="itemNo" type="text" value="${list.itemNo}">
                <input hidden name="itemName${status.index}" type="text" value="${list.itemName}">
                ${list.itemName}
            </td>
            <td><input hidden name="cartAmount" type="text" value="${list.cartAmount}">
                ${list.cartAmount} 개</td>
            <td><input hidden name="itemPrice" type="text" value="${list.itemPrice}">
              <fmt:formatNumber pattern="###,###,###" value="${list.itemPrice}"/> 원</td>
          </tr>
        </c:forEach>
      </table>

      <h3>주문자 정보</h3>
      <table>
        <tr>
          <th>구매자이름</th>
          <td><input type="text" name="userName" value="${userVo.userName}" readonly></td>
        </tr>
        <tr>
          <th>구매자이메일</th>
          <td><input type="text" name="userEmail" value="${userVo.userEmail}" readonly></td>
        </tr>
        <tr hidden>
          <th>주문형태</th>
          <td><input type="hidden" name="orderType" value="${orderType}" /></td>
        </tr>
      </table>
        <br>
        <h3>배송정보</h3>
      <table>  <tr>
        <th> 배송지 확인</th>
        <td>
        <c:forEach var="list" items="${delyList}" varStatus="status">
             <input type="radio" id="delyPlace" name="delyPlace" value="${list.delyPlace}" ${list.delyNo==1 ? "checked" : ""}/>
              ${list.delyPlace} ${list.delyNo==1 ? "(기본배송지)" : ""}
              <button type="button" class="delyBtn" id="openBtn${status.index}">상세보기</button>
          <script>
            $("#openBtn${status.index}").on("click", function(){

              window.open("<c:url value='/buy/delyView'/>?delyPlace=${list.delyPlace}","Child","left=400,top=200,width=500,height=500");

            });
          </script>
        </c:forEach>
        </td>
        </tr>
        <tr>
          <th>남기실 말씀</th>
          <td class="order-req">
            <input class="order-req-input" type="text" maxlength="60" name="orderReq" value="" placeholder="60자 이내로 입력 가능합니다." />
          </td>
        </tr>
      </table>

      <br>
      <h3>결제정보</h3>
      <table>
        <tr class="payment-tr">
          <th>결제수단</th>
          <td>
            <select name="payment">
              <option value="card" selected>card</option>
            </select>
          </td>
        </tr>
      </table>
      <input hidden name="totalPrice" type="text" value="${totalPrice}">
      <div class="total"><h3>최종 결제 금액</h3> <h2><fmt:formatNumber pattern="###,###,###" value="${totalPrice}"/></h2><h3>원</h3></div>
        <div class="payCheck"> <button type="button" id="check_module" class="payment-Btn"> 결제하기 </button> </div>


    </form>

<script>

  $('.order-req-input').keyup(function (e) {

    let content = $(this).val();

    // 글자수 제한
    if (content.length > 60) {
      // 60자 넘으면 알림창 뜨도록
      alert('글자수는 60자까지 입력 가능합니다.');
    };

  });

  $("#check_module").on("click", function () {

    //테스트용 코드
    let form = $("#form");
    form.attr("action", "<c:url value='/buy/confirm' />");
    form.attr("method", "post");
    form.submit();

    <%--let IMP = window.IMP;--%>
    <%--IMP.init("imp12500623")--%>

    <%--IMP.request_pay({--%>
    <%--  pg : 'html5_inicis',--%>
    <%--  merchant_uid: "${uniqueNo}",--%>
    <%--  name : '${vo.itemName} ${vo.itemAmount}개',--%>
    <%--  amount : ${totalItemPrice},--%>
    <%--  pay_method : $("#payment").val(),--%>
    <%--  buyer_email : '${userVo.userEmail}',--%>
    <%--  buyer_name : '${userVo.userName}',--%>
    <%--}, function (rsp) {--%>
    <%--  if(rsp.success) {--%>
    <%--    alert("결제가 완료되었습니다.");--%>
    <%--    let form = $("#form");--%>
    <%--    form.attr("action", "<c:url value='/buy/confirm' />");--%>
    <%--    form.attr("method", "post");--%>
    <%--    form.submit();--%>
    <%--  } else {--%>
    <%--    alert("결제에 실패했습니다. 에러 내용: " + rsp.error_msg);--%>
    <%--  }--%>

    <%--}); //request_pay--%>

  }); //check_module

</script>
  </div>
    </div>
  </div>
</main>
<jsp:include page="include/footer.jsp" flush="false" />
</body>

</html>