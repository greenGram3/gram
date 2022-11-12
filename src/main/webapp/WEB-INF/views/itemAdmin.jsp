<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="true"%>

<%@ page import="java.net.URLDecoder"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
  <style>
    * { box-sizing:border-box; }
    form {
      width:400px;
      height:600px;
      display : flex;
      flex-direction: column;
      align-items:center;
      position : absolute;
      top:50%;
      left:50%;
      transform: translate(-50%, -50%) ;
      border: 1px solid rgb(89,117,196);
      border-radius: 10px;
    }
    .input-field {
      width: 300px;
      height: 40px;
      border : 1px solid rgb(89,117,196);
      border-radius:5px;
      padding: 0 10px;
      margin-bottom: 10px;
    }
    button {
      background-color: rgb(89,117,196);
      border-radius: 5px;
      border : none;
      cursor: pointer;
      color : white;
      width:80px;
      height:40px;
      font-size: 17px;
      margin : 10px 0 30px 0;
    }

    .category_option {
      width: 300px;
      height: 40px;
      border : 1px solid rgb(89,117,196);
      border-radius:5px;
      padding: 0 10px;
      margin-bottom: 10px;
    }
    label {
      width:300px;
      height:30px;
      margin-top :4px;
    }
    .button_container {
      width: 300px;
      display: flex;
      justify-content: space-evenly;
    }
    .title {
      font-size : 20px;
      font-weight: bold;
      margin: 40px 0 30px 0;
    }
    .category_option .current_option {
      font-weight: bold;
    }
  </style>
  <title>상품 정보 수정</title>

</head>

<body>

<script>
  let msg = "${msg}";
  if(msg=="MOD_ERR") alert("게시물 수정에 실패했습니다. 다시 시도해주세요.");
  if(msg=="DEL_ERR") alert("게시물 삭제에 실패했습니다. 다시 시도해주세요.");
  if(msg=="DEL_ERR") alert("게시물 등록에 실패했습니다. 다시 시도해주세요.");
  if(msg=="UniqueKey_ERR") alert("게시물 등록에 실패했습니다.(중복 오류)");
</script>
<%--등록버튼 누르면 테이블에 insert 되도록 컨트롤러 돌려야될거같음--%>
<%--<form:form modelAttribute="user">--%>
<form id="form" action="" method="">
  <div class="title">상품 정보 관리</div>
  <label for="itemNo">상품번호</label>
  <input class="input-field" type="text" id="itemNo" name="itemNo", value="${vo.itemNo}", readonly>
  <label for="itemCategory1">카테고리1</label>
  <select class="category_option" id="itemCategory1" name="itemCategory1">
    <option class="current_option" value="${vo.itemCategory1}" selected>${vo.itemCategory1}</option>
    <option value="한식">한식</option>
    <option value="중식">중식</option>
    <option value="일식">일식</option>
    <option value="분식">분식</option>
    <option value="야식">야식</option>
  </select>
  <label for="itemCategory2">카테고리2</label>
  <select class="category_option" id="itemCategory2" name="itemCategory2">
    <option class="current_option" value="${vo.itemCategory2}" selected>${vo.itemCategory2}</option>
    <option value="한식">한식</option>
    <option value="중식">중식</option>
    <option value="일식">일식</option>
    <option value="분식">분식</option>
    <option value="야식">야식</option>
    <option value="선택안함">선택안함</option>
  </select>
  <label for="itemName">상품명</label>
  <input class="input-field" type="text" id="itemName" name="itemName" value="${vo.itemName}">
  <label for="itemAmount">재고수량</label>
  <input class="input-field" type="number" id="itemAmount" name="itemAmount" value="${vo.itemAmount}">
  <label for="itemPrice">가격</label>
  <input class="input-field" type="number" id="itemPrice" name="itemPrice" value="${vo.itemPrice}">
  <div class="button_container">
    <button type="button" id="modifyBtn" class="btn-modify">등록</button>
    <button type="button" id="removeBtn" class="btn-remove">삭제</button>
    <button type="button" id="listBtn" class="btn-cancel">취소</button>
  </div>
</form>

<script>

  $(document).ready(function(){

    let formCheck = function() {
      let form = document.getElementById("form");

      if(form.itemName.value=="") {
        alert("상품명을 입력해 주세요.");
        form.itemName.focus();
        return false;
      }
      if(form.itemAmount.value=="") {
        alert("재고수량을 입력해 주세요.");
        form.itemAmount.focus();
        return false;
      }
      if(form.itemPrice.value=="") {
        alert("가격을 입력해 주세요.");
        form.itemPrice.focus();
        return false;
      }
      return true;
    }

    $("#modifyBtn").on("click", function(){
      let form = $("#form");
      form.attr("action", "<c:url value='/item/modify${searchCondition.queryString}'/>");
      form.attr("method", "post");
      if(formCheck())
        form.submit();
    });

    $("#listBtn").on("click", function(){
      location.href="<c:url value='/item/list${searchCondition.queryString}'/>";
    });

    $("#removeBtn").on("click", function(){
      if(!confirm("정말로 삭제하시겠습니까?")) return;
      let form = $("#form");
      form.attr("action", "<c:url value='/item/remove${searchCondition.queryString}'/>");
      form.attr("method", "post");
      form.submit();
    });

  });

</script>

</body>

</html>

