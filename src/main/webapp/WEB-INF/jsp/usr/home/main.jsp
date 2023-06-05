<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="같이 할래?"></c:set>
<%@ include file="../common/head.jsp" %>
	<section class="mt-6 mx-20 text-lg min-w-1000">
		<div class="flex justify-center">
			<form action="../lol/search" method="POST" onsubmit="submitSearchForm(this); return false;">
				<input class="cursor-pointer input input-bordered input-info w-96 mr-1" type="text" name="summonerName" placeholder="소환사명을 입력해주세요."/>
				<button class="btn-text-color btn btn-info">검색</button>
			</form>
		</div>
	</section>
	<section class="mt-6 mx-20 text-lg min-w-1000">
		<c:if test="${summoner != null}">
			<div class="mt-4 flex">
				<div class="summoner-icon">
					<img src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer.get(0)}/img/profileicon/${summoner.profileIconId}.png" width="180" alt="profile icon"/>
					<div class="summoner-level text-sm text-black">${summoner.summonerLevel}</div>
				</div>
				<div class="mx-4 text-xl font-bold">${summoner.name}</div>
				<c:if test="${leagueEntries != null}">
					<c:forEach var="leagueEntry" items="${leagueEntries}">
						<c:if test="${leagueEntry.queueType == 'RANKED_SOLO_5x5'}">
							<div class="mx-4 flex items-center" >
								<div class="text-center">
									<div>
										<span>솔로랭크</span>
									</div>
									<div>
										<span>
											<img src="/resource/images/emblem-${leagueEntry.tier}.png" alt="tier emblem" width="150"/>
										</span>
									</div>
								</div>
								<div class="mx-5 text-center">
									<div>${leagueEntry.tier} ${leagueEntry.rank}</div>
									<div class="text-sm">${leagueEntry.leaguePoints} LP</div>
								</div>
								<div class="text-sm text-right">
									<span>${leagueEntry.wins} 승</span>
									<span>${leagueEntry.losses} 패</span>
									<div class="text-xs">
										승률 ${Math.round(leagueEntry.wins / (leagueEntry.wins + leagueEntry.losses) * 100)} %
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</c:if>
			</div>
		</c:if>
	</section>
	<section class="mt-6 mx-20 min-w-1000">
		<c:if test="${summoner != null && matches != null}">
			<div class="show-match h-80 overflow-auto">
				<c:forEach var="match" items="${matches}">
					<c:forEach var="participant" items="${match.info.participants}">
			 			<c:if test="${participant.puuid == summoner.puuid}">
							<div class="text-gray-600 rounded-lg mt-2 px-4 py-2 flex ${participant.win == true ? 'bg-blue-200' : 'bg-red-200'}">
				 				<div class="text-sm">
									<c:forEach var="queue" items="${summoner.dataQueues}">
										<c:if test="${queue.queueId == match.info.queueId}">
											<div class="w-32 text-base ${participant.win == true ? 'text-blue-600' : 'text-red-600'}">
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
									<div>${match.info.getMatchStartDateTime()}</div>
									<div class="w-16 ${participant.win == true ? 'border-b border-blue-500' : 'border-b border-red-500'}"></div>
									<div>
										<c:choose>
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
								<div class="ml-4">
									<div class="flex">
										<div>
											<img class="rounded-full" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer.get(0)}/img/champion/${participant.championName}.png" width="50" alt="champion icon image"/>
										</div>
										<div class="ml-1">
											<c:set var="spells" value="${participant.getSpellList()}"></c:set>
											<c:forEach var="spell" items="${spells}">
												<c:forEach var="spellData" items="${summoner.spellData.data}">
													<c:if test="${spellData.value.key == spell}">
														<img class="rounded" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer.get(0)}/img/spell/${spellData.key}.png" width="25" alt="spell image"/>
													</c:if>
												</c:forEach>
											</c:forEach>
										</div>
										<div>
											<div>룬1</div>
											<div>룬2</div>
										</div>
									</div>
									<div class="mt-2 flex">
										<c:set var="items" value="${participant.getItemList()}"></c:set>
										<c:forEach var="item" items="${items}">
											<div class="ml-1px">
												<c:choose>
													<c:when test="${item != 0}">
														<img class="rounded" src="http://ddragon.leagueoflegends.com/cdn/${summoner.dataDragonVer.get(0)}/img/item/${item}.png" width="25" alt="item image"/>
													</c:when>
													<c:otherwise>
														<div class="rounded w-25px h-25px ${participant.win == true ? 'bg-blue-400' : 'bg-red-400'}"></div>
													</c:otherwise>
												</c:choose>
											</div>
										</c:forEach>
									</div>
								</div>
							</div>
			 			</c:if>
					</c:forEach>
				</c:forEach>
			</div>
			<div class="rounded-lg mt-2">
				<a class="flex justify-center items-center btn-text-color btn btn-info" href="javascript:addMatches(`${summoner.name}`)">
					더보기
				</a>
			</div>
		</c:if>
	</section>
	<section class="mt-6 mx-20 text-lg min-w-1000">
		<div class="mt-4 flex">
			<div class="w-1/2 h-80 border border-indigo-400">공지사항</div>
			<div class="ml-4 w-1/2 h-80 border border-indigo-400">인기글</div>
		</div>
	</section>
	<section class="mt-6 mb-20 mx-20 text-lg min-w-1000">
		<div class="mt-6 flex">
			<a href="/" class="w-1/2"><img class="main-image w-full" src="/resource/images/리그오브레전드.jpg" alt="리그오브레전드 이미지"></a>
			<a href="/" class="ml-4 w-1/2"><img class="main-image w-full" src="/resource/images/배틀그라운드.jpg" alt="배틀그라운드 이미지"></a>
		</div>
		<div class="mt-6 flex">
			<a href="/" class="w-1/2"><img class="main-image w-full" src="/resource/images/리그오브레전드.jpg" alt="리그오브레전드 이미지"></a>
			<a href="/" class="ml-4 w-1/2"><img class="main-image w-full" src="/resource/images/배틀그라운드.jpg" alt="배틀그라운드 이미지"></a>
		</div>
		<div class="mt-6 flex">
			<a href="/" class="w-1/2"><img class="main-image w-full" src="/resource/images/리그오브레전드.jpg" alt="리그오브레전드 이미지"></a>
			<a href="/" class="ml-4 w-1/2"><img class="main-image w-full" src="/resource/images/배틀그라운드.jpg" alt="배틀그라운드 이미지"></a>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>