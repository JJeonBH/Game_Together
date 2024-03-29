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
	private FileService fileService;
	
	@Autowired
	public ReplyService(ReplyRepository replyRepository, FileService fileService) {
		this.replyRepository = replyRepository;
		this.fileService = fileService;
	}

	public Reply writeReply(int loginedMemberId, String relTypeCode, int relId, String body) {
		
		replyRepository.writeReply(loginedMemberId, relTypeCode, relId, body);
		
		int replyId = replyRepository.getLastInsertId();
		
		Reply reply = replyRepository.getReplyById(replyId);
		
		actorCanChangeData(loginedMemberId, reply);
		
		reply.setFormatRegDate(Util.formatRegDateVer1(reply.getRegDate()));
		reply.setProfileImg(fileService.getFileByRelId("profile", reply.getMemberId()));
		
		return reply;
		
	}
	
	public Reply getReplyById(int replyId) {
		
		Reply reply = replyRepository.getReplyById(replyId);
		
		reply.setFormatRegDate(Util.formatRegDateVer1(reply.getRegDate()));
		
		return reply;
		
	}
	
	public Reply getReplyForMD(int replyId) {
		return replyRepository.getReplyForMD(replyId);
	}
	
	public void modifyReply(int replyId, String body) {
		replyRepository.modifyReply(replyId, body);
	}
	
	public void deleteReply(int replyId) {
		replyRepository.deleteReply(replyId);
	}
	
	
	public int getRepliesCnt(String relTypeCode, int relId) {
		return replyRepository.getRepliesCnt(relTypeCode, relId);
	}
	
	public List<Reply> getReplies(int loginedMemberId, String relTypeCode, int relId) {
		
		List<Reply> replies = replyRepository.getReplies(relTypeCode, relId);
		
		for (Reply reply : replies) {
			actorCanChangeData(loginedMemberId, reply);
			reply.setFormatRegDate(Util.formatRegDateVer1(reply.getRegDate()));
			reply.setProfileImg(fileService.getFileByRelId("profile", reply.getMemberId()));
		}
		
		return replies;
		
	}
	
	public void deleteReplies(String relTypeCode, int relId) {
		replyRepository.deleteReplies(relTypeCode, relId);
	}
	
	public void actorCanChangeData(int loginedMemberId, Reply reply) {
		
		@SuppressWarnings("rawtypes")
		ResultData actorCanChangeDataRd = actorCanMD(loginedMemberId, reply);
		
		reply.setActorCanChangeData(actorCanChangeDataRd.isSuccess());
		
	}
	
	@SuppressWarnings("rawtypes")
	public ResultData actorCanMD(int loginedMemberId, Reply reply) {

		if (reply == null) {
			return ResultData.resultFrom("F-1", "해당 댓글은 존재하지 않습니다.");
		}

		if (loginedMemberId != reply.getMemberId()){
			return ResultData.resultFrom("F-2", "해당 댓글에 대한 권한이 없습니다.");
		}

		return ResultData.resultFrom("S-1", "가능");
		
	}

}