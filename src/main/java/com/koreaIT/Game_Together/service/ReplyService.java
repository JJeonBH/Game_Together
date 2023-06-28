package com.koreaIT.Game_Together.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreaIT.Game_Together.repository.ReplyRepository;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.Reply;
import com.koreaIT.Game_Together.vo.ResultData;

@Service
public class ReplyService {

	private ReplyRepository replyRepository;
	
	@Autowired
	public ReplyService(ReplyRepository replyRepository) {
		this.replyRepository = replyRepository;
	}

	public Reply writeReply(int loginedMemberId, String relTypeCode, int relId, String body) {
		
		replyRepository.writeReply(loginedMemberId, relTypeCode, relId, body);
		
		int replyId = replyRepository.getLastInsertId();
		
		Reply reply = replyRepository.getReplyById(replyId);
		
		actorCanChangeData(loginedMemberId, reply);
		
		reply.setFormatRegDate(Util.formatRegDateVer1(reply.getRegDate()));
		
		return reply;
		
	}

	public List<Reply> getReplies(int loginedMemberId, String relTypeCode, int relId) {
		
		List<Reply> replies = replyRepository.getReplies(relTypeCode, relId);
		
		for (Reply reply : replies) {
			actorCanChangeData(loginedMemberId, reply);
			reply.setFormatRegDate(Util.formatRegDateVer1(reply.getRegDate()));
		}
		
		return replies;
		
	}

	public int getRepliesCnt(String relTypeCode, int relId) {
		return replyRepository.getRepliesCnt(relTypeCode, relId);
	}
	
	public void actorCanChangeData(int loginedMemberId, Reply reply) {
		
		ResultData actorCanChangeDataRd = actorCanMD(loginedMemberId, reply);
		
		reply.setActorCanChangeData(actorCanChangeDataRd.isSuccess());
		
	}
	
	private ResultData actorCanMD(int loginedMemberId, Reply reply) {

		if (reply == null) {
			return ResultData.resultFrom("F-1", "해당 댓글은 존재하지 않습니다.");
		}

		if (loginedMemberId != reply.getMemberId()){
			return ResultData.resultFrom("F-2", "해당 댓글에 대한 권한이 없습니다.");
		}

		return ResultData.resultFrom("S-1", "가능");
		
	}
	
}