package com.koreaIT.Game_Together.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreaIT.Game_Together.vo.Member;

@Mapper
public interface MemberRepository {
	
	public void doJoin(String loginId, String loginPw, String name, String nickname, String birthday, String gender, String email, String cellphoneNum);

	public int getLastInsertId();
	
	public Member getMemberById(int id);
	
	public Member getMemberByLoginId(String loginId);

	public Member getMemberByNickname(String nickname);

	public Member getMemberByEmail(String email);

	public Member getMemberByCellphoneNum(String cellphoneNum);

	public void doModify(int loginedMemberId, String nickname, String email, String cellphoneNum);

	public void doPasswordModify(int loginedMemberId, String newLoginPw);

	public Member getMemberByNameAndEmail(String name, String email);

	public void doWithdraw(int loginedMemberId);

	public void restore(String loginId, String loginPw);

	public int getMembersCnt(String authLevel, String searchKeywordType, String searchKeyword);

	public List<Member> getMembers(String authLevel, String searchKeywordType, String searchKeyword, int itemsInAPage, int limitStart);

	public void deleteMember(int id);

}