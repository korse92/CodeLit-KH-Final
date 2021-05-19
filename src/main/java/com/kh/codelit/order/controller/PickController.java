package com.kh.codelit.order.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.codelit.order.model.service.PickService;
import com.kh.codelit.order.model.vo.Pick;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/order")
public class PickController {

	@Autowired
	private PickService pickService;
	
	@GetMapping("pick.do")
	public void pick(Model model) {
		List<Pick> pickList = pickService.selectPickList();
		log.debug("pickList = {}", pickList);
		
		model.addAttribute("pickList", pickList);
		
	}
}
