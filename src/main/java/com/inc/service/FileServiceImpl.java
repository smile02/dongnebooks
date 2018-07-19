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
			
			while(f.exists()) { //파일이 존재한다면
				long time = System.currentTimeMillis(); //현재 시간을 밀리세컨드로 표현
				int index = filename.lastIndexOf('.'); //파일명 뒤에서부터 .이라는 부분 찾기
				String f_name = filename.substring(0, index); //확장자의 앞에만
				String f_ext = filename.substring(index); //뒤에 확장자만
				filename = f_name + "_" + time + f_ext; // 파일명_시간.확장자
				f = new File(path, filename);
			}
						
			file.transferTo(f);
			return filename;
		}
		return "no_file";
	}
}
