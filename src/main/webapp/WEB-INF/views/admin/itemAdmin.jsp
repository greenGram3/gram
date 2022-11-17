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
  <link rel="stylesheet" href="<c:url value='/css/item.css'/>">
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

  <title>상품 정보 수정</title>

</head>

<body>
<jsp:include page="../include/header.jsp" flush="false" />

<script>
  let msg = "${msg}";
  if(msg=="MOD_ERR") alert("게시물 수정에 실패했습니다. 다시 시도해주세요.");
  if(msg=="DEL_ERR") alert("게시물 삭제에 실패했습니다. 다시 시도해주세요.");
  if(msg=="DEL_ERR") alert("게시물 등록에 실패했습니다. 다시 시도해주세요.");
  if(msg=="UniqueKey_ERR") alert("게시물 등록에 실패했습니다.(중복 오류)");
</script>
<main>

  <div class="main">
    <jsp:include page="../include/admin.jsp" flush="false" />

    <div class="itemAdmin">

<%--등록버튼 누르면 테이블에 insert 되도록 컨트롤러 돌려야될거같음--%>
<%--<form:form modelAttribute="user">--%>
<form id="form" action="" method="" enctype="">
  <h3>상품 정보 수정</h3>
  <hr>
  <table>
    <tr>
      <th><label for="itemNo">상품번호</label></th>
      <td colspan="2"><input class="input-field" type="text" id="itemNo" name="itemNo", value="${vo.itemNo}", readonly></td>
    </tr>
    <tr>
      <th><label for="itemCategory1">카테고리1</label></th>
      <td colspan="2"> <select class="category_option" id="itemCategory1" name="itemCategory1">
        <option class="current_option" value="${vo.itemCategory1}" selected>${vo.itemCategory1}</option>
        <option value="한식">한식</option>
        <option value="양식">양식</option>
        <option value="중식/일식">중식/일식</option>
        <option value="분식/야식">분식/야식</option>
        <option value="세트상품">세트상품</option>
      </select></td>
    </tr>
    <tr>
      <th><label for="itemCategory2">카테고리2</label></th>
      <td colspan="2"><select class="category_option" id="itemCategory2" name="itemCategory2">
        <option class="current_option" value="${vo.itemCategory2}" selected>${vo.itemCategory2}</option>
        <option value="비오는날">비오는날</option>
        <option value="집들이">집들이</option>
        <option value="캠핑">캠핑</option>
        <option value="술안주">술안주</option>
        <option value="혼밥">혼밥</option>
        <option value="선택안함">선택안함</option>
      </select></td>
    </tr>
    <tr>
      <th><label for="itemName">상품명</label></th>
      <td colspan="2"><input class="input-field" type="text" id="itemName" name="itemName" value="${vo.itemName}"></td>
    </tr>
    <tr>
      <th><label for="itemAmount">재고수량</label></th>
      <td colspan="2"><input class="input-field" type="number" id="itemAmount" name="itemAmount" value="${vo.itemAmount}"></td>
    </tr>

    <tr>
      <th><label for="itemPrice">가격</label></th>
      <td colspan="2"><input class="input-field" type="number" id="itemPrice" name="itemPrice" value="${vo.itemPrice}"></td>
    </tr>

     <!-- Image Update -->
     <tr>
       <th>상품이미지</th>
    <td>
      <li class="topImage">대표이미지</li>
      <li><img src="${vo.imgName}" class="select_img" width="100px" height="100px"></li>
      <li><input type="hidden" name="imgName" id="imgName" value="${vo.imgName}"></li>
      <li><input type="file" name="imgNamef" id="imgNamef" value=""></li>
    </td>
    <td>
      <li><img src="${vo1.imgName}" class="select_img1" width="100px" height="100px"></li>
      <li><input type="hidden" name="imgName" id="imgName1" value="${vo1.imgName}"></li>
      <li><input type="file" name="imgNamef1" id="imgNamef1" value=""></li>
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
      });

      $('#imgNamef1').change(function () {
        if (this.files && this.files[0]) {
          let reader = new FileReader;
          reader.readAsDataURL(this.files[0]);
          reader.onload = function (e) {
            $(".select_img1").attr("src", e.target.result)
                    .width(150).height(150);
          }
        }
      });
    </script>
  </table>
  <div class="button_container">
    <button type="button" id="modifyBtn" class="btn-modify">변경</button>
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
      // ** Heejeong 첨부파일 업로드 체크
      if(form.imgNamef.value=="") {
        alert("좌측 대표 이미지를 첨부해주세요.");
        return false;
      }

      if(form.imgNamef1.value=="") {
        alert("우측 상세 이미지를 첨부해주세요.");
        return false;
      }
      return true;
    }

    $("#modifyBtn").on("click", function(){
      let form = $("#form");
      form.attr("enctype","multipart/form-data")
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
    </div>
  </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>

</html>

