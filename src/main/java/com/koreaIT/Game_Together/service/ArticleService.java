package com.koreaIT.Game_Together.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreaIT.Game_Together.repository.ArticleRepository;

@Service
public class ArticleService {
	
	private ArticleRepository articleRepository;

	@Autowired
	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}
	
}