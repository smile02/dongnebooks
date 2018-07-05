package com.inc.service;

import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.management.RuntimeErrorException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.inc.dao.UsersDao;
import com.inc.domain.Users;

@Service
public class UsersServiceImpl implements UsersService{
	@Autowired
	private UsersDao usersDao;
	
	@Autowired
	private JavaMailSender javaMailSender;

	@Override
	public List<Users> userList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Users getUser(String id) {
		return usersDao.getUser(id);
	}

	@Override
	public void signup(Users user)  {
		usersDao.signup(user);
	}

	@Override
	public String sendCertifyEmail(String email) {
		// 이메일 발송하고 코드 리턴
		String from = "dongnebooks21@gmail.com";
		String subject = "DongneBooks 인증메일입니다.";
		String emailCode = makeCode();
		String content = "회원가입 창에 다음의 인증코드를 입력해주세요 :" + emailCode;
		try {
			MimeMessage msg = javaMailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(msg, true, "utf-8");
			helper.setFrom(from);
			helper.setTo(email);
			helper.setSubject(subject);
			helper.setText(content);
			javaMailSender.send(msg);
		}catch(MessagingException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		
		return emailCode;
	}

	private String makeCode() {
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < 5 ; i++) {
			sb.append((int)(Math.random()*10));
		}
		return sb.toString();
	}

	@Override
	public Users nickCheck(String nickname) {
		return usersDao.nickCheck(nickname);
	}

	@Override
	public boolean emailCheck(String email) {
		return usersDao.emailCheck(email);
	}

}
