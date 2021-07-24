<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

	<!-- <script src="https://code.jquery.com/jquery.min.js"></script> -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<main role="main" class="main-content">
	<div class="container-fluid">
	
		<h4>나도 그래프1</h4>
		<div id="chart_div" style="width:95%; height: 500px;"></div>

	</div>
</main>


<script>
	var chartDrowFun = {
	    chartDrow: function () {
	        var chartData = '';

	        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
	        var chartDateformat = 'yyyy년MM월dd일';
	        //라인차트의 라인 수
	        var chartLineCount = 10;
	        //컨트롤러 바 차트의 라인 수
	        var controlLineCount = 10;

	        function drawDashboard() {

	            var data = new google.visualization.DataTable();
	            //그래프에 표시할 컬럼 추가
	            data.addColumn('datetime', '날짜');
	            data.addColumn('number', '남성');
	            data.addColumn('number', '여성');
	            data.addColumn('number', '전체');

	            //그래프에 표시할 데이터
	            var dataRow = [];

	            for (var i = 0; i <= 29; i++) { //랜덤 데이터 생성
	                var total = Math.floor(Math.random() * 300) + 1;
	                var man = Math.floor(Math.random() * total) + 1;
	                var woman = total - man;

	                dataRow = [new Date('2017', '09', i, '10'), man, woman, total];
	                data.addRow(dataRow);
	            }

	            var chart = new google.visualization.ChartWrapper({
	                chartType: 'LineChart',
	                containerId: 'lineChartArea', //라인 차트 생성할 영역
	                options: {
	                    isStacked: 'percent',
	                    focusTarget: 'category',
	                    height: 500,
	                    width: '100%',
	                    legend: { position: "top", textStyle: { fontSize: 13 } },
	                    pointSize: 5,
	                    tooltip: { textStyle: { fontSize: 12 }, showColorCode: true, trigger: 'both' },
	                    hAxis: {
	                        format: chartDateformat, gridlines: {
	                            count: chartLineCount, units: {
	                                years: { format: ['yyyy년'] },
	                                months: { format: ['MM월'] },
	                                days: { format: ['dd일'] },
	                                hours: { format: ['HH시'] }
	                            }
	                        }, textStyle: { fontSize: 12 }
	                    },
	                    vAxis: { minValue: 100, viewWindow: { min: 0 }, gridlines: { count: -1 }, textStyle: { fontSize: 12 } },
	                    animation: { startup: true, duration: 1000, easing: 'in' },
	                    annotations: {
	                        pattern: chartDateformat,
	                        textStyle: {
	                            fontSize: 15,
	                            bold: true,
	                            italic: true,
	                            color: '#871b47',
	                            auraColor: '#d799ae',
	                            opacity: 0.8,
	                            pattern: chartDateformat
	                        }
	                    }
	                }
	            });

	            var control = new google.visualization.ControlWrapper({
	                controlType: 'ChartRangeFilter',
	                containerId: 'controlsArea',  //control bar를 생성할 영역
	                options: {
	                    ui: {
	                        chartType: 'LineChart',
	                        chartOptions: {
	                            chartArea: { 'width': '60%', 'height': 80 },
	                            hAxis: {
	                                'baselineColor': 'none', format: chartDateformat, textStyle: { fontSize: 12 },
	                                gridlines: {
	                                    count: controlLineCount, units: {
	                                        years: { format: ['yyyy년'] },
	                                        months: { format: ['MM월'] },
	                                        days: { format: ['dd일'] },
	                                        hours: { format: ['HH시'] }
	                                    }
	                                }
	                            }
	                        }
	                    },
	                    filterColumnIndex: 0
	                }
	            });

	            var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat });
	            date_formatter.format(data, 0);

	            var dashboard = new google.visualization.Dashboard(document.getElementById('Line_Controls_Chart'));
	            window.addEventListener('resize', function () { dashboard.draw(data); }, false); //화면 크기에 따라 그래프 크기 변경
	            dashboard.bind([control], [chart]);
	            dashboard.draw(data);
	        }
	        google.charts.setOnLoadCallback(drawDashboard);
	    }
	}
	
	$(document).ready(function(){
		google.charts.load('50', {'packages':['line','controls']});
		/* google.charts.load('current', {'packages':['line','controls']}); */
		chartDrowFun.chartDrow(); //chartDrow() 실행
	});
</script>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
		/* 라이브러리 로드 */
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawVisualization);
	
		function drawVisualization() { 
			var data = google.visualization.arrayToDataTable([
					['Month', 'Bolivia', 'Ecuador', 'Madagascar', 'Papua New Guinea', 'Rwanda', 'Average'],
					['2004/05',  165,      938,         522,             998,           450,      614.6],
					['2005/06',  135,      1120,        599,             1268,          288,      682],
					['2006/07',  157,      1167,        587,             807,           397,      623],
					['2007/08',  139,      1110,        615,             968,           215,      609.4],
					['2008/09',  136,      691,         629,             1026,          366,      569.6]
				]);
			var options = {
					title : 'Monthly Coffee Production by Country',
					vAxis: {title: 'Cups'},
					hAxis: {title: 'Month'}, 
					seriesType: 'bars',
					series: {5: {type: 'line'}}
				};
			
			var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
			chart.draw(data, options);
		}
	</script>
</head>


<%@ include file="../layout/footer.jsp"%>
