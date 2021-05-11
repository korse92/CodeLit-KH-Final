package com.kh.codelit.test.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.test.model.dao.TestDao;
import com.kh.codelit.test.model.vo.Test;



@Service
public class TestServiceImpl implements TestService {

	@Autowired
	private TestDao testDao;
	
	
	@Override
	public Test selectOneTest(String name) {
		// TODO Auto-generated method stub
		
		
		return testDao.selectOneTest(name);
	}

	
}
