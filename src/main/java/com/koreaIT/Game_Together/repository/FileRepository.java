package com.koreaIT.Game_Together.repository;

import org.apache.ibatis.annotations.Mapper;

import com.koreaIT.Game_Together.vo.FileVO;

@Mapper
public interface FileRepository {

	public void insertFileInfo(String originName, String savedName, String savedPath, String relTypeCode, int relId);

	public FileVO getFileByRelId(String relTypeCode, int relId);

	public FileVO getFileById(int id);

}