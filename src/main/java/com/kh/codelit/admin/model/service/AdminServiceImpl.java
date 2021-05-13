package com.kh.codelit.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.admin.model.dao.AdminDao;

@Service
public class AdminServiceImpl implements AdminService {

	
	@Autowired
	private AdminDao adminDao;

}
