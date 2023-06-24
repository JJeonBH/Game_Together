package com.koreaIT.Game_Together.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreaIT.Game_Together.vo.Board;

@Mapper
public interface BoardRepository {

	public Board getBoardById(int boardId);
	
	public Board getBoardByIdAndType(int boardId, String boardType);

	public List<Board> getBoardsByBoardType(String boardType);
	
}