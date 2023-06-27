package com.koreaIT.Game_Together.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreaIT.Game_Together.repository.ReplyRepository;
import com.koreaIT.Game_Together.vo.Reply;

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
		
		return reply;
		
	}

	public List<Reply> getReplies(String relTypeCode, int relId) {
		return replyRepository.getReplies(relTypeCode, relId);
	}

	public int getRepliesCnt(String relTypeCode, int relId) {
		return replyRepository.getRepliesCnt(relTypeCode, relId);
	}
	
}