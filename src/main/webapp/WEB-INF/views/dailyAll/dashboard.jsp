<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>


<main role="main" class="main-content">
	<div class="container-fluid">
		<div class="alert alert-primary" role="alert">일별, 누적 확진자를 확인할 수 있습니다.</div>
		<div class="alert alert-primary" role="alert"><a href="/testChart">TEST CHART GO</a></div>
		<div class="row justify-content-center">
			<div class="col-12">
				<div class="row">
					<div class="col-md-6 col-xl-3 mb-4">
						<div class="card shadow bg-primary text-white border-0">
							<div class="card-body">
								<div class="row align-items-center">
									<div class="col-3 text-center">
										<span class="circle circle-sm bg-primary-light">
											<i class="fe fe-16 fe-shopping-bag text-white mb-0"></i>
										</span>
									</div>
									<div class="col pr-0">
										<p class="small text-muted mb-0">Monthly Sales</p>
										<span class="h3 mb-0 text-white">$1250</span>
										<span class="small text-muted">+5.5%</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-xl-3 mb-4">
						<div class="card shadow border-0">
							<div class="card-body">
								<div class="row align-items-center">
									<div class="col-3 text-center">
										<span class="circle circle-sm bg-primary">
											<i class="fe fe-16 fe-shopping-cart text-white mb-0"></i>
										</span>
									</div>
									<div class="col pr-0">
										<p class="small text-muted mb-0">Orders</p>
										<span class="h3 mb-0">1,869</span>
										<span class="small text-success">+16.5%</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-xl-3 mb-4">
						<div class="card shadow border-0">
							<div class="card-body">
								<div class="row align-items-center">
									<div class="col-3 text-center">
										<span class="circle circle-sm bg-primary">
											<i class="fe fe-16 fe-filter text-white mb-0"></i>
										</span>
									</div>
									<div class="col">
										<p class="small text-muted mb-0">Conversion</p>
										<div class="row align-items-center no-gutters">
											<div class="col-auto">
												<span class="h3 mr-2 mb-0"> 86.6% </span>
											</div>
											<div class="col-md-12 col-lg">
												<div class="progress progress-sm mt-2" style="height: 3px">
													<div class="progress-bar bg-success" role="progressbar" style="width: 87%" aria-valuenow="87" aria-valuemin="0" aria-valuemax="100"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-xl-3 mb-4">
						<div class="card shadow border-0">
							<div class="card-body">
								<div class="row align-items-center">
									<div class="col-3 text-center">
										<span class="circle circle-sm bg-primary">
											<i class="fe fe-16 fe-activity text-white mb-0"></i>
										</span>
									</div>
									<div class="col">
										<p class="small text-muted mb-0">AVG Orders</p>
										<span class="h3 mb-0">$80</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- end section -->
				<div class="row align-items-center my-2">
					<div class="col-auto ml-auto">
						<form class="form-inline">
							<div class="form-group">
								<label for="reportrange" class="sr-only">Date Ranges</label>
								<div id="reportrange" class="px-2 py-2 text-muted">
									<i class="fe fe-calendar fe-16 mx-2"></i>
									<span class="small"></span>
								</div>
							</div>
							<div class="form-group">
								<button type="button" class="btn btn-sm">
									<span class="fe fe-refresh-ccw fe-12 text-muted"></span>
								</button>
								<button type="button" class="btn btn-sm">
									<span class="fe fe-filter fe-12 text-muted"></span>
								</button>
							</div>
						</form>
					</div>
				</div>
				
				<!-- charts-->
				<div class="row my-4">
					<div class="col-md-12">
						<div class="chart-box">
							<div id="columnChart"></div>
						</div>
					</div>
					<!-- .col -->
				</div>
				<!-- end section -->
				
				<!-- info small box -->
				<div class="row">
					<div class="col-md-6">
						<div class="card shadow mb-4">
							<div class="card-body">
								<h3 class="mb-1">전일대비 확진자 비교</h3>
								<div class="chart-widget">
									<div id="gradientRadial"></div>
								</div>
								<fmt:parseNumber var="adecPer" value="${adec1/adec2 * 100}" integerOnly="true" />
								<fmt:formatNumber type="percent" value="${adec1/adec2}" pattern="0.0%" var="adecPerr"/>
								<input type="hidden" id="adecPer" value="${adecPer}" />
								<div class="row">
									<div class="col-6 text-center">
										<p class="text-muted mb-0">어제</p>
										<h4 class="mb-1">${adec2}</h4>
									</div>
									<div class="col-6 text-center">
										<p class="text-muted mb-0">오늘</p>
										<h4 class="mb-1">${adec1}</h4>
									</div>
								</div>
							</div>
							<!-- .card-body -->
						</div>
						<!-- .card -->
					</div>
					<!-- .col -->
					
					<div class="col-md-6">
						<div class="card shadow mb-4">
							<div class="card-body">
								<!-- <p class="mb-0"><strong class="mb-0 text-uppercase text-muted">Today</strong></p> -->
								<h3 class="mb-0">최근 10일 확진자 추이</h3>
								<p class="text-muted">+18.9% Last week</p>
								<div class="chart-box mt-n5">
									<div id="lineChartWidget"></div>
								</div>
								<div class="row">
									<div class="col-4 text-center mt-3">
										<p class="mb-1 text-muted">Completions</p>
										<h6 class="mb-0">26</h6>
										<span class="small text-muted">+20%</span>
										<span class="fe fe-arrow-up text-success fe-12"></span>
									</div>
									<div class="col-4 text-center mt-3">
										<p class="mb-1 text-muted">Goal Value</p>
										<h6 class="mb-0">$260</h6>
										<span class="small text-muted">+6%</span>
										<span class="fe fe-arrow-up text-success fe-12"></span>
									</div>
									<div class="col-4 text-center mt-3">
										<p class="mb-1 text-muted">Conversion</p>
										<h6 class="mb-0">6%</h6>
										<span class="small text-muted">-2%</span>
										<span class="fe fe-arrow-down text-danger fe-12"></span>
									</div>
								</div>
							</div>
							<!-- .card-body -->
						</div>
						<!-- .card -->
					</div>
					<!-- .col-md -->
				</div>
				<!-- / .row -->
				
				<br><br>
				<div class="row">
					<!-- Recent orders -->
					<div class="col-md-12">
						<h4 class="mb-3" style="text-align:center">최근 10일 코로나 확진 현황</h4>
						<table class="table table-borderless table-striped">
							<thead>
								<tr role="row">
									<th>기준일</th>
									<th>누적 확진자</th>
									<th>추가 확진자</th>
									<th>누적 치료환자</th>
									<th>추가 치료환자</th>
									<th>누적 사망자</th>
									<th>추가 사망자</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${alist}">
								<fmt:parseDate value="${list.stateDt}" var="stateDt" pattern="yyyyMMdd" />
								<tr>
									<th scope="col"><fmt:formatDate value="${stateDt}" pattern="MM월 dd일" /></th>
									<td><fmt:formatNumber value="${list.decideCnt}" pattern="#,###,###" /></td>
									<td>+ <fmt:formatNumber value="${list.ADecideCnt}" pattern="#,###,###" /></td>
									<td><fmt:formatNumber value="${list.careCnt}" pattern="#,###,###" /></td>
									<td>+ <fmt:formatNumber value="${list.ACareCnt}" pattern="#,###,###" /></td>
									<td><fmt:formatNumber value="${list.deathCnt}" pattern="#,###,###" /></td>
									<td>+ <fmt:formatNumber value="${list.ADeathCnt}" pattern="#,###,###" /></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- / .col-md-3 -->
				</div>
				<!-- end section -->
			</div>
		</div>
		<!-- .row -->
	</div>
	<!-- .container-fluid -->
	<div class="modal fade modal-notif modal-slide" tabindex="-1" role="dialog" aria-labelledby="defaultModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="defaultModalLabel">Notifications</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="list-group list-group-flush my-n3">
						<div class="list-group-item bg-transparent">
							<div class="row align-items-center">
								<div class="col-auto">
									<span class="fe fe-box fe-24"></span>
								</div>
								<div class="col">
									<small><strong>Package has uploaded successfull</strong></small>
									<div class="my-0 text-muted small">Package is zipped and uploaded</div>
									<small class="badge badge-pill badge-light text-muted">1m ago</small>
								</div>
							</div>
						</div>
						<div class="list-group-item bg-transparent">
							<div class="row align-items-center">
								<div class="col-auto">
									<span class="fe fe-download fe-24"></span>
								</div>
								<div class="col">
									<small><strong>Widgets are updated successfull</strong></small>
									<div class="my-0 text-muted small">Just create new layout Index, form, table</div>
									<small class="badge badge-pill badge-light text-muted">2m ago</small>
								</div>
							</div>
						</div>
						<div class="list-group-item bg-transparent">
							<div class="row align-items-center">
								<div class="col-auto">
									<span class="fe fe-inbox fe-24"></span>
								</div>
								<div class="col">
									<small><strong>Notifications have been sent</strong></small>
									<div class="my-0 text-muted small">Fusce dapibus, tellus ac cursus commodo</div>
									<small class="badge badge-pill badge-light text-muted">30m ago</small>
								</div>
							</div>
							<!-- / .row -->
						</div>
						<div class="list-group-item bg-transparent">
							<div class="row align-items-center">
								<div class="col-auto">
									<span class="fe fe-link fe-24"></span>
								</div>
								<div class="col">
									<small><strong>Link was attached to menu</strong></small>
									<div class="my-0 text-muted small">New layout has been attached to the menu</div>
									<small class="badge badge-pill badge-light text-muted">1h ago</small>
								</div>
							</div>
						</div>
						<!-- / .row -->
					</div>
					<!-- / .list-group -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-block" data-dismiss="modal">Clear All</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade modal-shortcut modal-slide" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="defaultModalLabel">Shortcuts</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body px-5">
					<div class="row align-items-center">
						<div class="col-6 text-center">
							<div class="squircle bg-success justify-content-center">
								<i class="fe fe-cpu fe-32 align-self-center text-white"></i>
							</div>
							<p>Control area</p>
						</div>
						<div class="col-6 text-center">
							<div class="squircle bg-primary justify-content-center">
								<i class="fe fe-activity fe-32 align-self-center text-white"></i>
							</div>
							<p>Activity</p>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-6 text-center">
							<div class="squircle bg-primary justify-content-center">
								<i class="fe fe-droplet fe-32 align-self-center text-white"></i>
							</div>
							<p>Droplet</p>
						</div>
						<div class="col-6 text-center">
							<div class="squircle bg-primary justify-content-center">
								<i class="fe fe-upload-cloud fe-32 align-self-center text-white"></i>
							</div>
							<p>Upload</p>
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-6 text-center">
							<div class="squircle bg-primary justify-content-center">
								<i class="fe fe-users fe-32 align-self-center text-white"></i>
							</div>
							<p>Users</p>
						</div>
						<div class="col-6 text-center">
							<div class="squircle bg-primary justify-content-center">
								<i class="fe fe-settings fe-32 align-self-center text-white"></i>
							</div>
							<p>Settings</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
