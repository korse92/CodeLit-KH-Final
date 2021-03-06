package com.kh.codelit.common.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class Utils {
	/**
	 * <pre>
	 * 단방향 암호화 : 복호화가 불가능. 암호화된 값(hash)을 가지고 비교연산
	 * 	- md5 sha1 sha256 sha512등의 알고리즘 지원
	 * 	- MessageDigest
	 * 양방향 암호화 : 암호화/복호화가 가능
	 * 
	 * 암호화절차
	 * 1. 암호화객체생성
	 * 2. 문자열 -> byte[] -> 암호화객체에 전달 및 암호화
	 * 3. 암호화된 byte[] -> 인코더Base64를 통한 문자열변환
	 * 
	 * </pre>
	 * 
	 * @param parameter
	 * @return
	 */
	public static String getEncryptedPassword(String password) {
		String encryptedPassword = null;
		try {
			// 1. 암호화객체생성
			MessageDigest md = MessageDigest.getInstance("SHA-512");

			// 2. 문자열 -> byte[] -> 암호화객체에 전달 및 암호화
			byte[] bytes = password.getBytes("UTF-8");
			md.update(bytes);
			byte[] encryptedBytes = md.digest();
			System.out.println(new String(encryptedBytes));
			// 3. 암호화된 byte[] -> 인코더Base64를 통한 문자열변환
			encryptedPassword = Base64.getEncoder().encodeToString(encryptedBytes);
			System.out.println(encryptedPassword);
		} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
		
		
		return encryptedPassword;
	}

}
