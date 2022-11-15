<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<%--<%@ page import="java.net.URLDecoder"%>--%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>payment</title>
  <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
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
    }
    table {
      border-collapse: collapse;
      width: 100%;
      border-top: 2px solid rgb(39, 39, 39);
    }
    .tr1, .tr3, .tr6, .tr8 {
      background-color: #f0f0f070;
    }
    .tr2 td, .tr6 td, tr4 td {
      display: flex;
      justify-content: center;
      align-items: center;
    }
    th,
    td {
      width:100px;
      text-align: center;
      padding: 10px 12px;
    }
    td {
      color: rgb(53, 53, 53);
    }
    .tr2 {
      width: 100%;
    }
    .tr1, .tr2, .tr3, .tr4, .tr5, .tr6, .tr7 {
      display: flex;
      justify-content: space-evenly;
      width: 100%;
    }
    .dely-addr, .order-req {
      width: 100%;
    }
    .delyAddr-select, .orderReq-select {
      width: 100%;
    }
    .block-div {
      width: 100%;
      height: 50px;
      border-bottom: 1px solid rgb(39, 39, 39);
    }
    .board-container {
      margin-top: 50px;
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
    .tr5 input {
      text-align: center;
      border: 1px solid black;
      height: 100px;
    }
    .order-req-input {
      width: 100%;
      border: 1px solid black;
    }
  </style>
</head>

<body>

<div id="menu">
</div>

<div class="pageTitle_container">
  <h2>결제하기</h2>
</div>

<div style="text-align:center">

  <div class="board-container">
    <form id="form" action="" method="">
      <table>
        <tr class="tr1">
          <th class="item-no">상품번호</th>
          <th class="item-name">상품명</th>
          <th class="item-amount">수량</th>
          <th class="item-price">가격</th>
        </tr>
        <tr class="tr2">
          <td><input name="itemNo" type="text" value="${dto.itemNo}"></td>
          <td><input name="itemName" type="text" value="${dto.itemName}"></td>
          <td><input name="itemAmount" type="text" value="${dto.itemAmount}"></td>
          <td><input name="itemPrice" type="text" value="${dto.itemPrice}"></td>
        </tr>

        <tr class="block-div"></tr>

        <tr class="tr3">
          <th class="dely-addr">배송지</th>
        </tr>
        <tr class="tr4">
          <td><button type="button" id="delySelectBtn" class="delySelect-Btn">배송지선택</button></td>
        </tr>
        <tr class="tr5">
          <td class="dely-addr"><input class="delyAddr-select" name="delyAddr" type="content" value=""></td>
        </tr>

        <tr class="block-div"></tr>

        <tr class="tr6">
          <th class="order-req">요청사항</th>
        </tr>
        <tr class="tr7">
          <td class="order-req"><input class="order-req-input" name="orderReq" type="content" value=""></td>
        </tr>

        <tr class="block-div"></tr>

        <tr class="tr8">
          <th class="order-payment">결제수단</th>
        </tr>
        <tr class="tr9">
          <td class="order-payment"><input class="orderPayment-select" name="payment" type="content" value=""></td>
        </tr>

        <tr class="block-div"></tr>

        <tr class="tr10">
          <td><button type="button" id="check_module" class="payment-Btn">결제하기</button></td>
        </tr>

      </table>

    </form>

  </div>

</div>

<script>

  $("#check_module").on("click", function () {

    let IMP = window.IMP;
    IMP.init("imp12500623")

    IMP.request_pay({
      pg : 'html5_inicis',
      pay_method : 'card',
      merchant_uid: "57008833-33010",
      name : '당근 10kg',
      amount : 1000,
      buyer_email : 'Iamport@chai.finance',
      buyer_name : '아임포트 기술지원팀',
      buyer_tel : '010-1234-5678',
      buyer_addr : '서울특별시 강남구 삼성동',
      buyer_postcode : '123-456',
    }, function (rsp) {
      if(rsp.success) {
        jQuery.ajax({
          url: "paymentConfirm",
          method: "POST",
          headers: { "Content-Type": "application/json" },
          data: {
            imp_uid: rsp.imp_uid,
            merchant_uid: rsp.merchant_uid
          }
        }).done(function (data) {
          alert("결제에 성공했습니다.");
        })
      } else {
        alert("결제에 실패했습니다. 에러 내용: " + rsp.error_msg);
      }

    });
  })
</script>

</body>

</html>