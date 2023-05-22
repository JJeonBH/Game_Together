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

	public ResultData<Integer> doJoin(String loginId, String loginPw, String name, String nickname, String birthday, String gender, String email, String cellphoneNum) {

		Member member = getMemberByLoginId(loginId);

		if (member != null) {
			return ResultData.resultFrom("F-1", String.format("이미 사용중인 아이디(%s)입니다", loginId));
		}
		
		member = getMemberByNickname(nickname);
		
		if (member != null) {
			return ResultData.resultFrom("F-2", String.format("이미 사용중인 닉네임(%s)입니다", nickname));
		}
		
		member = getMemberByEmail(email);
		
		if (member != null) {
			return ResultData.resultFrom("F-3", String.format("이미 사용중인 이메일(%s)입니다", email));
		}
		
		member = getMemberByCellphoneNum(cellphoneNum);
		
		if (member != null) {
			return ResultData.resultFrom("F-4", String.format("이미 사용중인 휴대전화 번호(%s)입니다", cellphoneNum));
		}
		
		memberRepository.doJoin(loginId, loginPw, name, nickname, birthday, gender, email, cellphoneNum);

		return ResultData.resultFrom("S-1", String.format("%s님 가입을 환영합니다", nickname), "id", memberRepository.getLastInsertId());

	}

	public Member getMemberByLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);
	}

	private Member getMemberByNickname(String nickname) {
		return memberRepository.getMemberByNickname(nickname);
	}
	
	private Member getMemberByEmail(String email) {
		return memberRepository.getMemberByEmail(email);
	}
	
	private Member getMemberByCellphoneNum(String cellphoneNum) {
		return memberRepository.getMemberByCellphoneNum(cellphoneNum);
	}
	
}