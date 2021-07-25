<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawVisualization);

      function drawVisualization() {
        // Some raw data (not necessarily accurate)
        for(var i = 0; i < 19; i++) {
        	var gubun = $('#gubun')
        
        	gubun[i]
        }
        
        for(var i = 0; i < 19; i++) {
        	var incDec = parseInt($('#incDec'))
        	/* incDec = parseInt(incDec1);
        	incDec[i] */
        }
        for(var i = 0; i < 19; i++) {
        	var isolIngCnt = parseInt($('#isolIngCnt'))
        	/* isolIngCnt = parseInt(isolIngCnt1);
        	isolIngCnt[i] */
        }
        for(var i = 0; i < 19; i++) {
        	var isolClearCnt = parseInt($('#isolClearCnt'))
        	/* isolClearCnt = parseInt(isolClearCnt1);
        	isolClearCnt[i] */
        }
        for(var i = 0; i < 19; i++) {
        	var deathCnt[i] = parseInt($('#deathCnt'))
        	/* deathCnt = parseInt(deathCnt);
        	deathCnt[i] */
        }
        
        /* var confCase =$('#confCase').val()
        confCase = parseInt(confCase);
        console.log("confCase: " + confCase);

        var deathCnt =$('#deathCnt').val() 
        deathCnt = parseInt(deathCnt); 
        console.log("deathCnt: " + deathCnt);

        var dateTime =$('#dateTime').val()
        
        var defCnt =$('#defCnt').val()
        defCnt = parseInt(defCnt);        
        
        var isolIngCnt =$('#isolIngCnt').val() 
        isolIngCnt = parseInt(isolIngCnt); 
        
        var incDec =$('#incDec').val() 
        incDec = parseInt(incDec);	 
        
        var overFlowCnt =$('#overFlowCnt').val()
        overFlowCnt = parseInt(overFlowCnt);  */
        
/*          var data = google.visualization.arrayToDataTable([
          ['구분', 'Bolivia', 'Ecuador', 'Madagascar', 'Papua New Guinea', 'Rwanda', 'Average'],
          ['2005/06',  165,      938,         522,             998,           450,      614.6],
          ['2005/06',  135,      1120,        599,             1268,          288,      682],
          ['2006/07',  157,      1167,        587,             807,           397,      623],
          ['2007/08',  139,      1110,        615,             968,           215,      609.4],
          ['2008/09',  136,      691,         629,             1026,          366,      569.6]
        ]);  */
         /* var data = google.visualization.arrayToDataTable */
         /* var data = new google.visualization.arrayToDataTable(); */
     	/* data.addColumn('string', '지역');
     	data.addColumn('number', '확진자');
     	data.addColumn('number', '격리중');
     	data.addColumn('number', '격리해제');
     	data.addColumn('number', '사망자');
     	
     	data.addRows */
     	var data = google.visualization.arrayToDataTable([
            ['지역', '확진자', '격리중', '격리해제', '사망자',],
            ['검역', incDec[18], isolIngCnt[18], isolClearCnt[18], deathCnt[18]],
            ['제주', incDec[17], isolIngCnt[17], isolClearCnt[17], deathCnt[17]],
            ['경남', incDec[16], isolIngCnt[16], isolClearCnt[16], deathCnt[16]],
            ['경북', incDec[15], isolIngCnt[15], isolClearCnt[15], deathCnt[15]],
            ['전남', incDec[14], isolIngCnt[14], isolClearCnt[14], deathCnt[14]],
            ['전북', incDec[13], isolIngCnt[13], isolClearCnt[13], deathCnt[13]],
            ['충남', incDec[12], isolIngCnt[12], isolClearCnt[12], deathCnt[12]],
            ['충북', incDec[11], isolIngCnt[11], isolClearCnt[11], deathCnt[11]],
            ['강원', incDec[10], isolIngCnt[10], isolClearCnt[10], deathCnt[10]],
            ['경기', incDec[9], isolIngCnt[9], isolClearCnt[9], deathCnt[9]],
            ['세종', incDec[8], isolIngCnt[8], isolClearCnt[8], deathCnt[8]],
            ['울산', incDec[7], isolIngCnt[7], isolClearCnt[7], deathCnt[7]],
            ['대전', incDec[6], isolIngCnt[6], isolClearCnt[6], deathCnt[6]],
            ['광주', incDec[5], isolIngCnt[5], isolClearCnt[5], deathCnt[5]],
            ['인천', incDec[4], isolIngCnt[4], isolClearCnt[4], deathCnt[4]],
            ['대구', incDec[3], isolIngCnt[3], isolClearCnt[3], deathCnt[3]],
            ['부산', incDec[2], isolIngCnt[2], isolClearCnt[2], deathCnt[2]],
            ['서울', incDec[1], isolIngCnt[1], isolClearCnt[1], deathCnt[1]],
            ['합계', incDec[0], isolIngCnt[0], isolClearCnt[0], deathCnt[0]],
         ]); 

        var options = {
          title : 'Monthly Coffee Production by Country',
          vAxis: {title: '인원 수'},
          hAxis: {title: '지역'},
          seriesType: 'bars',
          series: {4: {type: 'line'}}
        };

        var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      } -->
</script>
		
		<main role="main" class="main-content">
		<div class="container-fluid">
		<div class="alert alert-primary" role="alert">지역, 성별, 연령별 확진자를 확인할 수 있습니다.</div>
		<div class="row justify-content-center">
		<!-- <div id="chart_div" style="width: 1125px; height: 500px; margin: 20px;"></div> -->
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
