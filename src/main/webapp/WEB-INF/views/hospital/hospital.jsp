<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<style>
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 13px;height: 65px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;;text-align: left;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
</style>
<div id="map" style="width:100%;height:100vh;"></div>
 <script type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=922ca951b44c6af51770da3a41e90f60&libraries=services"></script>
      <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
      
   <script>
   var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(33.450701, 126.570667),
		level: 3
	};

	var map = new kakao.maps.Map(container, options);
	if (navigator.geolocation) {
	    
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
	        var lat = position.coords.latitude, // 위도
	            lon = position.coords.longitude; // 경도
	        
	        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	            message = '<div style="padding:5px;">현재위치입니다.</div>'; // 인포윈도우에 표시될 내용입니다
	        
	        // 마커와 인포윈도우를 표시합니다
	        displayMarker(locPosition, message);
	            
	      });
	    
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
	    
	    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
	        message = 'geolocation을 사용할수 없어요..'
	        
	    displayMarker(locPosition, message);
	}
	function displayMarker(locPosition, message) {

	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({  
	        map: map, 
	        position: locPosition,
	        clickable: true
	    }); 
	    
	    var iwContent = message, // 인포윈도우에 표시할 내용
	        iwRemoveable = true;

	    // 인포윈도우를 생성합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content : iwContent,
	        removable : iwRemoveable
	    });
	    
	    // 인포윈도우를 마커위에 표시합니다 
	    infowindow.open(map, marker);
	    
	    // 지도 중심좌표를 접속위치로 변경합니다
	    map.setCenter(locPosition);
	    
	}
	$.get("${pageContext.request.contextPath}/resources/json/data.json", function(data) {
		for (let i = 0; i < $(data.positions).length; i++) {
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch($(data.positions)[i].주소, function(result, status) {
			// 정상적으로 검색이 완료됐으면 
			 if (status === kakao.maps.services.Status.OK) {
				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

				// 결과값으로 받은 위치를 마커로 표시합니다
				var marker = new kakao.maps.Marker({
					map: map,
					position: coords,
					clickable: true
				});
				// 마커에 표시할 인포윈도우를 생성합니다 
					/* var infowindow = new kakao.maps.InfoWindow({ */
					//content: positions[i].content // 인포윈도우에 표시할 내용
					var content = '<div class="wrap">' + 
		            '    <div class="info">' + 
		            '        <div class="title">' + $(data.positions)[i].의료기관명 + 
		            '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
		            '        </div>' + 
		            '        <div class="body">' + 
		            '            <div class="desc">' + 
		            '                <div class="ellipsis">' + $(data.positions)[i].주소 +'</div>' + 
		            '				 <div><a href="https://map.kakao.com/link/to/'+ $(data.positions)[i].의료기관명  + ',' + result[0].y + ',' + result[0].x + '"' + 'target="_blank" class="link">길찾기</a></div>' + 
		            '            </div>' + 
		            '        </div>' + 
		            '    </div>' +    
		            '</div>';
					
				//});
					var overlay = new kakao.maps.CustomOverlay({
					    content: content,
					    map: map,
					    position: marker.getPosition()       
					});

					// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
					kakao.maps.event.addListener(marker, 'click', function() {
					    overlay.open(map, maker);
					});

					// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
					function closeOverlay() {
					    overlay.setMap(null);     
					}

			}
		});
		}		
		});   
   </script>

<%@ include file="../layout/footer.jsp"%>
