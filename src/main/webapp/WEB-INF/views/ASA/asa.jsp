<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawVisualization);

      function drawVisualization() {
        // Some raw data (not necessarily accurate)
       /*  for(var i = 0; i < 19; i++) {
           var gubun = $('#gubun').val()
        
           gubun[i]
        } */
        
        for(var i = 0; i < 19; i++) {
           incDec[i] = parseInt($('#incDec').val())
           console.log(incDec[i])
           /* incDec = parseInt(incDec1);
           incDec[i] */
        }
        for(var i = 0; i < 19; i++) {
           isolIngCnt[i] = parseInt($('#isolIngCnt').val())
           /* isolIngCnt = parseInt(isolIngCnt1);
           isolIngCnt[i] */
        }
        for(var i = 0; i < 19; i++) {
           isolClearCnt[i] = parseInt($('#isolClearCnt').val())
           /* isolClearCnt = parseInt(isolClearCnt1);
           isolClearCnt[i] */
        }
        for(var i = 0; i < 19; i++) {
           deathCnt[i] = parseInt($('#deathCnt').val())
           /* deathCnt = parseInt(deathCnt);
           deathCnt[i] */
        }
        
         var data = google.visualization.arrayToDataTable([
            ['구분','확진자', '격리중', '사망자'],
               ['서울', Number(incDec[17].value), Number(isolIngCnt[17].value), Number(deathCnt[17].value)],
               ['부산',incDec[16].value, isolIngCnt[16].value, deathCnt[16].value],
               ['대구',incDec[15].value, isolIngCnt[15].value, deathCnt[15].value],
               ['인천',incDec[14].value, isolIngCnt[14].value, deathCnt[14].value],
               ['광주',incDec[13].value, isolIngCnt[13].value, deathCnt[13].value],
               ['대전',incDec[12].value, isolIngCnt[12].value, deathCnt[12].value],
               ['울산',incDec[11].value, isolIngCnt[11], deathCnt[11].value],
               ['세종',incDec[10].value, isolIngCnt[10], deathCnt[10].value],
               ['경기',incDec[9].value, isolIngCnt[9].value, deathCnt[9].value],
               ['강원',incDec[8].value, isolIngCnt[8].value, deathCnt[8].value],
               ['충북',incDec[7].value, isolIngCnt[7].value, deathCnt[7].value],
               ['충남',incDec[6].value, isolIngCnt[6].value, deathCnt[6].value],
               ['전북',incDec[5].value, isolIngCnt[5].value, deathCnt[5].value],
               ['전남',incDec[4].value, isolIngCnt[4].value, deathCnt[4].value],
               ['경북',incDec[3].value, isolIngCnt[3].value, deathCnt[3].value],
               ['경남',incDec[2].value, isolIngCnt[2].value, deathCnt[2].value],
               ['제주',incDec[1].value, isolIngCnt[1].value, deathCnt[1].value],
               ['검역',incDec[0].value, isolIngCnt[0].value, deathCnt[0].value],
            ]); 
         var options = {
               title : '전국 확진자 한눈에 보기',
               vAxis: {title: '인원'},
               hAxis: {title: '지역'}, 
               seriesType: 'bars',
               series: {5: {type: 'line'}}
            };
         
         var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
         chart.draw(data, options);
      }
      
      
      
      
</script>
		
		<main role="main" class="main-content">
		<div class="container-fluid">
		<div class="alert alert-primary" role="alert">지역, 성별, 연령별 확진자를 확인할 수 있습니다.</div>
		<div class="row justify-content-center">
		<div id="chart_div" style="width: 1125px; height: 500px; margin: 20px;"></div>
			<div class="row">
					<div class="col-md-12">
					<h6 class="mb-3" style="text-align:center;">성별 연령별 확진자 한눈에 보기</h6>
					<c:set var="list" value="${blist}"/>
					<c:choose>
						<c:when test="${list ne '유감'}">
						<table class="table table-borderless table-striped">
							<thead>
								<tr role="row">
									<th>연령, 성별</th>
									<th>확진률</th>
									<th>확진자</th>
									<th>사망률</th>
									<th>사망자</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="blist" items="${blist}">
								<tr>
									<th scope="col">${blist.gubun}</th>
									<td>${blist.confCaseRate}%</td>
									<td>+${blist.confCase}</td>
									<input type="hidden" name="confCase" id="confCase" value="${blist.confCase}">
									<td>${blist.deathRate}%</td>
									<td>${blist.death}</td>
									<input type="hidden" name="death" id="death" value="${blist.death}">
								</tr>
							</c:forEach>
							</tbody>
						</table>
						</c:when>
						<c:when test="${list eq '유감'}">
						<h1 style="text-align: center;">성별, 연령별 확진자 정보의 업데이트가 되지 않았습니다.(유감)
							<br>주말에는 업데이트가 어렵습니다.(유감)</h1>
						</c:when>
					</c:choose>
				</div>
