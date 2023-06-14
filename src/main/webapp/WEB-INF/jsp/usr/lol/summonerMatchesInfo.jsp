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
		    backgroundColor: 'transparent',
			width: 200,
			height: 200,
			pieHole: 0.8,
			pieSliceText: 'none',
			legend: 'none',
			tooltip: { 
				trigger: 'none'
			},
			chartArea: {
				left: '25%',
				width: '50%'
			},
			enableInteractivity: 'false'
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
					color: '#ee54ff'
				},
				baselineColor: '#008efa'
			}
		};
	     
		let chart = new google.visualization.ColumnChart(document.getElementById('barChart'));
		
		chart.draw(data, options);
	     
	}
	
	//	글자색 3초마다 랜덤으로 변경
	window.onload = function() {
		
		let statisticsTitle = document.getElementById("statistics-title")
		
		setInterval(function() { 
		 
		let vr = parseInt(Math.random() * 256);
		let vg = parseInt(Math.random() * 256); 
		let vb = parseInt(Math.random() * 256); 
		
		statisticsTitle.style.color = 'rgb(' + vr +',' + vg +',' + vb +')';
		  
		}, 3000)
		
	}
	
</script>
<section class="mt-6 mx-20 text-sm min-w-1000">
	<c:if test="${summoner != null && matches != null}">
		<div class="statistics border border-indigo-100">
			<div class="flex justify-center text-xl mt-2">
				<span id="statistics-title">최근 ${matchesData.totalWins + matchesData.totalLoses}게임 통계</span>
			</div>
			<div class="flex justify-center">
				<div>
					<div class="pieChartWithOverlay">
						<div id="pieChart"></div>
						<div class="pieChartTitleOverlay w-full text-center">${matchesData.totalWins + matchesData.totalLoses}전 ${matchesData.totalWins}승 ${matchesData.totalLoses}패</div>
						<div class="pieChartOverlay">${Math.round((matchesData.totalWins / (matchesData.totalWins + matchesData.totalLoses)) * 100)}%</div>
					</div>
				</div>
				<div class="flex items-center">
					<div>
						<div class="text-gray-400">
							<c:set var="avgKill" value="${Math.round((matchesData.totalKills / (matchesData.totalWins + matchesData.totalLoses)) * 10) / 10.0}" />
							<span class="avgKill">${avgKill}</span>
							<span>/</span>
							<c:set var="avgDeath" value="${Math.round((matchesData.totalDeaths / (matchesData.totalWins + matchesData.totalLoses)) * 10) / 10.0}" />
							<span class="avgDeath text-red-600">${avgDeath}</span>
							<span>/</span>
							<c:set var="avgAssist" value="${Math.round((matchesData.totalAssists / (matchesData.totalWins + matchesData.totalLoses)) * 10) / 10.0}" />
							<span class="avgAssist">${avgAssist}</span>
						</div>
						<div class="my-1">
							<span class="avgKDA text-base">${Math.round(((avgKill + avgAssist) / avgDeath) * 100) / 100.0} 평점</span>
						</div>
						<div>
							<span class="avgKillInvolvement text-red-600">킬관여 ${Math.round(((matchesData.totalKills + matchesData.totalAssists) / matchesData.totalTeamKills) * 100)}%</span>
						</div>
					</div>
				</div>
				<div class="ml-12 flex items-center">
					<div>
						<div class="my-3 text-gray-400">
							<span class="mostChampionsTitle">플레이한 챔피언 (최근 ${matchesData.totalWins + matchesData.totalLoses}게임)</span>
						</div>
						<div class="mostChampions h-28">
							<c:forEach var="champion" items="${matchesData.champions}" begin="0" end="2">
								<div class="flex items-center text-xs my-2">
									<div>
										<img class="rounded-full" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer.get(0)}/img/champion/${champion.championName}.png" width="30" alt="champion icon image"/>
									</div>
									<div class="ml-2">
										<span class="${Math.round((champion.winCount / champion.matchCount) * 100) < 60 ? 'text-gray-500' : 'text-red-600'}">${Math.round((champion.winCount / champion.matchCount) * 100)}%</span>
									</div>
									<div class="ml-1">
										<span class="text-gray-400">(${champion.winCount}승 ${champion.matchCount - champion.winCount}패)</span>
									</div>
									<div class="ml-1">
										<c:set var="champAvgKDA" value="${Math.round(((champion.kills + champion.assists) / champion.deaths) * 100) / 100.0}"/>
										<span class="${champAvgKDA < 3.0 ? 'text-gray-500' : champAvgKDA < 4.0 ? 'text-green-500' : champAvgKDA < 5.0 ? 'text-blue-500' : 'text-yellow-500'}">${champAvgKDA} 평점</span>
									</div>
								</div>
							</c:forEach>
						</div>
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
		</div>
	</c:if>
</section>