<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<br>
<br>

<main  role="main" class="main-content">
<!-- ################ accordion toggle 적용 START ################ -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			
			<h3 style="text-align: center;">${start} ${doo} 병원 검색 하기</h3>


			<hr>
		</div>

		<div class="col-md-12">
			<div class="panel-group" id="accordion" role="tablist"
				aria-multiselectable="true">

				<c:set var="count" value="0" />
				<c:forEach var="list" items="${vlist}">
					<c:set var="count" value="${count = count + 1}" />
					<div class="panel panel-default"
						style="margin-top: 10px; margin-bottom: 10px;">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a class="collapsed" role="button" data-toggle="collapse"
									data-parent="#accordion" href="#collapse${count}"
									aria-expanded="true" aria-controls="collapse${count}">
									<div>
										<span style="float: left;"><img height="20" width="20"
											src="${pageContext.request.contextPath}/resources/image/vac.png">&nbsp;
											${list.orgnm}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <span
											style="float: right;">${list.orgZipaddr}</span>&nbsp;
									</div>
								</a>
							</h4>
						</div>
						<div id="collapse${count}" class="panel-collapse collapse"
							role="tabpanel" aria-labelledby="heading${count}">
							<div class="panel-body">
								<%-- <p>This is 간단한 내용. write here. (${count})</p> --%>
								<form method="get" action="/vaccine/vacmap" id="mapFrm">
									<iframe id="if" name="param"
										style="width: 0px; height: 0px; border: 0px;"></iframe>

									<table class="table table-striped" style="margin-top: 10px;">
										<thead>
											<tr>
												<th>기관코드</th>
												<th>기관명</th>
												<th>기관전화번호</th>
												<th>기관 주소</th>

											</tr>
										</thead>
										<tbody>
											<tr>
												<td>${list.orgcd}</td>
												<td>${list.orgnm}</td>
												<td>${list.orgTlno}</td>
												<td id="ddd">${list.orgZipaddr}</td>
												<td><input type="hidden" name="orgZipaddr"
													id="orgZipaddr" value="${list.orgZipaddr}">
													<input type="hidden" name="orgnm"
													id="orgnm" value="${list.orgnm}">
											<button name="mapbtn" style="float: right; margin: 8px 10px 15px 10px;">지도보기</button>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
</main>
<br>


<script type="text/javascript">
	$(document).ready(function() {
		$('#mapbtn').click(function() {
			/* 				if(${idCheck} === 'none') {
			 alert("로그인이 필요한 서비스입니다.");
			 location.href="/auth/loginForm";
			 }
			 else { */
			$('#mapFrm').submit();
			/* 				} */
		});
	});
</script>

<%@ include file="../layout/footer.jsp"%>

