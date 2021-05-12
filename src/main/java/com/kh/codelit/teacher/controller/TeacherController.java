package com.kh.codelit.teacher.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.codelit.teacher.model.service.TeacherService;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Controller
@RequestMapping("/teacher")
public class TeacherController {

	@Autowired
	private TeacherService teacherService;
	
	@GetMapping("/teacherRequest.do")
	public String teacherRequest() {
		log.debug("강사등록 요청 {}", "컨트롤러 매핑 도착");
		
		return "teacher/teacherRequest";
	}
	
	@GetMapping("/lectureEnroll.do")
	public void lectureEnroll() {}
	
	
}
