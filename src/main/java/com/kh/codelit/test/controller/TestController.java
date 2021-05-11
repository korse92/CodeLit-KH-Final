package com.kh.codelit.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.codelit.test.model.service.TestService;
import com.kh.codelit.test.model.vo.Test;

import lombok.extern.slf4j.Slf4j;



@Controller
@Slf4j
@RequestMapping("/test")
public class TestController {

	
	@Autowired
	private TestService testService;
	
	@GetMapping("/test.do")
	public ModelAndView test(
				@RequestParam String name,
				ModelAndView mav
			) {
		
		log.debug("테스트 도착 {}", name);
		try {
			Test test = testService.selectOneTest(name);
			mav.addObject("test", test);
			mav.setViewName("test");
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
}
