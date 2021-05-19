package com.kh.codelit.order.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.order.model.vo.Pick;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class PickDaoImpl implements PickDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Pick> selectPickList() {
		return session.selectList("pick.selectPickList");
	}

}
