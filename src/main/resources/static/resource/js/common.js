function themeToggle() {
	
		const theme = localStorage.getItem("theme") ?? "light";
		
		if (theme == 'light') {
			localStorage.setItem("theme", "night");
		} else {
			localStorage.setItem("theme", "light");
		}
		
		themeInit();
		
}

function themeInit() {
	
		const theme = localStorage.getItem("theme") ?? "light";
		
		themeApplyTo(theme);
		
}

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

function submitSearchForm(form) {
	
	form.summonerName.value = form.summonerName.value.trim();
	
	if (form.summonerName.value.length == 0) {
		alert("소환사명을 입력해주세요.");
		return;
	}
	
	form.submit();
	
}

function addMatches(sName) {

	$.get('/usr/lol/getSummoner', {
		summonerName : sName
	}, function(summoner) {
		getMatches(summoner.puuid, summoner);
	}, 'json');
	
}

function getMatches(sPuuid, summoner) {
	
	$.get('/usr/lol/getMatches', {
		summonerPuuid : sPuuid
	}, function(matches) {
		showMatches(matches, summoner);
	});
	
}

function showMatches(matches, summoner) {
	
	matches.forEach((match, idx1, arr1) => {
		match.info.participants.forEach((participant, idx2, arr2) => {
			if (participant.puuid == summoner.puuid) {
				let append = `<div class="text-gray-600 rounded-lg mt-2 px-4 py-2 flex ${participant.win == true ? 'bg-blue-200' : 'bg-red-200'}">`;
				append += `<div class="text-sm">`;
				summoner.dataQueues.forEach((queue, idx3, arr3) => {
					if(queue.queueId == match.info.queueId) {
						append += `<div class="w-32 text-base ${participant.win == true ? 'text-blue-600' : 'text-red-600'}">`;
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
				append += `<div>${match.info.matchStartDateTime}</div>`;
				append += `<div class="w-16 ${participant.win == true ? 'border-b border-blue-500' : 'border-b border-red-500'}"></div>`;
				append += `<div>`;
				if (participant.win) {
					append += `<span>승리</span>`;
				} else {
					append += `<span>패배</span>`;
				}
				append += `</div>`;
				append += `<div>${match.info.matchDuration}</div>`;
				append += `</div>`;
				append += `<div class="ml-4">`;
				append += `<div class="flex">`;
				append += `<div>`;
				append += `<img class="rounded-full" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer[0]}/img/champion/${participant.championName}.png" width="50" alt="champion icon image"/>`;
				append += `</div>`;
				append += `<div class="ml-1">`;
				let spells = participant.spellList;
//				let map = summoner.spellData.data
//				console.log(map);
//				spells.forEach((spell, idx4, arr4) => {
//					summoner.spellData.data.forEach((spellData, idx5, arr5) => {
//						if(spellData.value.key == spell) {
//							append += `<img class="rounded" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer.get[0]}/img/spell/${spellData.key}.png" width="25" alt="spell image"/>`;
//						}
//					});
//				});
				append += `</div>`;
				append += `<div>`;
				append += `<div>룬1</div>`;
				append += `<div>룬2</div>`;
				append += `</div>`;
				append += `</div>`;
				append += `<div class="mt-2 flex">`;
				let items = participant.itemList;
				items.forEach((item, idx6, arr6) => {
					append += `<div class="ml-1px">`;
					if (item != 0) {
						append += `<img class="rounded" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer[0]}/img/item/${item}.png" width="25" alt="item image"/>`;
					} else {
						append += `<div class="rounded w-25px h-25px ${participant.win == true ? 'bg-blue-400' : 'bg-red-400'}"></div>`;
					}
					append += `</div>`;
				});
				append += `</div>`;
				append += `</div>`;
				append += `</div>`;
				$('.show-match').append(append);
			}
		});
	});
	
}

themeInit();