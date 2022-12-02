<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>companyInfo</title>
    <style>
        main * {
            margin: auto;
            text-align: center;
        }

        .companyInfo {
            margin-top: 250px;
            margin-bottom: 100px;
        }
        img.company_info {
            width: 400px;
            margin-top: 0px;
            margin-right: 70px;
        }
        .companyInfo>div {
            display: flex;
            width: 1200px;
            flex-direction: row-reverse;
        }

        pre>span {
            font-size: 25px;
            color: rgb(84, 108, 92);
            font-weight: 1000;
        }

        pre>p {
            font-size: 30px;
            color: rgb(84, 108, 92);
            font-weight: 1000;
            text-align: left;
            width: 600px;
        }
        pre {
            text-align: left;
            width: 1200px;
            font-size: 20px;
            font-weight: 500;
        }
        #map {
            width: 600px;
            height: 400px;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f06ae939c7dcd32ef5d324f2b2743e62&libraries=services">
    </script>
</head>
<body>
<jsp:include page="include/header.jsp" flush="false"/>
<main>
    <div class="companyInfo">
        <div>
        <img class="company_info" src="<c:url value='/icon/companyInfo.png'/>">
        <pre>
            정직과 건강을 담은 편한밥상으로
            오늘도 믿음과 신뢰를 만들어 갑니다.

            <p>밀키트  '편한밥상' 의 시작</p>

            주식회사 제일 C&F는 1997년 설립 이후
            B2B , B2C 온라인 마케팅, 프렌차이즈 등
            많은 경험을 토대로 건강을 담은 특별한 밀키트  <span>편한밥상</span> 으로
            우리 가족이 먹는 건강한 밥상을 만들어가겠습니다.

            <p> 밀키트  '편한밥상' 은 '근사한 세트'</p>

            정성을 다해 담은 밀키트  <span>편한밥상</span> 은 더 간편하고, 더 맛있고, 더 재미있는
            요리를 할 수 있도록 제품을 구성하여
            요리에 자신없는 초보자도 손쉽게 요리의 즐거움을 더하고
            근사한 세트가 될 수 있도록 제품을 특화했습니다

            밀키트  <span>편한밥상</span> 은 전국 최고의 인천 식품 산업단지 (I-Food Park)
            본사 식품 공장에서 깨끗하고 신선한 재료와 엄격한 위생관리,
            품질관리를 통해 만들고 있습니다
        </pre>
    </div>
        <br><br>
        <h2>편한밥상 본사 위치</h2>
        <h3>경기 성남시 분당구 돌마로 46 광천프라자 5층 503호, 대표번호: 02.0000.0000</h3>
        <br><br>
        <div id="map"></div>
        <br>

        <!-- 지도만들기 -->
        <script>
            // 1. 초기화
            let mapContainer = document.getElementById('map'),
                mapOption = {
                    center: new kakao.maps.LatLng(37.349809, 127.106992),
                    level: 3
                };
            // 2. 지도생성
            let map = new kakao.maps.Map(mapContainer, mapOption);
            // 3. 주소-좌표 변환 객체
            let geocoder = new kakao.maps.services.Geocoder();
            let address = '경기 성남시 분당구 돌마로 46 광천프라자';
            let description = '편한밥상';

            geocoder.addressSearch(address, function (result, status) {
                if (status === daum.maps.services.Status.OK) { //주소-좌표 변환 성공
                    let coords = new daum.maps.LatLng(result[0].y, result[0].x); //위도,경도 set
                    let marker = new daum.maps.Marker({map: map, position: coords}); //결과값 marker표시

                    let infowindow = new daum.maps.InfoWindow({ //장소 설명표시
                        content: '<div style="width:150px; text-align:center; padding:6px 0; font-weight: bold;">' + description + '</div>'
                    });

                    // map,marker 표시 시작
                    infowindow.open(map, marker);
                    map.setCenter(coords); // map 중심으로 이동
                }
            });
        </script>
        <%--
        <button>
                <a href="javascript:history.back();">돌아가기</a>
        </button>
        --%>
    </div>
</main>
<jsp:include page="include/footer.jsp" flush="false"/>
</body>
</html>
