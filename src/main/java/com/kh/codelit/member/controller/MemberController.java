package com.kh.codelit.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {
	
	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {}
	
	@GetMapping("/memberLogin.do")
	public void memberLogin() {}
	
	@PostMapping("/memberLogin.do")
	public void memberLogin_() {
		log.debug("로그인 포스트 {}", "도착");
	}

}