<%-- 				<!-- 퍼센트 -->
                <div class="col-md-12 col-lg-4">
                  <div class="card shadow eq-card mb-4">
                  <div class="dropdown">
                          <button class="btn btn-sm dropdown-toggle more-vertical" type="button" id="dr1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"  style="float:right">
                          <span class="text-muted sr-only">Action</span>
                          </button>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dr1">
                            <a class="dropdown-item" href="/ASA/age">man</a>
                            <a class="dropdown-item" href="#">woman</a>
                            </div>
                        </div>
                    <div class="card-body">
                      <div class="chart-widget mb-2">
                        <div id="radialbar"></div>
                      </div>
                      <div class="row items-align-center">
                      <c:forEach var="blist" items="${blist}">
                      <div>
                      <h6 class="mb-3" style="text-align:center;">${blist.gubun}</h6>
                      </div>
                        <div class="col-4 text-center">
                          <p class="text-muted mb-1">확진자</p>
                          <h6 class="mb-1">${blist.confCase}</h6>
                        </div>
                        <div class="col-4 text-center">
                          <p class="text-muted mb-1">사망률</p>
                          <h6 class="mb-1">${blist.deathRate}</h6>
                        </div>
                        <div class="col-4 text-center">
                          <p class="text-muted mb-1">사망자</p>
                          <h6 class="mb-1">${blist.death}</h6>
                        </div>
                        </c:forEach>
                      </div>
                    </div> <!-- .card-body -->
                  </div> <!-- .card -->
                </div> <!-- .col -->
                <div class="col-md-12 col-lg-4">
                  <div class="card shadow eq-card mb-4">
                    <div class="card-body">
                      <div class="d-flex mt-3 mb-4">
                        <div class="flex-fill pt-2">
                          <p class="mb-0 text-muted">Total</p>
                          <h4 class="mb-0">108</h4>
                          <span class="small text-muted">+37.7%</span>
                        </div>
                        <div class="flex-fill chart-box mt-n2">
                          <div id="barChartWidget"></div>
                        </div>
                      </div> <!-- .d-flex -->
                      <div class="row border-top">
                        <div class="col-md-6 pt-4">
                          <h6 class="mb-0">108 <span class="small text-muted">+37.7%</span></h6>
                          <p class="mb-0 text-muted">Cost</p>
                        </div>
                        <div class="col-md-6 pt-4">
                          <h6 class="mb-0">1168 <span class="small text-muted">-18.9%</span></h6>
                          <p class="mb-0 text-muted">Revenue</p>
                        </div>
                      </div> <!-- .row -->
                    </div> <!-- .card-body -->s
                  </div> <!-- .card -->
                </div> <!-- .col-md --> --%>
			<!-- 지역 리스트 -->
				<div class="col-md-12">
					<h6 class="mb-3" style="text-align:center;">전국 확진자 한눈에 보기</h6>
						<table class="table table-borderless table-striped">
							<thead>
								<tr role="row">
									<th>지역</th>
									<th>등록 일시</th>
									<th>전체 확진자</th>
									<th>전일 대비</th>
									<th>격리중</th>
									<th>격리 해제</th>
									<th>사망자 수</th>
									<th>지역 발생</th>
									<th>해외 유입</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="alist" items="${alist}">
								<tr>
									<th scope="col">${alist.gubun}</th>
									<input type="hidden" name="gubun" id="gubun" value="${alist.gubun}">
									<fmt:parseDate value="${alist.createDt}" var="dateTime" pattern="yyyy-MM-dd HH:mm:ss" />
									<td><fmt:formatDate value="${dateTime}" pattern="yyyy-MM-dd"/></td>
									<input type="hidden" name="dateTime" id="dateTime" value="${dateTime}">
									<td>${alist.defCnt}</td>  <!-- 전체 확진자 -->
									<input type="hidden" name="defCnt" id="defCnt" value="${alist.defCnt}">
									<td>+${alist.incDec}</td> <!-- 전일 대비 -->
									<input type="hidden" name="incDec" id="incDec" value="${alist.incDec}">
									<td>${alist.isolIngCnt}</td> <!-- 격리중 -->
									<input type="hidden" name="isolIngCnt" id="isolIngCnt" value="${alist.isolIngCnt}">
									<td>${alist.isolClearCnt}</td> <!-- 격리해제 --> 
									<input type="hidden" name="isolClearCnt" id="isolClearCnt" value="${alist.isolClearCnt}">
									<td>${alist.deathCnt}</td>	<!-- 사망자 수  -->
									<input type="hidden" name="deathCnt" id="deathCnt" value="${alist.deathCnt}">
									<td>${alist.localOccCnt}</td>
									<td>${alist.overFlowCnt}</td>	<!-- 해외 유입 -->
									<input type="hidden" name="overFlowCnt" id="overFlowCnt" value="${alist.overFlowCnt}">
								</tr>
							</c:forEach>
							</tbody>
						</table>
				</div>
					</div>
					<!-- / .col-md-3 -->
					</div>
					</div>
			</main>
<%@ include file="../layout/footer.jsp"%>
