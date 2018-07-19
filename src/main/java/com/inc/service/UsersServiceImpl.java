package com.inc.service;

import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.inc.dao.UsersDao;
import com.inc.domain.Users;
import com.inc.util.SHA256Encryptor;

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
		String content = "다음의 인증코드를 입력해주세요 :" + emailCode;
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

	@Override
	public String findId(String email) {
		return usersDao.findID(email);
	}

	@Override
	public String getTempPwd(String id) {
		// 1. 유저 정보 가져오기
		Users user = usersDao.getUser(id);
		// 2. 임시비밀번호 생성 tempPwd
		String tempPwd = makePwd();
		// 3. 임시비밀번호 암호화 encryptedPwd
		String encryptedPwd = SHA256Encryptor.shaEncrypt(tempPwd);
		// 4. 암호화된 패스워드 유저 정보에 저장하고 usersDao에 넘김(업데이트 처리)
		user.setPassword(encryptedPwd);
		usersDao.updatePwd(user);
		// 5. tempPwd 리턴.
		return tempPwd;
	}
	
	private String makePwd() {
		//7자리의 임시 비번을 생성해 리턴한다.
		char[] pwdArray = new char[] {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'W', 'X', 'Y', 'Z',
				'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
		StringBuffer sb = new StringBuffer();
		
		for(int i = 0 ; i < 7 ; i++) {
			int idx = (int)(Math.random() * pwdArray.length);
			sb.append(pwdArray[idx]);
		}
		
		return sb.toString();
	}

	@Override
	public void update(Users user) {
		usersDao.update(user);
	}

	@Override
	public void updatePwd(Users user) {
		usersDao.updatePwd(user);
	}

	@Override
	public void keepLogin(String id, String sessionId, Date next) {
		usersDao.keepLogin(id, sessionId, next);
	}

	@Override
	public Users checkLoginBefore(String value) {
		return usersDao.checkUserWithSessionKey(value);
	}
	
}
