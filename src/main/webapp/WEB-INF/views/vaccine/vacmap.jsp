<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<main role="main" class="main-content">

<div id="map" style="width:100%;height:100vh;"></div>


<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fd8866ad623c48904091d8acb42a7829&libraries=services"></script>
<script type="text/javascript">

function orgZipaddr1(orgZipaddr1) {
    jQuery.ajax({
        type: "GET",
        url: "/vaccine/vacmap",
        data: {orgZipaddr : orgZipaddr,
        orgnm : orgnm,
        },
        });

}
 var  orgZipaddr ='<%= (request.getParameter("orgZipaddr")) %>';
 var  orgnm ='<%= (request.getParameter("orgnm")) %>';
 

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};  





//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

//주소로 좌표를 검색합니다
geocoder.addressSearch(orgZipaddr, function(result, status) {

// 정상적으로 검색이 완료됐으면 
 if (status === kakao.maps.services.Status.OK) {

    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

    // 결과값으로 받은 위치를 마커로 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: coords
    });

    // 인포윈도우로 장소에 대한 설명을 표시합니다
    var infowindow = new kakao.maps.InfoWindow({
        content: orgnm 
    });
    infowindow.open(map, marker);

    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    map.setCenter(coords);
} 
});    
</script>

</main>
<%@ include file="../layout/footer.jsp"%>