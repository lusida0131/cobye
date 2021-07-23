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
        var blist = '${blist}';
        var data = google.visualization.arrayToDataTable([
          ['구분', 'Bolivia', 'Ecuador', 'Madagascar', 'Papua New Guinea', 'Rwanda', 'Average'],
          [blist,  165,      938,         522,             998,           450,      614.6],
          ['2005/06',  135,      1120,        599,             1268,          288,      682],
          ['2006/07',  157,      1167,        587,             807,           397,      623],
          ['2007/08',  139,      1110,        615,             968,           215,      609.4],
          ['2008/09',  136,      691,         629,             1026,          366,      569.6]
        ]);

        var options = {
          title : 'Monthly Coffee Production by Country',
          vAxis: {title: '인원 수'},
          hAxis: {title: '나이, 성별'},
          seriesType: 'bars',
          series: {5: {type: 'line'}}
        };

        var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
</script>
		
		<main role="main" class="main-content">
		
		<div class="alert alert-primary" role="alert">지역, 성별, 연령별 확진자를 확인할 수 있습니다.</div>
		<div class="row justify-content-center">
		<div id="chart_div" style="width: 1500px; height: 500px; margin: 10px;"></div>
			<div class="row">
					<div class="col-md-12">
					<h6 class="mb-3" style="text-align:center;">성별 연령별 확진자 한눈에 보기</h6>
						<table class="table table-borderless table-striped">
							<thead>
								<tr role="row">
									<th>구분</th>
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
									<td>${blist.deathRate}%</td>
									<td>${blist.death}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
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
									<fmt:parseDate value="${alist.createDt}" var="dateTime" pattern="yyyy-MM-dd HH:mm:ss" />
									<td><fmt:formatDate value="${dateTime}" pattern="yyyy-MM-dd"/></td>
									<td>${alist.defCnt}</td>
									<td>+${alist.incDec}</td>
									<td>${alist.isolIngCnt}</td>
									<td>${alist.isolClearCnt}</td>
									<td>${alist.deathCnt}</td>
									<td>${alist.localOccCnt}</td>
									<td>${alist.overFlowCnt}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
				</div>
					</div>
					<!-- / .col-md-3 -->
					</div>
			</main>
<%@ include file="../layout/footer.jsp"%>
