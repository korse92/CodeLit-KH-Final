package com.kh.codelit.common.aop;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kh.codelit.lecture.model.service.LectureService;
import com.kh.codelit.websocket.model.service.MessengerService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class CategoryAdvice {

	@Autowired
	private LectureService lectureService;

	@Autowired
	private MessengerService msgService;

	@ModelAttribute
	public void getCategoryList(Model model){

		List<Map<String, Object>> categoryList = lectureService.selectCategoryListInstance();
		Map<Integer, Object> categoryMap = lectureService.getCategoryMapInstance();

		log.debug("categoryList = {}", categoryList);
		log.debug("categoryMap = {}", categoryMap);

		model.addAttribute("categoryList", categoryList);
		model.addAttribute("categoryMap", categoryMap);
	}

	  @ModelAttribute
	  public void getReadVal(Principal pri, Model model){
		  if(pri != null) {
			  int readVal = msgService.getReadVal(pri.getName());

			  model.addAttribute("readVal", readVal);
		  }
	  }
	}
