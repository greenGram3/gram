<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<html>
<head>
    <title>itemDetail</title>
    <link rel="stylesheet" href="<c:url value='/css/item.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script>
        // ** 구매하기 버튼 클릭 시 구매하기 폼으로(action buy)
        $(function () {

            let buyButton = $('#buyButton');
            let orderAmount = $('#cartAmount');

            buyButton.click(function () {

                if (confirm('구매하시겠습니까?') == true) {
                    alert('구매 페이지로 이동합니다.');
                } else {
                    return false;
                }
                orderAmount.attr("name", "itemAmount");
                orderAmount.attr("id", "itemAmount");

                const itemDetailForm = $('#itemDetailForm');
                itemDetailForm.attr("action", "buy");
                itemDetailForm.attr("method", "post");
                itemDetailForm.submit();
            })
        });
    </script>
    <script>
        // ** 상세페이지 reviewList
        function reviewListD(itemNo) {
            $.ajax({
                type: 'Get',
                url: 'reviewlistD',
                data: {
                    itemNo: itemNo
                },
                success: function (resultPage) {
                    $('#resultArea1').html(resultPage);
                },
                error: function () {
                    $('#resultArea1').html('상세페이지 review 요청 error');
                }
            }); //ajax
        } //reviewListD
        //==========================================================================//
        // ** 상품 상세페이지 Detail
        function itemDetailPage(itemNo) {
            $.ajax({
                type: 'Get',
                url: 'itemDetailPage',
                data: {
                    itemNo: itemNo
                },
                success: function (resultPage) {
                    $('#resultArea1').html('');
                    $('#resultArea1').html(resultPage);
                },
                error: function () {
                    $('#resultArea1').html('상품 설명페이지 error');
                }
            }); //ajax
        } //itemDetail
        //==========================================================================//
        // ** 배송정보
        function deli_info() {
            $.ajax({
                type: 'Get',
                url: 'deliInfo',
                success: function (resultPage) {
                    $('#resultArea1').html('');
                    $('#resultArea1').html(resultPage);
                },
                error: function () {
                    $('#resultArea1').html('상세페이지 배송안내 요청 error');
                }
            }); //ajax
        } //deli_info


    </script>
</head>
<body>
<jsp:include page="include/header.jsp" flush="false"/>

<c:if test="${not empty msg}">
    <script type="text/javascript">
        let message = "${msg}";
        alert(message);
    </script>
</c:if>

<main>
    <div class="itemDetail">
    <div class="itemDetail-container">
        <form action="cart" method="post" name="itemDetailForm" id="itemDetailForm">
            <div class="itemInfo">
                    <div class="itemImage">
                        <input hidden type="text" name="itemNo" value="${itemResult.itemNo}" readonly>
                        <%--<input type="text" name="userId" value="${userId}" disabled>--%>
                        <img src="${itemResult.imgName}" width=300 height=300></td>
                    </div>
                <table>
                <tr>
                    <th colspan="2"><input type="text" name="itemName" id="itemName" value="${itemResult.itemName}"></th>
                </tr>
                <tr>
                    <th>판매가</th>
                    <td><input type="text" name="itemPrice" id="itemPrice" value="${itemResult.itemPrice}"> 원</td>
                </tr>
                <tr>
                    <th>배송정보</th>
                    <td>  지정일배송</td>
                </tr>
                <tr>
                    <th>배송비</th>
                    <td>3000 원 / n만원 이상 무료배송</td>
                </tr>
                <tr>
                    <th>수량</th>
                    <td> <button type="button" value="▼" name="itemMin" id="itemMin" onclick="minAmount();">▼
                    </button>
                        <input type="text" name="cartAmount" id="cartAmount" value="1" size="3" onkeyup="calc();">
                        <button type="button" value="▲" name="itemAdd" id="itemAdd" onclick="addAmount();">▲
                        </button></td>
                </tr>
                <tr>
                    <th>총 상품금액</th>
                    <th> <input type="text" name="totalItemPrice" id="totalItemPrice"  value="${itemResult.itemPrice}"readonly>  원</th>
                </tr>
            </table>
            </div>
                <div class="itemCheck">
                <button type="submit" onclick="return confirm('장바구니에 추가하시겠습니까?')" id="cartButton">장바구니 담기</button>
                <button type="button" id="buyButton">바로주문</button>
                </div>
        </form>
    </div>
    <div class="itemDetail_menu_container">
            <span onclick="itemDetailPage(${itemResult.itemNo});" class="itemDetail_menu checked" id="content1" >상품상세</span></li>
            <span onclick="reviewListD(${itemResult.itemNo});" class="itemDetail_menu noChecked" id="content2">상품후기</span></li>
            <span onclick="deli_info();" id="content3" class="itemDetail_menu noChecked">배송정보</span></li>
        </ul>
    </div>
    <div class="resultArea-container">
        <div id="resultArea1"></div>
        <div id="resultArea2"></div>
        <div id="resultArea3"></div>
    </div>

    <script>
        // 상품 +- 시 가격변동 js
        function minAmount() {
            if (document.itemDetailForm.cartAmount.value > 1) {
                document.itemDetailForm.cartAmount.value--;
            } else {
                return false;
            }
            calc();
        }

        function addAmount() {
            if (document.itemDetailForm.cartAmount.value < 10) {
                document.itemDetailForm.cartAmount.value++;
            } else {
                return false;
            }
            calc();
        }

        function calc() {
            document.itemDetailForm.totalItemPrice.value =
                document.itemDetailForm.itemPrice.value * document.itemDetailForm.cartAmount.value;
        }
        let itemDetail_menus = document.querySelector('.itemDetail_menu_container');
        let menu = itemDetail_menus.getElementsByClassName('itemDetail_menu');
        let tmp = menu[0];

        for(let i=0; i<menu.length;i++){

            menu[i].addEventListener('click',(e) => {

                let eventMenu = e.target;

                if(eventMenu.classList.contains('noChecked')) {
                    tmp.classList.remove('checked');
                    tmp.classList.add('noChecked');
                    eventMenu.classList.remove('noChecked');
                    eventMenu.classList.add('checked');
                    tmp=eventMenu;
                }

            })
        }

    </script>
    </div>
</main>
<jsp:include page="include/footer.jsp" flush="false"/>
</body>
</html>
