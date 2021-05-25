package com.kh.codelit.websocket.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.codelit.common.HelloSpringUtils;
import com.kh.codelit.websocket.model.service.MessengerService;
import com.kh.codelit.websocket.model.vo.Messenger;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/alarm")
public class MessengerController {

	@Autowired
	private MessengerService service;
	
	private SimpMessagingTemplate sim;
	
	
	@MessageMapping("/user")
	@SendTo("/topic/user")
	public Messenger user(@RequestBody Messenger msg, Principal pri) {
		try {
			// 알림 작성
			log.debug("================ msg {}", msg);
			msg.setRefWriterId(pri.getName());
			String auth = "ROLE_USER";
			List<Map<String, String>> user = service.selectAuth(auth);
						
				 for(int i =0; i< user.size(); i++) {
					 msg.setRefReceiverId(user.get(i).get("memberId").toString());
					 log.debug("보낼사람 {}",msg.getRefReceiverId());
					 service.insertMsg(msg); 
				 } 
		} catch (Exception e) {
			throw e;
		}
		return msg;
	}
	


	@MessageMapping("/teacher")
	@SendTo("/topic/teacher")
	public Messenger teacher(@RequestBody Messenger msg, Principal pri) {
		// 알림 작성
		msg.setRefWriterId(pri.getName());
		// 알림 조회

		// 사용자 권한 조회 > 사용자 조회
		log.info("/app/teacher/{} 요청 : {}", msg);
		return msg;
	}

	@GetMapping("/alarmWrite.do")
	public void alarmwrite(Model model) {
		/*
		 * String auth = "ROLE_USER"; List<Map<String, String>> user =
		 * service.selectAuth(auth); model.addAttribute("user",user);
		 */
	}
	
	@GetMapping("/alarmList.do")
	public void alarmList(Model model,Principal pri, @RequestParam(defaultValue = "1") int cPage,HttpServletRequest request) {
		int numPerPage = 10;
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("numPerPage", numPerPage);
		param.put("cPage", cPage);
		param.put("name", pri.getName());
		

		List<Messenger> list = service.arlarmList(param);
		int count = service.getListCount(pri.getName());
		String uri = HelloSpringUtils.convertToParamUrl(request);
		String pageBar = HelloSpringUtils.getPageBar(count, cPage, numPerPage, uri);
		
		model.addAttribute("list", list);
		model.addAttribute("pageBar", pageBar);
	}

	@PostMapping("/alarmInsert.do")
	public void alarmInsert() {

	}
}
