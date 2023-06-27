package com.koreaIT.Game_Together.repository;

import org.apache.ibatis.annotations.Mapper;

import com.koreaIT.Game_Together.vo.ReactionPoint;

@Mapper
public interface ReactionPointRepository {
	
	public ReactionPoint getReactionPoint(int loginedMemberId, String relTypeCode, int relId);
	
	public void doInsertReactionPoint(int loginedMemberId, String relTypeCode, int relId);
	
	public void doDeleteReactionPoint(int loginedMemberId, String relTypeCode, int relId);

	public int getChangedReactionPoint(String relTypeCode, int relId);

}