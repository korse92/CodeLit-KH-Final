package com.kh.codelit.community.student.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.community.student.model.dao.CommentDAO;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentDAO dao;

	
}
