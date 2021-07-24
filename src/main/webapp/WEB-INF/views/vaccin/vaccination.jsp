<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../layout/header.jsp"%>
    
    
    
    <main role="main" class="main-content">
	<form id="flightFrm" name="flightFrm" action="//vaccin/vaccination" method="get">
		<div class="alert alert-primary" role="alert">일별, 누적 확진자를 확인할 수 있습니다.</div>
		<h1 style="width:90%;  margin:auto; text-align: center;">거주지역을 선택하세요</h1>
		<div style="width:90%;  margin:auto; text-align: center;">
		<input  type="radio" name="gubun" value="0" autocomplete="off"> 서울특별시
		<input 	type="radio" name="gubun" value="1" autocomplete="off"> 경기도
		<input 	type="radio" name="gubun" value="3" autocomplete="off"> 인천광역시
		<input 	type="radio" name="gubun" value="4" autocomplete="off"> 강원도
		<input 	type="radio" name="gubun" value="5" autocomplete="off"> 세종특별자치구
		<input 	type="radio" name="gubun" value="6" autocomplete="off"> 충청남도<br>
		<input 	type="radio" name="gubun" value="7" autocomplete="off"> 충청북도
		<input 	type="radio" name="gubun" value="8" autocomplete="off"> 대전광역시
		<input 	type="radio" name="gubun" value="9" autocomplete="off"> 대구광역시
		<input 	type="radio" name="gubun" value="10" autocomplete="off"> 경상북도
		<input 	type="radio" name="gubun" value="11" autocomplete="off"> 대구광역시
		<input 	type="radio" name="gubun" value="12" autocomplete="off"> 울산광역시
		<input 	type="radio" name="gubun" value="13" autocomplete="off"> 부산광역시<br>
		<input 	type="radio" name="gubun" value="14" autocomplete="off"> 전라북도
		<input 	type="radio" name="gubun" value="15" autocomplete="off"> 전라남도
		<input 	type="radio" name="gubun" value="16" autocomplete="off"> 경상남도
		<input 	type="radio" name="gubun" value="17" autocomplete="off"> 광주광역시
		<input 	type="radio" name="gubun" value="18" autocomplete="off"> 제주도			
	</div>
	
	<div style="width:90%;  margin:auto; text-align: center; ">
	<div class="col-xs-12">
														<input type="button" id="flightBtn" class="btn btn-primary btn-block" value="Search Flight">
													</div>
		<input type="button" id="flightBtn" class="btn btn-primary btn-block" value="Search Flight">
		
</div>
</form>
</main>
<!-- main -->
    
<script type="text/javascript">
		
			$(document).ready(function(e){
				$('#flightBtn').click(function(){
					
						$('#flightFrm').submit();
					console.log("flightFrm");
				});
			});

		</script>
		

<%@ include file="../layout/footer.jsp"%>