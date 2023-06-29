package com.koreaIT.Game_Together.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreaIT.Game_Together.vo.Reply;

@Mapper
public interface ReplyRepository {

	public void writeReply(int loginedMemberId, String relTypeCode, int relId, String body);

	public int getLastInsertId();

	public Reply getReplyById(int replyId);

	public Reply getReplyForMD(int replyId);
	
	public List<Reply> getReplies(String relTypeCode, int relId);

	public int getRepliesCnt(String relTypeCode, int relId);

	public void deleteReply(int replyId);

}