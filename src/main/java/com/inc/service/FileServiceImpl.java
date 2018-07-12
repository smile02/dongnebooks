package com.inc.service;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileServiceImpl implements FileService {

	@Override
	public String saveFile(String path, MultipartFile file) throws IllegalStateException, IOException {
		if(!file.isEmpty()) { //파일이 있다면
			String filename = file.getOriginalFilename();
			File f = new File(path, filename);
						
			file.transferTo(f);
			return filename;
		}
		return "no_file";
	}
}
