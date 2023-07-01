package com.koreaIT.Game_Together.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreaIT.Game_Together.repository.ReactionPointRepository;
import com.koreaIT.Game_Together.vo.ReactionPoint;

@Service
public class ReactionPointService {

	private ReactionPointRepository reactionPointRepository;
	
	@Autowired
	public ReactionPointService(ReactionPointRepository reactionPointRepository) {
		this.reactionPointRepository = reactionPointRepository;
	}
	
	public ReactionPoint getReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
		return reactionPointRepository.getReactionPoint(loginedMemberId, relTypeCode, relId);
	}
	
	public void doInsertReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
		reactionPointRepository.doInsertReactionPoint(loginedMemberId, relTypeCode, relId);
	}
	
	public void doDeleteReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
		reactionPointRepository.doDeleteReactionPoint(loginedMemberId, relTypeCode, relId);
	}

	public int getChangedReactionPoint(String relTypeCode, int relId) {
		return reactionPointRepository.getChangedReactionPoint(relTypeCode, relId);
	}

	public void deleteReactionPoints(String relTypeCode, int relId) {
		reactionPointRepository.deleteReactionPoints(relTypeCode, relId);
	}
	
}