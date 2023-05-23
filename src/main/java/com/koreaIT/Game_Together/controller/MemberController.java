package com.koreaIT.Game_Together.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.Game_Together.service.MemberService;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.Member;
import com.koreaIT.Game_Together.vo.ResultData;

@Controller
public class MemberController {

	private MemberService memberService;
	
	@Autowired
	public MemberController(MemberService memberService) {
		this.memberService = memberService;
	}

	@RequestMapping("/usr/member/join")
	public String join() {
		return "usr/member/join";
	}

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name, String nickname, String birthday, String gender, String email, String cellphoneNum) {

		if (Util.empty(loginId)) {
			return Util.jsHistoryBack("아이디를 입력해주세요");
		}

		if (Util.empty(loginPw)) {
			return Util.jsHistoryBack("비밀번호를 입력해주세요");
		}

		if (Util.empty(name)) {
			return Util.jsHistoryBack("이름을 입력해주세요");
		}

		if (Util.empty(nickname)) {
			return Util.jsHistoryBack("닉네임을 입력해주세요");
		}

		if (Util.empty(birthday)) {
			return Util.jsHistoryBack("생년월일을 입력해주세요");
		}

		if (Util.empty(gender)) {
			return Util.jsHistoryBack("성별을 입력해주세요");
		}

		if (Util.empty(email)) {
			return Util.jsHistoryBack("이메일을 입력해주세요");
		}

		if (Util.empty(cellphoneNum)) {
			return Util.jsHistoryBack("휴대전화 번호를 입력해주세요");
		}

		ResultData<Integer> doJoinRd = memberService.doJoin(loginId, Util.sha256(loginPw), name, nickname, birthday, gender, email, cellphoneNum);
		
		if (doJoinRd.isFail()) {
			return Util.jsHistoryBack(doJoinRd.getMsg());
		}
		
		return Util.jsReplace(doJoinRd.getMsg(), "/");
		
	}

	@RequestMapping("/usr/member/loginIdDupCheck")
	@ResponseBody
	public ResultData<String> loginIdDupCheck(String loginId) {
		
//		if (Util.empty(loginId)) {
//			return ResultData.resultFrom("F-1", "필수 정보입니다");
//		}
		
//		if (!loginId.matches("^[a-z]{1}[a-z0-9_-]{4,19}$")) {
//			return ResultData.resultFrom("F-2", "5~20자의 영문 소문자(로 시작), 숫자와 특수기호(_),(-)만 사용 가능합니다");
//		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member != null) {
			return ResultData.resultFrom("F-3", "이미 사용중이거나 탈퇴한 아이디입니다", "loginId", loginId);
		}
		
		return ResultData.resultFrom("S-1", "사용 가능한 아이디입니다", "loginId", loginId);
		
	}
	
}