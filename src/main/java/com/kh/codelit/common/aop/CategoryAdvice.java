package com.kh.codelit.common.aop;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.codelit.lecture.model.service.LectureService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
//@SessionAttributes(value = {"categoryList"})
public class CategoryAdvice {
	
	@Autowired
	private LectureService lectureService;
	
	@ModelAttribute
	public void getCategoryList(Model model){
		
		List<Map<String, Object>> categoryList = lectureService.selectCategoryListInstance();
		Map<Integer, Object> categoryMap = lectureService.getCategoryMapInstance();
		
		log.debug("categoryList = {}", categoryList);
		log.debug("categoryMap = {}", categoryMap);
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("categoryMap", categoryMap);
	}
}
