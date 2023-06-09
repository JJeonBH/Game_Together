<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
// 	let totalWins = <c:out value="${totalWins}"/>;
// 	let totalLoses = <c:out value="${totalLoses}"/>;
	google.charts.load('current', {packages: ['corechart']});
	google.charts.setOnLoadCallback(drawChart);
	
	function drawChart() {
		// Define the chart to be drawn.
		let data = new google.visualization.DataTable();
			data.addColumn('string', 'WinOrLose');
			data.addColumn('number', 'Count');
			data.addRows([
				['승리', ${totalWins}],
				['패배', ${totalLoses}]
			]);
		
		// Set chart options
		let options = {
			title: ${totalWins + totalLoses} + '전 ' + ${totalWins} + '승 ' + ${totalLoses} + '패',
		    backgroundColor: 'transparent',
			width: 200,
			height: 200,
			fontSize: 15,
			pieHole: 0.7,
			pieSliceText: 'none',
			legend: 'none',
			tooltip: { 
				trigger: 'none'
			},
			chartArea:{
				left: '25%',
				width: '50%',
			},
			enableInteractivity: 'false',
		};
		
		// Instantiate and draw the chart.
		let chart = new google.visualization.PieChart(document.getElementById('pieChart'));
		
		chart.draw(data, options);
		
	}
	
</script>

<section class="mt-6 mx-20 text-sm min-w-1000">
	<c:if test="${summoner != null && matches != null}">
		<div class="flex border border-indigo-100">
			<div>
				<div class="chartWithOverlay">
					<div id="pieChart"></div>
					<div class="overlay">${odds}%</div>
				</div>
			</div>
			<div>
			</div>
		</div>
	</c:if>
</section>