<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@page session="true"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>payment</title>
<%--  <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">--%>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <!-- jQuery -->
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <!-- iamport.payment.js -->
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: "Noto Sans KR", sans-serif;
    }

    .board-container {
      width: 60%;
      height: 1200px;
      margin: 50px auto 0 auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    .table-one {
      border-top: 2px solid rgb(39, 39, 39);
    }

    .item-tr,
    .addr-tr,
    .req-tr,
    .payment-tr {
      width: 100%;
      background-color: #f0f0f070;
    }

    th,
    td {
      width:100px;
      text-align: center;
      padding: 10px 12px;
    }

    .block-div {
      width: 100%;
      height: 50px;
      border-bottom: 1px solid rgb(39, 39, 39);
    }
    .pageTitle_container {
      margin-top: 50px;
      display: flex;
      justify-content: center;
    }
    button {
      background-color: rgb(89,117,196);
      border-radius: 5px;
      border : none;
      cursor: pointer;
      color : white;
      width:100px;
      height:40px;
      font-size: 15px;
      margin : 30px 0 20px 0;
    }
    .order-req-input {
      width: 100%;
      height: 80px;
      border: 1px solid black;
    }
    .hidden {
      display: none;
    }
  </style>
</head>

<body>

<div class="pageTitle_container">
  <h2>결제하기</h2>
</div>

<div style="text-align:center">

  <div class="board-container">

    <form id="form" action="" method="">

      <table class="table-one">
        <tr class="item-tr">
          <th>상품번호</th>
          <th>상품명</th>
          <th>수량</th>
          <th>가격</th>
          <th>총금액</th>
        </tr>
        <c:forEach var="list" items="${odvoList}">
          <tr class="itemList-tr">
            <td><input name="itemNo" type="text" value="${list.itemNo}"></td>
            <td><input name="itemName" type="text" value="${list.itemName}"></td>
            <td><input name="cartAmount" type="text" value="${list.cartAmount}"></td>
            <td><input name="itemPrice" type="text" value="${list.itemPrice}"></td>
            <td><input name="totalItemPrice" type="text" value="${totalItemPrice}"></td>
          </tr>

        </c:forEach>
        <tr class="block-div"></tr>
        <tr class="addr-tr">
          <th>배송지</th>
        </tr>
        <c:forEach var="list" items="${delyList}" varStatus="status">
          <table>
            <tr>
              <td>선택 <input type="radio" id="delyPlace" name="delyPlace" value="${list.delyPlace}" ${list.delyNo==1 ? "checked" : ""}/></td>
              <td>${list.delyPlace} ${list.delyNo==1 ? "(기본배송지)" : ""}</td>
              <td><button type="button" id="openBtn${status.index}">상세보기</button></td>
            </tr>
          </table>

          <script>
            $("#openBtn${status.index}").on("click", function(){

              window.open("<c:url value='/buy/delyView'/>?delyPlace=${list.delyPlace}","Child","left=400,top=200,width=500,height=500");

            });
          </script>

        </c:forEach>
      </table>

      <table>
        <tr class="req-tr">
          <th>요청사항</th>
        </tr>
        <tr class="tr7">
          <td class="order-req"><input class="order-req-input" name="orderReq" type="content" value=""></td>
        </tr>
        <tr class="block-div"></tr>
        <tr class="payment-tr">
          <th>결제수단</th>
        </tr>
        <tr>
          <td>
            <select name="payment">
              <option value="card" selected>card</option>
            </select>
          </td>
        </tr>
        <tr class="block-div"></tr>
        <tr>
          <td><button type="button" id="check_module" class="payment-Btn">결제하기</button></td>
        </tr>
      </table>

      <table class="hidden">
        <tr>
          <th>구매자이름</th>
          <td><input type="text" name="userName" value="${userVo.userName}"></td>
        </tr>
        <tr>
          <th>구매자이메일</th>
          <td><input type="text" name="userEmail" value="${userVo.userEmail}"></td>
        </tr>
        <tr>
          <th>주문형태</th>
          <td><input type="hidden" name="orderType" value="${orderType}" /></td>
        </tr>
      </table>

    </form>

  </div>

</div>

<script>

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

</body>

</html>