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
        img {
            display: block;
        }
        .companyInfo {
            margin-top: 250px;
            margin-bottom: 100px;
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
        <%--<img src="<c:url value='/icon/logo.png'/>" style="margin-top:300px;">--%>
        <img src="<c:url value='/icon/company_info.jpg'/>">
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
