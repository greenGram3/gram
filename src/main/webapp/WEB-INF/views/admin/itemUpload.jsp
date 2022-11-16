<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="true"%>

<%--<%@ page import="java.net.URLDecoder"%>--%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="<c:url value='/css/item.css'/>">
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

  <title>상품 등록</title>

</head>

<body>
<jsp:include page="../include/header.jsp" flush="false" />

<script>
  let msg = "${msg}";
  if(msg=="UPL_ERR") alert("게시물 등록에 실패했습니다. 다시 시도해주세요.");
</script>
<main>

  <div class="main">
    <jsp:include page="../include/admin.jsp" flush="false" />

    <div class="itemUpload">
<%--등록버튼 누르면 테이블에 insert 되도록 컨트롤러 돌려야될거같음--%>
<%--<form:form modelAttribute="user">--%>
<form id="form" action="" method="" enctype="">
  <h3>상품 등록</h3>
  <hr>
  <table>
  <tr>
    <th><label for="itemCategory1">카테고리1</label></th>
    <td> <select class="category_option" id="itemCategory1" name="itemCategory1">
      <option class="current_option" value="" selected>선택</option>
      <option value="한식">한식</option>
      <option value="중식">중식</option>
      <option value="일식">일식</option>
      <option value="분식">분식</option>
      <option value="야식">야식</option>
    </select></td>
  </tr>

  <tr>
    <th><label for="itemCategory2">카테고리2</label></th>
    <td>  <select class="category_option" id="itemCategory2" name="itemCategory2">
      <option class="current_option" value="" selected>선택</option>
      <option value="한식">한식</option>
      <option value="중식">중식</option>
      <option value="일식">일식</option>
      <option value="분식">분식</option>
      <option value="야식">야식</option>
      <option value="선택안함">선택안함</option>
    </select></td>
  </tr>
    <tr>
      <th><label for="itemName">상품명</label></th>
      <td><input class="input-field" type="text" id="itemName" name="itemName"  value=""></td>
    </tr>
    <tr>
      <th><label for="itemAmount">재고수량</label></th>
      <td> <input class="input-field" type="number" id="itemAmount" name="itemAmount" value=""></td>
    </tr>

    <tr>
      <th><label for="itemPrice">가격</label></th>
      <td><input class="input-field" type="number" id="itemPrice" name="itemPrice" value=""></td>
    </tr>

    <tr>
      <th>상품이미지</th>
      <td>
        <img src="" class="select_img"><br> <!-- 대표이미지 -->
        <input type="file" name="imgNamef" id="imgNamef"></td>
      </td>
      <td>
        <img src="" class="select_img1"><br> <!-- 파일 미리보기(js이용) -->
        <input type="file" name="imgNamef1" id="imgNamef1"></td>
      </td>
    </tr>
    <script>
      $('#imgNamef').change(function () {
        if (this.files && this.files[0]) {
          let reader = new FileReader;
          reader.readAsDataURL(this.files[0]);
          reader.onload = function (e) {
            $(".select_img").attr("src", e.target.result)
                    .width(150).height(150);
          }
        }
      }); //change

      $('#imgNamef1').change(function () {
        if (this.files && this.files[0]) {
          let reader = new FileReader;
          reader.readAsDataURL(this.files[0]);
          reader.onload = function (e) {
            $(".select_img1").attr("src", e.target.result)
                    .width(150).height(150);
          }
        }
      }); //change
    </script>

  </table>

  <div class="button_container">
    <button type="button" id="uploadBtn" class="btn-modify">등록</button>
    <button type="button" id="listBtn" class="btn-cancel">취소</button>
  </div>
</form>

<script>

  $(document).ready(function(){

    let formCheck = function() {
      let form = document.getElementById("form");

      if(form.itemCategory1.value=="") {
        alert("카테고리1을 선택해 주세요.");
        return false;
      }

      if(form.itemCategory2.value=="") {
        alert("카테고리2를 선택해 주세요.");
        return false;
      }

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

    $("#uploadBtn").on("click", function(){
      let form = $("#form");
      form.attr("enctype","multipart/form-data");
      form.attr("action", "<c:url value='/item/upload'/>");
      form.attr("method", "post");
      if(formCheck())
        form.submit();
    });

    $("#listBtn").on("click", function(){
      location.href="<c:url value='/item/list'/>";
    });

  });

</script>
    </div>
  </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>

</html>

