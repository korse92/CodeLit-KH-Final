package com.kh.codelit.websocket.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.codelit.common.HelloSpringUtils;
import com.kh.codelit.websocket.model.service.MessengerService;
import com.kh.codelit.websocket.model.vo.Messenger;

//db 저장용
@Controller
@RequestMapping("/alarm")
public class AlramController {
	
	@Autowired
	private MessengerService service;
	
	@GetMapping("/alarmWrite.do")
	public void alarmwrite() {
		
	}
	
	@GetMapping("/alarmList.do")
	public void alarmList(Model model,Principal pri, @RequestParam(defaultValue = "1") int cPage,HttpServletRequest request) {
		int numPerPage = 10;
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("numPerPage", numPerPage);
		param.put("cPage", cPage);
		param.put("name", pri.getName());
		

		List<Messenger> message = service.arlarmList(param);
		int count = service.getListCount(pri.getName());
		String uri = HelloSpringUtils.convertToParamUrl(request);
		String pageBar = HelloSpringUtils.getPageBar(count, cPage, numPerPage, uri);
		
		model.addAttribute("message", message);
		model.addAttribute("pageBar", pageBar);
	}

	@GetMapping("/alarmDetail.do")
	public void alarmDetail(@RequestParam int msgNo, Model model) {
		int result = service.updateReadVal(msgNo);
		Messenger message = service.selectOneMsg(msgNo);
		
		model.addAttribute("message", message);
	}
}
