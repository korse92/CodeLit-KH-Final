package com.kh.codelit.admin.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.teacher.model.vo.Teacher;

@Repository
public class AdminDaoImpl implements AdminDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Member> selectMemberList() {

		return session.selectList("admin.selectMemberList");
	}

	@Override
	public int deleteMember(String memberId) {

		return session.delete("admin.deleteMember", memberId);
	}

	@Override
	public List<Teacher> selectTeacherList() {

		return session.selectList("admin.selectTeacherList");
	}


}
