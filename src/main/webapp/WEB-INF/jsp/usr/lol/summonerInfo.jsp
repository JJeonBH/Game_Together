<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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