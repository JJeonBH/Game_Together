package com.koreaIT.Game_Together.service;

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
	
	public Article getForPrintArticle(int id) {
		
		Article article = articleRepository.getForPrintArticle(id);
		
		return article;
		
	}
	
	public void actorCanChangeData(int loginedMemberId, Article article) {
		
		ResultData actorCanChangeDataRd = actorCanMD(loginedMemberId, article);
		
		article.setActorCanChangeData(actorCanChangeDataRd.isSuccess());
		
	}
	
	public ResultData actorCanMD(int loginedMemberId, Article article) {
		
		if(article == null) {
			return ResultData.resultFrom("F-1", "해당 게시물은 존재하지 않습니다.");
		}
		
		if (loginedMemberId != article.getMemberId()) {
			return ResultData.resultFrom("F-2", "해당 게시물에 대한 권한이 없습니다.");	
		}
		
		return ResultData.resultFrom("S-1", "가능");
		
	}
	
	public void increaseViewCount(int id) {
		articleRepository.increaseViewCount(id);
	}
	
}