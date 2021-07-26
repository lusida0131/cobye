<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

	<!-- <script src="https://code.jquery.com/jquery.min.js"></script> -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>


 <style>
#container {
    height: 400px;
}

.highcharts-figure, .highcharts-data-table table {
    min-width: 310px;
    max-width: 800px;
    margin: 1em auto;
}

#datatable {
    font-family: Verdana, sans-serif;
    border-collapse: collapse;
    border: 1px solid #EBEBEB;
    margin: 10px auto;
    text-align: center;
    width: 100%;
    max-width: 500px;
}
#datatable caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
#datatable th {
	font-weight: 600;
    padding: 0.5em;
}
#datatable td, #datatable th, #datatable caption {
    padding: 0.5em;
}
#datatable thead tr, #datatable tr:nth-child(even) {
    background: #f8f8f8;
}
#datatable tr:hover {
    background: #f1f7ff;
}

 </style>   

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<figure class="highcharts-figure">
    <div id="container"></div>
    <p class="highcharts-description">
        Chart showing how an HTML table can be used as the data source for the
        chart using the Highcharts data module. The chart is built by
        referencing the existing HTML data table in the page. Several common
        data source types are available, including CSV and Google Spreadsheet.
    </p>

    <table id="datatable">
        <thead>
            <tr>
                <th></th>
                <th>Jane</th>
                <th>John</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>Apples</th>
                <td>3</td>
                <td>4</td>
            </tr>
            <tr>
                <th>Pears</th>
                <td>2</td>
                <td>0</td>
            </tr>
            <tr>
                <th>Plums</th>
                <td>5</td>
                <td>11</td>
            </tr>
            <tr>
                <th>Bananas</th>
                <td>1</td>
                <td>1</td>
            </tr>
            <tr>
                <th>Oranges</th>
                <td>2</td>
                <td>4</td>
            </tr>
        </tbody>
    </table>
</figure>
<script>
Highcharts.chart('container', {
    data: {
        table: 'datatable'
    },
    chart: {
        type: 'column'
    },
    title: {
        text: 'Data extracted from a HTML table in the page'
    },
    yAxis: {
        allowDecimals: false,
        title: {
            text: 'Units'
        }
    },
    tooltip: {
        formatter: function () {
            return '<b>' + this.series.name + '</b><br/>' +
                this.point.y + ' ' + this.point.name.toLowerCase();
        }
    }
});
    </script>
<%@ include file="../layout/footer.jsp"%>