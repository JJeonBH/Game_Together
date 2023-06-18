//	테마 관련 함수
function themeToggle() {
	
		const theme = localStorage.getItem("theme") ?? "light";
		
		if (theme == 'light') {
			localStorage.setItem("theme", "dark");
		} else {
			localStorage.setItem("theme", "light");
		}
		
		themeInit();
		
}

//	테마 관련 함수
function themeInit() {
	
		const theme = localStorage.getItem("theme") ?? "light";
		
		themeApplyTo(theme);
		
}

//	테마 관련 함수
function themeApplyTo(themeName) {
	
		$('html').attr('data-theme', themeName);
		
		$('.theme-toggle-msg').empty();
		
		if (themeName == 'light') {
			$('.theme-toggle-msg').append('Light mode');
			$('.dropdown-content').css('background', 'white');
			$('.dropdown-content').css('color', 'black');
		} else {
			$('.theme-toggle-msg').append('Dark mode');
			$('.dropdown-content').css('background', '#221c75');
			$('.dropdown-content').css('color', '#ffffff');
		}
		
}

//	테마 적용
themeInit();

//	소환사 검색시 유효성 검사
function submitSummonerSearchForm(form) {
	
	form.summonerName.value = form.summonerName.value.trim();
	
	if (form.summonerName.value.length == 0) {
		alert("소환사명을 입력해주세요.");
		return;
	}
	
	form.submit();
	
}