<!-- main -->


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/apexcharts.min.js"></script>
<script>
	var adecPer = $('#adecPer').val();
	console.log("adecPer: "+adecPer);
	var gradientRadialChart;
	var gradientRadialOptions = { 
	    series: [adecPer], 
	    chart: { 
	        height: 200, 
	        type: "radialBar", 
	        toolbar: { show: !1 } 
	    }, 
	    plotOptions: { 
	        radialBar: { 
	            startAngle: -135, 
	            endAngle: 225, 
	            hollow: { 
	                margin: 0, 
	                size: "70%", 
	                background: "#f8f9fa", 
	                image: void 0, 
	                imageOffsetX: 0, 
	                imageOffsetY: 0, 
	                position: "front" 
	            }, 
	            track: { 
	                background: "#f8f9fa", 
	                strokeWidth: "67%", margin: 0 
	            }, 
	            dataLabels: { 
	                show: !0, 
	                name: { 
	                    fontSize: "0.875rem", 
	                    fontWeight: 400, 
	                    offsetY: -10, 
	                    show: !0, 
	                    color: "#adb5bd", 
	                    fontFamily: "Overpass, sans-serif" 
	                }, 
	                value: { 
	                    formatter: function (e) { return parseInt(e) }, 
	                    color: "#495057", 
	                    fontSize: "1.53125rem", 
	                    fontWeight: 700, 
	                    fontFamily: "Overpass, sans-serif", 
	                    offsetY: 5, 
	                    show: !0 
	                }, 
	                total: { 
	                    show: !0, 
	                    fontSize: "0.875rem", 
	                    fontWeight: 400, 
	                    offsetY: -10, 
	                    color: "#adb5bd", 
	                    fontFamily: "Overpass, sans-serif" 
	                } 
	            } 
	        } 
	    }, 
	    fill: { 
	        type: "gradient", 
	        gradient: { 
	            shade: "dark", 
	            type: "horizontal", 
	            shadeIntensity: .5, 
	            gradientToColors: ["#ABE5A1"], 
	            inverseColors: !0, 
	            opacityFrom: 1, 
	            opacityTo: 1, 
	            stops: [0, 100] 
	        } 
	    }, 
	    stroke: { lineCap: "round" }, 
	    labels: ["Percent"] 
	};
	var gradientRadial = document.querySelector("#gradientRadial"); 
	gradientRadial && (gradientRadialChart = new ApexCharts(gradientRadial, gradientRadialOptions)).render(); 
</script>


<%@ include file="../layout/footer.jsp"%>
