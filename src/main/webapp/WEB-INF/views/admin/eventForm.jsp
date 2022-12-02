<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="setEvent" value="${eventVO.eventNo==null ? '등록' : '수정'}"/>
<%@ page session="true"%>

<%--<%@ page import="java.net.URLDecoder"%>--%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="<c:url value='/css/event.css'/>">
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

  <title>이벤트 ${setEvent}</title>

</head>

<body>
<jsp:include page="../include/header.jsp" flush="false" />

<script>
  let msg = "${msg}";
  if(msg=="SAVE_ERR") alert("이벤트 등록에 실패했습니다. 다시 시도해주세요.");
  if(msg=="MOD_ERR") alert("이벤트 수정에 실패했습니다. 다시 시도해주세요.");
</script>
<main>

  <div class="main">
    <jsp:include page="../include/admin.jsp" flush="false" />

    <div class="eventForm">

<form id="form" action="" method="" enctype="">
  <h3>이벤트 ${setEvent}</h3>
  <hr>
  <table>
      <input hidden name="eventNo" value="${eventVO.eventNo}">
    <tr>
      <th>이벤트명</th>
      <td colspan="2"><input class="eventName" type="text" id="eventName" name="eventName"  value="${eventVO.eventName}"></td>
    </tr>

    <tr>
      <th>배너</th>
      <td colspan="2">
        <input type="radio" class="none" name="banner" value="none">선택안함　
        <input type="radio" class="banner" name="banner" value="banner">배너　</td>　
    </tr>

    <tr>
      <th>이벤트 이미지</th>
      <td>대표이미지
        <li><img src="<c:url value='${eventVO.imgPath}'/>" class="imgPath" width="200px" height="100px"></li>
        <input hidden name="imgPath" value="${eventVO.imgPath}">
        <li><input type="file" id="imgPath" name="fileName"></li>
      </td>
      <td>상세이미지
        <li><img src="<c:url value='${eventVO.imgName}'/>" class="imgName" width="200px" height="100px"></li>
        <input hidden name="imgName" value="${eventVO.imgName}">
        <li><input type="file" id="imgName" name="detailImage"></li>
      </td>
    </tr>
    <script>

      $('#imgPath').change(function () {
        if (this.files && this.files[0]) {
          let reader = new FileReader;
          reader.readAsDataURL(this.files[0]);
          reader.onload = function (e) {
            $(".imgPath").attr("src", e.target.result)
                    .width(150).height(150);
          }
        }
      }); //change
      $('#imgName').change(function () {
        if (this.files && this.files[0]) {
          let reader = new FileReader;
          reader.readAsDataURL(this.files[0]);
          reader.onload = function (e) {
            $(".imgName").attr("src", e.target.result)
                    .width(150).height(150);
          }
        }
      }); //change
    </script>

  </table>

  <div class="button_container">
    <c:if test="${setEvent == '등록'}">
      <button type="button" id="uploadBtn" class="btn-save">등록</button>
    </c:if>
    <c:if test="${setEvent == '수정'}">
      <button type="button" id="modifyBtn" class="btn-modify">수정</button>
    </c:if>
    <button type="button" id="cancelBtn" class="btn-cancel">취소</button>
  </div>
</form>

<script>

  $(document).ready(function(){
    let event = '${setEvent}';
    let banner;
    if(event == '등록'){
      banner = document.querySelector(".none");
    }else {
      banner = document.querySelector(".${eventVO.banner}");
    }

    banner.setAttribute("checked","checked");

    let uploadCheck = function() {
      let form = document.getElementById("form");
      if(form.eventName.value=="") {
        alert("이벤트명을 입력해주세요.");
        return false;
      }
      if(form.fileName.value=="") {
        alert("대표 이미지를 첨부해주세요");
        return false;
      }
      if(form.detailImage.value=="") {
        alert("상세 이미지를 첨부해주세요");
        return false;
      }
      return true;
    }

    let modifyCheck = function() {
      let form = document.getElementById("form");
      if(form.eventName.value=="") {
        alert("이벤트명을 입력해주세요.");
        return false;
      }
      return true;
    }

    $("#uploadBtn").on("click", function(){
      let form = $("#form");
      form.attr("enctype","multipart/form-data");
      form.attr("action", "<c:url value='/event/upload'/>");
      form.attr("method", "post");
      if(uploadCheck())
        form.submit();
    });

    $("#modifyBtn").on("click", function(){
      let form = $("#form");
      form.attr("enctype","multipart/form-data");
      form.attr("action", "<c:url value='/event/modify'/>");
      form.attr("method", "post");
      if(modifyCheck())
        form.submit();
    });

      $("#cancelBtn").on("click", function(){
        history.back();
      });

  });

</script>
    </div>
  </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>

</html>

