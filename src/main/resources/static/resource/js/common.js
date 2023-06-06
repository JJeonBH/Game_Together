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
	
	$('.add-matches').empty();
	$('.add-matches').addClass('loading loading-spinner');

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
		$('.add-matches').html('더보기');
		$('.add-matches').removeClass('loading loading-spinner');
	});
	
}

function showMatches(matches, summoner) {
	
	matches.forEach((match) => {
		match.info.participants.forEach((participant) => {
			if (participant.puuid == summoner.puuid) {
				let append = `<div class="text-gray-600 rounded-lg mt-2 px-4 py-2 flex ${participant.win == true ? 'bg-blue-200' : 'bg-red-200'}">`;
				append += `<div class="text-sm">`;
				summoner.queues.forEach((queue) => {
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
				let spellIds = participant.spellIds;
				let spellData = summoner.spellData.data
				spellIds.forEach((spellId) => {
					for (let spellName in spellData) {
						if(spellData[spellName].key == spellId) {
							append += `<img class="rounded" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer[0]}/img/spell/${spellName}.png" width="25" alt="spell image"/>`;
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
				append += `</div>`;
				append += `<div class="mt-2 flex">`;
				let items = participant.items;
				items.forEach((item) => {
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