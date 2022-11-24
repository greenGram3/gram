<%@ page contentType="text/html;charset=UTF-8"  language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!DOCTYPE html>
<html>
<head>
    <title>delyList</title>
    <link rel="stylesheet" href="<c:url value='/css/delyForm.css'/>">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp" flush="false" />
<main>
    <div class="main">

        <%@include file="../include/mypage.jsp"%>

        <div class="delyForm">
            <h3>배송지 관리</h3>
            <table>
                <th>수령인</th>
                <th>배송지</th>
                <th>기본배송지</th>
                <th>주소</th>
                <th>연락처</th>
                <th>관리</th>

                <c:forEach var="item" items="${list}" varStatus="status">
                    <tr>
                        <td>${item.receiver}</td>
                        <td>${item.delyPlace}</td>
                        <td>
                            <c:if  test="${item.delyNo eq 1}">
                                <span style="color: dodgerblue;" id="base${status.index}">기본 배송지</span>
                            </c:if>
                        </td>
                        <td>${item.delyAddr}</td>
                        <td>${item.delyPhone}</td>
                        <td><input type="button" value="수정" id="updateBtn${status.index}">
                            <input type="button" value="삭제" id="deleteBtn${status.index}"></td>
                    </tr>
                    <script>
                        document.querySelector("#updateBtn${status.index}").addEventListener('click', function(){
                            window.open("<c:url value='/delivery/update'/>?receiver=${item.receiver}&delyPlace=${item.delyPlace}&delyAddr=${item.delyAddr}&delyPhone=${item.delyPhone}&delyNo=${item.delyNo}","Child","left=400,top=200,width=500,height=500")
                        })

                        document.querySelector("#deleteBtn${status.index}").addEventListener('click', function(){
                            if(!(!(document.querySelector('#base${status.index}')))){
                                let flag = false;
                                $.ajax({
                                    type: 'Post',
                                    async: false,
                                    url: 'register2',
                                    success: function (result) {
                                        if (result.code == 1) {
                                            flag = !flag
                                            alert("기본배송지는 1개 존재해야합니다.");
                                        };
                                    },
                                    error: function (result) {
                                        alert('error : '+result+" "+result.code);
                                    }
                                }) //ajax
                                if(flag) return;
                            }

                            if(!confirm("삭제하시겠습니까?"))return;
                            $.ajax({
                                type: 'Post',
                                url: 'delete',
                                async: false,
                                data: {
                                    receiver :  '${item.receiver}',
                                    delyPlace :  '${item.delyPlace}',
                                    delyNo : '${item.delyNo}',
                                    delyPhone :  '${item.delyPhone}'
                                },
                                success: function (result) {
                                    location.reload();
                                    alert("삭제되었습니다.");
                                },
                                error: function (result) {
                                    alert('error : '+result+" "+result.code);
                                }
                            })
                        })
                    </script>
                </c:forEach>
            </table>
            <button type="button" id="regBtn">배송지 등록</button>
            <script>
                document.querySelector("#regBtn").addEventListener('click',function (){
                    window.open("<c:url value="/delivery/register"/>","Child","left=400,top=200,width=500,height=500")
                })
            </script>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>


