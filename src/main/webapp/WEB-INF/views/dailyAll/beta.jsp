<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>


<main role="main" class="main-content">
	<div class="container-fluid">
		<div class="alert alert-info" role="alert"><span class="fe fe-alert-circle fe-16 mr-2"></span>실시간 확진자의 집계는 실제 확진자 수와 다를 수 있으며, 공적인 효력이 없음을 안내합니다.&nbsp;&nbsp;해당 데이터를 사용하면서 발생하는 문제는 전적으로 사용자에게 있습니다.</div><br>
		<div class="row justify-content-center">
			<div class="col-12">
				<div class="row">
					<div class="col-md-6 col-xl-6 mb-4">
						<div class="card shadow bg-primary text-white border-0">
							<div class="card-body">
								<div class="row align-items-center">
									<div class="col-3 text-center">
										<span class="circle circle-sm bg-primary-light"><i class="fe fe-16 fe-alert-circle text-white mb-0"></i></span>
									</div>
									<div class="col pr-0">
										<p class="small text-muted mb-0">실시간 추가 확진자</p>
										<span class="h3 mb-0 text-white">&nbsp;<fmt:formatNumber value="${mCnt}" pattern="#,###,###" /> 명</span>
										<!-- <span class="small text-muted">+5.5%</span> -->
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-xl-6 mb-4">
						<div class="card shadow border-0">
							<div class="card-body">
								<div class="row align-items-center">
									<div class="col-3 text-center">
										<span class="circle circle-sm bg-primary"><i class="fe fe-16 fe-filter text-white mb-0"></i></span>
									</div>
									<div class="col pr-0">
										<p class="small text-muted mb-0">어제 확진자</p>
										<span class="h3 mb-0">&nbsp;<fmt:formatNumber value="${state}" pattern="#,###,###" /> 명</span>
										<span class="small text-success">+16.5%</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- end section -->
				
				<%-- <br>
				<!-- charts-->
				<div class="row my-4">
					<div class="col-md-12">
						<div class="chart-box">
							<div id="columnChart"></div>
						</div>
					</div>
					<!-- .col -->
				</div>--%>
				<!-- end section -->
				
				<br><hr>
				<div class="row">
					<div class="col-md-12"><br>
						<h4 style="text-align:center; margin:30px 0px;">실시간 코로나 확진 현황</h4>
						<c:choose>
						<c:when test="${n ne null}">
							<h6 style="text-align:center; margin:40px 0px;">금일 집계된 데이터는 없습니다.</h6>
						</c:when>
						<c:when test="${dlist ne null}">
						<table class="table table-borderless table-striped">
							<thead>
								<tr role="row">
									<th>발생일시</th>
									<th>지역</th>
									<th>재난 문자 내용</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${dlist}">
								<fmt:parseDate value="${list.create_date}" var="dt" pattern="yyyy/MM/dd HH:mm:ss" />
								<tr>
									<th scope="col"><fmt:formatDate value="${dt}" pattern="MM월 dd일 HH시 mm분" /></th>
									<td>${list.location_name}</td>
									<td>${list.msg}</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
						</c:when></c:choose>
					</div>
				</div>
				<!-- end section -->
			</div>
		</div>
		<!-- .row -->
	</div>
	<!-- .container-fluid -->
</main>
<!-- main -->


<%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/apexcharts.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tinycolor-min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/config.js"></script>

<script>
	var dateArea = [], D = [];
	<c:forEach var="dlist" items="${alist}">
		var aa = ('${dlist.stateDt}'*1+1) + "";
		var a = aa.substr(4,2) + "/" + aa.substr(6,2) + "/" +  aa.substr(0,4);
	    var a1 = '${dlist.ADecideCnt}';
	    /* console.log('a: '+a+'   a1: '+a1); */
	    dateArea.push(a);
	    D.push(a1);
	</c:forEach>
	var columnChart, columnChartoptions = {
        series: [{
            name: "일일 확진자",
            data: D
        }],
        chart: {
            type: "bar",
            height: 350,
            stacked: !1,
            columnWidth: "70%",
            zoom: {
                enabled: !0
            },
            toolbar: {
                show: !1
            },
            background: "transparent"
        },
        dataLabels: {
            enabled: !1
        },
        theme: {
            mode: colors.chartTheme
        },
        responsive: [{
            breakpoint: 480,
            options: {
                legend: {
                    position: "bottom",
                    offsetX: -10,
                    offsetY: 0
                }
            }
        }],
        plotOptions: {
            bar: {
                horizontal: !1,
                columnWidth: "10%",
                radius: 30,
                enableShades: !1,
                endingShape: "rounded"
            }
        },
        xaxis: {
            type: "datetime",
            categories: dateArea,
            labels: {
                show: !0,
                trim: !0,
                offsetX: 40,
                minHeight: void 0,
                maxHeight: 120,
                style: {
                    colors: colors.mutedColor,
                    cssClass: "text-muted",
                    fontFamily: base.defaultFontFamily
                }
            },
            axisBorder: {
                show: !1
            }
        },
        yaxis: {
            labels: {
                show: !0,
                trim: !1,
                offsetX: -10,
                minHeight: void 0,
                maxHeight: 120,
                style: {
                    colors: colors.mutedColor,
                    cssClass: "text-muted",
                    fontFamily: base.defaultFontFamily
                }
            }
        },
        legend: {
            position: "top",
            fontFamily: base.defaultFontFamily,
            fontWeight: 400,
            labels: {
                colors: colors.mutedColor,
                useSeriesColors: !1
            },
            markers: {
                width: 10,
                height: 10,
                strokeWidth: 0,
                strokeColor: "#fff",
                fillColors: [extend.primaryColor, extend.primaryColorLighter],
                radius: 6,
                customHTML: void 0,
                onClick: void 0,
                offsetX: 0,
                offsetY: 0
            },
            itemMargin: {
                horizontal: 10,
                vertical: 0
            },
            onItemClick: {
                toggleDataSeries: !0
            },
            onItemHover: {
                highlightDataSeries: !0
            }
        },
        fill: {
            opacity: 1,
            colors: [base.primaryColor, extend.primaryColorLighter]
        },
        grid: {
            show: !0,
            borderColor: colors.borderColor,
            strokeDashArray: 0,
            position: "back",
            xaxis: {
                lines: {
                    show: !1
                }
            },
            yaxis: {
                lines: {
                    show: !0
                }
            },
            row: {
                colors: void 0,
                opacity: .5
            },
            column: {
                colors: void 0,
                opacity: .5
            },
            padding: {
                top: 0,
                right: 0,
                bottom: 0,
                left: 0
            }
        }
    },
    columnChartCtn = document.querySelector("#columnChart");
	columnChartCtn && (columnChart = new ApexCharts(columnChartCtn, columnChartoptions)).render();
</script> --%>


<%@ include file="../layout/footer.jsp"%>
