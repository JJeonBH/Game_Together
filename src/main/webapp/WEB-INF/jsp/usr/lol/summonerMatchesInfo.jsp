<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>

	google.charts.load('current', {packages: ['corechart']});
	google.charts.setOnLoadCallback(drawPieChart);
	google.charts.setOnLoadCallback(drawBarChart);
	
	function drawPieChart() {
		// Define the chart to be drawn.
		let data = new google.visualization.DataTable();
			data.addColumn('string', 'WinOrLose');
			data.addColumn('number', 'Count');
			data.addRows([
				['승리', ${matchesData.totalWins}],
				['패배', ${matchesData.totalLoses}]
			]);
		
		// Set chart options
		let options = {
			title: ${matchesData.totalWins + matchesData.totalLoses} + '전 ' + ${matchesData.totalWins} + '승 ' + ${matchesData.totalLoses} + '패',
			titleTextStyle: {
				color: '#81c8e6'
			},
		    backgroundColor: 'transparent',
			width: 200,
			height: 200,
			fontSize: 15,
			pieHole: 0.8,
			pieSliceText: 'none',
			legend: 'none',
			tooltip: { 
				trigger: 'none'
			},
			chartArea: {
				left: '25%',
				width: '50%',
			},
			enableInteractivity: 'false',
		};
		
		// Instantiate and draw the chart.
		let chart = new google.visualization.PieChart(document.getElementById('pieChart'));
		
		chart.draw(data, options);
		
	}
	
	function drawBarChart() {
		
	     let data = google.visualization.arrayToDataTable([
	       ['Position', 'Frequency', { role: 'style' }],
	       ["Top", ${matchesData.getTeamPositions().get("TOP")}, 'color: #ff0303; opacity: 0.7;'],
	       ["Jungle", ${matchesData.getTeamPositions().get("JUNGLE")}, 'color: #ff8903; opacity: 0.7;'],
	       ["Middle", ${matchesData.getTeamPositions().get("MIDDLE")}, 'color: #63ff03; opacity: 0.7;'],
	       ["Bottom", ${matchesData.getTeamPositions().get("BOTTOM")}, 'color: #03afff; opacity: 0.7;'],
	       ["Support", ${matchesData.getTeamPositions().get("UTILITY")}, 'color: #c403ff; opacity: 0.7;']
	     ]);
	
	     let options = {
			title: "선호 포지션 (솔로랭크)",
			titleTextStyle: {
				color: '#858585',
				fontSize: 15
			},
			backgroundColor: 'transparent',
			width: 425,
			fontSize: 12,
			legend: { 
				position: "none"
			},
			hAxis: {
				textStyle: {
					color: 'transparent'
				}
			},
			vAxis: {
				textStyle: {
					color: '#858585'
				},
				gridlines: {
					color: '#ee54ff',
				},
				baselineColor: '#008efa',
				ticks: [0, 5, 10, 15, 20]
			}
	     };
	     
	     let chart = new google.visualization.ColumnChart(document.getElementById('barChart'));
	     
	     chart.draw(data, options);
	     
	 }
	
</script>

<section class="mt-6 mx-20 text-sm min-w-1000">
	<c:if test="${summoner != null && matches != null}">
		<div class="flex justify-center border border-indigo-100">
			<div>
				<div class="pieChartWithOverlay">
					<div id="pieChart"></div>
					<div class="pieChartOverlay">${matchesData.odds}%</div>
				</div>
			</div>
			<div class="flex items-center">
				<div>
					<div class="text-gray-400">
						<span>${matchesData.avgKill}</span>
						<span>/</span>
						<span class="text-red-600">${matchesData.avgDeath}</span>
						<span>/</span>
						<span>${matchesData.avgAssist}</span>
					</div>
					<div class="my-1">
						<span class="text-base">${matchesData.avgKDA} 평점</span>
					</div>
					<div>
						<span class="text-red-600">킬관여 ${matchesData.killInvolvement}%</span>
					</div>
				</div>
			</div>
			<div class="ml-12 flex items-center">
				<div>
					<div class="my-3 text-gray-400">
						<span>플레이한 챔피언 (최근 20게임)</span>
					</div>
					<c:forEach var="champion" items="${matchesData.champions}" begin="0" end="2">
						<div class="flex items-center text-xs my-2">
							<div>
								<img class="rounded-full" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer.get(0)}/img/champion/${champion.championName}.png" width="30" alt="champion icon image"/>
							</div>
							<div class="ml-2">
								<span class="${champion.getOdds() < 60 ? 'text-gray-500' : 'text-red-600'}">${champion.getOdds()}%</span>
							</div>
							<div class="ml-1">
								<span class="text-gray-400">(${champion.winCount}승 ${champion.matchCount - champion.winCount}패)</span>
							</div>
							<div class="ml-1">
								<span class="${champion.getAvgKDA() < 3.0 ? 'text-gray-500' : champion.getAvgKDA() < 4.0 ? 'text-green-500' : champion.getAvgKDA() < 5.0 ? 'text-blue-500' : 'text-yellow-500'}">${champion.getAvgKDA()} 평점</span>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div>
				<div class="barChartWithOverlay">
					<div id="barChart"></div>
					<div class="barChartOverlay flex">
						<div class="mx-4">
							<img src="/resource/images/Position_Grandmaster-Top.png" alt="position img" width="25">
						</div>
						<div class="mx-4">
							<img src="/resource/images/Position_Grandmaster-Jungle.png" alt="position img" width="25">
						</div>
						<div class="mx-4">
							<img src="/resource/images/Position_Grandmaster-Mid.png" alt="position img" width="25">
						</div>
						<div class="mx-4">
							<img src="/resource/images/Position_Grandmaster-Bot.png" alt="position img" width="25">
						</div>
						<div class="mx-4">
							<img src="/resource/images/Position_Grandmaster-Support.png" alt="position img" width="25">
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>
</section>