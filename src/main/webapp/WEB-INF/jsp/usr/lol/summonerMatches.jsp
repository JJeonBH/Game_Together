<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<section class="mt-6 mx-20 min-w-1000">
	<c:if test="${summoner != null && matches != null}">
		<div class="show-match h-80 overflow-auto">
			<c:forEach var="match" items="${matches}">
				<c:forEach var="participant" items="${match.info.participants}">
		 			<c:if test="${participant.puuid == summoner.puuid}">
						<div class="text-gray-600 rounded-lg mt-2 px-4 py-2 flex ${participant.win == true ? 'bg-blue-200' : 'bg-red-200'}">
			 				<div class="text-sm">
								<c:forEach var="queue" items="${summoner.queues}">
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
										<c:set var="spellIds" value="${participant.getSpellIds()}"></c:set>
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
								</div>
								<div class="mt-2 flex">
									<c:set var="items" value="${participant.getItems()}"></c:set>
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
			<a class="add-matches flex justify-center items-center btn-text-color btn btn-info" href="javascript:addMatches(`${summoner.name}`)">
				더보기
			</a>
		</div>
	</c:if>
</section>