package com.koreaIT.Game_Together.repository;

import org.apache.ibatis.annotations.Mapper;

import com.koreaIT.Game_Together.vo.Article;

@Mapper
public interface ArticleRepository {
	
	public void writeArticle(int memberId, int boardId, String title, String body);
	
	public int getLastInsertId();
	
	public Article getForPrintArticle(int id);
	
	public int increaseViewCount(int id);

}