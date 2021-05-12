package com.kh.security.model.dao;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;



@Repository
@Slf4j
public class UserDetailsDaoImpl implements UserDetailsDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public Member selectOneMember(String id) {
//		log.debug("userdetailsDao id={}", id);
		return session.selectOne("security.selectOneMember", id);
	}
	
	
}
