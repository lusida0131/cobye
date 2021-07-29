<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		
	<main role="main" class="main-content">
		<div class="container-fluid">
			<div class="alert alert-primary" role="alert">지역, 성별, 연령별 확진자를 확인할 수 있습니다.</div>
			<div class="row justify-content-center">
				<div class="col-12">
					<div class="row">
						<div class="col-md-12">
							<h6 class="mb-3" style="text-align:center;">성별 연령별 확진자 한눈에 보기</h6>
							<c:set var="list" value="${blist}"/>
							<c:choose>
								<c:when test="${list ne '유감'}">
									<div class="row my-4">
										<div class="col-md-12">
											<h4 style="text-align:center; margin:30px 0px;">연령별 확진자</h4>
											<div class="chart-box" style="padding:0px 20px;">
												<div id="columnChart" style="margin: 20px auto;  text-align: center;"></div>
											</div>
										</div>
									</div>
									
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
												<input type="hidden" name="confCase" id="confCase" value="${blist.confCase}" />
												<td>${blist.deathRate}%</td>
												<td>${blist.death}</td>
												<input type="hidden" name="death" id="death" value="${blist.death}" />
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
						<!-- 그래프 -->
						<div class="col-md-12">
							<h4 style="text-align:center; margin-top:150px; ">지역별 확진자</h4>
							<div class="chart-box" style="padding:0px 20px;">
								<div id="columnChart1" style="margin: 20px auto;  text-align: center;"></div>
							</div>
						</div>
						<!-- 지역 리스트 -->
						<div class="col-md-12">
							<h6 class="mb-3" style="text-align:center;">지역 리스트</h6>
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
											<input type="hidden" name="gubun" id="gubun" value="${alist.gubun}" />
											<fmt:parseDate value="${alist.createDt}" var="dateTime" pattern="yyyy-MM-dd HH:mm:ss" />
											<td><fmt:formatDate value="${dateTime}" pattern="yyyy-MM-dd"/></td>
											<input type="hidden" name="dateTime" id="dateTime" value="${dateTime}" />
											<td>${alist.defCnt}</td>  <!-- 전체 확진자 -->
											<input type="hidden" name="defCnt" id="defCnt" value="${alist.defCnt}" />
											<td>+${alist.incDec}</td> <!-- 전일 대비 -->
											<input type="hidden" name="incDec" id="incDec" value="${alist.incDec}" />
											<td>${alist.isolIngCnt}</td> <!-- 격리중 -->
											<input type="hidden" name="isolIngCnt" id="isolIngCnt" value="${alist.isolIngCnt}" />
											<td>${alist.isolClearCnt}</td> <!-- 격리해제 --> 
											<input type="hidden" name="isolClearCnt" id="isolClearCnt" value="${alist.isolClearCnt}" />
											<td>${alist.deathCnt}</td>	<!-- 사망자 수  -->
											<input type="hidden" name="deathCnt" id="deathCnt" value="${alist.deathCnt}" />
											<td>${alist.localOccCnt}</td>
											<td>${alist.overFlowCnt}</td>	<!-- 해외 유입 -->
											<input type="hidden" name="overFlowCnt" id="overFlowCnt" value="${alist.overFlowCnt}" />
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/apexcharts.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tinycolor-min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/config.js"></script>

<!-- 지역 그래프 -->
<script>
	var dateArea = [], D = [];
	<c:forEach var="alist" items="${alist}">
		var a = "${alist.gubun}";
	    var a1 = '${alist.incDec}';
	    dateArea.push(a);
	    D.push(a1);
	</c:forEach>
	dateArea.reverse();
	D.reverse();
	dateArea.shift();
	D.shift();
	var columnChart, columnChartoptions = {
        series: [{
            name: "확진자",
            data: D,
        }],
        chart: {
            type: "bar",
            height: 350,
            stacked: !1,
            columnWidth: "90%",
            zoom: {
                enabled: !1
            },
            toolbar: {
                show: !1
            },
            background: "transparent"
        },
        dataLabels: { enabled: !1 },
        theme: { mode: colors.chartTheme },
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
                columnWidth: "12%",
                radius: 30,
                enableShades: !1,
                endingShape: "rounded",
                dataLabels: {
					position: 'top', // top, center, bottom
				},
            }
        },
        dataLabels: {
            enabled: true,
            offsetY: -30,
            style: {
              fontSize: '12px',
              colors: [colors.chartTheme]
            }
          },
        xaxis: {
            /* type: "datetime", */
            categories: dateArea,
            labels: {
                show: !0,
                trim: !1,
                offsetX: 0,
                minHeight: void 0,
                maxHeight: 120,
                style: {
                    colors: colors.mutedColor,
                    cssClass: "text-muted",
                    fontFamily: base.defaultFontFamily
                }
            },
            axisBorder: { show: !1 }
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
            onItemClick: { toggleDataSeries: !0 },
            onItemHover: { highlightDataSeries: !0 }
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
                lines: { show: !1 }
            },
            yaxis: {
                lines: { show: !0 }
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
    columnChartCtn = document.querySelector("#columnChart1");
	columnChartCtn && (columnChart = new ApexCharts(columnChartCtn, columnChartoptions)).render();
	
</script>

<!-- 연령별 그래프 -->
<script>
	var dateArea = [], D = [];
	<c:forEach var="blist" items="${blist}">
		var a = "${blist.gubun}";
	    var a1 = '${blist.confCase}';
	    dateArea.push(a);
	    D.push(a1);
	</c:forEach>
	D.length = 9;
	dateArea.length = 9;
	var columnChart, columnChartoptions = {
        series: [{
            name: "확진자",
            data: D,
        }],
        chart: {
            type: "bar",
            height: 350,
            stacked: !1,
            columnWidth: "90%",
            zoom: {
                enabled: !1
            },
            toolbar: {
                show: !1
            },
            background: "transparent"
        },
        dataLabels: { enabled: !1 },
        theme: { mode: colors.chartTheme },
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
                columnWidth: "12%",
                radius: 30,
                enableShades: !1,
                endingShape: "rounded",
                dataLabels: {
					position: 'top', // top, center, bottom
				},
            }
        },
        dataLabels: {
            enabled: true,
            offsetY: -30,
            style: {
              fontSize: '12px',
              colors: [colors.chartTheme]
            }
          },
        xaxis: {
            /* type: "datetime", */
            categories: dateArea,
            labels: {
                show: !0,
                trim: !1,
                offsetX: 0,
                minHeight: void 0,
                maxHeight: 120,
                style: {
                    colors: colors.mutedColor,
                    cssClass: "text-muted",
                    fontFamily: base.defaultFontFamily
                }
            },
            axisBorder: { show: !1 }
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
            onItemClick: { toggleDataSeries: !0 },
            onItemHover: { highlightDataSeries: !0 }
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
                lines: { show: !1 }
            },
            yaxis: {
                lines: { show: !0 }
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
</script>
<%@ include file="../layout/footer.jsp"%>
