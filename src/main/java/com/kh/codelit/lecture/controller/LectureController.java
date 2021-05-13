package com.kh.codelit.lecture.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.kh.codelit.lecture.model.service.LectureService;

@Controller
public class LectureController {
	
	@Autowired
	private LectureService lectureService;	

}
