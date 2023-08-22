package com.koreaIT.Game_Together.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.Game_Together.service.MemberService;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.Member;

@Controller
public class AdmMemberController {

	private MemberService memberService;
	
	@Autowired
	public AdmMemberController(MemberService memberService) {
		this.memberService = memberService;
	}

	@RequestMapping("/adm/member/main")
	public String showMain() {
		return "adm/member/main";
	}
	
	@RequestMapping("/adm/member/list")
	public String showList(Model model, @RequestParam(defaultValue = "0") String authLevel,
			@RequestParam(defaultValue = "1") int page, 
			@RequestParam(defaultValue = "loginId,name,nickname") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword) {

		if (page <= 0) {
			page = 1;
		}
		
		int membersCnt = memberService.getMembersCnt(authLevel, searchKeywordType, searchKeyword);
		int itemsInAPage = 10;
		int pagesCount = (int) Math.ceil((double) membersCnt / itemsInAPage);
		List<Member> members = memberService.getMembers(authLevel, searchKeywordType, searchKeyword, itemsInAPage, page);
		
		if (page > pagesCount) {
			page = pagesCount;
		}
		
		for (Member member : members) {
			member.setFormatRegDate(Util.formatRegDateVer1(member.getRegDate()));
			if(member.getDelDate() != null) {
				member.setFormatDelDate(Util.formatRegDateVer1(member.getDelDate()));
			} else {
				member.setFormatDelDate("없음");
			}
			if(member.getBanDate() != null) {
				member.setFormatBanDate(Util.formatRegDateVer1(member.getBanDate()));
			} else {
				member.setFormatBanDate("없음");
			}
		}
		
		int pageSize = 10;
		int startPage = ((page - 1) / pageSize) * pageSize + 1;
		int endPage = startPage + pageSize - 1;
		
		if (endPage > pagesCount) {
			endPage = pagesCount;
		}

		model.addAttribute("authLevel", authLevel);
		model.addAttribute("page", page);
		model.addAttribute("searchKeywordType", searchKeywordType);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("membersCnt", membersCnt);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("members", members);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

		return "adm/member/list";
		
	}
	
	@RequestMapping("/adm/member/doDeleteMembers")
	@ResponseBody
	public String doDeleteMembers(@RequestParam(defaultValue = "") String ids) {

		if (Util.isEmpty(ids)) {
			return Util.jsAlertHistoryBack("선택한 회원이 없습니다.");
		}

		List<Integer> memberIds = new ArrayList<>();

		for (String idStr : ids.split(",")) {
			memberIds.add(Integer.parseInt(idStr));
		}
		
		if (memberIds.contains(1)) {
			return Util.jsAlertHistoryBack("관리자는 강퇴할 수 없습니다.");
		}

		memberService.deleteMembers(memberIds);

		return Util.jsAlertReplace("선택한 회원이 강퇴되었습니다.", "list");
		
	}
	
}