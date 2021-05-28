package com.kh.codelit.websocket.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;

import com.kh.codelit.websocket.model.service.MessengerService;
import com.kh.codelit.websocket.model.vo.Messenger;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MessengerController {

	@Autowired
	private MessengerService service;
	
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
	
	//강사 신청 승인
	@MessageMapping("/success/{memberId}")
	@SendTo("/topic/success/{memberId}")
	public Messenger teacherSuccessAlarm(@DestinationVariable String memberId, Messenger msg,Principal pri) {
		try {
			log.debug("###################### 강사신청 = {}", msg);
			msg.setRefWriterId(pri.getName());
			msg.setRefReceiverId(memberId);
			service.insertMsg(msg);
		} catch (Exception e) {
			throw e;
		}
		return msg;
	}
	
	//강사 신청 거절
	@MessageMapping("/reject/{memberId}")
	@SendTo("/topic/reject/{memberId}")
	public Messenger teacherrejectAlarm(@DestinationVariable String memberId, Messenger msg,Principal pri) {
		try {
			
			msg.setRefWriterId(pri.getName());
			msg.setRefReceiverId(memberId);
			service.insertMsg(msg);
		} catch (Exception e) {
			throw e;
		}
		return msg;
	}
}
