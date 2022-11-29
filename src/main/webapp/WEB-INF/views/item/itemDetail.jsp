<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<html>
<head>
    <title>itemDetail</title>
    <link rel="stylesheet" href="<c:url value='/css/item.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script>

        let msg = "${param.msg}";
        if(msg=="PAY_ERR") alert("결제 페이지로 이동하는데 실패했습니다. 다시 시도해주세요.");

        // ** 구매하기 버튼 클릭 시 구매하기 폼으로(action buy)
        $(function () {
            // ** load시 자동으로 제품상세 클릭해서 먼저 보여주기
            $('#content1').trigger('click');
//-----------------------------------------------------------------//
            // ** 구매 action으로 가는 js
            let buyButton = $('#buyButton');
            let orderAmount = $('#cartAmount');
            const itemDetailForm = $('#itemDetailForm');

            let requestURI ="/meal/login/login?requestURI=/meal/${requestURI}";
            buyButton.click(function () {

                if("${userId}" == ""){
                    alert("로그인 페이지로 이동합니다");
                    location.href=requestURI; return false;
                }

                if (confirm('구매하시겠습니까?') == true) {
                    alert('구매 페이지로 이동합니다.');
                } else {
                    return false;
                }

                itemDetailForm.attr("action", "buy/payment");
                itemDetailForm.attr("method", "post");
                itemDetailForm.submit();
            })


        });
    </script>
    <script>
        // ** 상세페이지 itemReviewList
        function itemReview(itemNo) {
            $.ajax({
                type: 'Get',
                url: 'itemReview',
                data: {
                    itemNo: itemNo
                },
                success: function (resultPage) {
                    $('#resultArea1').html(resultPage);
                },
                error: function () {
                    $('#resultArea1').html('itemReview error');
                }
            }); //ajax
            return false;
        } //itemReview
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
        //-----------------------------------------------------------------------//
    </script>
</head>
<body>
<jsp:include page="../include/header.jsp" flush="false"/>

<c:if test="${not empty msg}">
    <script type="text/javascript">
        let message = "${msg}";
        if(message =='login_ok')alert("로그인 되었습니다");
        else alert(message);
    </script>
</c:if>

<main>
    <div class="itemDetail">
    <div class="itemDetail-container">
        <form action="cart" method="post" name="itemDetailForm" id="itemDetailForm">
            <div class="itemInfo">
                    <div class="itemImage">
                        <input hidden type="text" name="itemNo" id="itemNo" value="${itemResult.itemNo}" readonly>
                        <%--<input type="text" name="userId" value="${userId}" disabled>--%>
                        <img src="<c:url value='${itemResult.fileName}'/>" width=500 height=500>
                    </div>
                <table>
                <tr>
                    <th colspan="2"><input type="text" name="itemName" id="itemName" value="${itemResult.itemName}"readonly></th>
                </tr>
                <tr>
                    <th>판매가</th>
                    <td><input type="text" name="itemPrice" id="itemPrice" value="${itemResult.itemPrice}"readonly> 원</td>
                </tr>
                <tr>
                    <th>배송정보</th>
                    <td> 지정일배송</td>
                </tr>
                <tr>
                    <th>배송비</th>
                    <td>무료배송</td>
                </tr>
                <tr>
                    <th>수량</th>
                    <td> <button type="button" value="▼" name="itemMin" id="itemMin" onclick="minAmount();">▼
                    </button>
                        <input type="text" name="cartAmount" id="cartAmount"  size="3" onkeyup="calc();">
                        <button type="button" value="▲" name="itemAdd" id="itemAdd" onclick="addAmount();">▲
                        </button></td>
                </tr>
                <tr>
                    <th>총 상품금액</th>
                    <th> <input type="text" name="totalPrice" id="totalPrice"  value="${itemResult.itemPrice}" readonly>  원</th>
                </tr>
            </table>
            </div>
                <div class="itemCheck">
                <button type="button" id="cartButton">장바구니 담기</button>
                <button type="button" id="buyButton">바로주문</button>
                </div>
        </form>
    </div>
    <div class="itemDetail_menu_container">
            <span onclick="itemDetailPage(${itemResult.itemNo});" class="itemDetail_menu checked" id="content1" >상품상세</span>
            <span onclick="itemReview(${itemResult.itemNo});" class="itemDetail_menu noChecked" id="content2">상품후기</span>
            <span onclick="deli_info();" class="itemDetail_menu noChecked" id="content3">배송정보</span>
    </div>
    <div class="resultArea-container">
        <div id="resultArea1"></div>
        <div id="resultArea2"></div>
        <div id="resultArea3"></div>
    </div>

    <script>

        document.itemDetailForm.cartAmount.value = 1;

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
                console.log(document.itemDetailForm.cartAmount.value);
            } else {
                return false;
            }
            calc();
        }

        function calc() {
            document.itemDetailForm.totalPrice.value =
                document.itemDetailForm.itemPrice.value * document.itemDetailForm.cartAmount.value;
        }
        //-------------------------------------------------------------

        let itemNo=$('#itemNo').val();
        // let itemPrice=$('#itemPrice').val();


        //장바구니 담기
        $('#cartButton').click(function () {
            let cartAmount = document.itemDetailForm.cartAmount.value;
            console.log(cartAmount);
            if(!confirm("장바구니에 담으시겠습니까")) return;

            $.ajax({
                type:'post',
                url: '/meal/cart',
                headers : { "content-type": "application/json"},
                dataType : 'text',
                data : JSON.stringify({itemNo:"${itemResult.itemNo}", itemName:"${itemResult.itemName}",
                    cartAmount:cartAmount, itemPrice:"${itemResult.itemPrice}", fileName:"${itemResult.fileName}"}),
                success : function(result){
                    if(!confirm("장바구니에 추가되었습니다 장바구니로 이동하시겠습니까")) return;
                    location.href = "cart";
                },
                error   : function(){ alert("장바구니 담기 실패") }
            });
        })


        let itemDetail_menus = document.querySelector('.itemDetail_menu_container');
        let itemDetail_menu = itemDetail_menus.getElementsByClassName('itemDetail_menu');
        let tmp = itemDetail_menu[0];

        for(let i=0; i<itemDetail_menu.length; i++){

            itemDetail_menu[i].addEventListener('click',(e) => {

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
<jsp:include page="../include/footer.jsp" flush="false"/>
</body>
</html>
