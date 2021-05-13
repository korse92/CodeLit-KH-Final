package com.kh.codelit.teacher.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.codelit.lecture.model.service.LectureService;
import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.teacher.model.service.TeacherService;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Controller
@RequestMapping("/teacher")
public class TeacherController {

	@Autowired
	private TeacherService teacherService;
	
	@Autowired
	private LectureService lectureService;
	
	
	
	@GetMapping("/teacherRequest.do")
	public ModelAndView teacherRequest(
				Authentication authentication,
				ModelAndView mav
			) {
		log.debug("강사등록 요청 {}", "컨트롤러 매핑 도착");
		
		try {
			Member loginMember = (Member)authentication.getPrincipal();
			log.debug("loginMember = {}", loginMember);
			mav.addObject("loginMember", loginMember);
			
			List<Map<String, Object>> list = lectureService.selectCategoryListInstance();
			mav.addObject("catList", list);
			
			mav.setViewName("teacher/teacherRequest");
		} catch(Exception e) {
			throw e;
		}
		
		return mav;
	}
	
	
	
	@GetMapping("/lectureEnroll.do")
	public void lectureEnroll() {}
	
	
}
