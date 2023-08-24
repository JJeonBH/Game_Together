package com.koreaIT.Game_Together.service;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.koreaIT.Game_Together.repository.MemberRepository;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.Member;
import com.koreaIT.Game_Together.vo.ResultData;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class MemberService {
	
	@Value("${custom.siteName}")
	private String siteName;
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${coolsms.api.key}")
	private String api_key;
	@Value("${coolsms.api.secret}")
	private String api_secret;
	
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
	
	public int getMembersCnt(String authLevel, String searchKeywordType, String searchKeyword, int banStatus) {
		return memberRepository.getMembersCnt(authLevel, searchKeywordType, searchKeyword, banStatus);
	}
	
	public List<Member> getMembers(String authLevel, String searchKeywordType, String searchKeyword, int banStatus, int itemsInAPage, int page) {

		int limitStart = (page - 1) * itemsInAPage;

		return memberRepository.getMembers(authLevel, searchKeywordType, searchKeyword, banStatus, itemsInAPage, limitStart);
		
	}
	
	public void deleteMembers(List<Integer> memberIds) {
		
		for (int memberId : memberIds) {
			
			Member member = getMemberById(memberId);

			if (member != null) {
				deleteMember(member);
			}
			
		}
		
	}
	
	private void deleteMember(Member member) {
		memberRepository.deleteMember(member.getId());
	}

	public void releaseMembers(List<Integer> memberIds) {
		
		for (int memberId : memberIds) {
			
			Member member = getMemberById(memberId);

			if (member != null) {
				releaseMember(member);
			}
			
		}
		
	}
	
	private void releaseMember(Member member) {
		memberRepository.releaseMember(member.getId());
	}

	public String sendCertificationNumber(String cellphoneNum) throws CoolsmsException {
		
	    Message coolsms = new Message(api_key, api_secret);
	    
	    Random rand  = new Random();
	    
	    String numStr = "";
	    
	    for (int i = 0; i < 4; i++) {
	    	numStr += Integer.toString(rand.nextInt(10));
	    }    
	    
	    HashMap<String, String> params = new HashMap<String, String>();
	    //	받는 사람 번호
	    params.put("to", cellphoneNum);
	    //	보내는 사람 번호
	    params.put("from", "자신의 번호 (-없이 숫자만)");
	    params.put("type", "SMS");
	    params.put("text", "[Game_Together] 인증번호는" + "[" + numStr + "]" + "입니다.");
	    
	    coolsms.send(params);
		
		return numStr;
		
	}
	
}