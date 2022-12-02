<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<c:set var="loginId" value="${sessionScope.userId}"/>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 상세</title>
    <link rel="stylesheet" href="<c:url value='/css/event.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

</head>

<body>
<jsp:include page="include/header.jsp" flush="false" />
<main>

    <div class="main">

        <div class="eventDetail">

<div class="pageTitle_container">
    <h3>이벤트</h3>
</div>

    <div class="event_container">
        <c:set var="pageLink" value="/eventModify?eventN0=${eventVO.eventNo}"/>
            <table>
                <tr>
                    <th>
                        ${eventVO.eventName}
                    </th>
                </tr>
                <tr>
                    <td>
                      <h6>관리자</h6>
                    </td>
                </tr>
                <tr>
                    <td><img src="<c:url value='${eventVO.imgPath}'/>"></td>
                </tr>
            </table>
            <div class="button_container">
                <c:set var="eventList" value="${link=='A' ? 'event/list?link=A' : 'event/list'}"/>
                <button type="button" id="listBtn" class="btn-list" onclick="location.href='${eventList}'">목록으로</button>

                <c:if test="${loginId=='admin'}">
                    <c:set var="pageLink" value="event/modify?eventNo=${eventVO.eventNo}"/>
                <button type="button" id="modifyBtn" onclick="location.href='${pageLink}'" class="btn-modify">수정</button>
                <button type="button" id="delBtn" class="btn-del">삭제</button>
                </c:if>

            </div>
        </form>

    </div>

<script>

    let eventNo ='${eventVO.eventNo}';

    $(document).ready(function(){

        $("#delBtn").on("click", function(){
                if(!confirm("이벤트를 삭제하시겠습니까?")) return;

                $.ajax({
                    type:'delete',
                    url: '/meal/event/delete/'+eventNo,
                    headers : { "content-type": "application/json"},
                    dataType : 'text',
                    data : JSON.stringify({eventNo:eventNo}),
                    success : function(result){
                        alert("삭제가 완료되었습니다");
                        location.href="<c:url value='/event/list?link=A'/>";
                    },
                    error   : function(){ alert("삭제를 실패하였습니다. 다시 시도해 주세요") }
                });
        });

    });

</script>
        </div>
    </div>
</main>
<jsp:include page="include/footer.jsp" flush="false" />
</body>

</html>