//	'매치' 화면에 보여주기
function showMatches(matches, summoner) {
	
	matches.forEach((match) => {
		match.info.participants.forEach((participant) => {
			if (participant.puuid == summoner.puuid) {
				
				//	처음 여는 div
				let append = `<div class="text-gray-600 rounded-lg mt-2 px-4 py-2 flex items-center ${participant.gameEndedInEarlySurrender == true ? 'bg-gray-200' : participant.win == true ? 'bg-blue-200' : 'bg-red-200'}">`;
				
				//	class="w-36" div 시작
				append += `<div class="w-36">`;
				
				summoner.queues.forEach((queue) => {
					if(queue.queueId == match.info.queueId) {
						append += `<div class="text-base ${participant.gameEndedInEarlySurrender == true ? 'text-gray-600' : participant.win == true ? 'text-blue-600' : 'text-red-600'}">`;
						switch (queue.queueId) {
							case 0:
								append += `<div>사용자 지정 게임</div>`;
								break;
							case 400:
							case 430:
								append += `<div>일반</div>`;
								break;
							case 420:
								append += `<div>솔랭</div>`;
								break;
							case 440:
								append += `<div>자유 5:5 랭크</div>`;
								break;
							case 450:
								append += `<div>무작위 총력전</div>`;
								break;
							case 830:
								append += `<div>입문</div>`;
								break;
							case 840:
								append += `<div>초보</div>`;
								break;
							case 850:
								append += `<div>중급</div>`;
								break;
							case 900:
							case 1010:
								append += `<div>모두 무작위 U.R.F.</div>`;
								break;
							case 920:
								append += `<div>전설의 포로왕</div>`;
								break;
							case 1400:
								append += `<div>궁극의 주문서</div>`;
								break;
							case 1900:
								append += `<div>U.R.F.</div>`;
								break;
							default:
								append += `<div>특별 게임</div>`;
								break;
						}
						append += `</div>`;
					}
				});
				append += `<div>${match.info.matchFinishDateTime}</div>`;
				append += `<div class="w-16 my-1 ${participant.gameEndedInEarlySurrender == true ? 'border-b border-gray-500' : participant.win == true ? 'border-b border-blue-500' : 'border-b border-red-500'}"></div>`;
				append += `<div>`;
				if (participant.gameEndedInEarlySurrender) {
					append += `<span>다시하기</span>`;
				} else if (participant.win) {
					append += `<span>승리</span>`;
				} else {
					append += `<span>패배</span>`;
				}
				append += `</div>`;
				append += `<div>${match.info.matchDuration}</div>`;
				
				//	class="w-36" div 끝
				append += `</div>`;
				
				//	class="w-68" div 시작
				append += `<div class="w-68">`;
				
				append += `<div class="flex">`;
				append += `<div>`;
				append += `<img class="rounded-full" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer[0]}/img/champion/${participant.championName}.png" width="50" alt="champion icon image"/>`;
				append += `</div>`;
				append += `<div class="ml-1">`;
				let spellIds = participant.spellIds;
				let spellData = summoner.spellData.data
				spellIds.forEach((spellId) => {
					for (let spellName in spellData) {
						if(spellData[spellName].key == spellId) {
							append += `<img class="rounded my-1px" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer[0]}/img/spell/${spellName}.png" width="25" alt="spell image"/>`;
						}
					}
				});
				append += `</div>`;
				append += `<div class="ml-1px">`;
				summoner.runeStyle.forEach((runeStyle) => {
					if(runeStyle.id == participant.perks.styles[0].style) {
						runeStyle.slots.forEach((runeDetail) => {
							runeDetail.runes.forEach((rune) => {
								if(rune.id == participant.perks.styles[0].selections[0].perk) {
									append += `<div>`;
									append += `<img class="rounded-full bg-black my-1px" src="http://ddragon.leagueoflegends.com/cdn/img/${rune.icon}" width="25" alt="rune image"/>`;
									append += `</div>`;
								}
							});
						});
					}
				});
				summoner.runeStyle.forEach((runeStyle) => {
					if(runeStyle.id == participant.perks.styles[1].style) {
						append += `<div>`;
						append += `<img class="rounded-full my-1px" src="http://ddragon.leagueoflegends.com/cdn/img/${runeStyle.icon}" width="25" alt="rune image"/>`;
						append += `</div>`;
					}
				});
				append += `</div>`;
				append += `<div class="ml-3 mt-1 text-black text-base">`;
				append += `<div>`;
				append += `<span>${participant.kills}</span>`;
				append += `<span class="text-gray-500"> / </span>`;
				append += `<span class="text-red-600">${participant.deaths}</span>`;
				append += `<span class="text-gray-500"> / </span>`;
				append += `<span>${participant.assists}</span>`;
				append += `</div>`;
				append += `<div>`;
				append += `<span>${participant.kda} 평점</span>`;
				append += `</div>`;
				append += `</div>`;
				append += `</div>`;
				append += `<div class="mt-3 flex">`;
				let items = participant.items;
				items.forEach((item) => {
					append += `<div class="ml-1px">`;
					if (item != 0) {
						append += `<img class="rounded" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer[0]}/img/item/${item}.png" width="25" alt="item image"/>`;
					} else {
						append += `<div class="rounded w-25px h-25px ${participant.gameEndedInEarlySurrender == true ? 'bg-gray-400' : participant.win == true ? 'bg-blue-400' : 'bg-red-400'}"></div>`;
					}
					append += `</div>`;
				});
				append += `</div>`;
				
				//	class="w-68" div 끝
				append += `</div>`;
				
				//	class="w-36 text-xs" div 시작
				append += `<div class="w-36 text-xs">`;
				
				match.info.teams.forEach((team) => {
					if (team.teamId == participant.teamId) {
						let kASum = participant.kills + participant.assists;
						let teamChampionKills = team.objectives.champion.kills;
						let killInvolvement = getKillInvolvement(kASum, teamChampionKills);
						append += `<div class="text-red-600">킬관여 ${killInvolvement}%</div>`
					}
				});
				append += `<div>제어 와드 ${participant.visionWardsBoughtInGame}</div>`;
				append += `<div>와드 설치 ${participant.wardsPlaced}</div>`;
				append += `<div>와드 제거 ${participant.wardsKilled}</div>`;
				let cs = participant.cs;
				let csPerMinute = getCSPerMinute(match.info, cs);
				append += `<div class="text-purple-600">CS ${cs} (${csPerMinute})</div>`
				append += `<div class="text-pink-600">피해량 ${participant.totalDamageDealtToChampions}</div>`
				
				//	class="w-36 text-xs" div 끝
				append += `</div>`;
				
				//	class="ml-6 w-40" ul 시작
				append += `<ul class="ml-6 w-40">`;
				
				for (let index = 0; index < 5; index++) {
					append += `<li class="flex">`;
					append += `<div class="my-1px">`;
					append += `<img class="${match.info.participants[index].puuid == summoner.puuid ? 'rounded-full' : 'rounded'}" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer[0]}/img/champion/${match.info.participants[index].championName}.png" width="20" alt="champion icon image"/>`;
					append += `</div>`;
					append += `<div class="w-32 my-1px ml-1 truncate ${match.info.participants[index].puuid == summoner.puuid ? 'text-indigo-600' : ''}"><a href="../lol/searchFromMatch?summonerPuuid=${match.info.participants[index].puuid}">${match.info.participants[index].summonerName}</a></div>`;
					append += `</li>`;
				}
				
				//	class="ml-6 w-40" ul 끝
				append += `</ul>`;
				
				//	class="ml-3 w-40" ul 시작
				append += `<ul class="ml-3 w-40">`;
				
				for (let index = 5; index < 10; index++) {
					append += `<li class="flex">`;
					append += `<div class="my-1px">`;
					append += `<img class="${match.info.participants[index].puuid == summoner.puuid ? 'rounded-full' : 'rounded'}" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer[0]}/img/champion/${match.info.participants[index].championName}.png" width="20" alt="champion icon image"/>`;
					append += `</div>`;
					append += `<div class="w-32 my-1px ml-1 truncate ${match.info.participants[index].puuid == summoner.puuid ? 'text-indigo-600' : ''}"><a href="../lol/searchFromMatch?summonerPuuid=${match.info.participants[index].puuid}">${match.info.participants[index].summonerName}</a></div>`;
					append += `</li>`;
				}
				
				//	class="ml-3 w-40" ul 끝
				append += ``;

				//	마지막 닫는 div
				append += `</div>`;
				
				$('.show-match').append(append);
				
			}
		});
	});
	
}

//	매치 킬관여
function getKillInvolvement(kASum, teamChampionKills) {
	return Math.round((kASum / teamChampionKills) * 100);
}

//	매치 분당 CS
function getCSPerMinute(matchInfo, cs) {
	if (matchInfo.gameEndTimestamp != 0) {
		return Math.round(((cs / matchInfo.gameDuration) * 60) * 10) / 10.0;
	} else {
		let gD = matchInfo.gameDuration / 1000;
		return Math.round(((cs / gD) * 60) * 10) / 10.0;
	}
}