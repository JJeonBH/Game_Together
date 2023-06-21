package com.koreaIT.Game_Together.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreaIT.Game_Together.repository.BoardRepository;
import com.koreaIT.Game_Together.vo.Board;

@Service
public class BoardService {
	
	private BoardRepository boardRepository;
	
	@Autowired
	public BoardService(BoardRepository boardRepository) {
		this.boardRepository = boardRepository;
	}
	
	public Board getBoardById(int boardId) {
		return boardRepository.getBoardById(boardId);
	}

	public List<Board> getBoardsByBoardType(String boardType) {
		return boardRepository.getBoardsByBoardType(boardType);
	}

}