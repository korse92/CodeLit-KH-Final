package com.kh.codelit.member.model.service;

import org.springframework.security.core.userdetails.UserDetailsService;

public interface MemberService extends UserDetailsService{
	
	//public static final 
	String ROLE_USER = "USER";
	String ROLE_ADMIN = "ADMIN";
	String ROLE_TEACHER = "TEACHER";
	
}
