package com.kh.codelit.common.aop;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kh.codelit.websocket.model.service.MessengerService;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@ControllerAdvice
public class AlarmAdvice {
	
	@Autowired
	private MessengerService msgService;
	
	@ModelAttribute 
	public void getReadVal(Principal pri, Model model){
		if(pri != null) {
			int readVal = msgService.getReadVal(pri.getName());
			model.addAttribute("readVal", readVal);			  
		}
	}
	/*
	 * @ModelAttribute public void getMsg() {
	 * 
	 * }
	 */
}
