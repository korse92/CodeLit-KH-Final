package com.kh.codelit.test.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.test.model.vo.Test;



@Repository
public class TestDaoImpl implements TestDao {

	@Autowired
	private SqlSessionTemplate session;

	
	
	@Override
	public Test selectOneTest(String name) {
		// TODO Auto-generated method stub
		
		return session.selectOne("test.selectOneTest", name);
	}
	
}
