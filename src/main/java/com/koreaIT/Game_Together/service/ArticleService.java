package com.koreaIT.Game_Together.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreaIT.Game_Together.repository.ArticleRepository;
import com.koreaIT.Game_Together.vo.Article;
import com.koreaIT.Game_Together.vo.ResultData;

@Service
public class ArticleService {
	
	private ArticleRepository articleRepository;

	@Autowired
	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}
	
	public void writeArticle(int memberId, int boardId, String title, String body) {
		articleRepository.writeArticle(memberId, boardId, title, body);
	}
	
	public int getLastInsertId() {
		return articleRepository.getLastInsertId();
	}
	
	public Article getForPrintArticle(int articleId, String boardType, int boardId, String searchKeywordType, String searchKeyword, int memberId) {
		
		Article article = articleRepository.getForPrintArticle(articleId, boardType, boardId, searchKeywordType, searchKeyword, memberId);
		
		return article;
		
	}
	
	public Article getArticleById(int articleId) {
		
		Article article = articleRepository.getArticleById(articleId);
		
		return article;
		
	}
	
	public void modifyArticle(int articleId, int boardId, String title, String body) {
		articleRepository.modifyArticle(articleId, boardId, title, body);
	}
	
	public void deleteArticle(int articleId) {
		articleRepository.deleteArticle(articleId);
	}
	
	public void increaseViewCount(int articleId) {
		articleRepository.increaseViewCount(articleId);
	}
	
	public int getArticlesCntByBoardType(String boardType, String searchKeywordType, String searchKeyword, int memberId) {
		return articleRepository.getArticlesCntByBoardType(boardType, searchKeywordType, searchKeyword, memberId);
	}
	
	public int getArticlesCntByBoardId(int boardId, String searchKeywordType, String searchKeyword) {
		return articleRepository.getArticlesCntByBoardId(boardId, searchKeywordType, searchKeyword);
	}
	
	public List<Article> getArticlesByBoardType(String boardType, String searchKeywordType, String searchKeyword, int itemsInAPage, int page, int memberId) {
		
		int limitStart = (page - 1) * itemsInAPage;
		
		return articleRepository.getArticlesByBoardType(boardType, searchKeywordType, searchKeyword, itemsInAPage, limitStart, memberId);
		
	}
	
	public List<Article> getArticlesByBoardId(int boardId, String searchKeywordType, String searchKeyword, int itemsInAPage, int page) {
		
		int limitStart = (page - 1) * itemsInAPage;
		
		return articleRepository.getArticlesByBoardId(boardId, searchKeywordType, searchKeyword, itemsInAPage, limitStart);
	
	}
	
	public void actorCanChangeData(int loginedMemberId, Article article) {
		
		@SuppressWarnings("rawtypes")
		ResultData actorCanChangeDataRd = actorCanMD(loginedMemberId, article);
		
		article.setActorCanChangeData(actorCanChangeDataRd.isSuccess());
		
	}
	
	@SuppressWarnings("rawtypes")
	public ResultData actorCanMD(int loginedMemberId, Article article) {
		
		if(article == null) {
			return ResultData.resultFrom("F-1", "해당 게시물은 존재하지 않습니다.");
		}
		
		if (loginedMemberId != article.getMemberId()) {
			return ResultData.resultFrom("F-2", "해당 게시물에 대한 권한이 없습니다.");	
		}
		
		return ResultData.resultFrom("S-1", "가능");
		
	}

	public List<Article> getNoticeArticles(String boardType, int limitStart, int itemsInAPage) {
		return articleRepository.getNoticeArticles(boardType, limitStart, itemsInAPage);
	}
	
}