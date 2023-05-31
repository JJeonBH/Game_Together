package com.koreaIT.Game_Together.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.Game_Together.service.MemberService;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.Member;
import com.koreaIT.Game_Together.vo.Request;
import com.koreaIT.Game_Together.vo.ResultData;

@Controller
public class MemberController {

	private MemberService memberService;
	private Request rq;
	
	@Autowired
	public MemberController(MemberService memberService, Request rq) {
		this.memberService = memberService;
		this.rq = rq;
	}

	@RequestMapping("/usr/member/join")
	public String join() {
		return "usr/member/join";
	}

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name, String nickname, String birthday, String gender, String email, String cellphoneNum) {

		ResultData doJoinRd = memberService.doJoin(loginId, Util.sha256(loginPw), name, nickname, birthday, gender, email, cellphoneNum);
		
		return Util.jsAlertReplace(doJoinRd.getMsg(), "/");
		
	}
	
	@RequestMapping("/usr/member/login")
	public String login() {
		return "usr/member/login";
	}
	
	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		rq.login(member);
		
		return Util.jsAlertReplace("", "/");
		
	}
	
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout() {
		
		rq.logout();
		
		return Util.jsAlertReplace("로그아웃 되었습니다.", "/");
		
	}
	
	@RequestMapping("/usr/member/profile")
	public String showProfile(Model model) {
		
		if (rq.getLoginedMember() == null) {
			return rq.returnMain("세션이 만료되었습니다. 다시 로그인 해주세요.");
		}
		
		String regDate = Util.formatDate(rq.getLoginedMember().getRegDate());
		
		model.addAttribute("regDate", regDate);
		
		return "usr/member/profile";
		
	}

	@RequestMapping("/usr/member/checkLogin")
	@ResponseBody
	public ResultData checkLogin(String loginId, String loginPw) {
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null) {
			return ResultData.resultFrom("F-1", "아이디 또는 비밀번호를 잘못 입력했습니다.<br>입력하신 내용을 다시 확인해 주세요.");
		}
		
		if (!member.getLoginPw().equals(Util.sha256(loginPw))) {
			return ResultData.resultFrom("F-2", "아이디 또는 비밀번호를 잘못 입력했습니다.<br>입력하신 내용을 다시 확인해 주세요.");
		}
		
		return ResultData.resultFrom("S-1", "로그인 성공");
		
	}
	
	@RequestMapping("/usr/member/loginIdDupCheck")
	@ResponseBody
	public ResultData<String> loginIdDupCheck(String loginId) {
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member != null) {
			return ResultData.resultFrom("F-1", "이미 사용중이거나 탈퇴한 아이디입니다.", "loginId", loginId);
		}
		
		return ResultData.resultFrom("S-1", "사용 가능한 아이디입니다.", "loginId", loginId);
		
	}
	
	@RequestMapping("/usr/member/nicknameDupCheck")
	@ResponseBody
	public ResultData<String> nicknameDupCheck(String nickname) {
		
		Member member = memberService.getMemberByNickname(nickname);
		
		if (member != null) {
			return ResultData.resultFrom("F-1", "이미 사용중인 닉네임입니다.", "nickname", nickname);
		}
		
		return ResultData.resultFrom("S-1", "사용 가능한 닉네임입니다.", "nickname", nickname);
		
	}
	
	@RequestMapping("/usr/member/emailDupCheck")
	@ResponseBody
	public ResultData<String> emailDupCheck(String email) {
		
		Member member = memberService.getMemberByEmail(email);
		
		if (member != null) {
			return ResultData.resultFrom("F-1", "이미 사용중인 이메일입니다.", "email", email);
		}
		
		return ResultData.resultFrom("S-1", "사용 가능한 이메일입니다.", "email", email);
		
	}
	
	@RequestMapping("/usr/member/cellphoneNumDupCheck")
	@ResponseBody
	public ResultData<String> cellphoneNumDupCheck(String cellphoneNum) {
		
		Member member = memberService.getMemberByCellphoneNum(cellphoneNum);
		
		if (member != null) {
			return ResultData.resultFrom("F-1", "이미 사용중인 휴대전화 번호입니다.", "cellphoneNum", cellphoneNum);
		}
		
		return ResultData.resultFrom("S-1", "사용 가능한 휴대전화 번호입니다.", "cellphoneNum", cellphoneNum);
		
	}
	
}