package com.koreaIT.Game_Together.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreaIT.Game_Together.repository.MemberRepository;
import com.koreaIT.Game_Together.vo.Member;
import com.koreaIT.Game_Together.vo.ResultData;

@Service
public class MemberService {

	private MemberRepository memberRepository;

	@Autowired
	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	@SuppressWarnings("rawtypes")
	public ResultData doJoin(String loginId, String loginPw, String name, String nickname, String birthday, String gender, String email, String cellphoneNum) {
		
		memberRepository.doJoin(loginId, loginPw, name, nickname, birthday, gender, email, cellphoneNum);

		return ResultData.resultFrom("S-1", String.format("%s님 가입을 환영합니다.", nickname));

	}
	
	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);
	}

	public Member getMemberByNickname(String nickname) {
		return memberRepository.getMemberByNickname(nickname);
	}
	
	public Member getMemberByEmail(String email) {
		return memberRepository.getMemberByEmail(email);
	}
	
	public Member getMemberByCellphoneNum(String cellphoneNum) {
		return memberRepository.getMemberByCellphoneNum(cellphoneNum);
	}
	
}