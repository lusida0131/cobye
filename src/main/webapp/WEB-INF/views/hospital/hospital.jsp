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
    .info .desc {position: relative;margin: 0 5px 0 5px;height: 100px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;;text-align: left;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .link {tdisplay:inline-block;text-align:right;margin-left: 220px;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
</style>
<main role="main" class="main-content">
	<div class="alert alert-dark" role="alert">
		<img height="20" width="20" src="${pageContext.request.contextPath}/resources/image/map-marker-icon_34392.png">&nbsp; 현위치&nbsp; 
		<img height="20" width="20" src="${pageContext.request.contextPath}/resources/image/marker_icon-icons.com_54388.png">&nbsp; 임시 선별진료소&nbsp;
		<img height="20" width="20" src="${pageContext.request.contextPath}/resources/image/clipart353131.png">&nbsp; 선별진료소
	</div>
	<div class="container-fluid">
			<div id="map" style="width:100%;height:100vh;"></div>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
 <script type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=922ca951b44c6af51770da3a41e90f60&libraries=services,clusterer"></script>

<script>
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
		
		var imageSrc = '${pageContext.request.contextPath}/resources/image/map-marker-icon_34392.png', // 마커이미지의 주소입니다    
	    imageSize = new kakao.maps.Size(33, 33), // 마커이미지의 크기입니다
	    imageOption = {offset: new kakao.maps.Point(16.5, 33)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	      
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다
	
	    var iwContent = message,
	        iwRemoveable = true;

	    // 인포윈도우를 생성합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content : iwContent,
	        removable : iwRemoveable,
	        position: locPosition
	    });
	    
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    	mapOption = {
       	center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
       	level : 3
    	// 지도의 확대 레벨
    	};
	
		var map = new kakao.maps.Map(mapContainer, mapOption);
	
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
						var overlay = new kakao.maps.CustomOverlay({
					    	map: map,
					    	position: marker.getPosition()       
						});

						//마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 시작
						var Customcontent = document.createElement('div');
						Customcontent.className = "wrap";

						var info = document.createElement('div');
						info.className = "info"			
						Customcontent.appendChild(info);

						//커스텀오버레이 타이틀
						var contentTitle = document.createElement("div");
						contentTitle.className = "title"
						contentTitle.appendChild(document.createTextNode($(data.positions)[i].의료기관명));
						info.appendChild(contentTitle);

						//커스텀오버레이 닫기 버튼
						var closeBtn = document.createElement("div");
						closeBtn.className = "close";
						closeBtn.setAttribute("title","닫기");
						closeBtn.onclick = function() { overlay.setMap(null); };
						contentTitle.appendChild(closeBtn);

						var bodyContent = document.createElement("div");
						bodyContent.className = "body";
						info.appendChild(bodyContent);

						var descContent = document.createElement("div");
						descContent.className = "desc"
						bodyContent.appendChild(descContent);

						//커스텀오버레이 주소			
						var addressContent = document.createElement("div");
						addressContent.className = "ellipsis";
						addressContent.appendChild(document.createTextNode($(data.positions)[i].주소));
						descContent.appendChild(addressContent);
					
						var daytimeContent = document.createElement("div");
						daytimeContent.className = "ellipsis1";
						daytimeContent.appendChild(document.createTextNode("평일 운영 시간 : "));
						addressContent.appendChild(daytimeContent);
				  	
					
						var daytime1Content = document.createTextNode($(data.positions)[i].평일운영시간);
						daytime1Content.className = "ellipsis2";
						daytimeContent.appendChild(daytime1Content);
					
						var weekendContent = document.createElement("div");
						weekendContent.className = "ellipsis3";
						weekendContent.appendChild(document.createTextNode("토요일 운영 시간 : "));
						daytimeContent.appendChild(weekendContent);
					
						var weekend1Content = document.createTextNode($(data.positions)[i].토요일운영시간);
						weekend1Content.className = "ellipsis4";
						weekendContent.appendChild(weekend1Content);
					
						var holidayContent = document.createElement("div");
						holidayContent.className = "ellipsis5";
						holidayContent.appendChild(document.createTextNode("일요일 운영 시간 : "));
						weekendContent.appendChild(holidayContent);
					
						var holiday1Content = document.createTextNode($(data.positions)[i].일요일공휴일);
						holiday1Content.className = "ellipsis6";
						holidayContent.appendChild(holiday1Content);
					
					
						var LinkDiv = document.createElement("div");
						descContent.appendChild(LinkDiv);
					
						//커스텀오버레이 링크
						var LinkContent = document.createElement("a");
						url = "https://map.kakao.com/link/to/"+ $(data.positions)[i].의료기관명  + "," + result[0].y + "," + result[0].x;
					
						LinkContent.setAttribute("href", url);

						LinkContent.setAttribute("target", "_blank");
					
						LinkContent.className = "link";
						LinkContent.appendChild(document.createTextNode("길찾기"));
						LinkDiv.appendChild(LinkContent);
						//마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 끝

						overlay.setContent(Customcontent);
					
						var testOverlay = null;
						// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
						daum.maps.event.addListener(marker, 'click', function() {
						overlay.setMap(map);
						});					
					
						// 인포윈도우로 장소에 대한 설명을 표시합니다
						overlay.setMap(null);
					}
			 
				});
			}
		});

		$.get("${pageContext.request.contextPath}/resources/json/dataTem.json", function(data) {
			for (let i = 0; i < $(data.positions).length; i++) {
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch($(data.positions)[i].주소, function(result, status) {
					var imageSrc = '${pageContext.request.contextPath}/resources/image/marker_icon-icons.com_54388.png', // 마커이미지의 주소입니다    
					imageSize = new kakao.maps.Size(33, 33), // 마커이미지의 크기입니다
					imageOption = {offset: new kakao.maps.Point(16.5, 33)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
						      
					// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
					var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
					markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다
					
					// 정상적으로 검색이 완료됐으면 
				 	if (status === kakao.maps.services.Status.OK) { //
						var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

						// 결과값으로 받은 위치를 마커로 표시합니다
						var marker = new kakao.maps.Marker({
							map: map,
							position: coords,
							image : markerImage,
							clickable: true
						});
						var overlay = new kakao.maps.CustomOverlay({
						    map: map,
						    position: marker.getPosition()       
						});

						//마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 시작
						var Customcontent = document.createElement('div');
						Customcontent.className = "wrap";

						var info = document.createElement('div');
						info.className = "info"			
						Customcontent.appendChild(info);

						//커스텀오버레이 타이틀
						var contentTitle = document.createElement("div");
						contentTitle.className = "title"
						contentTitle.appendChild(document.createTextNode($(data.positions)[i].임시선별검사소));
						info.appendChild(contentTitle);

						//커스텀오버레이 닫기 버튼
						var closeBtn = document.createElement("div");
						closeBtn.className = "close";
						closeBtn.setAttribute("title","닫기");
						closeBtn.onclick = function() { overlay.setMap(null); };
						contentTitle.appendChild(closeBtn);

						var bodyContent = document.createElement("div");
						bodyContent.className = "body";
						info.appendChild(bodyContent);

						var descContent = document.createElement("div");
						descContent.className = "desc"
						bodyContent.appendChild(descContent);

						//커스텀오버레이 주소			
						var addressContent = document.createElement("div");
						addressContent.className = "ellipsis";
						addressContent.appendChild(document.createTextNode($(data.positions)[i].주소));
						descContent.appendChild(addressContent);
						
						var daytimeContent = document.createElement("div");
						daytimeContent.className = "ellipsis1";
						daytimeContent.appendChild(document.createTextNode("평일 운영 시간 : "));
						addressContent.appendChild(daytimeContent);
					  	
						
						var daytime1Content = document.createTextNode($(data.positions)[i].평일운영시간);
						daytime1Content.className = "ellipsis2";
						daytimeContent.appendChild(daytime1Content);
						
						var weekendContent = document.createElement("div");
						weekendContent.className = "ellipsis3";
						weekendContent.appendChild(document.createTextNode("토요일 운영 시간 : "));
						daytimeContent.appendChild(weekendContent);
						
						var weekend1Content = document.createTextNode($(data.positions)[i].토요일운영시간);
						weekend1Content.className = "ellipsis4";
						weekendContent.appendChild(weekend1Content);
						
						var holidayContent = document.createElement("div");
						holidayContent.className = "ellipsis5";
						holidayContent.appendChild(document.createTextNode("일요일 운영 시간 : "));
						weekendContent.appendChild(holidayContent);
						
						var holiday1Content = document.createTextNode($(data.positions)[i].일요일공휴일);
						holiday1Content.className = "ellipsis6";
						holidayContent.appendChild(holiday1Content);
						
						
						var LinkDiv = document.createElement("div");
						descContent.appendChild(LinkDiv);
						
						//커스텀오버레이 링크
						var LinkContent = document.createElement("a");
						url = "https://map.kakao.com/link/to/"+ $(data.positions)[i].임시선별검사소  + "," + result[0].y + "," + result[0].x;
						
						LinkContent.setAttribute("href", url);

						LinkContent.setAttribute("target", "_blank");
						
						LinkContent.className = "link";
						LinkContent.appendChild(document.createTextNode("길찾기"));
						LinkDiv.appendChild(LinkContent);
						//마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 끝

						overlay.setContent(Customcontent);
						
						var testOverlay = null;
						// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
						daum.maps.event.addListener(marker, 'click', function() {
							overlay.setMap(map);
						});					
						
						// 인포윈도우로 장소에 대한 설명을 표시합니다
						overlay.setMap(null);
						
					}
						
				});
				var marker = new kakao.maps.Marker({  
					map: map, 
				    position: locPosition,
				    image : markerImage
				        
				});
				infowindow.open(map, marker);
				map.setCenter(locPosition);
			}
				
				
		});
	}
</script>
   </body>

	</div>
</main>

<%@ include file="../layout/footer.jsp"%>
