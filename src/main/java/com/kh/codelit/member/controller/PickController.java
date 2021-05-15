package com.kh.codelit.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.codelit.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class PickController {

	@Autowired
	private MemberService memberService;
	
	@GetMapping("pick.do")
	public void pick() {
		log.debug("찜 목록");
	}
}
