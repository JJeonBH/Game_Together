package com.koreaIT.Game_Together.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.Game_Together.service.ArticleService;
import com.koreaIT.Game_Together.service.BoardService;
import com.koreaIT.Game_Together.service.ReplyService;
import com.koreaIT.Game_Together.util.Util;
import com.koreaIT.Game_Together.vo.Article;
import com.koreaIT.Game_Together.vo.Board;
import com.koreaIT.Game_Together.vo.Reply;
import com.koreaIT.Game_Together.vo.Request;

@Controller
public class UsrArticleController {

	private ArticleService articleService;
	private BoardService boardService;
	private ReplyService replyService;
	private Request rq;
	
	@Autowired
	public UsrArticleController(ArticleService articleService, BoardService boardService, ReplyService replyService, Request rq) {
		this.articleService = articleService;
		this.boardService = boardService;
		this.replyService = replyService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/article/write")
	public String join(Model model, String boardType) {
		
		List<Board> boards = boardService.getBoardsByBoardType(boardType);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boards", boards);
		
		return "usr/article/write";
		
	}
	
	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(String boardType, int boardId, String title, String body) {
		
		if (Util.isEmpty(boardType)) {
			return Util.jsAlertHistoryBack("게시판을 선택해 주세요.");
		}
		
		if (boardId == 0) {
			return Util.jsAlertHistoryBack("게시판을 선택해 주세요.");
		}
		
		if (Util.isEmpty(title)) {
			return Util.jsAlertHistoryBack("제목을 입력해 주세요.");
		}

		if (Util.isEmpty(body)) {
			return Util.jsAlertHistoryBack("내용을 입력해 주세요.");
		}

		articleService.writeArticle(rq.getLoginedMemberId(), boardId, title, body);

		int articleId = articleService.getLastInsertId();

		return Util.jsAlertReplace("", String.format("detail?articleId=%d&boardType=%s&boardId=%d", articleId, boardType, boardId));
		
	}
	
	@RequestMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest req, HttpServletResponse resp, Model model, int articleId, String boardType, int boardId,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "0") int memberId,
			@RequestParam(defaultValue = "0") int event) {
		
		Cookie oldCookie = null;
		Cookie[] cookies = req.getCookies();
		
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("viewCount")) {
					oldCookie = cookie;
				}
			}
		}
		
		if (oldCookie != null) {
			if (!oldCookie.getValue().contains("[" + articleId + "]")) {
				articleService.increaseViewCount(articleId);
				oldCookie.setValue(oldCookie.getValue() + "_[" + articleId + "]");
				oldCookie.setPath("/");
				oldCookie.setMaxAge(60 * 60);
				resp.addCookie(oldCookie);
			}
		} else {
			articleService.increaseViewCount(articleId);
			Cookie newCookie = new Cookie("viewCount", "[" + articleId + "]");
			newCookie.setPath("/");
			newCookie.setMaxAge(60 * 60);
			resp.addCookie(newCookie);
		}
		
		List<Reply> replies = replyService.getReplies(rq.getLoginedMemberId(), "article", articleId);
		
		Article article = articleService.getForPrintArticle(articleId, boardType, boardId, searchKeywordType, searchKeyword, memberId);
		
		if (article == null) {
			return rq.jsHistoryBack("존재하지 않는 게시물입니다.", true);
		}
		
		article.setRepliesCnt(replyService.getRepliesCnt("article", articleId));
		
		article.setFormatRegDate(Util.formatRegDateVer1(article.getRegDate()));

		articleService.actorCanChangeData(rq.getLoginedMemberId(), article);
		
		List<Board> boards = boardService.getBoardsByBoardType(boardType);

		model.addAttribute("article", article);
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardId", boardId);
		model.addAttribute("boards", boards);
		model.addAttribute("page", page);
		model.addAttribute("searchKeywordType", searchKeywordType);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("memberId", memberId);
		model.addAttribute("replies", replies);
		model.addAttribute("event", event);

		return "usr/article/detail";
		
	}
	
	@RequestMapping("/usr/article/list")
	public String showList(Model model, String boardType,
			@RequestParam(defaultValue = "0") int boardId,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "0") int memberId) {
		
		if (page <= 0) {
			return rq.jsHistoryBack("페이지번호가 올바르지 않습니다.", true);
		}
		
		int articlesCnt;
		List<Article> articles = new ArrayList<>();
		String pageTitle;
		
		int itemsInAPage = 10;
		
		if(boardId == 0) {
			articlesCnt = articleService.getArticlesCntByBoardType(boardType, searchKeywordType, searchKeyword, memberId);
			articles = articleService.getArticlesByBoardType(boardType, searchKeywordType, searchKeyword, itemsInAPage, page, memberId);
			if (memberId == 0) {
				pageTitle = "전체 게시판";
			} else {
				pageTitle = "내가 쓴 글";
			}
		} else {
			Board board = boardService.getBoardByIdAndType(boardId, boardType);
			
			if (board == null) {
				return rq.jsHistoryBack("존재하지 않는 게시판입니다.", true);
			}
			
			articlesCnt = articleService.getArticlesCntByBoardId(boardId, searchKeywordType, searchKeyword);
			articles = articleService.getArticlesByBoardId(boardId, searchKeywordType, searchKeyword, itemsInAPage, page);
			pageTitle = board.getName();
		}
		
		for (Article article : articles) {
			article.setFormatRegDate(Util.formatRegDateVer2(article.getRegDate()));
			article.setRepliesCnt(replyService.getRepliesCnt("article", article.getId()));
		}

		int pagesCount = (int) Math.ceil((double) articlesCnt / itemsInAPage);
		
		if (page > pagesCount) {
			page = pagesCount;
		}
		
		List<Board> boards = boardService.getBoardsByBoardType(boardType);
		
		int pageSize = 10;
		int startPage = ((page - 1) / pageSize) * pageSize + 1;
		int endPage = startPage + pageSize - 1;
		
		if (endPage > pagesCount) {
			endPage = pagesCount;
		}
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardId", boardId);
		model.addAttribute("page", page);
		model.addAttribute("searchKeywordType", searchKeywordType);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("memberId", memberId);
		model.addAttribute("articlesCnt", articlesCnt);
		model.addAttribute("articles", articles);
		model.addAttribute("pageTitle", pageTitle);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("boards", boards);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

		return "usr/article/list";
		
	}

}