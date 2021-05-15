package com.kh.codelit.community.student.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.codelit.community.student.model.service.StudentService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/community")
@Slf4j
public class StudentBoardController {
	
	@Autowired
	private StudentService service;
	
	@GetMapping("/studentList.do")
	public void BoardList() {
		
	}
	@GetMapping()
	public void BoardDetail() {
		
	}
	
	@PostMapping("/studentInsert.do")
	public void BoardInsert() {
		
	}
	
	@GetMapping("/studentUpdate.do")
	public void BoardUpdate() {
		
	}
	
	@GetMapping("/studentDelete.do")
	public void BoardDelete() {
		
	}
	
}	
