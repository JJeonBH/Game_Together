package com.koreaIT.Game_Together.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreaIT.Game_Together.vo.Article;

@Mapper
public interface ArticleRepository {
	
	public void writeArticle(int memberId, int boardId, String title, String body);
	
	public int getLastInsertId();
	
	public Article getForPrintArticle(int articleId, String boardType, int boardId, String searchKeywordType, String searchKeyword, int memberId);
	
	public int increaseViewCount(int articleId);
	
	public int getArticlesCntByBoardType(String boardType, String searchKeywordType, String searchKeyword, int memberId);
	
	public int getArticlesCntByBoardId(int boardId, String searchKeywordType, String searchKeyword);
	
	public List<Article> getArticlesByBoardType(String boardType, String searchKeywordType, String searchKeyword, int itemsInAPage, int limitStart, int memberId);
	
	public List<Article> getArticlesByBoardId(int boardId, String searchKeywordType, String searchKeyword, int itemsInAPage, int limitStart);

}