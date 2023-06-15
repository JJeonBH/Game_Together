<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>

	let mD;
	
	// 소환사 이름으로 소환사 정보 가져오기
	function addMatches(summonerName) {
		
		if (mD == null) {
			mD = getOriginalMatchesData();
		}
		
		$('.add-matches').empty();
		$('.add-matches').addClass('loading loading-spinner');
	
		$.get('/usr/lol/getSummoner', {
			summonerName : summonerName
		}, function(summoner) {
			getMatches(summoner.puuid, summoner);
		}, 'json');
		
	}
	
	//	처음 검색했을 때 보여준 통계 정보 가져오기
	function getOriginalMatchesData() {
		
		let originalMatchesData = {
				
			totalWins: ${matchesData.totalWins},
			totalLoses: ${matchesData.totalLoses},
			totalKills: ${matchesData.totalKills},
			totalDeaths: ${matchesData.totalDeaths},
			totalAssists: ${matchesData.totalAssists},
			totalTeamKills: ${matchesData.totalTeamKills},
			teamPositions: new Map([
				["TOP", ${matchesData.teamPositions.get("TOP")}],
				["JUNGLE", ${matchesData.teamPositions.get("JUNGLE")}],
				["MIDDLE", ${matchesData.teamPositions.get("MIDDLE")}],
				["BOTTOM", ${matchesData.teamPositions.get("BOTTOM")}],
				["UTILITY", ${matchesData.teamPositions.get("UTILITY")}]
			]),
			champions: []
				
		}
		
		let champion;
		
		<c:forEach var="champ" items="${matchesData.champions}">
			
			champion = {
				
				championName: '${champ.championName}',
				kills: ${champ.kills},
				deaths: ${champ.deaths},
				assists: ${champ.assists},
				winCount: ${champ.winCount},
				matchCount: ${champ.matchCount}
				
			}
			
			originalMatchesData.champions.push(champion);
			
		</c:forEach>
		
		return originalMatchesData;
		
	}
	
	//	소환사 정보의 puuid로 매치 정보 가져오기
	function getMatches(summonerPuuid, summoner) {
		
		$.get('/usr/lol/getMatches', {
			summonerPuuid : summonerPuuid
		}, function(matches) {
			if (matches != null) {
				let mcsData = getMatchesData(matches, summoner);
				addMatchesData(mcsData);
				showMatches(matches, summoner);
				google.charts.setOnLoadCallback(modifyPieChart);
				google.charts.setOnLoadCallback(modifyBarChart);
				modifyStatistics(summoner);
			}
			$('.add-matches').html('더보기');
			$('.add-matches').removeClass('loading loading-spinner');
		});
		
	}
	
	//	매치 정보에서 통계에 필요한 정보 뽑기
	function getMatchesData(matches, summoner) {
		
		let mcsData = {
			
			totalWins: 0,
			totalLoses: 0,
			totalKills: 0,
			totalDeaths: 0,
			totalAssists: 0,
			totalTeamKills: 0,
			teamPositions: new Map([
				["TOP", 0],
				["JUNGLE", 0],
				["MIDDLE", 0],
				["BOTTOM", 0],
				["UTILITY", 0]
			]),
			champions: []
			
		}
		
		matches.forEach((match) => {
			
			match.info.participants.forEach((participant) => {
				
				if (participant.puuid == summoner.puuid) {
					
					if (participant.gameEndedInEarlySurrender == false) {
						
						let kills = participant.kills;
						let deaths = participant.deaths;
						let assists = participant.assists;
						
						if (participant.win) {
							mcsData.totalWins += 1;
						} else {
							mcsData.totalLoses += 1;
						}
						
						mcsData.totalKills += kills;
						mcsData.totalDeaths += deaths;
						mcsData.totalAssists += assists;
						
						match.info.teams.forEach((team) => {
							
							if (team.teamId == participant.teamId) {
								mcsData.totalTeamKills += team.objectives.champion.kills;
							}
							
						});
						
						if (match.info.queueId == 420) {
							mcsData.teamPositions.set(participant.teamPosition, mcsData.teamPositions.get(participant.teamPosition) + 1);
						}
						
						let championName = participant.championName;
						let matchCount = 1;
						let winCount;
						
						if (participant.win) {
							winCount = 1;
						} else {
							winCount = 0;
						}
						
						let champion = {
							
							championName: championName,
							kills: kills,
							deaths: deaths,
							assists: assists,
							winCount: winCount,
							matchCount: matchCount
							
						}
						
						mcsData.champions.push(champion);
						
						for (let i = 0; i < mcsData.champions.length; i++) {
							
							let champ = mcsData.champions[i];
							let champName = champ.championName;
							
							for (let j = i + 1; j < mcsData.champions.length; j++) {
								
								if (champName == mcsData.champions[j].championName) {
									
									let equalChamp = mcsData.champions[j];
									
									champ.kills += equalChamp.kills;
									champ.deaths += equalChamp.deaths;
									champ.assists += equalChamp.assists;
									champ.winCount += equalChamp.winCount;
									champ.matchCount += equalChamp.matchCount;
									
									mcsData.champions.splice(j, 1);
									
								}
								
							}
							
						}
						
					}
					
				}
				
			});
			
		});
		
		//	경기 수 기준 내림차순 정렬
		mcsData.champions.sort(function(champA, champB) {
			return champB.matchCount - champA.matchCount;
		});
		
		return mcsData;
		
	}
	
	//	기존에 있던 통계 정보에 가져온 정보 합치기
	function addMatchesData(mcsData) {
		
		mD.totalWins += mcsData.totalWins;
		mD.totalLoses += mcsData.totalLoses;
		mD.totalKills += mcsData.totalKills;
		mD.totalDeaths += mcsData.totalDeaths;
		mD.totalAssists += mcsData.totalAssists;
		mD.totalTeamKills += mcsData.totalTeamKills;
		
		mD.teamPositions.set("TOP", mD.teamPositions.get("TOP") + mcsData.teamPositions.get("TOP"));
		mD.teamPositions.set("JUNGLE", mD.teamPositions.get("JUNGLE") + mcsData.teamPositions.get("JUNGLE"));
		mD.teamPositions.set("MIDDLE", mD.teamPositions.get("MIDDLE") + mcsData.teamPositions.get("MIDDLE"));
		mD.teamPositions.set("BOTTOM", mD.teamPositions.get("BOTTOM") + mcsData.teamPositions.get("BOTTOM"));
		mD.teamPositions.set("UTILITY", mD.teamPositions.get("UTILITY") + mcsData.teamPositions.get("UTILITY"));
		
		mD.champions = mD.champions.concat(mcsData.champions);
		
		for (let i = 0; i < mD.champions.length; i++) {
			
			let champ = mD.champions[i];
			let champName = champ.championName;
			
			for (let j = i + 1; j < mD.champions.length; j++) {
				
				if (champName == mD.champions[j].championName) {
					
					let equalChamp = mD.champions[j];
					
					champ.kills += equalChamp.kills;
					champ.deaths += equalChamp.deaths;
					champ.assists += equalChamp.assists;
					champ.winCount += equalChamp.winCount;
					champ.matchCount += equalChamp.matchCount;
					
					mD.champions.splice(j, 1);
					
				}
				
			}
			
		}
		
		mD.champions.sort(function(champA, champB) {
			return champB.matchCount - champA.matchCount;
		});
		
	}
	
	//	원형 차트 값 변경
	function modifyPieChart() {
		// Define the chart to be drawn.
		let data = new google.visualization.DataTable();
			data.addColumn('string', 'WinOrLose');
			data.addColumn('number', 'Count');
			data.addRows([
				['승리', mD.totalWins],
				['패배', mD.totalLoses]
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
	
	//	막대 차트 값 변경
	function modifyBarChart() {
		
		let data = google.visualization.arrayToDataTable([
			['Position', 'Frequency', { role: 'style' }],
			["Top", mD.teamPositions.get("TOP"), 'color: #ff0303; opacity: 0.7;'],
			["Jungle", mD.teamPositions.get("JUNGLE"), 'color: #ff8903; opacity: 0.7;'],
			["Middle", mD.teamPositions.get("MIDDLE"), 'color: #63ff03; opacity: 0.7;'],
			["Bottom", mD.teamPositions.get("BOTTOM"), 'color: #03afff; opacity: 0.7;'],
			["Support", mD.teamPositions.get("UTILITY"), 'color: #c403ff; opacity: 0.7;']
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
	
	//	'더보기' 눌렀을 때 통계 업데이트
	function modifyStatistics(summoner) {
		
		$('#statistics-title').empty();
		$('#statistics-title').html('최근 ' + (mD.totalWins + mD.totalLoses) + '게임 통계');
		$('.pieChartTitleOverlay').empty();
		$('.pieChartTitleOverlay').html((mD.totalWins + mD.totalLoses) + '전 ' + mD.totalWins + '승 ' + mD.totalLoses + '패');
		$('.pieChartOverlay').empty();
		$('.pieChartOverlay').html(Math.round((mD.totalWins / (mD.totalWins + mD.totalLoses)) * 100) + '%');
		let avgKill = Math.round((mD.totalKills / (mD.totalWins + mD.totalLoses)) * 10) / 10.0;
		let avgDeath = Math.round((mD.totalDeaths / (mD.totalWins + mD.totalLoses)) * 10) / 10.0;
		let avgAssist = Math.round((mD.totalAssists / (mD.totalWins + mD.totalLoses)) * 10) / 10.0;
		$('.avgKill').empty();
		$('.avgKill').html(avgKill);
		$('.avgDeath').empty();
		$('.avgDeath').html(avgDeath);
		$('.avgAssist').empty();
		$('.avgAssist').html(avgAssist);
		$('.avgKDA').empty();
		$('.avgKDA').html(Math.round(((avgKill + avgAssist) / avgDeath) * 100) / 100.0 + ' 평점');
		$('.avgKillInvolvement').empty();
		$('.avgKillInvolvement').html('킬관여 ' + Math.round(((mD.totalKills + mD.totalAssists) / mD.totalTeamKills) * 100) + '%');
		$('.mostChampionsTitle').empty();
		$('.mostChampionsTitle').html('플레이한 챔피언 (최근 ' + (mD.totalWins + mD.totalLoses) + '게임)');
		$('.mostChampions').empty();
		
		for (let i = 0; i < 3; i++) {
			
			let champion = mD.champions[i];
			
			if (champion != null) {
				let champAvgKDA = Math.round(((champion.kills + champion.assists) / champion.deaths) * 100) / 100.0;
				
				let append = `<div class="flex items-center text-xs my-2">`;
				append += `<div>`;
				append += `<img class="rounded-full" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer[0]}/img/champion/\${champion.championName}.png" width="30" alt="champion icon image"/>`;
				append += `</div>`;
				append += `<div class="ml-2">`;
				append += `<span class="\${Math.round((champion.winCount / champion.matchCount) * 100) < 60 ? 'text-gray-500' : 'text-red-600'}">\${Math.round((champion.winCount / champion.matchCount) * 100)}%</span>`;
				append += `</div>`;
				append += `<div class="ml-1">`;
				append += `<span class="text-gray-400">(\${champion.winCount}승 \${champion.matchCount - champion.winCount}패)</span>`;
				append += `</div>`;
				append += `<div class="ml-1">`;
				append += `<span class="\${champAvgKDA < 3.0 ? 'text-gray-500' : champAvgKDA < 4.0 ? 'text-green-500' : champAvgKDA < 5.0 ? 'text-blue-500' : 'text-yellow-500'}">\${champAvgKDA} 평점</span>`;
				append += `</div>`;
				append += `</div>`;
				
				$('.mostChampions').append(append);
			}
			
		}
		
	}

</script>
<section class="mt-3 mx-20 text-sm min-w-1000">
	<c:if test="${summoner != null && matches != null}">
		<div class="show-match h-96 overflow-auto">
			<c:forEach var="match" items="${matches}">
				<c:forEach var="participant" items="${match.info.participants}">
		 			<c:if test="${participant.puuid == summoner.puuid}">
						<div class="text-gray-600 rounded-lg mt-2 px-4 py-2 flex items-center ${participant.gameEndedInEarlySurrender == true ? 'bg-gray-200' : participant.win == true ? 'bg-blue-200' : 'bg-red-200'}">
			 				<div class="w-36">
								<c:forEach var="queue" items="${summoner.queues}">
									<c:if test="${queue.queueId == match.info.queueId}">
										<div class="text-base ${participant.gameEndedInEarlySurrender == true ? 'text-gray-600' : participant.win == true ? 'text-blue-600' : 'text-red-600'}">
											<c:choose>
												<c:when test="${queue.queueId == 0}">
													<div>사용자 지정 게임</div>
												</c:when>
												<c:when test="${queue.queueId == 400 || queue.queueId == 430}">
													<div>일반</div>
												</c:when>
												<c:when test="${queue.queueId == 420}">
													<div>솔랭</div>
												</c:when>
												<c:when test="${queue.queueId == 440}">
													<div>자유 5:5 랭크</div>
												</c:when>
												<c:when test="${queue.queueId == 450}">
													<div>무작위 총력전</div>
												</c:when>
												<c:when test="${queue.queueId == 830}">
													<div>입문</div>
												</c:when>
												<c:when test="${queue.queueId == 840}">
													<div>초보</div>
												</c:when>
												<c:when test="${queue.queueId == 850}">
													<div>중급</div>
												</c:when>
												<c:when test="${queue.queueId == 900 || queue.queueId == 1010}">
													<div>모두 무작위 U.R.F.</div>
												</c:when>
												<c:when test="${queue.queueId == 920}">
													<div>전설의 포로왕</div>
												</c:when>
												<c:when test="${queue.queueId == 1400}">
													<div>궁극의 주문서</div>
												</c:when>
												<c:when test="${queue.queueId == 1900}">
													<div>U.R.F.</div>
												</c:when>
												<c:otherwise>
													<div>특별 게임</div>
												</c:otherwise>
											</c:choose>
										</div>
									</c:if>
								</c:forEach>
								<div>${match.info.getMatchFinishDateTime()}</div>
								<div class="w-16 my-1 ${participant.gameEndedInEarlySurrender == true ? 'border-b border-gray-500' : participant.win == true ? 'border-b border-blue-500' : 'border-b border-red-500'}"></div>
								<div>
									<c:choose>
										<c:when test="${participant.gameEndedInEarlySurrender}">
											<span>다시하기</span>
										</c:when>
										<c:when test="${participant.win}">
											<span>승리</span>
										</c:when>
										<c:otherwise>
											<span>패배</span>
										</c:otherwise>
									</c:choose>
								</div>
								<div>${match.info.getMatchDuration()}</div>
							</div>
							<div class="w-68">
								<div class="flex">
									<div>
										<img class="rounded-full" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer.get(0)}/img/champion/${participant.championName}.png" width="50" alt="champion icon image"/>
									</div>
									<div class="ml-1">
										<c:set var="spellIds" value="${participant.getSpellIds()}"/>
										<c:forEach var="spellId" items="${spellIds}">
											<c:forEach var="spellData" items="${summoner.spellData.data}">
												<c:if test="${spellData.value.key == spellId}">
													<img class="rounded my-1px" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer.get(0)}/img/spell/${spellData.key}.png" width="25" alt="spell image"/>
												</c:if>
											</c:forEach>
										</c:forEach>
									</div>
									<div class="ml-1px">
										<c:forEach var="runeStyle" items="${summoner.runeStyle}">
											<c:if test="${runeStyle.id == participant.perks.styles.get(0).style}">
												<c:forEach var="runeDetail" items="${runeStyle.slots}">
													<c:forEach var="rune" items="${runeDetail.runes}">
														<c:if test="${rune.id == participant.perks.styles.get(0).selections.get(0).perk}">
															<div>
																<img class="rounded-full bg-black my-1px" src="http://ddragon.leagueoflegends.com/cdn/img/${rune.icon}" width="25" alt="rune image"/>
															</div>
														</c:if>
													</c:forEach>
												</c:forEach>
											</c:if>
										</c:forEach>
										<c:forEach var="runeStyle" items="${summoner.runeStyle}">
											<c:if test="${runeStyle.id == participant.perks.styles.get(1).style}">
												<div>
													<img class="rounded-full my-1px" src="http://ddragon.leagueoflegends.com/cdn/img/${runeStyle.icon}" width="25" alt="rune image"/>
												</div>
											</c:if>
										</c:forEach>
									</div>
									<div class="ml-3 mt-1 text-black text-base">
										<div>
											<span>${participant.kills}</span>
											<span class="text-gray-500">/</span>
											<span class="text-red-600">${participant.deaths}</span>
											<span class="text-gray-500">/</span>
											<span>${participant.assists}</span>
										</div>
										<div>
											<span>${participant.getKDA()} 평점</span>
										</div>
									</div>
								</div>
								<div class="mt-3 flex">
									<c:set var="items" value="${participant.getItems()}"/>
									<c:forEach var="item" items="${items}">
										<div class="ml-1px">
											<c:choose>
												<c:when test="${item != 0}">
													<img class="rounded" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer.get(0)}/img/item/${item}.png" width="25" alt="item image"/>
												</c:when>
												<c:otherwise>
													<div class="rounded w-25px h-25px ${participant.gameEndedInEarlySurrender == true ? 'bg-gray-400' : participant.win == true ? 'bg-blue-400' : 'bg-red-400'}"></div>
												</c:otherwise>
											</c:choose>
										</div>
									</c:forEach>
								</div>
							</div>
							<div class="w-36 text-xs">
								<c:forEach var="team" items="${match.info.teams}">
									<c:if test="${team.teamId == participant.teamId}">
										<div class="text-red-600">킬관여 ${participant.getKillInvolvement(team.objectives.champion.kills)}%</div>
									</c:if>
								</c:forEach>
								<div>제어 와드 ${participant.visionWardsBoughtInGame}</div>
								<div>와드 설치 ${participant.wardsPlaced}</div>
								<div>와드 제거 ${participant.wardsKilled}</div>
								<div class="text-purple-600">CS ${participant.getCS()} (${match.info.getCSPerMinute(participant.getCS())})</div>
								<div class="text-pink-600">피해량 ${participant.getTotalDamageDealtToChampions()}</div>
							</div>
							<ul class="ml-6 w-40">
								<c:forEach var="participant" items="${match.info.participants}" begin="0" end="4">
									<li class="flex">
										<div class="my-1px">
											<img class="${participant.puuid == summoner.puuid ? 'rounded-full' : 'rounded'}" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer.get(0)}/img/champion/${participant.championName}.png" width="20" alt="champion icon image"/>
										</div>
										<div class="w-32 my-1px ml-1 truncate ${participant.puuid == summoner.puuid ? 'text-indigo-600' : ''}"><a href="../lol/searchFromMatch?summonerPuuid=${participant.puuid}">${participant.summonerName}</a></div>
									</li>
								</c:forEach>
							</ul>
							<ul class="ml-3 w-40">
								<c:forEach var="participant" items="${match.info.participants}" begin="5" end="9">
									<li class="flex">
										<div class="my-1px">
											<img class="${participant.puuid == summoner.puuid ? 'rounded-full' : 'rounded'}" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer.get(0)}/img/champion/${participant.championName}.png" width="20" alt="champion icon image"/>
										</div>
										<div class="w-32 my-1px ml-1 truncate ${participant.puuid == summoner.puuid ? 'text-indigo-600' : ''}"><a href="../lol/searchFromMatch?summonerPuuid=${participant.puuid}">${participant.summonerName}</a></div>
									</li>
								</c:forEach>
							</ul>
						</div>
		 			</c:if>
				</c:forEach>
			</c:forEach>
		</div>
		<div class="rounded-lg mt-2">
			<a class="add-matches flex justify-center items-center btn-text-color btn btn-info" href="javascript:addMatches(`${summoner.name}`)">
				더보기
			</a>
		</div>
	</c:if>
</section>