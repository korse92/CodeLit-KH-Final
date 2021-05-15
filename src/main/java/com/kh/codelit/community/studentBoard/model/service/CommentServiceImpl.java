package com.kh.codelit.community.studentBoard.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.community.studentBoard.model.dao.CommentDAO;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentDAO dao;

	
}
