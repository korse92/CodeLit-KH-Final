package com.kh.codelit.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.codelit.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/order")
public class BasketController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("basket.do")
	public void basket() {
		log.debug("장바구니 목록");
	}

}
