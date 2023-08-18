package com.koreaIT.Game_Together.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.koreaIT.Game_Together.repository.FileRepository;
import com.koreaIT.Game_Together.vo.FileVO;

@Service
public class FileService {
	
	@Value("${file.dir}")
	private String fileDir;
	
	private FileRepository fileRepository;

	@Autowired
	public FileService(FileRepository fileRepository) {
		this.fileRepository = fileRepository;
	}
	
	public void saveFile(MultipartFile file, String relTypeCode, int relId) throws IOException {

		if (file.isEmpty()) {
			return;
		}

		String originName = file.getOriginalFilename();

		String uuid = UUID.randomUUID().toString();
		
		String extension = originName.substring(originName.lastIndexOf("."));

		String savedName = uuid + extension;

		String savedPath = fileDir + "/" + savedName;

		fileRepository.insertFileInfo(originName, savedName, savedPath, relTypeCode, relId);

		file.transferTo(new File(savedPath));

	}
	
	public FileVO getFileByRelId(String relTypeCode, int relId) {
		return fileRepository.getFileByRelId(relTypeCode, relId);
	}

	public FileVO getFileById(int id) {
		return fileRepository.getFileById(id);
	}

	public void deleteFile(String relTypeCode, int relId) {
		fileRepository.deleteFile(relTypeCode, relId);
	}

}