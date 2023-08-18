package com.koreaIT.Game_Together.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.koreaIT.Game_Together.service.FileService;
import com.koreaIT.Game_Together.service.MemberService;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.FileVO;
import com.koreaIT.Game_Together.vo.Member;
import com.koreaIT.Game_Together.vo.Request;
import com.koreaIT.Game_Together.vo.ResultData;

@Controller
public class UsrMemberController {

	private MemberService memberService;
	private FileService fileService;
	private Request rq;
	
	@Autowired
	public UsrMemberController(MemberService memberService, FileService fileService, Request rq) {
		this.memberService = memberService;
		this.fileService = fileService;
		this.rq = rq;
	}

	@RequestMapping("/usr/member/join")
	public String join() {
		return "usr/member/join";
	}

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name, String nickname, String birthday, String gender, String email, String cellphoneNum, MultipartFile file) {

		@SuppressWarnings("rawtypes")
		ResultData doJoinRd = memberService.doJoin(loginId, Util.sha256(loginPw), name, nickname, birthday, gender, email, cellphoneNum);
		
		int relId = memberService.getLastInsertId();
		
		if (!file.isEmpty()) {
			try {
				fileService.saveFile(file, "profile", relId);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
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
			return rq.jsReplace("세션이 만료되었습니다. 다시 로그인 해주세요.", "/");
		}
		
		String regDate = Util.formatDate(rq.getLoginedMember().getRegDate());
		
		FileVO profileImg = fileService.getFileByRelId("profile", rq.getLoginedMemberId());
		
		model.addAttribute("regDate", regDate);
		model.addAttribute("profileImg", profileImg);
		
		return "usr/member/profile";
		
	}
	
	@RequestMapping("/usr/member/passwordCheck")
	public String passwordCheck() {
		
		if (rq.getLoginedMember() == null) {
			return rq.jsReplace("세션이 만료되었습니다. 다시 로그인 해주세요.", "/");
		}
		
		return "usr/member/passwordCheck";
		
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping("/usr/member/doPasswordCheck")
	@ResponseBody
	public ResultData doPasswordCheck(String loginPw) {
		
		if (!rq.getLoginedMember().getLoginPw().equals(Util.sha256(loginPw))) {
			return ResultData.resultFrom("F-1", "비밀번호가 틀렸습니다.");
		}
		
		return ResultData.resultFrom("S-1", "비밀번호 일치");
		
	}
	
	@RequestMapping("/usr/member/modify")
	public String modify(Model model) {
		
		if (rq.getLoginedMember() == null) {
			return rq.jsReplace("세션이 만료되었습니다. 다시 로그인 해주세요.", "/");
		}
		
		String regDate = Util.formatDate(rq.getLoginedMember().getRegDate());
		
		model.addAttribute("regDate", regDate);
		
		return "usr/member/modify";
		
	}
	
	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(String nickname, String email, String cellphoneNum) {

		memberService.doModify(rq.getLoginedMemberId(), nickname, email, cellphoneNum);

		return Util.jsAlertReplace("회원정보가 수정되었습니다", "profile");
		
	}
	
	@RequestMapping("/usr/member/passwordModify")
	public String passwordModify() {
		
		if (rq.getLoginedMember() == null) {
			return rq.jsReplace("세션이 만료되었습니다. 다시 로그인 해주세요.", "/");
		}
		
		return "usr/member/passwordModify";
		
	}
	
	@RequestMapping("/usr/member/doPasswordModify")
	@ResponseBody
	public String doPasswordModify(String newLoginPw) {
		
		memberService.doPasswordModify(rq.getLoginedMemberId(), Util.sha256(newLoginPw));

		return Util.jsAlertReplace("비밀번호가 변경되었습니다", "profile");
		
	}
	
	@RequestMapping("/usr/member/nicknameDupCheckForChange")
	@ResponseBody
	public ResultData<String> nicknameDupCheckForChange(String nickname) {
		
		Member member = memberService.getMemberByNickname(nickname);
		
		if (member != null) {
			return ResultData.resultFrom("F-1", "이미 사용중인 닉네임입니다.", "nickname", nickname);
		}
		
		return ResultData.resultFrom("S-1", "사용 가능한 닉네임입니다.", "nickname", nickname);
		
	}
	
	@RequestMapping("/usr/member/emailDupCheckForChange")
	@ResponseBody
	public ResultData<String> emailDupCheckForChange(String email) {
		
		Member member = memberService.getMemberByEmail(email);
		
		if (member != null) {
			return ResultData.resultFrom("F-1", "이미 사용중인 이메일입니다.", "email", email);
		}
		
		return ResultData.resultFrom("S-1", "사용 가능한 이메일입니다.", "email", email);
		
	}
	
	@RequestMapping("/usr/member/cellphoneNumDupCheckForChange")
	@ResponseBody
	public ResultData<String> cellphoneNumDupCheckForChange(String cellphoneNum) {
		
		Member member = memberService.getMemberByCellphoneNum(cellphoneNum);
		
		if (member != null) {
			return ResultData.resultFrom("F-1", "이미 사용중인 휴대전화 번호입니다.", "cellphoneNum", cellphoneNum);
		}
		
		return ResultData.resultFrom("S-1", "사용 가능한 휴대전화 번호입니다.", "cellphoneNum", cellphoneNum);
		
	}
	
	@SuppressWarnings("rawtypes")
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
	
	@RequestMapping("/usr/member/findLoginId")
	public String findLoginId() {
		return "usr/member/findLoginId";
	}
	
	@RequestMapping("/usr/member/doFindLoginId")
	@ResponseBody
	public String doFindLoginId(String name, String email) {

		Member member = memberService.getMemberByNameAndEmail(name, email);

		if (member == null) {
			return Util.jsAlertHistoryBack("입력하신 정보와 일치하는 회원이 존재하지 않습니다.");
		}

		return Util.jsAlertReplace(String.format("회원님의 아이디는 [ %s ] 입니다.", member.getLoginId()), "login");
		
	}

	@RequestMapping("/usr/member/findLoginPw")
	public String findLoginPw() {
		return "usr/member/findLoginPw";
	}
	
	@RequestMapping("/usr/member/doFindLoginPw")
	@ResponseBody
	public String doFindLoginPw(String loginId, String name, String email) {

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Util.jsAlertHistoryBack("입력하신 아이디와 일치하는 회원이 존재하지 않습니다.");
		}
		
		if (!member.getName().equals(name)) {
			return Util.jsAlertHistoryBack("이름이 일치하지 않습니다.");
		}
		
		if (!member.getEmail().equals(email)) {
			return Util.jsAlertHistoryBack("이메일이 일치하지 않습니다.");
		}
		
		@SuppressWarnings("rawtypes")
		ResultData notifyTempLoginPwByEmailRd = memberService.notifyTempLoginPwByEmail(member);

		return Util.jsAlertReplace(notifyTempLoginPwByEmailRd.getMsg(), "login");
		
	}
	
}