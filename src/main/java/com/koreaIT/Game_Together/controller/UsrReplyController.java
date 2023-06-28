package com.koreaIT.Game_Together.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.Game_Together.service.ReplyService;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.Reply;
import com.koreaIT.Game_Together.vo.Request;
import com.koreaIT.Game_Together.vo.ResultData;

@Controller
public class UsrReplyController {
	
	private ReplyService replyService;
	private Request rq;
	
	@Autowired
	public UsrReplyController(ReplyService replyService, Request rq) {
		this.replyService = replyService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/reply/doWrite")
	@ResponseBody
	public ResultData<Reply> doWrite(String relTypeCode, int relId, String body) {

		Reply reply = replyService.writeReply(rq.getLoginedMemberId(), relTypeCode, relId, body);
		
		int changedRepliesCnt = replyService.getRepliesCnt(relTypeCode, relId);
		
		ResultData<Reply> replyRD = ResultData.resultFrom("S-1", "댓글 등록", "reply", reply);
		
		replyRD.setData2("changedRepliesCnt", changedRepliesCnt);
		
		return replyRD;
		
	}

}