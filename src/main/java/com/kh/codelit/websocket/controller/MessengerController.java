package com.kh.codelit.websocket.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

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

	@MessageMapping("/all")
	@SendTo("/topic/all")
	public Messenger all(@RequestBody Messenger msg, Principal pri) {
		try {
			// 알림 작성
			msg.setRefWriterId(pri.getName());
			List<Map<String, String>> member = service.selectMember();
		
				if(member.size() != 0) {
					for(int i =0; i< member.size(); i++) {
						msg.setRefReceiverId(member.get(i).get("memberId").toString());
						service.insertMsg(msg);
					}
				}
		} catch (Exception e) {
			throw e;
		}
		return msg;
	}
	
	@MessageMapping("/user")
	@SendTo("/topic/user/{userList}")
	public Messenger user(@DestinationVariable String userList, @RequestBody Messenger msg, Principal pri) {
		// 알림 작성
		log.info("memberID ==========={}",userList);
		msg.setRefWriterId(pri.getName());
		
		//유저권한 조회
		String auth = "ROLE_USER";
		List<Map<String, String>> user = service.selectAuth(auth);
		
		
		// 알림 조회
		
		// 사용자 권한 조회 > 사용자 조회
		
		log.info("/app/user/{} 요청 : {}", msg);
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
		String auth = "ROLE_USER";
		List<Map<String, String>> user = service.selectAuth(auth);
		model.addAttribute("user",user);
	}
	@GetMapping("/alarmList.do")
	public void alarmList() {
		
	}

	@PostMapping("/alarmInsert.do")
	public void alarmInsert() {

	}
}
