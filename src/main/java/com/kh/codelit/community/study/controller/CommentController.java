package com.kh.codelit.community.study.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.codelit.community.study.model.service.CommentService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping
@Slf4j
public class CommentController {
	
	@Autowired
	private CommentService service;
	
	
	
}