package com.koreaIT.Game_Together.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.Game_Together.service.ReactionPointService;
import com.koreaIT.Game_Together.vo.ReactionPoint;
import com.koreaIT.Game_Together.vo.Request;
import com.koreaIT.Game_Together.vo.ResultData;

@Controller
public class UsrReactionPointController {
	
	private ReactionPointService reactionPointService;
	private Request rq;
	
	@Autowired
	public UsrReactionPointController(ReactionPointService reactionPointService, Request rq) {
		this.reactionPointService = reactionPointService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/reactionPoint/getReactionPoint")
	@ResponseBody
	public ResultData<ReactionPoint> getReactionPoint(String relTypeCode, int relId) {

		ReactionPoint reactionPoint = reactionPointService.getReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);

		return ResultData.resultFrom("S-1", "리액션 정보 조회 성공", "reactionPoint", reactionPoint);
		
	}
	
	@RequestMapping("/usr/reactionPoint/doInsertReactionPoint")
	@ResponseBody
	public int doInsertReactionPoint(String relTypeCode, int relId) {
		
		reactionPointService.doInsertReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
		
		int changedReactionPoint = reactionPointService.getChangedReactionPoint(relTypeCode, relId);
		
		return changedReactionPoint;
	
	}
	
	@RequestMapping("/usr/reactionPoint/doDeleteReactionPoint")
	@ResponseBody
	public int doDeleteReactionPoint(String relTypeCode, int relId) {
		
		reactionPointService.doDeleteReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
		
		int changedReactionPoint = reactionPointService.getChangedReactionPoint(relTypeCode, relId);
		
		return changedReactionPoint;
		
	}

}