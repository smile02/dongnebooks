package com.inc.util;

import java.security.MessageDigest;

public class SHA256Encryptor {
	//로그인 및 회원가입 시 비밀번호 암호화.
	public static String shaEncrypt(String password) {
		String encryptPwd = null;
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			digest.update("dongnebooks".getBytes());
			byte[] byteData = digest.digest(password.getBytes("UTF-8"));
			StringBuffer sb = new StringBuffer();
			
			for(byte b : byteData) {
				String byteToPwd = Integer.toString((b & 0xff) + 0x100, 16).substring(1);
				sb.append(byteToPwd);
			}
			encryptPwd = sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return encryptPwd;
	}
	/*public static void main(String[] args) {
		//테스트 코드
		String password = SHA256Encryptor.shaEncrypt("admin");
		
		System.out.println(password);
	}*/
}
