<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<main role="main" class="main-content">
	<div class="container-fluid">
		<div class="alert alert-primary" role="alert">일별, 누적 확진자를 확인할 수
			있습니다.&nbsp;&nbsp;</div>

		<form id="flightFrm" name="flightFrm" action="/vaccine/vac2" method="get">
							<select	class="cs-select cs-skin-border" id="from_place" name="from_place">
								<option value="" disabled selected>시.도 선택</option>
								<option value="서울특별시">서울특별시</option>
								<option value="경기도">경기도</option>
								<option value="인천광역시">인천광역시</option>
								<option value="강원도">강원도</option>
								<option value="세종특별자치구">세종</option>
								<option value="충청남도">충청남도</option>
								<option value="충청북도">충청북도</option>
								<option value="대전광역시">대전광역시</option>
								<option value="대구광역시">대구광역시</option>
								<option value="경상북도">경상북도</option>
								<option value="울산광역시">울산광역시</option>
								<option value="부산광역시">부산광역시</option>
								<option value="전라북도">전라북도</option>
								<option value="전라남도">전라남도</option>
								<option value="경상남도">경상남도</option>
								<option value="광주광역시">광주광역시</option>
								<option value="제주도">제주도</option>
							</select>
					 <input type="button"	id="input_submit" onclick="input()" value="조회">
				
		</form>

	</div>
</main>
<!-- main -->
<!-- <script type="text/javascript">
		
			$(document).ready(function(e){
				$('#flightBtn').click(function(){
					
						$('#flightFrm').submit();
					
				});
			});

		</script> -->
<script type="text/javascript">
	function input() {
		const dday = document.querySelector("#from_place").value;

		console.log(dday);
		$('#flightFrm').submit();
	}
</script>

<%@ include file="../layout/footer.jsp"%>