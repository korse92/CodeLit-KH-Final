package com.kh.codelit.member.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSessionTemplate session; 
	
	@Override
	public Member selectOneMember(String id) {
		// TODO Auto-generated method stub
		log.debug("memberDao id={}", id);
		return session.selectOne("member.selectOneMember", id);
	}

	@Override
	public int insertMember(Member member) {
		return session.insert("member.insertMember", member);
	}
	
	@Override
	public int updateMemberProfile(Map<String, String> map) {
		return session.update("member.updateMemberProfile", map);
	}

}
