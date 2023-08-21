package com.koreaIT.Game_Together.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.koreaIT.Game_Together.repository.MemberRepository;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.Member;
import com.koreaIT.Game_Together.vo.ResultData;

@Service
public class MemberService {
	
	@Value("${custom.siteName}")
	private String siteName;
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	
	private MemberRepository memberRepository;
	private MailService mailService;

	@Autowired
	public MemberService(MemberRepository memberRepository, MailService mailService) {
		this.memberRepository = memberRepository;
		this.mailService = mailService;
	}

	@SuppressWarnings("rawtypes")
	public ResultData doJoin(String loginId, String loginPw, String name, String nickname, String birthday, String gender, String email, String cellphoneNum) {
		
		memberRepository.doJoin(loginId, loginPw, name, nickname, birthday, gender, email, cellphoneNum);

		return ResultData.resultFrom("S-1", String.format("%s님 가입을 환영합니다.", nickname));

	}
	
	public int getLastInsertId() {
		return memberRepository.getLastInsertId();
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

	public void doModify(int loginedMemberId, String nickname, String email, String cellphoneNum) {
		memberRepository.doModify(loginedMemberId, nickname, email, cellphoneNum);
	}

	public void doPasswordModify(int loginedMemberId, String newLoginPw) {
		memberRepository.doPasswordModify(loginedMemberId, newLoginPw);
	}

	public Member getMemberByNameAndEmail(String name, String email) {
		return memberRepository.getMemberByNameAndEmail(name, email);
	}
	
	@SuppressWarnings("rawtypes")
	public ResultData notifyTempLoginPwByEmail(Member member) {

		String title = "[" + siteName + "] 임시 비밀번호 발송";
		String tempPassword = Util.getTempPassword(8);
		String body = "<h1>임시 비밀번호 : " + tempPassword + "</h1>";
		body += "<a style='font-size:2rem;' href=\"" + siteMainUri + "/usr/member/login\" target=\"_blank\">로그인 하러가기</a>";

		ResultData sendRd = mailService.send(member.getEmail(), title, body);

		if (sendRd.isFail()) {
			return sendRd;
		}

		setTempPassword(member, tempPassword);

		return ResultData.resultFrom("S-1", "계정의 이메일주소로 임시 비밀번호가 발송되었습니다.");
		
	}

	private void setTempPassword(Member member, String tempPassword) {
		memberRepository.doPasswordModify(member.getId(), Util.sha256(tempPassword));
	}

	public void doWithdraw(int loginedMemberId) {
		memberRepository.doWithdraw(loginedMemberId);
	}

	public void restore(String loginId, String loginPw) {
		memberRepository.restore(loginId, loginPw);
	}
	
}