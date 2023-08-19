package com.koreaIT.Game_Together.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.Game_Together.service.FileService;
import com.koreaIT.Game_Together.service.ReplyService;
import com.koreaIT.Game_Together.vo.Reply;
import com.koreaIT.Game_Together.vo.Request;
import com.koreaIT.Game_Together.vo.ResultData;

@Controller
public class UsrReplyController {
	
	private ReplyService replyService;
	private FileService fileService;
	private Request rq;
	
	@Autowired
	public UsrReplyController(ReplyService replyService, FileService fileService, Request rq) {
		this.replyService = replyService;
		this.fileService = fileService;
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
	
	@RequestMapping("/usr/reply/getReplyContent")
	@ResponseBody
	public ResultData<Reply> getReplyContent(int replyId) {
		
		Reply reply = replyService.getReplyById(replyId);
		reply.setProfileImg(fileService.getFileByRelId("profile", reply.getMemberId()));
		
		@SuppressWarnings("rawtypes")
		ResultData actorCanMDRd = replyService.actorCanMD(rq.getLoginedMemberId(), reply);
		
		if (actorCanMDRd.isFail()) {
			return ResultData.resultFrom(actorCanMDRd.getResultCode(), actorCanMDRd.getMsg());
		} else {
			return ResultData.resultFrom(actorCanMDRd.getResultCode(), actorCanMDRd.getMsg(), "reply", reply);
		}
		
	}
	
	@RequestMapping("/usr/reply/doModify")
	@ResponseBody
	public ResultData<Reply> doModify(int replyId, String body) {
		
		Reply reply = replyService.getReplyForMD(replyId);
		
		@SuppressWarnings("rawtypes")
		ResultData actorCanMDRd = replyService.actorCanMD(rq.getLoginedMemberId(), reply);
		
		if (actorCanMDRd.isFail()) {
			return ResultData.resultFrom(actorCanMDRd.getResultCode(), actorCanMDRd.getMsg());
		} else {
			
			replyService.modifyReply(replyId, body);
			
			reply = replyService.getReplyById(replyId);
			reply.setProfileImg(fileService.getFileByRelId("profile", reply.getMemberId()));
			
			return ResultData.resultFrom(actorCanMDRd.getResultCode(), actorCanMDRd.getMsg(), "reply", reply);
			
		}
		
	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping("/usr/reply/doDelete")
	@ResponseBody
	public ResultData doDelete(int replyId, String relTypeCode, int relId) {
		
		Reply reply = replyService.getReplyForMD(replyId);
		
		ResultData actorCanMDRd = replyService.actorCanMD(rq.getLoginedMemberId(), reply);

		if (actorCanMDRd.isFail()) {
			return actorCanMDRd;
		} else {
			
			replyService.deleteReply(replyId);
			
			int changedRepliesCnt = replyService.getRepliesCnt(relTypeCode, relId);
			
			actorCanMDRd.setData2("changedRepliesCnt", changedRepliesCnt);
			
			return actorCanMDRd;
			
		}
		
	}
	
}