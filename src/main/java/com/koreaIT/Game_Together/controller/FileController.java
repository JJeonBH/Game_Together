package com.koreaIT.Game_Together.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.Game_Together.service.FileService;
import com.koreaIT.Game_Together.vo.FileVO;

@Controller
public class FileController {
	
	private FileService fileService;
	
	@Autowired
	public FileController(FileService fileService) {
		this.fileService = fileService;
	}
	
	@RequestMapping("/usr/file/getFileUrl/{fileId}")
	@ResponseBody
	public Resource getFileUrl(@PathVariable("fileId") int id) throws IOException {

		FileVO fileVO = fileService.getFileById(id);

		return new UrlResource("file:" + fileVO.getSavedPath());
		
	}

}